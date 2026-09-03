import 'dart:convert';

import 'node.dart';

abstract interface class NodeCodec {
  String get scheme;
  NodeDraft parse(String input);
  String? exportUri(Map<String, dynamic> config);
}

class NodeCodecRegistry {
  NodeCodecRegistry([Iterable<NodeCodec>? codecs]) {
    for (final codec in codecs ?? defaultNodeCodecs) {
      _codecs[codec.scheme.toLowerCase()] = codec;
      if (codec is Hysteria2Codec) {
        _codecs['hy2'] = codec;
      }
      if (codec is SocksCodec) {
        _codecs['socks'] = codec;
        _codecs['socks5'] = codec;
        _codecs['socks4'] = codec;
        _codecs['socks4a'] = codec;
      }
    }
  }

  final Map<String, NodeCodec> _codecs = {};

  NodeCodec? operator [](String scheme) => _codecs[scheme.toLowerCase()];
  Iterable<NodeCodec> get codecs => _codecs.values;

  NodeDraft parse(String input) {
    final normalizedInput = normalizeNodeUri(input);
    final uri = Uri.tryParse(normalizedInput);
    final codec = uri == null ? null : this[uri.scheme];
    if (codec == null) {
      return NodeDraft(
        config: const {},
        format: NodeInputKind.uri,
        source: input,
        issues: [
          NodeIssue(
            code: 'unsupported-scheme',
            message: 'Unsupported node scheme',
          ),
        ],
      );
    }
    try {
      final draft = codec.parse(normalizedInput);
      if (draft.issues.any((issue) => issue.isError)) return draft;
      final issues = <NodeIssue>[...draft.issues];
      if (draft.type.isEmpty) {
        issues.add(
          const NodeIssue(
            code: 'missing-type',
            message: 'A node requires a type.',
          ),
        );
      }
      if (draft.name.isEmpty) {
        issues.add(
          const NodeIssue(
            code: 'missing-name',
            message: 'A node requires a name.',
          ),
        );
      }
      if (draft.config['server']?.toString().trim().isEmpty != false) {
        issues.add(
          const NodeIssue(
            code: 'missing-server',
            message: 'A node requires a server.',
          ),
        );
      }
      final port = int.tryParse(draft.config['port']?.toString() ?? '') ?? 0;
      if (port < 1 || port > 65535) {
        issues.add(
          const NodeIssue(
            code: 'invalid-port',
            message: 'A node port must be between 1 and 65535.',
          ),
        );
      }
      final credentialsIssue = _credentialsIssue(draft);
      if (credentialsIssue != null) issues.add(credentialsIssue);
      return NodeDraft(
        config: draft.config,
        source: draft.source,
        sourceKey: draft.sourceKey,
        format: draft.format,
        issues: issues,
        metadata: draft.metadata,
      );
    } catch (error) {
      return NodeDraft(
        config: const {},
        format: NodeInputKind.uri,
        source: input,
        issues: [
          NodeIssue(
            code: 'invalid-uri',
            message: 'Invalid ${uri?.scheme ?? 'node'} URI: $error',
          ),
        ],
      );
    }
  }
}

String normalizeNodeUri(String input) {
  final normalized = input.trim().replaceFirstMapped(
    RegExp(r'^([a-zA-Z][a-zA-Z0-9+.-]*)\s*(?:\\\s*)?:\s*//'),
    (match) => '${match.group(1)}://',
  );
  return normalized
      .replaceAllMapped(RegExp(r'\\([@?#&=])'), (match) => match.group(1)!)
      .replaceAll('&amp;', '&');
}

NodeIssue? _credentialsIssue(NodeDraft draft) {
  final config = draft.config;
  final type = draft.type;
  bool empty(String key) => config[key]?.toString().trim().isEmpty ?? true;
  switch (type) {
    case 'vless':
    case 'vmess':
      return empty('uuid')
          ? const NodeIssue(
              code: 'missing-uuid',
              message: 'A node requires a UUID.',
            )
          : null;
    case 'ss':
      if (empty('cipher')) {
        return const NodeIssue(
          code: 'missing-cipher',
          message: 'A Shadowsocks node requires a cipher.',
        );
      }
      return empty('password')
          ? const NodeIssue(
              code: 'missing-password',
              message: 'A Shadowsocks node requires a password.',
            )
          : null;
    case 'trojan':
    case 'hysteria2':
    case 'anytls':
      return empty('password')
          ? const NodeIssue(
              code: 'missing-password',
              message: 'A node requires a password.',
            )
          : null;
    case 'tuic':
      if (!empty('token')) return null;
      if (empty('uuid')) {
        return const NodeIssue(
          code: 'missing-uuid-or-token',
          message: 'A TUIC node requires a UUID or token.',
        );
      }
      return empty('password')
          ? const NodeIssue(
              code: 'missing-password',
              message: 'A TUIC node requires a password.',
            )
          : null;
  }
  return null;
}

final List<NodeCodec> defaultNodeCodecs = [
  VlessCodec(),
  VmessCodec(),
  ShadowsocksCodec(),
  TrojanCodec(),
  Hysteria2Codec(),
  TuicCodec(),
  AnyTlsCodec(),
  SocksCodec(),
];

Map<String, dynamic> _base(
  String name,
  String type,
  Uri uri, {
  int? defaultPort,
}) {
  return <String, dynamic>{
    'name': name.isEmpty ? '${type}_${uri.host}' : name,
    'type': type,
    'server': uri.host,
    'port': uri.port == -1 ? defaultPort ?? -1 : uri.port,
  };
}

String _name(Uri uri, String type) => uri.fragment.isEmpty
    ? '${type}_${uri.host}'
    : _decodeComponent(uri.fragment);

String _decodeComponent(String value) {
  try {
    return Uri.decodeComponent(value);
  } catch (_) {
    return value;
  }
}

List<String> _listParam(String? value) => value == null || value.isEmpty
    ? const []
    : value.split(',').map(Uri.decodeComponent).toList();

void _tlsFields(
  Map<String, dynamic> config,
  Uri uri, {
  String sniKey = 'servername',
}) {
  final security = uri.queryParameters['security'];
  final tls = uri.queryParameters['tls'];
  if (security == 'tls' ||
      security == 'reality' ||
      _parseBool(security ?? '') ||
      _parseBool(tls ?? '')) {
    config['tls'] = true;
  }
  final sni = uri.queryParameters['sni'] ?? uri.queryParameters['servername'];
  if (sni != null && sni.isNotEmpty) config[sniKey] = sni;
  final fp =
      uri.queryParameters['fp'] ?? uri.queryParameters['client-fingerprint'];
  if (fp != null && fp.isNotEmpty) config['client-fingerprint'] = fp;
  final alpn = _listParam(uri.queryParameters['alpn']);
  if (alpn.isNotEmpty) config['alpn'] = alpn;
  final insecure =
      uri.queryParameters['allowInsecure'] ??
      uri.queryParameters['allow_insecure'] ??
      uri.queryParameters['insecure'] ??
      uri.queryParameters['skip-cert-verify'];
  if (insecure != null) {
    config['skip-cert-verify'] = _parseBool(insecure);
  }
  if (security == 'reality') {
    config['reality-opts'] = <String, dynamic>{
      if (uri.queryParameters['pbk'] != null)
        'public-key': uri.queryParameters['pbk'],
      if (uri.queryParameters['public-key'] != null)
        'public-key': uri.queryParameters['public-key'],
      if (uri.queryParameters['sid'] != null)
        'short-id': uri.queryParameters['sid'],
      if (uri.queryParameters['short-id'] != null)
        'short-id': uri.queryParameters['short-id'],
    };
  }
}

