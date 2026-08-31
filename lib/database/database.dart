import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:avalon/common/common.dart';
import 'package:avalon/enum/enum.dart';
import 'package:avalon/models/models.dart';

part 'converter.dart';
part 'generated/database.g.dart';
part 'groups.dart';
part 'icons.dart';
part 'links.dart';
part 'nodes.dart';
part 'chains.dart';
part 'profiles.dart';
part 'rules.dart';
part 'scripts.dart';

@DriftDatabase(
  tables: [
    Profiles,
    Scripts,
    Rules,
    ProfileRuleLinks,
    ProxyGroups,
    IconRecords,
    ProxyNodes,
    ProxyNodeBindings,
    ProxyChains,
    ProxyChainHops,
    ProxyChainBindings,
    ProxyNodeAssets,
    ProxyGroupMembers,
  ],
  daos: [
    ProfilesDao,
    ScriptsDao,
    RulesDao,
    ProxyGroupsDao,
    IconRecordsDao,
    ProxyNodesDao,
    ProxyNodeBindingsDao,
    ProxyChainsDao,
    ProxyChainHopsDao,
    ProxyChainBindingsDao,
    ProxyNodeAssetsDao,
    ProxyGroupMembersDao,
  ],
)
class Database extends _$Database {
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 4;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final databaseFile = File(await appPath.databasePath);
      return NativeDatabase.createInBackground(databaseFile);
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createTable(proxyGroups);
          await m.createTable(iconRecords);
          await _resetOrders();
          await _migrateRules(m);
        }
        if (from < 3) {
          await m.createTable(proxyNodes);
          await m.createTable(proxyNodeBindings);
          await m.createTable(proxyChains);
          await m.createTable(proxyChainHops);
          await m.createTable(proxyChainBindings);
          await m.createTable(proxyNodeAssets);
          await m.createTable(proxyGroupMembers);
        }
        if (from >= 3 && from < 4) {
          await m.addColumn(proxyChainBindings, proxyChainBindings.entryGroups);
        }
      },
    );
  }

  Future<void> _migrateRules(Migrator m) async {
    final tableInfo = await customSelect('PRAGMA table_info(rules)').get();
    final columnNames = tableInfo
        .map((row) => row.read<String>('name'))
        .toList();
    if (columnNames.isEmpty) {
      await m.createTable(rules);
      return;
    } else if (columnNames.contains('rule_action')) {
      return;
    }
    await customStatement(
      'ALTER TABLE rules ADD COLUMN rule_action TEXT NOT NULL DEFAULT ""',
    );
    await customStatement('ALTER TABLE rules ADD COLUMN content TEXT');
    await customStatement('ALTER TABLE rules ADD COLUMN rule_target TEXT');
    await customStatement('ALTER TABLE rules ADD COLUMN rule_provider TEXT');
    await customStatement('ALTER TABLE rules ADD COLUMN sub_rule TEXT');
    await customStatement(
      'ALTER TABLE rules ADD COLUMN no_resolve INTEGER NOT NULL DEFAULT 0',
    );
    await customStatement(
      'ALTER TABLE rules ADD COLUMN src INTEGER NOT NULL DEFAULT 0',
    );
    final oldRows = await customSelect('SELECT id, value FROM rules').get();
    for (final row in oldRows) {
      final id = row.read<int>('id');
      final value = row.read<String>('value');
      final parsed = Rule.parse(value, id: id);
      await customStatement(
        'UPDATE rules SET rule_action = ?, content = ?, rule_target = ?, rule_provider = ?, sub_rule = ?, no_resolve = ?, src = ? WHERE id = ?',
        [
          parsed.ruleAction.name,
          parsed.content,
          parsed.ruleTarget,
          parsed.ruleProvider,
          parsed.subRule,
          parsed.noResolve ? 1 : 0,
          parsed.src ? 1 : 0,
          id,
        ],
      );
    }
    await customStatement('ALTER TABLE rules DROP COLUMN value');
    await m.createIndex(idxRuleTarget);
  }

  Future<void> _resetOrders() async {
    await rulesDao.resetOrders();
  }

  Future<MigrationData> snapshot() async {
    return MigrationData(
      profiles: await profilesDao.query().get(),
      scripts: await scriptsDao.query().get(),
      rules: await rules.all().map((item) => item.toRule()).get(),
      links: await profileRuleLinks.all().map((item) => item.toLink()).get(),
      proxyGroups: await proxyGroups
          .all()
          .map((item) => item.toProxyGroup())
          .get(),
      proxyNodes: await proxyNodesDao.query().get(),
      proxyNodeBindings: await proxyNodeBindings
          .all()
          .map((item) => item.toProxyNodeBinding())
          .get(),
      proxyChains: await proxyChainsDao.query().get(),
      proxyChainHops: await proxyChainHops
          .all()
          .map((item) => item.toProxyChainHop())
          .get(),
      proxyChainBindings: await proxyChainBindings
          .all()
          .map((item) => item.toProxyChainBinding())
          .get(),
      proxyNodeAssets: await proxyNodeAssets
          .all()
          .map((item) => item.toProxyNodeAsset())
          .get(),
      proxyGroupMembers: await proxyGroupMembers
          .all()
          .map((item) => item.toProxyGroupMember())
          .get(),
    );
  }

  Future<void> restoreSnapshot(MigrationData data) async {
    await restore(
      data.profiles,
      data.scripts,
      data.rules,
      data.links,
      data.proxyGroups,
      proxyNodes: data.proxyNodes,
      proxyNodeBindings: data.proxyNodeBindings,
      proxyChains: data.proxyChains,
      proxyChainHops: data.proxyChainHops,
      proxyChainBindings: data.proxyChainBindings,
      proxyNodeAssets: data.proxyNodeAssets,
      groupMembers: data.proxyGroupMembers,
      isOverride: true,
    );
  }

  Future<void> restore(
    List<Profile> profiles,
    List<Script> scripts,
    List<Rule> rules,
    List<ProfileRuleLink> links,
    List<ProxyGroup> proxyGroups, {
    List<ProxyNode> proxyNodes = const [],
    List<ProxyNodeBinding> proxyNodeBindings = const [],
    List<ProxyChain> proxyChains = const [],
    List<ProxyChainHop> proxyChainHops = const [],
    List<ProxyChainBinding> proxyChainBindings = const [],
    List<ProxyNodeAsset> proxyNodeAssets = const [],
    List<ProxyGroupMember> groupMembers = const [],
    bool isOverride = false,
  }) async {
    if (isOverride ||
        profiles.isNotEmpty ||
        scripts.isNotEmpty ||
        rules.isNotEmpty ||
        links.isNotEmpty ||
        proxyGroups.isNotEmpty ||
        proxyNodes.isNotEmpty ||
        proxyNodeBindings.isNotEmpty ||
        proxyChains.isNotEmpty ||
        proxyChainHops.isNotEmpty ||
        proxyChainBindings.isNotEmpty ||
        proxyNodeAssets.isNotEmpty ||
        groupMembers.isNotEmpty) {
      await batch((b) {
        isOverride
            ? profilesDao.setAllWithBatch(b, profiles)
            : profilesDao.putAllWithBatch(
                b,
                profiles.map((item) => item.toCompanion()),
              );
        scriptsDao.setAllWithBatch(b, scripts);
        rulesDao.restoreWithBatch(b, rules, links);
        if (isOverride) {
          b.deleteAll(this.proxyGroupMembers);
          b.deleteAll(this.proxyChainHops);
          b.deleteAll(this.proxyChainBindings);
          b.deleteAll(this.proxyNodeBindings);
          b.deleteAll(this.proxyNodeAssets);
          b.deleteAll(this.proxyChains);
          b.deleteAll(this.proxyNodes);
        }
        proxyGroupsDao.setAllWithBatch(null, b, proxyGroups);
        proxyNodesDao.setAllWithBatch(b, proxyNodes);
        proxyNodeBindingsDao.setAllWithBatch(b, proxyNodeBindings);
        proxyChainsDao.setAllWithBatch(b, proxyChains);
        proxyChainHopsDao.setAllWithBatch(b, proxyChainHops);
        proxyChainBindingsDao.setAllWithBatch(b, proxyChainBindings);
        proxyNodeAssetsDao.setAllWithBatch(b, proxyNodeAssets);
        proxyGroupMembersDao.setAllWithBatch(b, groupMembers);
      });
    }
  }

  Future<void> setProfileCustomData(
    int profileId,
    List<ProxyGroup> groups,
    List<Rule> rules,
  ) async {
    await batch((b) {
      proxyGroupsDao.setAllWithBatch(profileId, b, groups);
      rulesDao.setCustomRulesWithBatch(profileId, b, rules);
    });
  }
}

