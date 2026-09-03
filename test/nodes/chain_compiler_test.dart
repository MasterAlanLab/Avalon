import 'package:avalon/features/chains/chains.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _node(String name, {String type = 'socks'}) => {
  'name': name,
  'type': type,
  'server': '$name.example.com',
  'port': 443,
};

void main() {
  test('compiles chain in client to first to final direction', () {
    final result = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'route',
        hops: const [
          ChainHop(target: ChainTarget.node('pre')),
          ChainHop(target: ChainTarget.node('main')),
          ChainHop(target: ChainTarget.node('post')),
        ],
        nodes: {
          'pre': _node('PRE'),
          'main': _node('MAIN'),
          'post': _node('POST'),
        },
      ),
    );

    expect(result.isValid, isTrue);
    expect(result.paths, hasLength(1));
    final names = result.paths.single.generatedNames;
    expect(result.generatedProxies[names[0]]?['dialer-proxy'], isNull);
    expect(result.generatedProxies[names[1]]?['dialer-proxy'], names[0]);
    expect(result.generatedProxies[names[2]]?['dialer-proxy'], names[1]);
    expect(result.generatedGroups.single.name, 'route');
    expect(result.generatedGroups.single.proxies, [names[2]]);
  });

  test('uses the chain name for its user-facing selector', () {
    final result = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: '上海链路',
        hops: const [ChainHop(target: ChainTarget.node('node'))],
        nodes: {'node': _node('NODE')},
        generatedPrefix: '__avalon_chain_200',
      ),
    );

    expect(result.isValid, isTrue);
    expect(result.generatedGroups.single.name, '上海链路');
    expect(
      result.generatedGroups.single.name,
      isNot(startsWith('__avalon_chain_')),
    );
    expect(
      result.generatedProxies.keys.single,
      startsWith('__avalon_chain_200_'),
    );
  });

  test('expands groups and enforces branch limit', () {
    final result = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'branch',
        branchLimit: 2,
        hops: const [
          ChainHop(target: ChainTarget.group('a')),
          ChainHop(target: ChainTarget.group('b')),
        ],
        nodes: {
          'one': _node('ONE'),
          'two': _node('TWO'),
          'three': _node('THREE'),
        },
        groups: {
          'a': const [ChainTarget.node('one'), ChainTarget.node('two')],
          'b': const [ChainTarget.node('three'), ChainTarget.node('one')],
        },
      ),
    );

    expect(result.isValid, isFalse);
    expect(
      result.diagnostics.map((item) => item.code),
      contains('branch-limit-exceeded'),
    );
  });

  test('reports empty groups and reserves generated names', () {
    final empty = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'route',
        hops: const [ChainHop(target: ChainTarget.group('empty'))],
        groups: const {'empty': []},
        nodes: const {},
      ),
    );
    expect(empty.isValid, isFalse);
    expect(empty.diagnostics.map((item) => item.code), contains('empty-group'));

    final reserved = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'route',
        hops: const [ChainHop(target: ChainTarget.node('node'))],
        nodes: {'node': _node('NODE')},
        reservedNames: const {'__avalon_chain_route_1_1_NODE'},
      ),
    );
    expect(reserved.generatedProxies.keys.single, contains('(2)'));
  });

  test('reports group cycles and assembler preserves source config', () {
    final cycle = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'cycle',
        hops: const [ChainHop(target: ChainTarget.group('a'))],
        groups: const {
          'a': [ChainTarget.group('b')],
          'b': [ChainTarget.group('a')],
        },
        nodes: const {},
      ),
    );
    expect(cycle.diagnostics.map((item) => item.code), contains('group-cycle'));

    final source = <String, dynamic>{
      'mode': 'rule',
      'proxies': [_node('SOURCE')],
      'proxy-groups': <Map<String, dynamic>>[],
    };
    final artifact = EffectiveConfigAssembler().assemble(
      EffectiveConfigRequest(
        profileConfig: source,
        nodes: {'manual': _node('MANUAL')},
        nodeBindings: const ['manual'],
        chains: [
          ChainCompileRequest(
            name: 'route',
            hops: const [ChainHop(target: ChainTarget.node('manual'))],
            nodes: {'manual': _node('MANUAL')},
          ),
        ],
      ),
    );
    expect(artifact.isValid, isTrue);
    expect(source['proxies'], hasLength(1));
    expect(artifact.config['proxies'], hasLength(3));
    expect(artifact.config['proxy-groups'], hasLength(1));
    expect(artifact.digest, hasLength(64));
  });

  test('rewrites group references when names are allocated', () {
    final artifact = EffectiveConfigAssembler().assemble(
      EffectiveConfigRequest(
        profileConfig: {
          'proxies': [_node('DUPLICATE')],
          'proxy-groups': [
            {
              'name': 'DUPLICATE',
              'type': 'select',
              'proxies': ['DUPLICATE'],
            },
          ],
        },
        nodes: {'manual': _node('DUPLICATE')},
        nodeBindings: const ['manual'],
        nodeAliases: const {'manual': 'MANUAL'},
      ),
    );
    final proxies = artifact.config['proxies'] as List;
    final groups = artifact.config['proxy-groups'] as List;
    expect(proxies.map((item) => item['name']), contains('DUPLICATE (2)'));
    expect(proxies.map((item) => item['name']), contains('MANUAL'));
    expect(groups.single['proxies'], ['DUPLICATE']);
  });

  test('keeps generated names unique across chains', () {
    final request = ChainCompileRequest(
      name: 'route',
      hops: const [ChainHop(target: ChainTarget.node('node'))],
      nodes: {'node': _node('NODE')},
    );
    final artifact = EffectiveConfigAssembler().assemble(
      EffectiveConfigRequest(
        profileConfig: const {},
        nodes: request.nodes,
        chains: [request, request],
      ),
    );
    final names = (artifact.config['proxies'] as List)
        .map((item) => item['name'] as String)
        .toList();
    expect(names.toSet(), hasLength(names.length));
  });

  test('replaces an existing dialer on every chain hop', () {
    final result = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'route',
        hops: const [
          ChainHop(target: ChainTarget.node('pre')),
          ChainHop(target: ChainTarget.node('main')),
        ],
        nodes: {
          'pre': {..._node('PRE'), 'dialer-proxy': 'outside'},
          'main': {..._node('MAIN'), 'dialer-proxy': 'outside'},
        },
      ),
    );

    expect(result.isValid, isTrue);
    final names = result.paths.single.generatedNames;
    expect(result.generatedProxies[names[0]]?['dialer-proxy'], isNull);
    expect(result.generatedProxies[names[1]]?['dialer-proxy'], names[0]);
    expect(
      result.diagnostics.where((item) => item.code == 'existing-dialer-proxy'),
      hasLength(2),
    );
  });

  test('compiles a local SOCKS endpoint in the same single-core chain', () {
    final result = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'local-pre',
        hops: const [
          ChainHop(
            target: ChainTarget.localEndpoint({
              'name': 'LOCAL_PRE',
              'type': 'socks5',
              'server': '127.0.0.1',
              'port': 1080,
            }),
          ),
          ChainHop(target: ChainTarget.node('main')),
        ],
        nodes: {'main': _node('MAIN')},
      ),
    );

    expect(result.isValid, isTrue);
    final names = result.paths.single.generatedNames;
    expect(result.generatedProxies[names.first]?['type'], 'socks5');
    expect(result.generatedProxies[names.last]?['dialer-proxy'], names.first);
  });

  test('warns for UDP, Reality, and ShadowTLS relay hops', () {
    final result = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'compatibility',
        hops: const [
          ChainHop(target: ChainTarget.node('entry')),
          ChainHop(target: ChainTarget.group('relays')),
        ],
        nodes: {
          'entry': _node('ENTRY'),
          'udp': {..._node('UDP', type: 'hysteria2'), 'udp': true},
          'reality': {
            ..._node('REALITY', type: 'vless'),
            'security': 'reality',
          },
          'shadow': {..._node('SHADOW', type: 'shadow-tls')},
        },
        groups: {
          'relays': const [
            ChainTarget.node('udp'),
            ChainTarget.node('reality'),
            ChainTarget.node('shadow'),
          ],
        },
      ),
    );

    expect(result.isValid, isTrue);
    expect(
      result.diagnostics.map((item) => item.code),
      containsAll(<String>[
        'udp-chain-compatibility',
        'reality-chain-compatibility',
        'shadow-tls-chain-compatibility',
      ]),
    );
  });

  // applyDefaultUdp 之后 `udp: true` 是绝大多数节点的默认值，不再是一个信号。
  // 拿它当警告条件会让每一条多跳链路都挂上 udp-chain-compatibility。
  test('a plain relay hop with the default udp flag raises no warning', () {
    final result = DialerChainCompiler().compile(
      ChainCompileRequest(
        name: 'route',
        hops: const [
          ChainHop(target: ChainTarget.node('entry')),
          ChainHop(target: ChainTarget.node('relay')),
        ],
        nodes: {
          'entry': {..._node('ENTRY', type: 'vless'), 'udp': true},
          'relay': {..._node('RELAY', type: 'vless'), 'udp': true},
        },
      ),
    );

    expect(result.isValid, isTrue);
    expect(
      result.diagnostics.map((item) => item.code),
      isNot(contains('udp-chain-compatibility')),
    );
  });
}