void _certificateFields(Map<String, dynamic> config, Uri uri) {
  final aliases = <String, List<String>>{
    'ca': ['ca', 'ca-file', 'certificate-authority'],
    'ca-str': ['ca-str', 'ca_str', 'ca-cert', 'certificate-authority-data'],
    'certificate': ['certificate', 'cert'],
    'private-key': ['private-key', 'private_key', 'key'],
  };
  for (final entry in aliases.entries) {
    final value = _queryValue(uri, entry.value);
    if (value != null) config[entry.key] = value;
  }
}

void _tlsExtraFields(Map<String, dynamic> config, Uri uri) {
  final nameCert = _queryValue(uri, ['name-cert-verify', 'vcn']);
  if (nameCert != null) config['name-cert-verify'] = nameCert;
  final fingerprint = _queryValue(uri, ['fingerprint', 'pcs', 'pinSHA256']);
  if (fingerprint != null) config['fingerprint'] = fingerprint;
  final ech = uri.queryParameters['ech'];
  if (ech != null && ech.isNotEmpty) {
    config['ech-opts'] = <String, dynamic>{'enable': true, 'config': ech};
  }
}

void _transportFields(
  Map<String, dynamic> config,
  Uri uri, {
  String? networkKey,
}) {
  final network = networkKey == null
      ? uri.queryParameters['type'] ?? uri.queryParameters['network']
      : uri.queryParameters[networkKey] ??
            uri.queryParameters['network'] ??
            _networkType(uri.queryParameters['type']);
  if (network != null && network.isNotEmpty) config['network'] = network;
  final path = uri.queryParameters['path'];
  final host = uri.queryParameters['host'] ?? uri.queryParameters['wsHost'];
  final mode = uri.queryParameters['mode'];
  if (network?.toLowerCase() == 'xhttp') {
    // Mihomo reads XHTTP transport settings from `xhttp-opts` only
    // (XHTTPOptions in adapter/outbound/vless.go), and its `host` is a plain
    // field rather than a header. Reusing `ws-opts` drops `path` and `mode` and
    // lets `host` fall back to the TLS servername, which breaks the node.
    final xhttpOpts = <String, dynamic>{
      'path': ?path,
      'host': ?host,
      'mode': ?mode,
    };
    if (xhttpOpts.isNotEmpty) config['xhttp-opts'] = xhttpOpts;
  } else if (path != null || host != null) {
    final target = switch (network?.toLowerCase()) {
      'http' => 'http-opts',
      'h2' => 'h2-opts',
      _ => 'ws-opts',
    };
    // Mihomo's shapes differ per transport: HTTPOptions takes `path` as a list
    // and `headers` values as lists, HTTP2Options takes `host` as a list with a
    // plain `path`, and WSOptions takes plain strings throughout.
    config[target] = switch (target) {
      'http-opts' => <String, dynamic>{
        if (path != null) 'path': [path],
        if (host != null)
          'headers': <String, dynamic>{
            'Host': [host],
          },
      },
      'h2-opts' => <String, dynamic>{
        'path': ?path,
        if (host != null) 'host': [host],
      },
      _ => <String, dynamic>{
        'path': ?path,
        if (host != null) 'headers': <String, dynamic>{'Host': host},
      },
    };
  }
  final serviceName = uri.queryParameters['serviceName'];
  final authority = uri.queryParameters['authority'];
  if (serviceName != null || authority != null) {
    config['grpc-opts'] = <String, dynamic>{
      if (serviceName != null) 'grpc-service-name': serviceName,
      if (authority != null) 'grpc-authority': authority,
    };
  }
  final httpHost =
      uri.queryParameters['http-host'] ?? uri.queryParameters['httpHost'];
  if (httpHost != null && httpHost.isNotEmpty) {
    config['http-opts'] = <String, dynamic>{
      'path': [uri.queryParameters['path'] ?? '/'],
      'headers': <String, dynamic>{
        'Host': [httpHost],
      },
    };
  }
  final seed = uri.queryParameters['seed'];
  if (seed != null) config['seed'] = seed;
}

String? _networkType(String? value) {
  if (value == null) return null;
  const values = {
    'tcp',
    'ws',
    'http',
    'h2',
    'grpc',
    'quic',
    'httpupgrade',
    'xhttp',
  };
  return values.contains(value.toLowerCase()) ? value : null;
}

Map<String, String> _unknownQuery(Uri uri, Set<String> known) {
  return <String, String>{
    for (final entry in uri.queryParameters.entries)
      if (!known.contains(entry.key)) entry.key: entry.value,
  };
}

String? _queryValue(Uri uri, Iterable<String> keys) {
  for (final key in keys) {
    final value = uri.queryParameters[key];
    if (value != null && value.isNotEmpty) return value;
  }
  return null;
}

dynamic _firstMapValue(Map<String, dynamic> map, Iterable<String> keys) {
  for (final key in keys) {
    if (map[key] != null) return map[key];
  }
  return null;
}

dynamic _decodeStructuredValue(String value) {
  final trimmed = value.trim();
  if (!(trimmed.startsWith('{') || trimmed.startsWith('['))) return value;
  try {
    return jsonDecode(trimmed);
  } catch (_) {
    return value;
  }
}

String _encodeStructuredValue(dynamic value) {
  if (value is Map || value is Iterable) return jsonEncode(value);
  return value.toString();
}

void _appendTlsTransportQuery(
  Map<String, String> query,
  Map<String, dynamic> config,
) {
  if (config['tls'] == true) query['security'] = 'tls';
  final sni = config['sni'] ?? config['servername'];
  if (sni != null) {
    query['sni'] = sni.toString();
  }
  if (config['client-fingerprint'] != null) {
    query['fp'] = config['client-fingerprint'].toString();
  }
  if (config['name-cert-verify'] != null) {
    query['vcn'] = config['name-cert-verify'].toString();
  }
  if (config['fingerprint'] != null) {
    query['pcs'] = config['fingerprint'].toString();
  }
  if (config['skip-cert-verify'] == true) query['allowInsecure'] = '1';
  final alpn = config['alpn'];
  if (alpn is Iterable) query['alpn'] = alpn.join(',');
  if (config['network'] != null) query['type'] = config['network'].toString();
  final ws = config['ws-opts'];
  if (ws is Map) {
    if (ws['path'] != null) query['path'] = ws['path'].toString();
    final headers = ws['headers'];
    if (headers is Map && headers['Host'] != null) {
      query['host'] = headers['Host'].toString();
    }
  }
  final http = config['http-opts'];
  if (http is Map) {
    final path = http['path'];
    if (path is Iterable && path.isNotEmpty)
      query['path'] = path.first.toString();
    if (path is String && path.isNotEmpty) query['path'] = path;
    final headers = http['headers'];
    if (headers is Map && headers['Host'] != null) {
      query['host'] = headers['Host'].toString();
    }
  }
  final xhttp = config['xhttp-opts'];
  if (xhttp is Map) {
    if (xhttp['path'] != null) query['path'] = xhttp['path'].toString();
    if (xhttp['host'] != null) query['host'] = xhttp['host'].toString();
    if (xhttp['mode'] != null) query['mode'] = xhttp['mode'].toString();
  }
  final grpc = config['grpc-opts'];
  if (grpc is Map && grpc['grpc-service-name'] != null) {
    query['serviceName'] = grpc['grpc-service-name'].toString();
  }
  final reality = config['reality-opts'];
  if (reality is Map) {
    query['security'] = 'reality';
    if (reality['public-key'] != null) {
      query['pbk'] = reality['public-key'].toString();
    }
    if (reality['short-id'] != null) {
      query['sid'] = reality['short-id'].toString();
    }
  }
  final ech = config['ech-opts'];
  if (ech is Map && ech['config'] != null) {
    query['ech'] = ech['config'].toString();
  }
}

String _userinfo(Uri uri) =>
    uri.userInfo.isEmpty ? '' : _decodeComponent(uri.userInfo);

List<String> _userinfoParts(Uri uri) {
  final userInfo = uri.userInfo;
  if (userInfo.isEmpty) return const [];
  final separator = userInfo.indexOf(':');
  if (separator < 0) return [_decodeComponent(userInfo)];
  return [
    _decodeComponent(userInfo.substring(0, separator)),
    _decodeComponent(userInfo.substring(separator + 1)),
  ];
}

