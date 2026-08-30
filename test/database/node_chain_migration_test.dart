import 'package:drift/native.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/features/chains/service.dart';
import 'package:fl_clash/features/nodes/service.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Database database;

  setUp(() {
    database = Database(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('stores nodes, bindings, chains, hops, and assets', () async {
    const node = ProxyNode(
      id: 100,
      displayName: 'Node',
      type: 'vless',
      config: {'name': 'Node', 'type': 'vless', 'server': 'HOST', 'port': 443},
      fingerprint: 'fingerprint',
    );
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const chain = ProxyChain(id: 200, name: 'Chain');
    const hop = ProxyChainHop(
      id: 201,
      chainId: 200,
      order: 0,
      targetKind: 'node',
      nodeId: 100,
    );
    const binding = ProxyNodeBinding(profileId: 1, nodeId: 100);
    const chainBinding = ProxyChainBinding(profileId: 1, chainId: 200);
    const asset = ProxyNodeAsset(
      id: 300,
      nodeId: 100,
      fieldPath: 'reality-opts.cert',
      fileName: 'cert.pem',
      relativePath: 'nodes/100/assets/cert.pem',
      sha256: 'hash',
      size: 4,
    );

    await database.profilesDao.putAll([profile.toCompanion()]);
    await database.restore(
      const [],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [node],
      proxyNodeBindings: const [binding],
      proxyChains: const [chain],
      proxyChainHops: const [hop],
      proxyChainBindings: const [chainBinding],
      proxyNodeAssets: const [asset],
    );

    expect((await database.proxyNodesDao.query().get()).single, node);
    expect(
      (await database.proxyNodeBindingsDao.query(1).get()).single,
      binding,
    );
    expect((await database.proxyChainsDao.query().get()).single, chain);
    expect((await database.proxyChainHopsDao.query(200).get()).single, hop);
    expect(
      (await database.proxyChainBindingsDao.query(1).get()).single,
      chainBinding,
    );
    expect((await database.proxyNodeAssetsDao.query(100).get()).single, asset);
  });

  test('keeps one default chain binding per profile', () async {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    await database.profilesDao.putAll([profile.toCompanion()]);
    final service = ChainLibraryService(store: database);
    final first = await service.create(name: 'First');
    final second = await service.create(name: 'Second');
    await service.bind(profileId: 1, chainId: first.id, isDefault: true);
    await service.bind(profileId: 1, chainId: second.id, isDefault: true);

    final bindings = await database.proxyChainBindingsDao.query(1).get();
    expect(
      bindings.where((item) => item.isDefault).map((item) => item.chainId),
      [second.id],
    );
  });

  test('override restore replaces node and chain records together', () async {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const firstNode = ProxyNode(
      id: 100,
      displayName: 'First',
      type: 'socks5',
      config: {'name': 'First', 'type': 'socks5', 'server': 'HOST'},
      fingerprint: 'first',
    );
    const secondNode = ProxyNode(
      id: 101,
      displayName: 'Second',
      type: 'socks5',
      config: {'name': 'Second', 'type': 'socks5', 'server': 'HOST'},
      fingerprint: 'second',
    );
    const firstChain = ProxyChain(id: 200, name: 'First Chain');
    const secondChain = ProxyChain(id: 201, name: 'Second Chain');
    await database.restore(
      const [profile],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [firstNode, secondNode],
      proxyChains: const [firstChain, secondChain],
      isOverride: true,
    );
    await database.restore(
      const [profile],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [firstNode],
      proxyChains: const [firstChain],
      isOverride: true,
    );

    expect((await database.proxyNodesDao.query().get()).map((e) => e.id), [
      100,
    ]);
    expect((await database.proxyChainsDao.query().get()).map((e) => e.id), [
      200,
    ]);
  });

  test('syncs map-form sources and marks a valid empty source stale', () async {
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    await database.profilesDao.putAll([profile.toCompanion()]);
    final sync = NodeSourceSyncService(
      library: NodeLibraryService(store: database),
    );

    final created = await sync.syncProfile(
      profileId: 1,
      config: const {
        'proxies': {
          'SOURCE': {'type': 'socks5', 'server': 'HOST', 'port': 1080},
        },
      },
    );
    expect(created.created, hasLength(1));
    expect(
      (await database.proxyNodeBindingsDao.query(1).get()).single.nodeId,
      created.created.single.id,
    );

    final invalid = await sync.syncProfile(
      profileId: 1,
      config: const {'proxies': 'invalid'},
    );
    expect(
      invalid.issues.map((item) => item.code),
      contains('invalid-source-payload'),
    );
    expect(
      (await database.proxyNodesDao.query().get()).single.status,
      'active',
    );

    final stale = await sync.syncProfile(
      profileId: 1,
      config: const {'proxies': <Object?>[]},
    );
    expect(stale.stale, hasLength(1));
    expect((await database.proxyNodesDao.query().get()).single.status, 'stale');
  });

  test(
    'keeps source nodes active for null or mixed-invalid payloads',
    () async {
      const profile = Profile(
        id: 2,
        label: 'Profile',
        autoUpdateDuration: Duration.zero,
      );
      await database.profilesDao.putAll([profile.toCompanion()]);
      final sync = NodeSourceSyncService(
        library: NodeLibraryService(store: database),
      );
      final initial = await sync.syncProfile(
        profileId: profile.id,
        config: const {
          'proxies': [
            {'name': 'KEEP', 'type': 'socks5', 'server': 'HOST', 'port': 1080},
          ],
        },
      );
      expect(initial.created, hasLength(1));

      final nullPayload = await sync.syncProfile(
        profileId: profile.id,
        config: const {'proxies': null},
      );
      expect(
        nullPayload.issues.map((issue) => issue.code),
        contains('invalid-source-payload'),
      );
      expect(
        (await database.proxyNodesDao.query().get()).single.status,
        'active',
      );

      final mixed = await sync.syncProfile(
        profileId: profile.id,
        config: const {
          'proxies': [
            {'name': 'NEW', 'type': 'socks5', 'server': 'HOST2', 'port': 1080},
            'invalid',
          ],
        },
      );
      expect(mixed.created, hasLength(1));
      expect(mixed.issues, isNotEmpty);
      expect(mixed.stale, isEmpty);
      expect(
        (await database.proxyNodesDao.query().get()).where(
          (node) => node.status == 'stale',
        ),
        isEmpty,
      );
    },
  );
}
