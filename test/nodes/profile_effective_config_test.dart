import 'dart:io';

import 'package:drift/native.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/features/chains/runtime.dart';
import 'package:fl_clash/models/models.dart';
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