bool _parseBool(String value) =>
    const {'1', 'true', 'yes', 'on'}.contains(value.toLowerCase());

dynamic _typedValue(String value) {
  final integer = int.tryParse(value);
  if (integer != null) return integer;
  final lower = value.toLowerCase();
  if (const {
    'true',
    'false',
    'yes',
    'no',
    'on',
    'off',
    '1',
    '0',
  }.contains(lower)) {
    return _parseBool(value);
  }
  return value;
}

void _copyKnownQuery(
  Map<String, dynamic> config,
  Uri uri,
  Iterable<String> keys, {
  Set<String> boolKeys = const {},
  Set<String> stringKeys = const {},
}) {
  for (final key in keys) {
    final value = uri.queryParameters[key];
    if (value == null || value.isEmpty) continue;
    config[key] = stringKeys.contains(key)
        ? value
        : boolKeys.contains(key)
        ? _parseBool(value)
        : _typedValue(value);
  }
}

void _commonFields(Map<String, dynamic> config, Uri uri) {
  _copyKnownQuery(
    config,
    uri,
    [
      'udp',
      'tfo',
      'mptcp',
      'ip-version',
      'interface-name',
      'routing-mark',
      'dialer-proxy',
    ],
    boolKeys: {'udp', 'tfo', 'mptcp'},
    stringKeys: {'ip-version', 'interface-name', 'dialer-proxy'},
  );
  // 分享链接极少带 udp 参数，缺了内核就按不支持 UDP 处理并回落到直连。写进配置
  // 而不是只靠生成时兜底，是为了让节点编辑器里能看见、导出分享链接时能带上。
  applyDefaultUdp(config);
}

void _appendCommonQuery(
  Map<String, String> query,
  Map<String, dynamic> config,
) {
  for (final key in [
    'udp',
    'tfo',
    'mptcp',
    'ip-version',
    'interface-name',
    'routing-mark',
    'dialer-proxy',
  ]) {
    if (config[key] != null) query[key] = config[key].toString();
  }
}

class VlessCodec implements NodeCodec {
  const VlessCodec();
  @override
  String get scheme => 'vless';

  @override
  NodeDraft parse(String input) {
    final uri = Uri.parse(normalizeNodeUri(input));
    final config = _base(_name(uri, 'vless'), 'vless', uri, defaultPort: 443);
    config['uuid'] = _userinfo(uri);
    config['encryption'] = uri.queryParameters['encryption'] ?? '';
    final flow = uri.queryParameters['flow'];
    if (flow != null && flow.isNotEmpty) config['flow'] = flow;
    final packetEncoding = _queryValue(uri, [
      'packetEncoding',
      'packet-encoding',
    ]);
    if (packetEncoding != null) config['packet-encoding'] = packetEncoding;
    _tlsFields(config, uri);
    _tlsExtraFields(config, uri);
    _certificateFields(config, uri);
    _transportFields(config, uri);
    _commonFields(config, uri);
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: _unknownQuery(uri, {
        'encryption',
        'flow',
        'security',
        'sni',
        'servername',
        'fp',
        'client-fingerprint',
        'pbk',
        'public-key',
        'sid',
        'short-id',
        'type',
        'network',
        'path',
        'host',
        'wsHost',
        'serviceName',
        'alpn',
        'allowInsecure',
        'allow_insecure',
        'insecure',
        'skip-cert-verify',
        'packetEncoding',
        'packet-encoding',
        'spx',
        'pqv',
        'ech',
        'vcn',
        'pcs',
        'fm',
        'authority',
        'mode',
        'extra',
        'udp',
        'tfo',
        'mptcp',
        'ip-version',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
      }),
    );
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (config['type']?.toString().toLowerCase() != scheme) return null;
    final query = <String, String>{
      'encryption': config['encryption']?.toString() ?? '',
      if (config['flow'] != null) 'flow': config['flow'].toString(),
      if (config['packet-encoding'] != null)
        'packetEncoding': config['packet-encoding'].toString(),
    };
    _appendTlsTransportQuery(query, config);
    _appendCommonQuery(query, config);
    return _buildUri(scheme, config, config['uuid']?.toString() ?? '', query);
  }
}

class VmessCodec implements NodeCodec {
  const VmessCodec();
  @override
  String get scheme => 'vmess';

  @override
  NodeDraft parse(String input) {
    final normalizedInput = normalizeNodeUri(input);
    final uri = Uri.parse(normalizedInput);
    final encoded = normalizedInput
        .substring(normalizedInput.indexOf('://') + 3)
        .split('#')
        .first
        .split('?')
        .first
        .replaceFirst(RegExp(r'^/+'), '');
    final payload = _decodeBase64(encoded);
    if (payload != null) {
      try {
        final value = jsonDecode(payload);
        if (value is Map) {
          return _fromMap(Map<String, dynamic>.from(value), input);
        }
      } catch (_) {
        if (uri.userInfo.isEmpty || uri.host.isEmpty) {
          return NodeDraft(
            config: const {},
            format: NodeInputKind.uri,
            issues: [
              const NodeIssue(
                code: 'invalid-vmess-json',
                message: 'Invalid VMess JSON payload',
              ),
            ],
          );
        }
      }
    }
    if (uri.userInfo.isNotEmpty && uri.host.isNotEmpty) {
      return _parseStandard(uri, input);
    }
    return NodeDraft(
      config: const {},
      format: NodeInputKind.uri,
      issues: [
        const NodeIssue(
          code: 'invalid-vmess-payload',
          message: 'Invalid VMess payload',
        ),
      ],
    );
  }

