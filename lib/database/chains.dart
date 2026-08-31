part of 'database.dart';

@DataClassName('RawProxyGroupMember')
class ProxyGroupMembers extends Table {
  @override
  String get tableName => 'proxy_group_members';

  IntColumn get id => integer()();

  IntColumn get groupId =>
      integer().references(ProxyGroups, #id, onDelete: KeyAction.cascade)();

  IntColumn get nodeId => integer().nullable().references(
    ProxyNodes,
    #id,
    onDelete: KeyAction.cascade,
  )();

  TextColumn get literalName => text().nullable()();

  IntColumn get order => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_proxy_chains_order', columns: {#order})
@DataClassName('RawProxyChain')
class ProxyChains extends Table {
  @override
  String get tableName => 'proxy_chains';

  IntColumn get id => integer()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  IntColumn get branchLimit => integer().withDefault(const Constant(64))();

  IntColumn get order => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_proxy_chain_hops_chain_order',
  columns: {#chainId, #order},
)
@DataClassName('RawProxyChainHop')
class ProxyChainHops extends Table {
  @override
  String get tableName => 'proxy_chain_hops';

  IntColumn get id => integer()();

  IntColumn get chainId =>
      integer().references(ProxyChains, #id, onDelete: KeyAction.cascade)();

  IntColumn get order => integer()();

  TextColumn get targetKind => text()();

  IntColumn get nodeId => integer().nullable().references(
    ProxyNodes,
    #id,
    onDelete: KeyAction.setNull,
  )();

  IntColumn get groupId => integer().nullable().references(
    ProxyGroups,
    #id,
    onDelete: KeyAction.setNull,
  )();

  IntColumn get profileId => integer().nullable().references(
    Profiles,
    #id,
    onDelete: KeyAction.setNull,
  )();

  TextColumn get groupName => text().nullable()();

  TextColumn get localEndpoint =>
      text().map(const JsonMapNullableConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_profile_proxy_chains_profile_order',
  columns: {#profileId, #order},
)
@DataClassName('RawProxyChainBinding')
class ProxyChainBindings extends Table {
  @override
  String get tableName => 'profile_proxy_chains';

  IntColumn get profileId =>
      integer().references(Profiles, #id, onDelete: KeyAction.cascade)();

  IntColumn get chainId =>
      integer().references(ProxyChains, #id, onDelete: KeyAction.cascade)();

  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  TextColumn get selectorName => text().nullable()();

  TextColumn get entryGroups =>
      text().map(const StringListConverter()).nullable()();

  IntColumn get order => integer().nullable()();

  @override
  Set<Column> get primaryKey => {profileId, chainId};
}

@DataClassName('RawProxyNodeAsset')
class ProxyNodeAssets extends Table {
  @override
  String get tableName => 'proxy_node_assets';

  IntColumn get id => integer()();

  IntColumn get nodeId =>
      integer().references(ProxyNodes, #id, onDelete: KeyAction.cascade)();

  TextColumn get fieldPath => text()();

  TextColumn get fileName => text()();

  TextColumn get relativePath => text()();

  TextColumn get sha256 => text()();

  IntColumn get size => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [ProxyChains])
class ProxyChainsDao extends DatabaseAccessor<Database>
    with _$ProxyChainsDaoMixin {
  ProxyChainsDao(super.attachedDatabase);

  Selectable<ProxyChain> query() {
    final stmt = proxyChains.select()
      ..orderBy([
        (t) => OrderingTerm(expression: t.order, nulls: NullsOrder.last),
        (t) => OrderingTerm.asc(t.id),
      ]);
    return stmt.map((item) => item.toProxyChain());
  }

  Future<ProxyChain?> get(int id) async {
    return (select(proxyChains)..where((t) => t.id.equals(id)))
        .map((item) => item.toProxyChain())
        .getSingleOrNull();
  }

  Future<void> put(ProxyChain chain) async {
    await into(proxyChains).insertOnConflictUpdate(chain.toCompanion());
  }

  void setAllWithBatch(Batch batch, Iterable<ProxyChain> chains) {
    batch.insertAllOnConflictUpdate(
      proxyChains,
      chains.map((item) => item.toCompanion()),
    );
  }

  void replaceAllWithBatch(Batch batch, Iterable<ProxyChain> chains) {
    batch.deleteWhere(proxyChains, (_) => const Constant(true));
    setAllWithBatch(batch, chains);
  }
}

@DriftAccessor(tables: [ProxyChainHops])
class ProxyChainHopsDao extends DatabaseAccessor<Database>
    with _$ProxyChainHopsDaoMixin {
  ProxyChainHopsDao(super.attachedDatabase);

  Selectable<ProxyChainHop> query(int chainId) {
    final stmt = proxyChainHops.select()
      ..where((t) => t.chainId.equals(chainId))
      ..orderBy([(t) => OrderingTerm.asc(t.order)]);
    return stmt.map((item) => item.toProxyChainHop());
  }

  void setAllWithBatch(Batch batch, Iterable<ProxyChainHop> hops) {
    batch.insertAllOnConflictUpdate(
      proxyChainHops,
      hops.map((item) => item.toCompanion()),
    );
  }

  void replaceAllWithBatch(Batch batch, Iterable<ProxyChainHop> hops) {
    batch.deleteWhere(proxyChainHops, (_) => const Constant(true));
    setAllWithBatch(batch, hops);
  }
}

@DriftAccessor(tables: [ProxyChainBindings])
class ProxyChainBindingsDao extends DatabaseAccessor<Database>
    with _$ProxyChainBindingsDaoMixin {
  ProxyChainBindingsDao(super.attachedDatabase);

  Future<void> put(ProxyChainBinding binding) async {
    await into(
      proxyChainBindings,
    ).insertOnConflictUpdate(binding.toCompanion());
  }

  Selectable<ProxyChainBinding> query(int profileId) {
    final stmt = proxyChainBindings.select()
      ..where((t) => t.profileId.equals(profileId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.order, nulls: NullsOrder.last),
        (t) => OrderingTerm.asc(t.chainId),
      ]);
    return stmt.map((item) => item.toProxyChainBinding());
  }

  void setAllWithBatch(Batch batch, Iterable<ProxyChainBinding> bindings) {
    batch.insertAllOnConflictUpdate(
      proxyChainBindings,
      bindings.map((item) => item.toCompanion()),
    );
  }

  void replaceAllWithBatch(Batch batch, Iterable<ProxyChainBinding> bindings) {
    batch.deleteWhere(proxyChainBindings, (_) => const Constant(true));
    setAllWithBatch(batch, bindings);
  }
}

@DriftAccessor(tables: [ProxyNodeAssets])
class ProxyNodeAssetsDao extends DatabaseAccessor<Database>
    with _$ProxyNodeAssetsDaoMixin {
  ProxyNodeAssetsDao(super.attachedDatabase);

  Selectable<ProxyNodeAsset> query(int nodeId) {
    return (proxyNodeAssets.select()..where((t) => t.nodeId.equals(nodeId)))
        .map((item) => item.toProxyNodeAsset());
  }

  void setAllWithBatch(Batch batch, Iterable<ProxyNodeAsset> assets) {
    batch.insertAllOnConflictUpdate(
      proxyNodeAssets,
      assets.map((item) => item.toCompanion()),
    );
  }

  void replaceAllWithBatch(Batch batch, Iterable<ProxyNodeAsset> assets) {
    batch.deleteWhere(proxyNodeAssets, (_) => const Constant(true));
    setAllWithBatch(batch, assets);
  }
}

@DriftAccessor(tables: [ProxyGroupMembers])
class ProxyGroupMembersDao extends DatabaseAccessor<Database>
    with _$ProxyGroupMembersDaoMixin {
  ProxyGroupMembersDao(super.attachedDatabase);

  Selectable<ProxyGroupMember> query(int groupId) {
    return (proxyGroupMembers.select()
          ..where((t) => t.groupId.equals(groupId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.order, nulls: NullsOrder.last),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .map((item) => item.toProxyGroupMember());
  }

  void setAllWithBatch(Batch batch, Iterable<ProxyGroupMember> members) {
    batch.insertAllOnConflictUpdate(
      proxyGroupMembers,
      members.map((item) => item.toCompanion()),
    );
  }

  void replaceAllWithBatch(Batch batch, Iterable<ProxyGroupMember> members) {
    batch.deleteWhere(proxyGroupMembers, (_) => const Constant(true));
    setAllWithBatch(batch, members);
  }
}

extension RawProxyChainExt on RawProxyChain {
  ProxyChain toProxyChain() => ProxyChain(
    id: id,
    name: name,
    description: description,
    branchLimit: branchLimit,
    order: order,
  );
}

extension ProxyChainCompanionExt on ProxyChain {
  ProxyChainsCompanion toCompanion() {
    return ProxyChainsCompanion.insert(
      id: Value(id),
      name: name,
      description: Value(description),
      branchLimit: Value(branchLimit),
      order: Value(order),
    );
  }
}

extension RawProxyChainHopExt on RawProxyChainHop {
  ProxyChainHop toProxyChainHop() => ProxyChainHop(
    id: id,
    chainId: chainId,
    order: order,
    targetKind: targetKind,
    nodeId: nodeId,
    groupId: groupId,
    profileId: profileId,
    groupName: groupName,
    localEndpoint: localEndpoint,
  );
}

extension ProxyChainHopCompanionExt on ProxyChainHop {
  ProxyChainHopsCompanion toCompanion() {
    return ProxyChainHopsCompanion.insert(
      id: Value(id),
      chainId: chainId,
      order: order,
      targetKind: targetKind,
      nodeId: Value(nodeId),
      groupId: Value(groupId),
      profileId: Value(profileId),
      groupName: Value(groupName),
      localEndpoint: Value(localEndpoint),
    );
  }
}

extension RawProxyChainBindingExt on RawProxyChainBinding {
  ProxyChainBinding toProxyChainBinding() => ProxyChainBinding(
    profileId: profileId,
    chainId: chainId,
    enabled: enabled,
    isDefault: isDefault,
    selectorName: selectorName,
    entryGroups: entryGroups ?? const [],
    order: order,
  );
}

extension ProxyChainBindingCompanionExt on ProxyChainBinding {
  ProxyChainBindingsCompanion toCompanion() {
    return ProxyChainBindingsCompanion.insert(
      profileId: profileId,
      chainId: chainId,
      enabled: Value(enabled),
      isDefault: Value(isDefault),
      selectorName: Value(selectorName),
      entryGroups: Value(entryGroups),
      order: Value(order),
    );
  }
}

extension RawProxyNodeAssetExt on RawProxyNodeAsset {
  ProxyNodeAsset toProxyNodeAsset() => ProxyNodeAsset(
    id: id,
    nodeId: nodeId,
    fieldPath: fieldPath,
    fileName: fileName,
    relativePath: relativePath,
    sha256: sha256,
    size: size,
  );
}

extension RawProxyGroupMemberExt on RawProxyGroupMember {
  ProxyGroupMember toProxyGroupMember() => ProxyGroupMember(
    id: id,
    groupId: groupId,
    nodeId: nodeId,
    literalName: literalName,
    order: order,
  );
}

extension ProxyGroupMemberCompanionExt on ProxyGroupMember {
  ProxyGroupMembersCompanion toCompanion() {
    return ProxyGroupMembersCompanion.insert(
      id: Value(id),
      groupId: groupId,
      nodeId: Value(nodeId),
      literalName: Value(literalName),
      order: Value(order),
    );
  }
}

extension ProxyNodeAssetCompanionExt on ProxyNodeAsset {
  ProxyNodeAssetsCompanion toCompanion() {
    return ProxyNodeAssetsCompanion.insert(
      id: Value(id),
      nodeId: nodeId,
      fieldPath: fieldPath,
      fileName: fileName,
      relativePath: relativePath,
      sha256: sha256,
      size: Value(size),
    );
  }
}
