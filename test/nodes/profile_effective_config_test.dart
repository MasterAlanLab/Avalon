import 'dart:io';

import 'package:drift/native.dart';
import 'package:avalon/database/database.dart';
import 'package:avalon/features/chains/chains.dart';
import 'package:avalon/features/chains/runtime.dart';
import 'package:avalon/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Database store;

  setUp(() {
    store = Database(NativeDatabase.memory());
  });

  tearDown(() async {
    await store.close();
  });

  test('assembles bound nodes and nested profile groups', () async {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const node = ProxyNode(
      id: 100,
      displayName: 'Node',
      type: 'socks',
      config: {'name': 'Node', 'type': 'socks', 'server': 'HOST', 'port': 1080},
      fingerprint: 'fingerprint',
    );
    const chain = ProxyChain(id: 200, name: 'Route');
    const hop = ProxyChainHop(
      id: 201,
      chainId: 200,
      order: 0,
      targetKind: 'group',
      groupName: 'Outer',
    );
    await store.profilesDao.putAll([profile.toCompanion()]);
    await store.restore(
      const [],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [node],
      proxyNodeBindings: const [ProxyNodeBinding(profileId: 1, nodeId: 100)],
      proxyChains: const [chain],
      proxyChainHops: const [hop],
      proxyChainBindings: const [
        ProxyChainBinding(profileId: 1, chainId: 200, isDefault: true),
      ],
    );

    final artifact =
        await ProfileEffectiveConfigService(
          store: store,
          nodeStorePath: Directory.systemTemp.path,
        ).assemble(
          profileId: 1,
          profileConfig: const {
            'proxies': [],
            'proxy-groups': [
              {
                'name': 'Inner',
                'type': 'select',
                'proxies': ['Node'],
              },
              {
                'name': 'Outer',
                'type': 'select',
                'proxies': ['Inner'],
              },
            ],
          },
        );

    expect(artifact.isValid, isTrue);
    expect(artifact.chainResults.single.paths, hasLength(1));
    expect(artifact.config['proxies'], hasLength(2));
    expect(artifact.config['proxy-groups'], hasLength(4));
  });

  test('normalizes map-form profile proxies before assembly', () async {
    final artifact =
        await ProfileEffectiveConfigService(
          store: store,
          nodeStorePath: Directory.systemTemp.path,
        ).assemble(
          profileId: 1,
          profileConfig: const {
            'proxies': {
              'Map node': {'type': 'socks5', 'server': 'HOST', 'port': 1080},
            },
          },
        );

    expect(artifact.isValid, isTrue);
    expect(artifact.config['proxies'], [
      {'name': 'Map node', 'type': 'socks5', 'server': 'HOST', 'port': 1080},
    ]);
  });

  test('reports missing assets only when a node is used', () async {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const node = ProxyNode(
      id: 100,
      displayName: 'Node',
      type: 'socks',
      config: {'name': 'Node', 'type': 'socks', 'server': 'HOST', 'port': 1080},
      fingerprint: 'fingerprint',
    );
    const asset = ProxyNodeAsset(
      id: 300,
      nodeId: 100,
      fieldPath: 'tls.cert',
      fileName: 'cert.pem',
      relativePath: 'nodes/100/assets/cert.pem',
      sha256: 'hash',
      size: 4,
    );
    await store.profilesDao.putAll([profile.toCompanion()]);
    await store.restore(
      const [],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [node],
      proxyNodeAssets: const [asset],
    );
    final service = ProfileEffectiveConfigService(
      store: store,
      nodeStorePath: Directory.systemTemp.path,
    );
    final unused = await service.assemble(
      profileId: 1,
      profileConfig: const {'proxies': []},
    );
    expect(unused.isValid, isTrue);

    await store.proxyNodeBindingsDao.put(
      const ProxyNodeBinding(profileId: 1, nodeId: 100),
    );
    final used = await service.assemble(
      profileId: 1,
      profileConfig: const {'proxies': []},
    );
    expect(used.isValid, isFalse);
    expect(
      used.diagnostics.map((item) => item.code),
      contains('missing-node-asset'),
    );
  });

  group('chain entry groups', () {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const node = ProxyNode(
      id: 100,
      displayName: 'Node',
      type: 'socks',
      config: {'name': 'Node', 'type': 'socks', 'server': 'HOST', 'port': 1080},
      fingerprint: 'fingerprint',
    );
    const chain = ProxyChain(id: 200, name: 'Route');
    const hop = ProxyChainHop(
      id: 201,
      chainId: 200,
      order: 0,
      targetKind: 'node',
      nodeId: 100,
    );
    const profileConfig = {
      'proxies': [
        {'name': 'Source', 'type': 'socks', 'server': 'HOST', 'port': 1080},
      ],
      'proxy-groups': [
        {
          'name': 'G',
          'type': 'select',
          'proxies': ['Source'],
        },
      ],
      'rules': ['MATCH,G'],
    };

    Future<void> seed({List<String> entryGroups = const []}) async {
      await store.profilesDao.putAll([profile.toCompanion()]);
      await store.restore(
        const [],
        const [],
        const [],
        const [],
        const [],
        proxyNodes: const [node],
        proxyChains: const [chain],
        proxyChainHops: const [hop],
        proxyChainBindings: [
          ProxyChainBinding(
            profileId: 1,
            chainId: 200,
            isDefault: true,
            entryGroups: entryGroups,
          ),
        ],
      );
    }

    Future<EffectiveConfigArtifact> assemble() {
      return ProfileEffectiveConfigService(
        store: store,
        nodeStorePath: Directory.systemTemp.path,
      ).assemble(profileId: 1, profileConfig: profileConfig);
    }

    List<String> membersOf(EffectiveConfigArtifact artifact, String name) {
      final group = (artifact.config['proxy-groups'] as List)
          .cast<Map>()
          .firstWhere((item) => item['name'] == name);
      return (group['proxies'] as List).map((item) => item.toString()).toList();
    }

    test('leaves the rule entry untouched without an entry group', () async {
      await seed();
      final artifact = await assemble();
      expect(membersOf(artifact, 'G'), ['Source']);
    });

    test('adds the chain selector to the selected entry group', () async {
      await seed(entryGroups: const ['G']);
      final artifact = await assemble();
      final selector = artifact.chainResults.single.generatedGroups.first.name;
      final members = membersOf(artifact, 'G');
      expect(members.first, 'Source');
      expect(members, contains(selector));
      expect(
        artifact.diagnostics.map((item) => item.code),
        isNot(contains('missing-chain-entry-group')),
      );
    });

    test('drops the entry once the binding is disabled', () async {
      await seed(entryGroups: const ['G']);
      await store.proxyChainBindingsDao.put(
        const ProxyChainBinding(
          profileId: 1,
          chainId: 200,
          enabled: false,
          entryGroups: ['G'],
        ),
      );
      final artifact = await assemble();
      expect(membersOf(artifact, 'G'), ['Source']);
      expect(artifact.chainResults, isEmpty);
    });

    test('warns when the entry group is missing from the profile', () async {
      await seed(entryGroups: const ['MISSING']);
      final artifact = await assemble();
      expect(membersOf(artifact, 'G'), ['Source']);
      expect(
        artifact.diagnostics.map((item) => item.code),
        contains('missing-chain-entry-group'),
      );
      expect(artifact.isValid, isTrue);
    });

    // Backs `addProfileFromChain`: the generated stub profile ships an empty
    // entry group so the appended chain selector ends up as the only member,
    // and therefore the default outbound.
    test('makes the chain the sole member of an empty entry group', () async {
      await store.profilesDao.putAll([profile.toCompanion()]);
      await store.restore(
        const [],
        const [],
        const [],
        const [],
        const [],
        proxyNodes: const [node],
        proxyChains: const [chain],
        proxyChainHops: const [hop],
        proxyChainBindings: const [
          ProxyChainBinding(
            profileId: 1,
            chainId: 200,
            isDefault: true,
            entryGroups: ['PROXY'],
          ),
        ],
      );
      final artifact =
          await ProfileEffectiveConfigService(
            store: store,
            nodeStorePath: Directory.systemTemp.path,
          ).assemble(
            profileId: 1,
            profileConfig: const {
              'proxies': <Map<String, Object?>>[],
              'proxy-groups': [
                {'name': 'PROXY', 'type': 'select', 'proxies': <String>[]},
              ],
              'rules': ['MATCH,PROXY'],
            },
          );
      final selector = artifact.chainResults.single.generatedGroups.first.name;
      expect(membersOf(artifact, 'PROXY'), [selector]);
      expect(
        artifact.diagnostics.map((item) => item.code),
        isNot(contains('missing-chain-entry-group')),
      );
      expect(artifact.isValid, isTrue);
    });
  });

  group('chain preview', () {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const node = ProxyNode(
      id: 100,
      displayName: 'Node',
      type: 'socks',
      config: {'name': 'Node', 'type': 'socks', 'server': 'HOST', 'port': 1080},
      fingerprint: 'fingerprint',
    );
    const chain = ProxyChain(id: 200, name: 'Route');

    setUp(() async {
      await store.profilesDao.putAll([profile.toCompanion()]);
      await store.restore(
        const [],
        const [],
        const [],
        const [],
        const [],
        proxyNodes: const [node],
        proxyChains: const [chain],
      );
    });

    Future<ChainPreview> preview(List<ProxyChainHop> hops) {
      return ProfileEffectiveConfigService(
        store: store,
        nodeStorePath: Directory.systemTemp.path,
      ).previewChain(
        profileId: 1,
        profileConfig: const {'proxies': []},
        chain: chain,
        hops: hops,
      );
    }

    test('counts the compiled paths of an unsaved chain', () async {
      final result = await preview(const [
        ProxyChainHop(
          id: 201,
          chainId: 200,
          order: 0,
          targetKind: 'node',
          nodeId: 100,
        ),
      ]);
      expect(result.pathCount, 1);
      expect(result.diagnostics, isEmpty);
      expect(result.isValid, isTrue);
    });

    test('reports an empty chain before it is saved', () async {
      final result = await preview(const []);
      expect(result.pathCount, 0);
      expect(
        result.diagnostics.map((item) => item.code),
        contains('empty-chain'),
      );
      expect(result.isValid, isFalse);
    });

    test('reports a hop that cannot be resolved in this profile', () async {
      final result = await preview(const [
        ProxyChainHop(
          id: 201,
          chainId: 200,
          order: 0,
          targetKind: 'node',
          nodeId: 999,
        ),
      ]);
      expect(
        result.diagnostics.map((item) => item.code),
        contains('invalid-hop'),
      );
      expect(result.isValid, isFalse);
    });

    test('exposes generated proxies, selector and node ids', () async {
      final result = await preview(const [
        ProxyChainHop(
          id: 201,
          chainId: 200,
          order: 0,
          targetKind: 'node',
          nodeId: 100,
        ),
        ProxyChainHop(
          id: 202,
          chainId: 200,
          order: 1,
          targetKind: 'local-endpoint',
          localEndpoint: {
            'type': 'socks5',
            'server': '127.0.0.1',
            'port': 7890,
          },
        ),
      ]);

      expect(result.isValid, isTrue);
      expect(result.generatedProxies, hasLength(2));
      expect(result.generatedGroups.single.proxies, hasLength(1));
      final terminal = result.generatedGroups.single.proxies.single;
      expect(result.generatedProxies[terminal]!['dialer-proxy'], isNotNull);
      expect(result.generatedNodeIds.values, contains('100'));
    });

    test('leaves the stored chain untouched', () async {
      await preview(const [
        ProxyChainHop(
          id: 201,
          chainId: 200,
          order: 0,
          targetKind: 'node',
          nodeId: 100,
        ),
      ]);
      expect(await store.proxyChainHopsDao.query(200).get(), isEmpty);
      expect(await store.proxyChainBindingsDao.query(1).get(), isEmpty);
    });
  });

  test('keeps a library node usable when only its chain is bound', () async {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const node = ProxyNode(
      id: 100,
      displayName: 'Manual',
      type: 'socks',
      config: {
        'name': 'Manual',
        'type': 'socks',
        'server': 'MANUAL_HOST',
        'port': 1080,
      },
      fingerprint: 'manual',
    );
    const chain = ProxyChain(id: 200, name: 'Route');
    const hop = ProxyChainHop(
      id: 201,
      chainId: 200,
      order: 0,
      targetKind: 'node',
      nodeId: 100,
    );
    await store.profilesDao.putAll([profile.toCompanion()]);
    await store.restore(
      const [],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [node],
      proxyChains: const [chain],
      proxyChainHops: const [hop],
      proxyChainBindings: const [ProxyChainBinding(profileId: 1, chainId: 200)],
    );

    final artifact = await ProfileEffectiveConfigService(
      store: store,
      nodeStorePath: Directory.systemTemp.path,
    ).assemble(profileId: 1, profileConfig: const {'proxies': []});

    expect(artifact.diagnostics.map((item) => item.code), isEmpty);
    expect(artifact.isValid, isTrue);
    expect(artifact.chainResults.single.paths, hasLength(1));
    expect(
      (artifact.config['proxies'] as List).where(
        (item) => item is Map && item['server'] == 'MANUAL_HOST',
      ),
      hasLength(1),
    );
  });

  test('keeps distinct endpoints for same named source nodes', () async {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const first = ProxyNode(
      id: 100,
      displayName: 'Shared',
      type: 'socks',
      config: {
        'name': 'Shared',
        'type': 'socks',
        'server': 'HOST_A',
        'port': 1080,
      },
      sourceSnapshot: {
        'name': 'Shared',
        'type': 'socks',
        'server': 'HOST_A',
        'port': 1080,
      },
      source: ProxyNodeSource(
        kind: 'profile',
        profileId: 1,
        sourceKey: 'profile::Shared',
      ),
      fingerprint: 'first',
    );
    const second = ProxyNode(
      id: 101,
      displayName: 'Shared',
      type: 'socks',
      config: {
        'name': 'Shared',
        'type': 'socks',
        'server': 'HOST_B',
        'port': 1080,
      },
      sourceSnapshot: {
        'name': 'Shared',
        'type': 'socks',
        'server': 'HOST_B',
        'port': 1080,
      },
      source: ProxyNodeSource(
        kind: 'profile',
        profileId: 1,
        sourceKey: 'profile::Shared#1',
      ),
      fingerprint: 'second',
    );
    await store.profilesDao.putAll([profile.toCompanion()]);
    await store.restore(
      const [],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [first, second],
      proxyNodeBindings: const [
        ProxyNodeBinding(profileId: 1, nodeId: 100),
        ProxyNodeBinding(profileId: 1, nodeId: 101),
      ],
    );

    final artifact =
        await ProfileEffectiveConfigService(
          store: store,
          nodeStorePath: Directory.systemTemp.path,
        ).assemble(
          profileId: 1,
          profileConfig: const {
            'proxies': [
              {
                'name': 'Shared',
                'type': 'socks',
                'server': 'HOST_A',
                'port': 1080,
              },
              {
                'name': 'Shared',
                'type': 'socks',
                'server': 'HOST_B',
                'port': 1080,
              },
            ],
          },
        );

    final proxies = (artifact.config['proxies'] as List).cast<Map>();
    expect(proxies, hasLength(2));
    expect(proxies.map((item) => item['server']).toSet(), {'HOST_A', 'HOST_B'});
    expect(proxies.map((item) => item['name']).toSet(), hasLength(2));
  });

  test(
    'does not expose a source node from another profile to a chain',
    () async {
      const firstProfile = Profile(
        id: 1,
        label: 'First',
        autoUpdateDuration: Duration.zero,
      );
      const secondProfile = Profile(
        id: 2,
        label: 'Second',
        autoUpdateDuration: Duration.zero,
      );
      const foreignNode = ProxyNode(
        id: 100,
        displayName: 'Foreign',
        type: 'socks',
        config: {
          'name': 'Foreign',
          'type': 'socks',
          'server': 'FOREIGN_HOST',
          'port': 1080,
        },
        source: ProxyNodeSource(kind: 'profile', profileId: 2),
        sourceSnapshot: {
          'name': 'Foreign',
          'type': 'socks',
          'server': 'FOREIGN_HOST',
          'port': 1080,
        },
        fingerprint: 'foreign',
      );
      const chain = ProxyChain(id: 200, name: 'Foreign route');
      const hop = ProxyChainHop(
        id: 201,
        chainId: 200,
        order: 0,
        targetKind: 'node',
        nodeId: 100,
      );
      await store.profilesDao.putAll([
        firstProfile.toCompanion(),
        secondProfile.toCompanion(),
      ]);
      await store.restore(
        const [],
        const [],
        const [],
        const [],
        const [],
        proxyNodes: const [foreignNode],
        proxyChains: const [chain],
        proxyChainHops: const [hop],
        proxyChainBindings: const [
          ProxyChainBinding(profileId: 1, chainId: 200),
        ],
      );

      final artifact = await ProfileEffectiveConfigService(
        store: store,
        nodeStorePath: Directory.systemTemp.path,
      ).assemble(profileId: 1, profileConfig: const {'proxies': []});

      expect(
        artifact.diagnostics.map((item) => item.code),
        contains('invalid-hop'),
      );
      expect(
        (artifact.config['proxies'] as List).where(
          (item) => item is Map && item['server'] == 'FOREIGN_HOST',
        ),
        isEmpty,
      );
    },
  );
}