  NodeDraft _parseStandard(Uri uri, String input) {
    final config = <String, dynamic>{
      'name': _name(uri, 'vmess'),
      'type': 'vmess',
      'server': uri.host,
      'port': uri.port == -1 ? 443 : uri.port,
      'uuid': _userinfo(uri),
      'alterId': int.tryParse(_queryValue(uri, ['aid', 'alterId']) ?? '') ?? 0,
      'cipher': _queryValue(uri, ['scy', 'cipher']) ?? 'auto',
    };
    final network = _queryValue(uri, ['net', 'network', 'type']);
    if (network != null) config['network'] = network;
    final security = _queryValue(uri, ['security', 'tls']);
    if (security == 'tls' ||
        security == 'reality' ||
        security == 'true' ||
        security == '1') {
      config['tls'] = true;
    }
    _tlsFields(config, uri);
    _tlsExtraFields(config, uri);
    _certificateFields(config, uri);
    _transportFields(config, uri, networkKey: 'net');
    if (network?.toLowerCase() == 'quic') {
      config['quic-opts'] = <String, dynamic>{
        if (_queryValue(uri, ['quicSecurity', 'quic-security']) != null)
          'security': _queryValue(uri, ['quicSecurity', 'quic-security']),
        if (_queryValue(uri, ['key', 'quicKey', 'quic-key']) != null)
          'key': _queryValue(uri, ['key', 'quicKey', 'quic-key']),
      };
    }
    _commonFields(config, uri);
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: _unknownQuery(uri, {
        'aid',
        'alterId',
        'scy',
        'cipher',
        'security',
        'tls',
        'net',
        'network',
        'type',
        'path',
        'host',
        'wsHost',
        'serviceName',
        'authority',
        'alpn',
        'sni',
        'servername',
        'fp',
        'client-fingerprint',
        'insecure',
        'allowInsecure',
        'allow_insecure',
        'skip-cert-verify',
        'fingerprint',
        'pcs',
        'pinSHA256',
        'ech',
        'ca',
        'ca-file',
        'certificate-authority',
        'ca-str',
        'ca_str',
        'ca-cert',
        'certificate-authority-data',
        'certificate',
        'cert',
        'private-key',
        'private_key',
        'key',
        'udp',
        'tfo',
        'mptcp',
        'ip-version',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
        'quicSecurity',
        'quic-security',
        'quicKey',
        'quic-key',
        'headerType',
      }),
    );
  }

  NodeDraft _fromMap(Map<String, dynamic> map, String input) {
    final address = map['add'] ?? map['address'] ?? map['server'];
    final portValue = map['port'];
    final config = <String, dynamic>{
      'name': map['ps']?.toString() ?? 'vmess_${address ?? ''}',
      'type': 'vmess',
      'server': address,
      'port': int.tryParse(portValue?.toString() ?? '') ?? portValue,
      'uuid': map['id'] ?? map['uuid'],
      'alterId':
          int.tryParse(map['aid']?.toString() ?? '') ??
          (int.tryParse(map['alterId']?.toString() ?? '') ?? 0),
      'cipher': map['scy'] ?? map['cipher'] ?? 'auto',
      if (map['packetEncoding'] != null)
        'packet-encoding': map['packetEncoding'],
      if (map['packet-encoding'] != null)
        'packet-encoding': map['packet-encoding'],
      if (map['globalPadding'] != null) 'global-padding': map['globalPadding'],
      if (map['global-padding'] != null)
        'global-padding': map['global-padding'],
      if (map['authenticatedLength'] != null)
        'authenticated-length': map['authenticatedLength'],
      if (map['authenticated-length'] != null)
        'authenticated-length': map['authenticated-length'],
    };
    final tls = map['tls'];
    if (tls == true ||
        const {
          'tls',
          'reality',
          'true',
          '1',
          'xtls',
        }.contains(tls?.toString().toLowerCase())) {
      config['tls'] = true;
    }
    if (map['sni'] != null && map['sni'].toString().isNotEmpty) {
      config['servername'] = map['sni'];
    }
    if (map['fp'] != null) config['client-fingerprint'] = map['fp'];
    if (map['client-fingerprint'] != null) {
      config['client-fingerprint'] = map['client-fingerprint'];
    }
    if (_mapBool(map['insecure'] ?? map['allowInsecure'])) {
      config['skip-cert-verify'] = true;
    }
    if (map['vcn'] != null || map['name-cert-verify'] != null) {
      config['name-cert-verify'] = map['vcn'] ?? map['name-cert-verify'];
    }
    if (map['pcs'] != null || map['fingerprint'] != null) {
      config['fingerprint'] = map['pcs'] ?? map['fingerprint'];
    }
    if (map['ech'] != null) {
      config['ech-opts'] = <String, dynamic>{
        'enable': true,
        'config': map['ech'],
      };
    }
    final certificateAliases = <String, List<String>>{
      'ca': ['ca', 'ca-file', 'certificate-authority'],
      'ca-str': ['ca-str', 'ca_str', 'ca-cert'],
      'certificate': ['certificate', 'cert'],
      'private-key': ['private-key', 'private_key', 'key'],
    };
    for (final entry in certificateAliases.entries) {
      final value = _firstMapValue(map, entry.value);
      if (value != null) config[entry.key] = value;
    }
    final network = map['net'] ?? map['network'];
    if (network != null && network.toString().isNotEmpty) {
      config['network'] = network;
    }
    final networkType = network?.toString().toLowerCase();
    final host = map['host'];
    final path = map['path'];
    final mode = map['mode'];
    if (networkType == 'xhttp') {
      // See _transportFields: mihomo takes XHTTP settings from `xhttp-opts`.
      final xhttpOpts = <String, dynamic>{
        'path': ?path,
        'host': ?host,
        'mode': ?mode,
      };
      if (xhttpOpts.isNotEmpty) config['xhttp-opts'] = xhttpOpts;
    } else if (networkType == 'ws' || networkType == 'httpupgrade') {
      config['ws-opts'] = <String, dynamic>{
        if (path != null) 'path': path,
        if (host != null) 'headers': <String, dynamic>{'Host': host},
      };
    } else if (networkType == 'http') {
      config['http-opts'] = <String, dynamic>{
        if (path != null) 'path': [path],
        if (host != null)
          'headers': <String, dynamic>{
            'Host': [host],
          },
      };
    } else if (networkType == 'h2') {
      config['h2-opts'] = <String, dynamic>{
        'path': ?path,
        if (host != null) 'host': [host],
      };
    } else if (networkType == 'grpc') {
      config['grpc-opts'] = <String, dynamic>{
        if (path != null) 'grpc-service-name': path,
        if (host != null) 'grpc-authority': host,
      };
    }
    if (networkType == 'quic') {
      final quicSecurity = map['quicSecurity'] ?? map['quic-security'];
      final quicKey = map['key'] ?? map['quicKey'] ?? map['quic-key'];
      config['quic-opts'] = <String, dynamic>{
        if (quicSecurity != null) 'security': quicSecurity,
        if (quicKey != null) 'key': quicKey,
      };
    }
    final commonAliases = <String, List<String>>{
      'udp': ['udp'],
      'tfo': ['tfo'],
      'mptcp': ['mptcp'],
      'ip-version': ['ip-version', 'ip'],
      'interface-name': ['interface-name', 'interface'],
      'routing-mark': ['routing-mark', 'routingMark'],
      'dialer-proxy': ['dialer-proxy', 'dialerProxy'],
    };
    for (final entry in commonAliases.entries) {
      final value = _firstMapValue(map, entry.value);
      if (value != null) config[entry.key] = value;
    }
    final known = <String>{
      'v',
      'ps',
      'add',
      'address',
      'server',
      'port',
      'id',
      'uuid',
      'aid',
      'alterId',
      'scy',
      'cipher',
      'packetEncoding',
      'packet-encoding',
      'globalPadding',
      'global-padding',
      'authenticatedLength',
      'authenticated-length',
      'tls',
      'sni',
      'fp',
      'client-fingerprint',
      'insecure',
      'allowInsecure',
      'vcn',
      'name-cert-verify',
      'pcs',
      'fingerprint',
      'ech',
      'net',
      'network',
      'host',
      'path',
      'serviceName',
      'authority',
      'quicSecurity',
      'quic-security',
      'quicKey',
      'quic-key',
      'key',
      'udp',
      'tfo',
      'mptcp',
      'ip-version',
      'ip',
      'interface-name',
      'interface',
      'routing-mark',
      'routingMark',
      'dialer-proxy',
      'dialerProxy',
      'ca',
      'ca-file',
      'certificate-authority',
      'ca-str',
      'ca_str',
      'ca-cert',
      'certificate',
      'cert',
      'private-key',
      'private_key',
    };
    final metadata = <String, dynamic>{
      for (final entry in map.entries)
        if (!known.contains(entry.key)) entry.key.toString(): entry.value,
    };
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: metadata,
    );
  }

  bool _mapBool(dynamic value) {
    if (value is bool) return value;
    return value != null && _parseBool(value.toString());
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (config['type']?.toString().toLowerCase() != scheme) return null;
    final ws = config['ws-opts'];
    final headers = ws is Map ? ws['headers'] : null;
    final quic = config['quic-opts'];
    final payload = <String, dynamic>{
      'v': '2',
      'ps': config['name'] ?? '',
      'add': config['server'],
      'port': config['port'],
      'id': config['uuid'],
      'aid': config['alterId'] ?? 0,
      'scy': config['cipher'] ?? 'auto',
      'net': config['network'] ?? 'tcp',
      'tls': config['tls'] == true ? 'tls' : '',
      if (config['skip-cert-verify'] == true) 'insecure': 1,
      if ((config['servername'] ?? config['sni']) != null)
        'sni': config['servername'] ?? config['sni'],
      if (config['client-fingerprint'] != null)
        'fp': config['client-fingerprint'],
      if (config['packet-encoding'] != null)
        'packetEncoding': config['packet-encoding'],
      if (config['fingerprint'] != null) 'fingerprint': config['fingerprint'],
      if (config['ech-opts'] is Map &&
          (config['ech-opts'] as Map)['config'] != null)
        'ech': (config['ech-opts'] as Map)['config'],
      if (config['ca'] != null) 'ca': config['ca'],
      if (config['ca-str'] != null) 'ca-str': config['ca-str'],
      if (config['certificate'] != null) 'certificate': config['certificate'],
      if (config['private-key'] != null) 'private-key': config['private-key'],
      if (config['global-padding'] != null)
        'globalPadding': config['global-padding'],
      if (config['authenticated-length'] != null)
        'authenticatedLength': config['authenticated-length'],
      if (headers is Map && headers['Host'] != null) 'host': headers['Host'],
      if (ws is Map && ws['path'] != null) 'path': ws['path'],
      if (config['http-opts'] is Map &&
          (config['http-opts'] as Map)['path'] is List &&
          (config['http-opts'] as Map)['path'].isNotEmpty)
        'path': (config['http-opts'] as Map)['path'].first,
      if (config['http-opts'] is Map &&
          (config['http-opts'] as Map)['headers'] is Map &&
          _firstHeaderValue((config['http-opts'] as Map)['headers']['Host']) !=
              null)
        'host': _firstHeaderValue(
          (config['http-opts'] as Map)['headers']['Host'],
        ),
      if (config['h2-opts'] is Map && (config['h2-opts'] as Map)['path'] != null)
        'path': (config['h2-opts'] as Map)['path'],
      if (config['h2-opts'] is Map &&
          _firstHeaderValue((config['h2-opts'] as Map)['host']) != null)
        'host': _firstHeaderValue((config['h2-opts'] as Map)['host']),
      if (config['grpc-opts'] is Map &&
          (config['grpc-opts'] as Map)['grpc-service-name'] != null)
        'path': (config['grpc-opts'] as Map)['grpc-service-name'],
      if (config['xhttp-opts'] is Map &&
          (config['xhttp-opts'] as Map)['path'] != null)
        'path': (config['xhttp-opts'] as Map)['path'],
      if (config['xhttp-opts'] is Map &&
          (config['xhttp-opts'] as Map)['host'] != null)
        'host': (config['xhttp-opts'] as Map)['host'],
      if (config['xhttp-opts'] is Map &&
          (config['xhttp-opts'] as Map)['mode'] != null)
        'mode': (config['xhttp-opts'] as Map)['mode'],
      if (quic is Map && quic['security'] != null)
        'quicSecurity': quic['security'],
      if (quic is Map && quic['key'] != null) 'key': quic['key'],
      if (config['udp'] != null) 'udp': config['udp'],
      if (config['tfo'] != null) 'tfo': config['tfo'],
      if (config['mptcp'] != null) 'mptcp': config['mptcp'],
      if (config['ip-version'] != null) 'ip': config['ip-version'],
      if (config['interface-name'] != null)
        'interface': config['interface-name'],
      if (config['routing-mark'] != null) 'routingMark': config['routing-mark'],
      if (config['dialer-proxy'] != null)
        'dialer-proxy': config['dialer-proxy'],
    };
    return 'vmess://${base64Url.encode(utf8.encode(jsonEncode(payload)))}';
  }
}