extension TableInfoExt<Tbl extends Table, Row> on TableInfo<Tbl, Row> {
  void setAll(
    Batch batch,
    Iterable<Insertable<Row>> items, {
    required Expression<bool> Function(Tbl tbl) deleteFilter,
    bool preDelete = false,
  }) async {
    if (preDelete) {
      batch.deleteWhere(this, deleteFilter);
    }
    batch.insertAllOnConflictUpdate(this, items);
    if (!preDelete) {
      batch.deleteWhere(this, deleteFilter);
    }
  }

  Selectable<int?> get count {
    final countExp = countAll();
    final query = select().addColumns([countExp]);
    return query.map((row) => row.read(countExp));
  }

  Future<int> remove(Expression<bool> Function(Tbl tbl) filter) async {
    return (delete()..where(filter)).go();
  }

  Future<int> put(Insertable<Row> item) async {
    return insertOnConflictUpdate(item);
  }
}

extension SimpleSelectStatementExt<T extends HasResultSet, D>
    on SimpleSelectStatement<T, D> {
  Selectable<int> get count {
    final countExp = countAll();
    final query = addColumns([countExp]);
    return query.map((row) => row.read(countExp)!);
  }
}

extension JoinedSelectStatementExt<T extends HasResultSet, D>
    on JoinedSelectStatement<T, D> {
  Selectable<int> get count {
    final countExp = countAll();
    addColumns([countExp]);
    return map((row) => row.read(countExp)!);
  }
}

final database = Database();
