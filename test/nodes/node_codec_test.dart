import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:fl_clash/features/nodes/nodes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('node codecs', () {
    test('parses VLESS Reality and exports it', () {
      final draft = NodeCodecRegistry().parse(
        'vless://UUID@HOST:443?encryption=none&flow=xtls-rprx-vision&security=reality&sni=SNI&fp=chrome&pbk=PUBLIC_KEY&sid=SHORT_ID&type=tcp#NODE',
      );
      expect(draft.config['type'], 'vless');
      expect(draft.config['reality-opts'], {
        'public-key': 'PUBLIC_KEY',
        'short-id': 'SHORT_ID',
      });
      final uri = const VlessCodec().exportUri(draft.config);
      expect(uri, contains('vless://UUID@host:443'));
      expect(uri, contains('pbk=PUBLIC_KEY'));
    });

    test('normalizes copied escaped VLESS links', () {
      final draft = NodeCodecRegistry().parse(
        r'vless\://00000000-0000-4000-8000-000000000001\@192.0.2.1:443?encryption=none\&amp;flow=xtls-rprx-vision\&security=reality\&sni=example.com\&fp=chrome\&pbk=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\&sid=0123456789abcdef\&type=tcp\&headerType=none#test-reality',
      );
      expect(draft.issues.where((issue) => issue.isError), isEmpty);
      expect(draft.config['server'], '192.0.2.1');
      expect(draft.config['flow'], 'xtls-rprx-vision');
      expect(draft.config['servername'], 'example.com');
      expect(draft.config['reality-opts'], {
        'public-key': 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
        'short-id': '0123456789abcdef',
      });
      expect(draft.metadata['headerType'], 'none');
    });

    test('parses common protocol batch and aliases', () {
      final vmessPayload = base64Url.encode(
        utf8.encode(
          jsonEncode({
            'ps': 'VMESS',
            'add': 'HOST',
            'port': '443',
            'id': 'UUID',
            'aid': '0',
            'net': 'tcp',
          }),
        ),
      );
      final ssUserInfo = base64Url
          .encode(utf8.encode('aes-256-gcm:password'))
          .replaceAll('=', '');
      final result = NodeInputDispatcher().importText(
        [
          'vmess://$vmessPayload',
          'ss://$ssUserInfo@HOST:8388#SS',
          'trojan://PASSWORD@HOST:443?sni=SNI#TROJAN',
          'hysteria2://PASSWORD@HOST:443?sni=SNI#HY2',
          'tuic://UUID:PASSWORD@HOST:443?sni=SNI#TUIC',
          'anytls://PASSWORD@HOST:443?sni=SNI#ANYTLS',
          'socks5://USER:PASSWORD@HOST:1080#SOCKS',
        ].join('\n'),
      );
      expect(result.drafts, hasLength(7));
      expect(
        result.drafts.map((item) => item.type),
        containsAll(<String>[
          'vmess',
          'ss',
          'trojan',
          'hysteria2',
          'tuic',
          'anytls',
          'socks5',
        ]),
      );
    });

    test('parses SIP002 and legacy Shadowsocks URIs', () {
      final registry = NodeCodecRegistry();
      final userInfo = base64Url
          .encode(utf8.encode('aes-256-gcm:password'))
          .replaceAll('=', '');
      final sip002 = registry.parse(
        'ss://$userInfo@HOST:8388?plugin=obfs-local%3Bobfs%3Dhttp&udp=1#SS-NODE',
      );
      expect(sip002.issues.where((issue) => issue.isError), isEmpty);
      expect(sip002.config['type'], 'ss');
      expect(sip002.config['server'], 'host');
      expect(sip002.config['port'], 8388);
      expect(sip002.config['cipher'], 'aes-256-gcm');
      expect(sip002.config['password'], 'password');
      expect(sip002.config['plugin'], 'obfs-local;obfs=http');
      expect(sip002.config['udp'], isTrue);
      expect(sip002.config['name'], 'SS-NODE');

      final legacyPayload = base64Url
          .encode(utf8.encode('aes-256-gcm:password@HOST:8388'))
          .replaceAll('=', '');
      final legacy = registry.parse('ss://$legacyPayload#LEGACY');
      expect(legacy.issues.where((issue) => issue.isError), isEmpty);
      expect(legacy.config['cipher'], 'aes-256-gcm');
      expect(legacy.config['password'], 'password');
      expect(legacy.config['server'], 'host');
      expect(legacy.config['port'], 8388);
      expect(legacy.config['name'], 'LEGACY');
    });

    test('round trips Shadowsocks plugins and reserved characters', () {
      final registry = NodeCodecRegistry();
      final source = const ShadowsocksCodec().exportUri({
        'name': '香港节点',
        'type': 'ss',
        'server': 'host',
        'port': 8388,
        'cipher': 'chacha20-ietf-poly1305',
        'password': r'p@ss:w/rd+1',
        'plugin': 'obfs-local;obfs=http',
      })!;
      final draft = registry.parse(source);
      expect(draft.issues.where((issue) => issue.isError), isEmpty);
      expect(draft.config['cipher'], 'chacha20-ietf-poly1305');
      expect(draft.config['password'], r'p@ss:w/rd+1');
      expect(draft.config['plugin'], 'obfs-local;obfs=http');
      expect(draft.config['name'], '香港节点');
    });

    test('parses and exports Trojan TLS and transport fields', () {
      final registry = NodeCodecRegistry();
      final draft = registry.parse(
        'trojan://p%40ss@HOST:443?security=tls&sni=SNI&type=ws&path=%2Fws'
        '&host=cdn.example&allowInsecure=1&alpn=h2%2Chttp%2F1.1'
        '&flow=xtls-rprx-vision#TROJAN',
      );
      expect(draft.issues.where((issue) => issue.isError), isEmpty);
      expect(draft.config['type'], 'trojan');
      expect(draft.config['server'], 'host');
      expect(draft.config['port'], 443);
      expect(draft.config['password'], 'p@ss');
      expect(draft.config['tls'], isTrue);
      expect(draft.config['sni'], 'SNI');
      expect(draft.config['skip-cert-verify'], isTrue);
      expect(draft.config['alpn'], ['h2', 'http/1.1']);
      expect(draft.config['network'], 'ws');
      expect(draft.config['ws-opts'], {
        'path': '/ws',
        'headers': {'Host': 'cdn.example'},
      });
      expect(draft.config['flow'], 'xtls-rprx-vision');

      final round = registry.parse(
        const TrojanCodec().exportUri(draft.config)!,
      );
      expect(round.issues.where((issue) => issue.isError), isEmpty);
      expect(round.config['password'], 'p@ss');
      expect(round.config['tls'], isTrue);
      expect(round.config['sni'], 'SNI');
      expect(round.config['skip-cert-verify'], isTrue);
      expect(round.config['alpn'], ['h2', 'http/1.1']);
      expect(round.config['ws-opts'], draft.config['ws-opts']);
      expect(round.config['name'], 'TROJAN');
    });

    test('drops Trojan TLS when the link disables security', () {
      final draft = NodeCodecRegistry().parse(
        'trojan://PASSWORD@HOST:443?security=none#PLAIN',
      );
      expect(draft.config.containsKey('tls'), isFalse);
      expect(draft.config['password'], 'PASSWORD');
    });

    test('round trips SOCKS encoded credentials and Unicode names', () {
      final registry = NodeCodecRegistry();
      final source = const SocksCodec().exportUri({
        'name': '日本語节点',
        'type': 'socks',
        'server': 'HOST',
        'port': 1080,
        'username': 'user:name',
        'password': 'p@ss:word',
      })!;
      final draft = registry.parse(source);
      expect(draft.issues.where((issue) => issue.isError), isEmpty);
      expect(draft.config['username'], 'user:name');
      expect(draft.config['password'], 'p@ss:word');
      expect(draft.config['name'], '日本語节点');
    });

    // Mihomo models these transports with different shapes:
    //   HTTPOptions  -> path []string, headers map[string][]string
    //   HTTP2Options -> host []string, path string
    //   WSOptions    -> path string,   headers map[string]string
    // Emitting the wrong shape produces a config the Core rejects at apply
    // time, which assembly-level tests cannot see.
    test('emits h2-opts with a list host and a plain path', () {
      final registry = NodeCodecRegistry();
      final draft = registry.parse(
        'vless://11111111-2222-3333-4444-555555555555@HOST:443'
        '?encryption=none&security=tls&type=h2&host=example.com&path=%2Fh2#H2',
      );
      expect(draft.issues.where((issue) => issue.isError), isEmpty);
      expect(draft.config.containsKey('http-opts'), isFalse);
      final opts = draft.config['h2-opts'] as Map;
      expect(opts['host'], ['example.com']);
      expect(opts['path'], '/h2');
    });

    test('emits http-opts with list path and list header values', () {
      final registry = NodeCodecRegistry();
      final draft = registry.parse(
        'vless://11111111-2222-3333-4444-555555555555@HOST:443'
        '?encryption=none&security=tls&type=http&host=example.com'
        '&path=%2Fhttp#HTTP',
      );
      expect(draft.issues.where((issue) => issue.isError), isEmpty);
      final opts = draft.config['http-opts'] as Map;
      expect(opts['path'], ['/http']);
      expect((opts['headers'] as Map)['Host'], ['example.com']);
    });

    test('keeps ws-opts headers as plain strings', () {
      final registry = NodeCodecRegistry();
      final draft = registry.parse(
        'vless://11111111-2222-3333-4444-555555555555@HOST:443'
        '?encryption=none&security=tls&type=ws&host=example.com&path=%2Fws#WS',
      );
      final opts = draft.config['ws-opts'] as Map;
      expect(opts['path'], '/ws');
      expect((opts['headers'] as Map)['Host'], 'example.com');
    });

    test('decodes base64 userinfo for SOCKS and HTTP links', () {
      final registry = NodeCodecRegistry();
      // base64('test:test') — the form many share links use.
      final socks = registry.parse('socks5://dGVzdDp0ZXN0@HOST:1080#S');
      expect(socks.issues.where((issue) => issue.isError), isEmpty);
      expect(socks.config['username'], 'test');
      expect(socks.config['password'], 'test');

      final http = registry.parse('http://dGVzdDp0ZXN0@HOST:8080#H');
      expect(http.config['username'], 'test');
      expect(http.config['password'], 'test');
    });

    test('keeps a plain userinfo username that looks like base64', () {
      final registry = NodeCodecRegistry();
      // 'dXNlcg' decodes to 'user', which carries no separator, so it must be
      // kept verbatim rather than reinterpreted as credentials.
      final draft = registry.parse('socks5://dXNlcg@HOST:1080#S');
      expect(draft.config['username'], 'dXNlcg');
      expect(draft.config['password'], isNull);
    });

    test('prefers an explicit user:password over base64 decoding', () {
      final registry = NodeCodecRegistry();
      final draft = registry.parse('socks5://USER:PASSWORD@HOST:1080#S');
      expect(draft.config['username'], 'USER');
      expect(draft.config['password'], 'PASSWORD');
    });

    test('keeps the SOCKS version across export and re-import', () {
      final registry = NodeCodecRegistry();
      for (final entry in {'socks4': 4, 'socks4a': '4a'}.entries) {
        final draft = registry.parse('${entry.key}://USER@HOST:1080#NODE');
        expect(draft.issues.where((issue) => issue.isError), isEmpty);
        // Mihomo rejects a bare `socks` type, so the codec emits `socks5` and
        // carries the SOCKS4/4a variant in `version`.
        expect(draft.config['type'], 'socks5');
        expect(draft.config['version'], entry.value);

        final exported = const SocksCodec().exportUri(draft.config)!;
        expect(exported, startsWith('${entry.key}://'));

        final round = registry.parse(exported);
        expect(round.config['version'], entry.value);
        expect(round.config['username'], 'USER');
        expect(round.config['name'], 'NODE');
      }

      final socks5 = registry.parse('socks5://USER@HOST:1080#NODE');
      expect(socks5.config.containsKey('version'), isFalse);
      expect(
        const SocksCodec().exportUri(socks5.config),
        startsWith('socks5://'),
      );
    });

    test('parses standard and escaped VMess links', () {
      final registry = NodeCodecRegistry();
      final standard = registry.parse(
        r'vmess://UUID@HOST:443?aid=0&net=ws&path=%2Fedge&host=cdn.example&sni=SNI&tls=1#STANDARD',
      );
      expect(standard.issues.where((issue) => issue.isError), isEmpty);
      expect(standard.config['uuid'], 'UUID');
      expect(standard.config['tls'], isTrue);
      expect(standard.config['network'], 'ws');
      expect(standard.config['ws-opts'], {
        'path': '/edge',
        'headers': {'Host': 'cdn.example'},
      });

      final escaped = registry.parse(
        r'vless\://UUID\@HOST:443?encryption=none#ESCAPED',
      );
      expect(escaped.issues.where((issue) => issue.isError), isEmpty);
      expect(escaped.config['type'], 'vless');
      expect(escaped.config['name'], 'ESCAPED');
    });

    test('preserves common QUIC protocol fields', () {
      final registry = NodeCodecRegistry();
      final hy2 = registry.parse(
        'hysteria2://PASS@HOST:443?sni=SNI&insecure=1&obfs=salamander&obfs-password=OBFS&pinSHA256=FP&up=30%20Mbps&down=100%20Mbps&fast-open=1&handshake-timeout=5',
      );
      expect(hy2.config['skip-cert-verify'], isTrue);
      expect(hy2.config['fingerprint'], 'FP');
      expect(hy2.config['obfs'], 'salamander');
      expect(hy2.config['up'], '30 Mbps');
      expect(hy2.config['handshake-timeout'], 5);
      final hy2Uri = const Hysteria2Codec().exportUri(hy2.config)!;
      expect(hy2Uri, contains('pinSHA256=FP'));
      expect(hy2Uri, contains('handshake-timeout=5'));

      final tuic = registry.parse(
        'tuic://UUID:PASS@HOST:443?allow_insecure=1&congestion_control=bbr&udp_relay_mode=native&disable_sni=1&max_open_streams=8',
      );
      expect(tuic.config['skip-cert-verify'], isTrue);
      expect(tuic.config['congestion-controller'], 'bbr');
      expect(tuic.config['disable-sni'], isTrue);
      expect(tuic.config['max-open-streams'], 8);

      final anytls = registry.parse(
        'anytls://PASS@HOST:443?udp=1&disable-sni=true&idle-session-timeout=30s',
      );
      expect(anytls.config['udp'], isTrue);
      expect(anytls.config['disable-sni'], isTrue);
      expect(anytls.config['idle-session-timeout'], '30s');
    });

    test('routes HTTP proxy URIs separately from subscriptions', () {
      final dispatcher = NodeInputDispatcher();
      final subscription = dispatcher.importText('https://HOST/sub');
      expect(subscription.subscriptionUrl, 'https://HOST/sub');
      expect(subscription.drafts, isEmpty);

      final result = dispatcher.importText(
        'https://user:p%40ss@HOST:8443?proxy=1&sni=proxy.example',
      );
      expect(result.subscriptionUrl, isNull);
      expect(result.drafts.single.config, {
        'name': 'http_host',
        'type': 'http',
        'server': 'host',
        'port': 8443,
        'username': 'user',
        'password': 'p@ss',
        'tls': true,
        'sni': 'proxy.example',
      });
      final uri = const HttpCodec().exportUri(result.drafts.single.config)!;
      expect(uri, startsWith('https://user:p%40ss@host:8443'));

      final explicit = dispatcher.importText('http://HOST:8080');
      expect(explicit.drafts.single.config['type'], 'http');
      expect(explicit.drafts.single.config['port'], 8080);
    });

    test('parses YAML, JSON, base64 and preserves unknown fields', () {
      const yamlText = '''
proxies:
  - name: RAW
    type: mystery
    server: HOST
    port: 1
    custom-field:
      enabled: true
''';
      final dispatcher = NodeInputDispatcher();
      final yamlResult = dispatcher.importText(yamlText);
      expect(yamlResult.drafts.single.config['custom-field'], {
        'enabled': true,
      });
      final encoded = base64Encode(utf8.encode(yamlText));
      expect(dispatcher.importText(encoded).drafts.single.type, 'mystery');
      expect(
        dispatcher.importText('https://HOST/sub').subscriptionUrl,
        'https://HOST/sub',
      );
    });
  });

  test('exports raw nodes in YAML JSON Base64 and ZIP', () async {
    final result = await NodeExportService().exportConfigs([
      {'name': 'RAW', 'type': 'mystery', 'server': 'HOST', 'port': 1},
    ], includeZip: true);
    expect(result.yaml, contains('proxies:'));
    expect(jsonDecode(result.json)['proxies'], hasLength(1));
    expect(utf8.decode(base64Decode(result.base64)), contains('mystery'));
    expect(result.zip, isNotEmpty);
  });

  test('exports selected node assets with relative paths and hashes', () async {
    final directory = await Directory.systemTemp.createTemp('node-export-');
    try {
      final assetFile = File(
        '${directory.path}/nodes/node-1/assets/certificate.pem',
      );
      await assetFile.parent.create(recursive: true);
      final assetBytes = utf8.encode('CERTIFICATE');
      await assetFile.writeAsBytes(assetBytes);
      final digest = sha256.convert(assetBytes).toString();
      final result = await NodeExportService().export(
        [
          ProxyNodeRecord(
            id: 'node-1',
            config: {
              'name': 'WITH-ASSET',
              'type': 'mystery',
              'server': 'HOST',
              'port': 1,
              'tls': {'certificate': assetFile.path},
            },
          ),
        ],
        includeZip: true,
        assets: [
          NodeAsset(
            id: 'certificate',
            nodeId: 'node-1',
            fieldPath: 'tls.certificate',
            relativePath: 'nodes/node-1/assets/certificate.pem',
            sha256: digest,
            size: assetBytes.length,
          ),
        ],
        assetManager: NodeAssetManager(directory.path),
      );
      expect(result.issues.where((issue) => issue.isError), isEmpty);
      final archive = ZipDecoder().decodeBytes(result.zip!);
      final entries = {for (final file in archive.files) file.name: file};
      const archivePath = 'assets/node-1/certificate.pem';
      expect(entries[archivePath]!.content, assetBytes);
      final exportedConfig = jsonDecode(
        utf8.decode(entries['nodes.json']!.content as List<int>),
      );
      expect(exportedConfig['proxies'][0]['tls']['certificate'], archivePath);
      final manifest = jsonDecode(
        utf8.decode(entries['manifest.json']!.content as List<int>),
      );
      expect(manifest['nodes'][0]['assets'][0], {
        'id': 'certificate',
        'fieldPath': 'tls.certificate',
        'path': archivePath,
        'sha256': digest,
        'size': assetBytes.length,
      });
    } finally {
      await directory.delete(recursive: true);
    }
  });

  test('exports generated chain proxies with their selector', () async {
    final result = await NodeExportService().exportConfigs(
      [
        {
          'name': 'CHAIN_1_1_FIRST',
          'type': 'socks5',
          'server': 'HOST_A',
          'port': 1080,
        },
        {
          'name': 'CHAIN_1_2_SECOND',
          'type': 'socks5',
          'server': 'HOST_B',
          'port': 1080,
          'dialer-proxy': 'CHAIN_1_1_FIRST',
        },
      ],
      nodeIds: const ['CHAIN_1_1_FIRST', 'CHAIN_1_2_SECOND'],
      groups: const [
        {
          'name': 'CHAIN_selector',
          'type': 'select',
          'proxies': ['CHAIN_1_2_SECOND'],
        },
      ],
      includeZip: true,
    );

    expect(result.yaml, contains('proxy-groups:'));
    final decoded = jsonDecode(result.json);
    expect(decoded['proxies'], hasLength(2));
    expect(decoded['proxy-groups'][0]['proxies'], ['CHAIN_1_2_SECOND']);
    expect(decoded['proxies'][1]['dialer-proxy'], 'CHAIN_1_1_FIRST');

    final archive = ZipDecoder().decodeBytes(result.zip!);
    final entries = {for (final file in archive.files) file.name: file};
    final manifest = jsonDecode(
      utf8.decode(entries['manifest.json']!.content as List<int>),
    );
    expect(manifest['groups'], [
      {
        'name': 'CHAIN_selector',
        'type': 'select',
        'proxies': ['CHAIN_1_2_SECOND'],
      },
    ]);
    final zipConfig = jsonDecode(
      utf8.decode(entries['nodes.json']!.content as List<int>),
    );
    expect(zipConfig['proxy-groups'][0]['name'], 'CHAIN_selector');
  });

  test('materializes verified assets from portable paths', () async {
    final directory = await Directory.systemTemp.createTemp('node-assets-');
    try {
      final assetFile = File(
        '${directory.path}/nodes/node-1/assets/certificate.pem',
      );
      await assetFile.parent.create(recursive: true);
      final bytes = utf8.encode('CERTIFICATE');
      await assetFile.writeAsBytes(bytes);
      final digest = sha256.convert(bytes).toString();
      final config = await NodeAssetManager(directory.path).materialize(
        {'tls': <String, dynamic>{}},
        [
          NodeAsset(
            id: 'certificate',
            nodeId: 'node-1',
            fieldPath: 'tls.certificate',
            relativePath: r'nodes\node-1\assets\certificate.pem',
            sha256: digest,
            size: bytes.length,
          ),
        ],
      );
      expect(config['tls']['certificate'], assetFile.path);
    } finally {
      await directory.delete(recursive: true);
    }
  });
}