class ShadowsocksCodec implements NodeCodec {
  const ShadowsocksCodec();
  @override
  String get scheme => 'ss';

  @override
  NodeDraft parse(String input) {
    final normalizedInput = normalizeNodeUri(input);
    final uri = Uri.parse(normalizedInput);
    final rawAuthority = normalizedInput
        .substring(normalizedInput.indexOf('://') + 3)
        .split('#')
        .first
        .split('?')
        .first;
    if (!rawAuthority.contains('@')) {
      final decoded = _decodeBase64(rawAuthority);
      final separator = decoded?.lastIndexOf('@') ?? -1;
      if (decoded != null && separator > 0) {
        final credentials = decoded.substring(0, separator);
        final address = Uri.tryParse(
          'ss://${decoded.substring(separator + 1)}',
        );
        if (address != null) {
          return _parse(address, _name(uri, 'ss'), input, credentials);
        }
      }
    }
    final user = _userinfo(uri);
    return _parse(uri, _name(uri, 'ss'), input, user);
  }

  NodeDraft _parse(Uri uri, String name, String source, [String? user]) {
    var credentialsText = user ?? _userinfo(uri);
    if (!credentialsText.contains(':')) {
      final decoded = _decodeBase64(credentialsText);
      if (decoded != null) credentialsText = decoded;
    }
    final credentials = credentialsText.split(':');
    final config = _base(name, 'ss', uri);
    if (credentials.length >= 2) {
      config['cipher'] = credentials.first;
      config['password'] = credentials.sublist(1).join(':');
    }
    final plugin = uri.queryParameters['plugin'];
    if (plugin != null) config['plugin'] = plugin;
    final tag = uri.queryParameters['tag'];
    if (tag != null && tag.isNotEmpty) config['name'] = tag;
    _copyKnownQuery(
      config,
      uri,
      ['udp', 'tfo', 'uot', 'ip-version'],
      boolKeys: {'udp', 'tfo', 'uot'},
      stringKeys: {'ip-version'},
    );
    _commonFields(config, uri);
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: source,
      metadata: _unknownQuery(uri, {
        'plugin',
        'tag',
        'udp',
        'tfo',
        'uot',
        'ip-version',
        'mptcp',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
      }),
    );
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (config['type']?.toString().toLowerCase() != scheme) return null;
    final user = '${config['cipher']}:${config['password']}';
    final authority = base64Url.encode(utf8.encode(user)).replaceAll('=', '');
    final queryValues = <String, String>{
      if (config['plugin'] != null) 'plugin': config['plugin'].toString(),
      for (final key in ['udp', 'tfo', 'uot', 'ip-version'])
        if (config[key] != null) key: config[key].toString(),
    };
    _appendCommonQuery(queryValues, config);
    final query = queryValues.isEmpty
        ? ''
        : '?${(queryValues.entries.toList()..sort((a, b) => a.key.compareTo(b.key))).map((entry) => '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}').join('&')}';
    final name = config['name'] == null
        ? ''
        : '#${Uri.encodeComponent(config['name'].toString())}';
    return 'ss://$authority@${_hostPort(config)}$query$name';
  }
}

class TrojanCodec implements NodeCodec {
  const TrojanCodec();
  @override
  String get scheme => 'trojan';
  @override
  NodeDraft parse(String input) {
    final uri = Uri.parse(normalizeNodeUri(input));
    final config = _base(_name(uri, 'trojan'), 'trojan', uri, defaultPort: 443);
    config['password'] = _userinfo(uri).isNotEmpty
        ? _userinfo(uri)
        : uri.queryParameters['password'] ?? uri.queryParameters['auth'] ?? '';
    _tlsFields(config, uri, sniKey: 'sni');
    _tlsExtraFields(config, uri);
    _certificateFields(config, uri);
    _transportFields(config, uri);
    _commonFields(config, uri);
    final flow = uri.queryParameters['flow'];
    if (flow != null && flow.isNotEmpty) config['flow'] = flow;
    final security = uri.queryParameters['security'];
    if (security == 'none') config.remove('tls');
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: _unknownQuery(uri, {
        'password',
        'auth',
        'security',
        'sni',
        'servername',
        'fp',
        'client-fingerprint',
        'allowInsecure',
        'allow_insecure',
        'insecure',
        'skip-cert-verify',
        'alpn',
        'type',
        'network',
        'path',
        'host',
        'wsHost',
        'serviceName',
        'authority',
        'flow',
        'udp',
        'tfo',
        'mptcp',
        'ip-version',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
      }),
    );
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (config['type']?.toString().toLowerCase() != scheme) return null;
    final query = <String, String>{};
    _appendTlsTransportQuery(query, config);
    _appendCommonQuery(query, config);
    return _buildUri(
      scheme,
      config,
      config['password']?.toString() ?? '',
      query,
    );
  }
}

