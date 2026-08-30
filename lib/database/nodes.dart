part of 'database.dart';

@TableIndex(name: 'idx_proxy_nodes_fingerprint', columns: {#fingerprint})
@TableIndex(name: 'idx_proxy_nodes_source', columns: {#sourceKind, #sourceKey})
@DataClassName('RawProxyNode')
class ProxyNodes extends Table {
  @override
  String get tableName => 'proxy_nodes';

  IntColumn get id => integer()();

  TextColumn get displayName => text()();

  TextColumn get type => text()();

  TextColumn get config => text().map(const JsonMapConverter())();

  TextColumn get sourceSnapshot =>
      text().map(const JsonMapNullableConverter()).nullable()();

  TextColumn get sourceKind => text().nullable()();

  IntColumn get sourceProfileId => integer().nullable().references(
    Profiles,
    #id,
    onDelete: KeyAction.setNull,
  )();

  TextColumn get sourceProvider => text().nullable()();

  TextColumn get sourceKey => text().nullable()();

  TextColumn get overlaySet =>
      text().map(const JsonMapNullableConverter()).nullable()();

  TextColumn get overlayRemove =>
      text().map(const StringListConverter()).nullable()();

  TextColumn get metadata =>
      text().map(const JsonMapNullableConverter()).nullable()();

  TextColumn get fingerprint => text()();

  TextColumn get status => text()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  IntColumn get order => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_profile_proxy_nodes_profile_order',
  columns: {#profileId, #order},
)
@DataClassName('RawProxyNodeBinding')
class ProxyNodeBindings extends Table {
  @override
  String get tableName => 'profile_proxy_nodes';

  IntColumn get profileId =>
      integer().references(Profiles, #id, onDelete: KeyAction.cascade)();

  IntColumn get nodeId =>
      integer().references(ProxyNodes, #id, onDelete: KeyAction.cascade)();

  TextColumn get alias => text().nullable()();

  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  IntColumn get order => integer().nullable()();

  @override
  Set<Column> get primaryKey => {profileId, nodeId};
}

@DriftAccessor(tables: [ProxyNodes])
class ProxyNodesDao extends DatabaseAccessor<Database>
    with _$ProxyNodesDaoMixin {
  ProxyNodesDao(super.attachedDatabase);

  Selectable<ProxyNode> query() {
    final stmt = proxyNodes.select()
      ..orderBy([
        (t) => OrderingTerm(expression: t.order, nulls: NullsOrder.last),
        (t) => OrderingTerm.asc(t.id),
      ]);
    return stmt.map((item) => item.toProxyNode());
  }

  Future<ProxyNode?> get(int id) async {
    return (select(proxyNodes)..where((t) => t.id.equals(id)))
        .map((item) => item.toProxyNode())
        .getSingleOrNull();
  }

  Future<ProxyNode?> getByFingerprint(String fingerprint) async {
    return (await getAllByFingerprint(fingerprint)).firstOrNull;
  }

  Future<List<ProxyNode>> getAllByFingerprint(String fingerprint) async {
    final stmt = select(proxyNodes)
      ..where((t) => t.fingerprint.equals(fingerprint))
      ..orderBy([(t) => OrderingTerm.asc(t.id)]);
    return stmt.map((item) => item.toProxyNode()).get();
  }

  Future<void> put(ProxyNode node) async {
    await into(proxyNodes).insertOnConflictUpdate(node.toCompanion());
  }

  Future<void> putAll(Iterable<ProxyNode> nodes) async {
    await batch((b) => setAllWithBatch(b, nodes));
  }

  void setAllWithBatch(Batch batch, Iterable<ProxyNode> nodes) {
    batch.insertAllOnConflictUpdate(
      proxyNodes,
      nodes.map((item) => item.toCompanion()),
    );
  }

  void replaceAllWithBatch(Batch batch, Iterable<ProxyNode> nodes) {
    batch.deleteWhere(proxyNodes, (_) => const Constant(true));
    setAllWithBatch(batch, nodes);
  }
}

@DriftAccessor(tables: [ProxyNodeBindings])
class ProxyNodeBindingsDao extends DatabaseAccessor<Database>
    with _$ProxyNodeBindingsDaoMixin {
  ProxyNodeBindingsDao(super.attachedDatabase);

  Selectable<ProxyNodeBinding> query(int profileId) {
    final stmt = proxyNodeBindings.select()
      ..where((t) => t.profileId.equals(profileId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.order, nulls: NullsOrder.last),
        (t) => OrderingTerm.asc(t.nodeId),
      ]);
    return stmt.map((item) => item.toProxyNodeBinding());
  }

  Future<void> put(ProxyNodeBinding binding) async {
    await into(proxyNodeBindings).insertOnConflictUpdate(binding.toCompanion());
  }

  Future<void> putAll(Iterable<ProxyNodeBinding> bindings) async {
    await batch((b) => setAllWithBatch(b, bindings));
  }

  void setAllWithBatch(Batch batch, Iterable<ProxyNodeBinding> bindings) {
    batch.insertAllOnConflictUpdate(
      proxyNodeBindings,
      bindings.map((item) => item.toCompanion()),
    );
  }

  void replaceAllWithBatch(Batch batch, Iterable<ProxyNodeBinding> bindings) {
    batch.deleteWhere(proxyNodeBindings, (_) => const Constant(true));
    setAllWithBatch(batch, bindings);
  }
}

extension RawProxyNodeExt on RawProxyNode {
  ProxyNode toProxyNode() {
    final sourceKindValue = sourceKind;
    final source = sourceKindValue == null
        ? null
        : ProxyNodeSource(
            kind: sourceKindValue,
            profileId: sourceProfileId,
            provider: sourceProvider,
            sourceKey: sourceKey,
          );
    return ProxyNode(
      id: id,
      displayName: displayName,
      type: type,
      config: config,
      sourceSnapshot: sourceSnapshot,
      source: source,
      overlaySet: overlaySet ?? const {},
      overlayRemove: overlayRemove ?? const [],
      metadata: metadata ?? const {},
      fingerprint: fingerprint,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      order: order,
    );
  }
}

extension ProxyNodeCompanionExt on ProxyNode {
  ProxyNodesCompanion toCompanion() {
    return ProxyNodesCompanion.insert(
      id: Value(id),
      displayName: displayName,
      type: type,
      config: config,
      sourceSnapshot: Value(sourceSnapshot),
      sourceKind: Value(source?.kind),
      sourceProfileId: Value(source?.profileId),
      sourceProvider: Value(source?.provider),
      sourceKey: Value(source?.sourceKey),
      overlaySet: Value(overlaySet),
      overlayRemove: Value(overlayRemove),
      metadata: Value(metadata),
      fingerprint: fingerprint,
      status: status,
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      order: Value(order),
    );
  }
}

extension RawProxyNodeBindingExt on RawProxyNodeBinding {
  ProxyNodeBinding toProxyNodeBinding() {
    return ProxyNodeBinding(
      profileId: profileId,
      nodeId: nodeId,
      alias: alias,
      enabled: enabled,
      order: order,
    );
  }
}

extension ProxyNodeBindingCompanionExt on ProxyNodeBinding {
  ProxyNodeBindingsCompanion toCompanion() {
    return ProxyNodeBindingsCompanion.insert(
      profileId: profileId,
      nodeId: nodeId,
      alias: Value(alias),
      enabled: Value(enabled),
      order: Value(order),
    );
  }
}
