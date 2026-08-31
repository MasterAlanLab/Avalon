import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:avalon/database/database.dart';
import 'package:avalon/enum/enum.dart';
import 'package:avalon/features/chains/service.dart';
import 'package:avalon/features/nodes/service.dart';
import 'package:avalon/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

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

  test('upgrades a schema v2 database and keeps existing data', () async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    addTearDown(
      () => driftRuntimeOptions.dontWarnAboutMultipleDatabases = false,
    );
    final directory = await Directory.systemTemp.createTemp('schema-v2');
    addTearDown(() => directory.delete(recursive: true));
    final file = File(join(directory.path, 'database.sqlite'));

    const profile = Profile(
      id: 1,
      label: 'Legacy profile',
      autoUpdateDuration: Duration.zero,
    );
    final script = Script(
      id: 2,
      label: 'Legacy script',
      lastUpdateTime: DateTime(2026),
    );
    const rule = Rule(
      id: 3,
      ruleAction: RuleAction.DOMAIN,
      content: 'example.com',
      ruleTarget: 'DIRECT',
    );
    const link = ProfileRuleLink(profileId: 1, ruleId: 3);
    const group = ProxyGroup(
      id: 4,
      profileId: 1,
      name: 'Legacy group',
      type: GroupType.Selector,
      proxies: ['DIRECT'],
    );

    final seed = Database(NativeDatabase(file));
    await seed.profilesDao.putAll([profile.toCompanion()]);
    await seed.restore(
      const [],
      [script],
      const [rule],
      const [link],
      const [group],
    );
    for (final table in const [
      'proxy_group_members',
      'proxy_chain_hops',
      'profile_proxy_chains',
      'profile_proxy_nodes',
      'proxy_node_assets',
      'proxy_chains',
      'proxy_nodes',
    ]) {
      await seed.customStatement('DROP TABLE $table');
    }
    await seed.customStatement('PRAGMA user_version = 2');
    await seed.close();

    final upgraded = Database(NativeDatabase(file));
    addTearDown(upgraded.close);

    final restored = await upgraded.snapshot();
    expect(restored.profiles.single.label, profile.label);
    expect(restored.scripts.single.label, script.label);
    expect(restored.rules.single.content, 'example.com');
    expect(restored.links.single.ruleId, 3);
    expect(restored.proxyGroups.single.name, 'Legacy group');

    const node = ProxyNode(
      id: 100,
      displayName: 'Node',
      type: 'socks5',
      config: {'name': 'Node', 'type': 'socks5', 'server': 'HOST'},
      fingerprint: 'fingerprint',
    );
    const chain = ProxyChain(id: 200, name: 'Chain');
    await upgraded.restore(
      const [],
      const [],
      const [],
      const [],
      const [],
      proxyNodes: const [node],
      proxyChains: const [chain],
      proxyChainBindings: const [
        ProxyChainBinding(profileId: 1, chainId: 200, entryGroups: ['G']),
      ],
    );
    expect((await upgraded.proxyNodesDao.query().get()).single.id, 100);
    expect(
      (await upgraded.proxyChainBindingsDao.query(1).get()).single.entryGroups,
      ['G'],
    );
  });

  test('upgrades a schema v3 database and keeps chain bindings', () async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    addTearDown(
      () => driftRuntimeOptions.dontWarnAboutMultipleDatabases = false,
    );
    final directory = await Directory.systemTemp.createTemp('schema-v3');
    addTearDown(() => directory.delete(recursive: true));
    final file = File(join(directory.path, 'database.sqlite'));

    final seed = Database(NativeDatabase(file));
    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    const chain = ProxyChain(id: 200, name: 'Chain');
    await seed.profilesDao.putAll([profile.toCompanion()]);
    await seed.restore(
      const [],
      const [],
      const [],
      const [],
      const [],
      proxyChains: const [chain],
      proxyChainBindings: const [
        ProxyChainBinding(profileId: 1, chainId: 200, isDefault: true),
      ],
    );
    await seed.customStatement(
      'ALTER TABLE profile_proxy_chains DROP COLUMN entry_groups',
    );
    await seed.customStatement('PRAGMA user_version = 3');
    await seed.close();

    final upgraded = Database(NativeDatabase(file));
    addTearDown(upgraded.close);
    final bindings = await upgraded.proxyChainBindingsDao.query(1).get();
    expect(bindings.single.chainId, 200);
    expect(bindings.single.isDefault, isTrue);
    expect(bindings.single.entryGroups, isEmpty);

    await upgraded.proxyChainBindingsDao.put(
      bindings.single.copyWith(entryGroups: const ['G']),
    );
    expect(
      (await upgraded.proxyChainBindingsDao.query(1).get()).single.entryGroups,
      ['G'],
    );
  });
}