class Hysteria2Codec implements NodeCodec {
  const Hysteria2Codec();
  @override
  String get scheme => 'hysteria2';
  @override
  NodeDraft parse(String input) {
    final uri = Uri.parse(normalizeNodeUri(input));
    final config = _base(
      _name(uri, 'hysteria2'),
      'hysteria2',
      uri,
      defaultPort: 443,
    );
    final userInfo = _userinfo(uri);
    config['password'] = userInfo.isNotEmpty
        ? userInfo
        : uri.queryParameters['password'] ?? '';
    _tlsFields(config, uri, sniKey: 'sni');
    _tlsExtraFields(config, uri);
    _certificateFields(config, uri);
    _commonFields(config, uri);
    final obfs = uri.queryParameters['obfs'];
    if (obfs != null) config['obfs'] = obfs;
    final obfsPassword = uri.queryParameters['obfs-password'];
    if (obfsPassword != null) config['obfs-password'] = obfsPassword;
    final ports = uri.queryParameters['mport'] ?? uri.queryParameters['ports'];
    if (ports != null) config['ports'] = ports;
    if (uri.queryParameters['hop-interval'] != null) {
      config['hop-interval'] = _typedValue(
        uri.queryParameters['hop-interval']!,
      );
    }
    final fingerprint = _queryValue(uri, ['fingerprint', 'pinSHA256']);
    if (fingerprint != null) config['fingerprint'] = fingerprint;
    final minPacketSize = _queryValue(uri, [
      'obfs-min-packet-size',
      'minPacketSize',
    ]);
    if (minPacketSize != null)
      config['obfs-min-packet-size'] = _typedValue(minPacketSize);
    final maxPacketSize = _queryValue(uri, [
      'obfs-max-packet-size',
      'maxPacketSize',
    ]);
    if (maxPacketSize != null)
      config['obfs-max-packet-size'] = _typedValue(maxPacketSize);
    _copyKnownQuery(
      config,
      uri,
      [
        'up',
        'down',
        'recv-window-conn',
        'recv-window',
        'max-incoming-connection',
        'fast-open',
        'disable-mtu-discovery',
        'protocol',
        'bbr-profile',
        'handshake-timeout',
        'initial-stream-receive-window',
        'max-stream-receive-window',
        'initial-connection-receive-window',
        'max-connection-receive-window',
      ],
      boolKeys: {'fast-open', 'disable-mtu-discovery'},
      stringKeys: {'up', 'down', 'protocol', 'bbr-profile'},
    );
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: _unknownQuery(uri, {
        'sni',
        'servername',
        'insecure',
        'allowInsecure',
        'allow_insecure',
        'skip-cert-verify',
        'alpn',
        'fingerprint',
        'pinSHA256',
        'ech',
        'ca',
        'ca-file',
        'certificate-authority',
        'ca-str',
        'ca_str',
        'ca-cert',
        'certificate-authority-data',
        'certificate',
        'cert',
        'private-key',
        'private_key',
        'key',
        'obfs',
        'obfs-password',
        'obfs-min-packet-size',
        'obfs-max-packet-size',
        'minPacketSize',
        'maxPacketSize',
        'mport',
        'ports',
        'hop-interval',
        'up',
        'down',
        'recv-window-conn',
        'recv-window',
        'max-incoming-connection',
        'fast-open',
        'disable-mtu-discovery',
        'protocol',
        'bbr-profile',
        'handshake-timeout',
        'initial-stream-receive-window',
        'max-stream-receive-window',
        'initial-connection-receive-window',
        'max-connection-receive-window',
        'udp',
        'tfo',
        'mptcp',
        'ip-version',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
      }),
    );
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (config['type']?.toString().toLowerCase() != scheme) return null;
    final query = <String, String>{
      if (config['sni'] != null) 'sni': config['sni'].toString(),
      if (config['servername'] != null && config['sni'] == null)
        'sni': config['servername'].toString(),
      if (config['alpn'] is Iterable)
        'alpn': (config['alpn'] as Iterable).join(','),
      if (config['skip-cert-verify'] == true) 'insecure': '1',
      if (config['fingerprint'] != null)
        'pinSHA256': config['fingerprint'].toString(),
      if (config['name-cert-verify'] != null)
        'vcn': config['name-cert-verify'].toString(),
      if (config['ech-opts'] is Map &&
          (config['ech-opts'] as Map)['config'] != null)
        'ech': (config['ech-opts'] as Map)['config'].toString(),
      if (config['ech'] != null) 'ech': config['ech'].toString(),
      if (config['ca'] != null) 'ca': config['ca'].toString(),
      if (config['ca-str'] != null) 'ca-str': config['ca-str'].toString(),
      if (config['certificate'] != null)
        'certificate': config['certificate'].toString(),
      if (config['private-key'] != null)
        'private-key': config['private-key'].toString(),
      if (config['obfs'] != null) 'obfs': config['obfs'].toString(),
      if (config['obfs-password'] != null)
        'obfs-password': config['obfs-password'].toString(),
      if (config['ports'] != null) 'mport': config['ports'].toString(),
      if (config['hop-interval'] != null)
        'hop-interval': config['hop-interval'].toString(),
      for (final key in [
        'up',
        'down',
        'recv-window-conn',
        'recv-window',
        'max-incoming-connection',
        'fast-open',
        'disable-mtu-discovery',
        'protocol',
        'bbr-profile',
        'handshake-timeout',
        'initial-stream-receive-window',
        'max-stream-receive-window',
        'initial-connection-receive-window',
        'max-connection-receive-window',
      ])
        if (config[key] != null) key: config[key].toString(),
      for (final entry in {
        'obfs-min-packet-size': 'minPacketSize',
        'obfs-max-packet-size': 'maxPacketSize',
      }.entries)
        if (config[entry.key] != null)
          entry.value: config[entry.key].toString(),
    };
    query.remove('fingerprint');
    _appendCommonQuery(query, config);
    return _buildUri(
      scheme,
      config,
      config['password']?.toString() ?? '',
      query,
    );
  }
}

class TuicCodec implements NodeCodec {
  const TuicCodec();
  @override
  String get scheme => 'tuic';
  @override
  NodeDraft parse(String input) {
    final uri = Uri.parse(normalizeNodeUri(input));
    final config = _base(_name(uri, 'tuic'), 'tuic', uri, defaultPort: 443);
    final userInfo = _userinfo(uri);
    final separator = userInfo.indexOf(':');
    final queryUuid = _queryValue(uri, ['uuid']);
    final queryPassword = _queryValue(uri, ['password', 'auth']);
    final queryToken = _queryValue(uri, ['token']);
    if (queryToken != null) config['token'] = queryToken;
    if (separator > 0) {
      config['uuid'] = userInfo.substring(0, separator);
      config['password'] = userInfo.substring(separator + 1);
    } else if (queryPassword != null && userInfo.isNotEmpty) {
      config['uuid'] = userInfo;
      config['password'] = queryPassword;
    } else if (userInfo.isNotEmpty && queryToken == null) {
      config['token'] = userInfo;
    }
    if (queryUuid != null) config['uuid'] = queryUuid;
    if (queryPassword != null) config['password'] = queryPassword;
    _tlsFields(config, uri, sniKey: 'sni');
    _tlsExtraFields(config, uri);
    _certificateFields(config, uri);
    _commonFields(config, uri);
    final congestion = _queryValue(uri, [
      'congestion-controller',
      'congestion_control',
    ]);
    if (congestion != null) config['congestion-controller'] = congestion;
    final relay = _queryValue(uri, ['udp-relay-mode', 'udp_relay_mode']);
    if (relay != null) config['udp-relay-mode'] = relay;
    final heartbeat = _queryValue(uri, [
      'heartbeat-interval',
      'heartbeat_interval',
      'heartbeat',
    ]);
    if (heartbeat != null)
      config['heartbeat-interval'] = _typedValue(heartbeat);
    _copyKnownQuery(
      config,
      uri,
      [
        'ip',
        'disable-sni',
        'disable_sni',
        'reduce-rtt',
        'reduce_rtt',
        'request-timeout',
        'request_timeout',
        'max-udp-relay-packet-size',
        'max_udp_relay_packet_size',
        'fast-open',
        'fast_open',
        'max-open-streams',
        'max_open_streams',
        'bbr-profile',
        'bbr_profile',
        'zero-rtt-handshake',
        'zero_rtt_handshake',
      ],
      boolKeys: {
        'disable-sni',
        'disable_sni',
        'reduce-rtt',
        'reduce_rtt',
        'fast-open',
        'fast_open',
        'zero-rtt-handshake',
        'zero_rtt_handshake',
      },
      stringKeys: {'ip', 'bbr-profile', 'bbr_profile'},
    );
    _renameKey(config, 'disable_sni', 'disable-sni');
    _renameKey(config, 'reduce_rtt', 'reduce-rtt');
    _renameKey(config, 'request_timeout', 'request-timeout');
    _renameKey(
      config,
      'max_udp_relay_packet_size',
      'max-udp-relay-packet-size',
    );
    _renameKey(config, 'fast_open', 'fast-open');
    _renameKey(config, 'max_open_streams', 'max-open-streams');
    _renameKey(config, 'bbr_profile', 'bbr-profile');
    _renameKey(config, 'zero_rtt_handshake', 'zero-rtt-handshake');
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: _unknownQuery(uri, {
        'token',
        'uuid',
        'password',
        'auth',
        'sni',
        'servername',
        'fp',
        'client-fingerprint',
        'fingerprint',
        'pcs',
        'pinSHA256',
        'alpn',
        'allowInsecure',
        'allow_insecure',
        'insecure',
        'skip-cert-verify',
        'congestion-controller',
        'congestion_control',
        'udp-relay-mode',
        'udp_relay_mode',
        'heartbeat-interval',
        'heartbeat_interval',
        'heartbeat',
        'ip',
        'disable-sni',
        'disable_sni',
        'reduce-rtt',
        'reduce_rtt',
        'request-timeout',
        'request_timeout',
        'max-udp-relay-packet-size',
        'max_udp_relay_packet_size',
        'fast-open',
        'fast_open',
        'max-open-streams',
        'max_open_streams',
        'bbr-profile',
        'bbr_profile',
        'zero-rtt-handshake',
        'zero_rtt_handshake',
        'ca',
        'ca-file',
        'certificate-authority',
        'ca-str',
        'ca_str',
        'ca-cert',
        'certificate-authority-data',
        'certificate',
        'cert',
        'private-key',
        'private_key',
        'key',
        'udp',
        'tfo',
        'mptcp',
        'ip-version',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
      }),
    );
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (config['type']?.toString().toLowerCase() != scheme) return null;
    final credentials = config['token']?.toString().isNotEmpty == true
        ? config['token'].toString()
        : '${config['uuid'] ?? ''}:${config['password'] ?? ''}';
    return _buildUri(scheme, config, credentials, {
      if (config['sni'] != null) 'sni': config['sni'].toString(),
      if (config['sni'] == null && config['servername'] != null)
        'sni': config['servername'].toString(),
      if (config['skip-cert-verify'] == true) 'allow_insecure': '1',
      if (config['alpn'] is Iterable)
        'alpn': (config['alpn'] as Iterable).join(','),
      if (config['congestion-controller'] != null)
        'congestion_control': config['congestion-controller'].toString(),
      if (config['udp-relay-mode'] != null)
        'udp_relay_mode': config['udp-relay-mode'].toString(),
      if (config['heartbeat-interval'] != null)
        'heartbeat_interval': config['heartbeat-interval'].toString(),
      if (config['disable-sni'] != null)
        'disable_sni': config['disable-sni'].toString(),
      if (config['reduce-rtt'] != null)
        'reduce_rtt': config['reduce-rtt'].toString(),
      if (config['request-timeout'] != null)
        'request_timeout': config['request-timeout'].toString(),
      if (config['max-udp-relay-packet-size'] != null)
        'max_udp_relay_packet_size': config['max-udp-relay-packet-size']
            .toString(),
      if (config['fast-open'] != null)
        'fast_open': config['fast-open'].toString(),
      if (config['max-open-streams'] != null)
        'max_open_streams': config['max-open-streams'].toString(),
      if (config['bbr-profile'] != null)
        'bbr_profile': config['bbr-profile'].toString(),
      if (config['zero-rtt-handshake'] != null)
        'zero_rtt_handshake': config['zero-rtt-handshake'].toString(),
      if (config['ca'] != null) 'ca': config['ca'].toString(),
      if (config['ca-str'] != null) 'ca_str': config['ca-str'].toString(),
      if (config['certificate'] != null)
        'certificate': config['certificate'].toString(),
      if (config['private-key'] != null)
        'private_key': config['private-key'].toString(),
      if (config['udp'] != null) 'udp': config['udp'].toString(),
      if (config['tfo'] != null) 'tfo': config['tfo'].toString(),
      if (config['mptcp'] != null) 'mptcp': config['mptcp'].toString(),
      if (config['ip-version'] != null)
        'ip-version': config['ip-version'].toString(),
      if (config['interface-name'] != null)
        'interface-name': config['interface-name'].toString(),
      if (config['routing-mark'] != null)
        'routing-mark': config['routing-mark'].toString(),
      if (config['dialer-proxy'] != null)
        'dialer-proxy': config['dialer-proxy'].toString(),
    });
  }
}

void _renameKey(Map<String, dynamic> config, String from, String to) {
  if (config[from] == null || config[to] != null) return;
  config[to] = config.remove(from);
}

class AnyTlsCodec implements NodeCodec {
  const AnyTlsCodec();
  @override
  String get scheme => 'anytls';
  @override
  NodeDraft parse(String input) {
    final uri = Uri.parse(normalizeNodeUri(input));
    final config = _base(_name(uri, 'anytls'), 'anytls', uri, defaultPort: 443);
    config['password'] = _userinfo(uri).isNotEmpty
        ? _userinfo(uri)
        : uri.queryParameters['password'] ?? '';
    _tlsFields(config, uri, sniKey: 'sni');
    _tlsExtraFields(config, uri);
    _certificateFields(config, uri);
    _commonFields(config, uri);
    _copyKnownQuery(
      config,
      uri,
      [
        'idle-session-check-interval',
        'idle-session-timeout',
        'min-idle-session',
        'padding-scheme',
        'client-metadata',
        'name-cert-verify',
        'udp',
        'disable-sni',
        'disable_sni',
      ],
      boolKeys: {'udp', 'disable-sni', 'disable_sni'},
      stringKeys: {'padding-scheme', 'client-metadata', 'name-cert-verify'},
    );
    _renameKey(config, 'disable_sni', 'disable-sni');
    for (final key in ['shadow-tls-opts', 'restls-opts', 'jls-opts']) {
      final value = uri.queryParameters[key];
      if (value != null && value.isNotEmpty) {
        config[key] = _decodeStructuredValue(value);
      }
    }
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: _unknownQuery(uri, {
        'sni',
        'servername',
        'insecure',
        'allowInsecure',
        'allow_insecure',
        'skip-cert-verify',
        'fp',
        'client-fingerprint',
        'fingerprint',
        'pcs',
        'pinSHA256',
        'alpn',
        'idle-session-check-interval',
        'idle-session-timeout',
        'min-idle-session',
        'padding-scheme',
        'client-metadata',
        'name-cert-verify',
        'password',
        'shadow-tls-opts',
        'restls-opts',
        'jls-opts',
        'udp',
        'disable-sni',
        'disable_sni',
        'ca',
        'ca-file',
        'certificate-authority',
        'ca-str',
        'ca_str',
        'ca-cert',
        'certificate-authority-data',
        'certificate',
        'cert',
        'private-key',
        'private_key',
        'key',
        'tfo',
        'mptcp',
        'ip-version',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
      }),
    );
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (config['type']?.toString().toLowerCase() != scheme) return null;
    final query = <String, String>{
      if (config['sni'] != null) 'sni': config['sni'].toString(),
      if (config['sni'] == null && config['servername'] != null)
        'sni': config['servername'].toString(),
      if (config['alpn'] is Iterable)
        'alpn': (config['alpn'] as Iterable).join(','),
      if (config['client-fingerprint'] != null)
        'fp': config['client-fingerprint'].toString(),
      if (config['fingerprint'] != null)
        'pcs': config['fingerprint'].toString(),
      if (config['name-cert-verify'] != null)
        'vcn': config['name-cert-verify'].toString(),
      if (config['ech-opts'] is Map &&
          (config['ech-opts'] as Map)['config'] != null)
        'ech': (config['ech-opts'] as Map)['config'].toString(),
      if (config['skip-cert-verify'] == true) 'insecure': '1',
      if (config['idle-session-check-interval'] != null)
        'idle-session-check-interval': config['idle-session-check-interval']
            .toString(),
      if (config['idle-session-timeout'] != null)
        'idle-session-timeout': config['idle-session-timeout'].toString(),
      if (config['min-idle-session'] != null)
        'min-idle-session': config['min-idle-session'].toString(),
      if (config['padding-scheme'] != null)
        'padding-scheme': config['padding-scheme'].toString(),
      if (config['client-metadata'] != null)
        'client-metadata': config['client-metadata'].toString(),
      if (config['shadow-tls-opts'] != null)
        'shadow-tls-opts': _encodeStructuredValue(config['shadow-tls-opts']),
      if (config['restls-opts'] != null)
        'restls-opts': _encodeStructuredValue(config['restls-opts']),
      if (config['jls-opts'] != null)
        'jls-opts': _encodeStructuredValue(config['jls-opts']),
      if (config['udp'] != null) 'udp': config['udp'].toString(),
      if (config['disable-sni'] != null)
        'disable-sni': config['disable-sni'].toString(),
      if (config['ca'] != null) 'ca': config['ca'].toString(),
      if (config['ca-str'] != null) 'ca-str': config['ca-str'].toString(),
      if (config['certificate'] != null)
        'certificate': config['certificate'].toString(),
      if (config['private-key'] != null)
        'private-key': config['private-key'].toString(),
    };
    _appendCommonQuery(query, config);
    return _buildUri(
      scheme,
      config,
      config['password']?.toString() ?? '',
      query,
    );
  }
}

class SocksCodec implements NodeCodec {
  const SocksCodec();
  @override
  String get scheme => 'socks5';
  @override
  NodeDraft parse(String input) {
    final uri = Uri.parse(normalizeNodeUri(input));
    // Mihomo only registers `socks5`; a bare `socks` type is rejected by
    // adapter.ParseProxy. SOCKS4/4a keep their variant in `version` below,
    // which `_socksScheme` uses to restore the scheme on export.
    final config = _base(_name(uri, 'socks'), 'socks5', uri, defaultPort: 1080);
    if (uri.scheme == 'socks4' || uri.scheme == 'socks4a') {
      config['version'] = uri.scheme == 'socks4' ? 4 : '4a';
    }
    if (uri.userInfo.isNotEmpty) {
      final user = _credentialParts(uri);
      config['username'] = user.first;
      if (user.length > 1) config['password'] = user[1];
    }
    config['username'] ??= uri.queryParameters['username'];
    config['password'] ??= uri.queryParameters['password'];
    if (_parseBool(uri.queryParameters['tls'] ?? '')) config['tls'] = true;
    if (_parseBool(uri.queryParameters['insecure'] ?? '')) {
      config['skip-cert-verify'] = true;
    }
    _commonFields(config, uri);
    return NodeDraft(
      config: config,
      format: NodeInputKind.uri,
      source: input,
      metadata: _unknownQuery(uri, {
        'username',
        'password',
        'tls',
        'insecure',
        'udp',
        'tfo',
        'mptcp',
        'ip-version',
        'interface-name',
        'routing-mark',
        'dialer-proxy',
      }),
    );
  }

  @override
  String? exportUri(Map<String, dynamic> config) {
    if (![
      'socks',
      'socks5',
      'socks4',
      'socks4a',
    ].contains(config['type']?.toString().toLowerCase()))
      return null;
    final username = config['username']?.toString();
    final password = config['password']?.toString();
    final user = username == null
        ? ''
        : '${Uri.encodeComponent(username)}${password == null ? '' : ':${Uri.encodeComponent(password)}'}@';
    final query = <String, String>{
      if (config['tls'] == true) 'tls': '1',
      if (config['skip-cert-verify'] == true) 'insecure': '1',
      if (username == null && config['username'] != null)
        'username': config['username'].toString(),
      if (password == null && config['password'] != null)
        'password': config['password'].toString(),
    };
    _appendCommonQuery(query, config);
    final params = (query.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
        .map(
          (entry) =>
              '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}',
        )
        .join('&');
    final name = config['name'] == null
        ? ''
        : '#${Uri.encodeComponent(config['name'].toString())}';
    final exportScheme = _socksScheme(config);
    return '$exportScheme://$user${_hostPort(config)}${params.isEmpty ? '' : '?$params'}$name';
  }
}

/// Userinfo split that also understands the widespread
/// `scheme://base64(user:password)@host:port` form used by SOCKS and HTTP
/// share links. The base64 branch only applies when the decoded value actually
/// carries a separator, so a literal username that happens to be valid base64
/// is left untouched.
List<String> _credentialParts(Uri uri) {
  final parts = _userinfoParts(uri);
  if (parts.length != 1) return parts;
  final decoded = _decodeBase64(parts.first);
  if (decoded == null) return parts;
  final separator = decoded.indexOf(':');
  if (separator <= 0) return parts;
  return [decoded.substring(0, separator), decoded.substring(separator + 1)];
}

String _socksScheme(Map<String, dynamic> config) {
  final type = config['type']?.toString().toLowerCase();
  if (type == 'socks4' || type == 'socks4a') return type!;
  final version = config['version']?.toString().toLowerCase();
  if (version == '4') return 'socks4';
  if (version == '4a') return 'socks4a';
  return 'socks5';
}

/// Reads a header/host value that mihomo models as either a plain string
/// (`ws-opts`) or a list of strings (`http-opts`, `h2-opts`).
String? _firstHeaderValue(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    if (value.isEmpty) return null;
    return value.first?.toString();
  }
  final text = value.toString();
  return text.isEmpty ? null : text;
}

String? _decodeBase64(String value) {
  try {
    final normalized = value
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll('-', '+')
        .replaceAll('_', '/');
    return utf8.decode(
      base64.decode(normalized.padRight((normalized.length + 3) ~/ 4 * 4, '=')),
    );
  } catch (_) {
    return null;
  }
}

String _hostPort(Map<String, dynamic> config) {
  final host = config['server']?.toString() ?? '';
  final formatted = host.contains(':') && !host.startsWith('[')
      ? '[$host]'
      : host;
  return '$formatted:${config['port']}';
}

String _buildUri(
  String scheme,
  Map<String, dynamic> config,
  String user,
  Map<String, String> query,
) {
  final params = (query.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
      .map(
        (entry) =>
            '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}',
      )
      .join('&');
  final name = config['name'] == null
      ? ''
      : '#${Uri.encodeComponent(config['name'].toString())}';
  final separator = user.indexOf(':');
  final encodedUser = separator > 0
      ? '${Uri.encodeComponent(user.substring(0, separator))}:${Uri.encodeComponent(user.substring(separator + 1))}'
      : Uri.encodeComponent(user);
  final userPart = encodedUser.isEmpty ? '' : '$encodedUser@';
  return '$scheme://$userPart${_hostPort(config)}${params.isEmpty ? '' : '?$params'}$name';
}
