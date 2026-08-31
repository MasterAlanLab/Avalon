import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:avalon/common/file.dart';
import 'package:avalon/common/path.dart';
import 'package:avalon/database/database.dart';
import 'package:avalon/common/snowflake.dart';
import 'package:avalon/models/models.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'importer.dart';
import 'node.dart';
import 'raw.dart';

class NodeImportCommitResult {
  const NodeImportCommitResult({
    this.created = const [],
    this.updated = const [],
    this.copies = const [],
    this.issues = const [],
  });

  final List<ProxyNode> created;
  final List<ProxyNode> updated;
  final List<ProxyNode> copies;
  final List<NodeIssue> issues;

  List<ProxyNode> get all => [...created, ...updated, ...copies];
}

class NodeLibraryService {
  const NodeLibraryService({Database? store}) : _store = store;

  final Database? _store;

  Database get store => _store ?? database;

  Stream<List<ProxyNode>> watch() => store.proxyNodesDao.query().watch();

  Future<List<ProxyNode>> list() => store.proxyNodesDao.query().get();

  Future<ProxyNode?> get(int id) => store.proxyNodesDao.get(id);

  Future<NodeImportCommitResult> commit(
    NodeImportResult input, {
    int? profileId,
    bool bind = false,
    bool createCopy = false,
  }) async {
    final created = <ProxyNode>[];
    final updated = <ProxyNode>[];
    final copies = <ProxyNode>[];
    final issues = input.issues.isEmpty
        ? input.drafts.expand((draft) => draft.issues).toList()
        : <NodeIssue>[...input.issues];
    await store.transaction(() async {
      for (final draft in input.drafts) {
        if (draft.issues.any((issue) => issue.isError)) {
          continue;
        }
        final config = _asObjectMap(draft.config);
        final type = config['type']?.toString().toLowerCase();
        if (type == null || type.isEmpty) {
          issues.add(
            const NodeIssue(message: 'A Mihomo node requires a type.'),
          );
          continue;
        }
        final now = DateTime.now();
        final existing = createCopy
            ? null
            : (await store.proxyNodesDao.getAllByFingerprint(
                draft.fingerprint,
              )).firstWhereOrNull((node) => node.source == null);
        final node = existing == null
            ? ProxyNode(
                id: snowflake.id,
                displayName: _displayName(config, type),
                type: type,
                config: config,
                fingerprint: draft.fingerprint,
                metadata: _asObjectMap(draft.metadata),
                createdAt: now,
                updatedAt: now,
              )
            : existing.copyWith(
                displayName: _displayName(config, type, existing.displayName),
                type: type,
                config: config,
                fingerprint: draft.fingerprint,
                metadata: draft.metadata.isEmpty
                    ? existing.metadata
                    : _asObjectMap(draft.metadata),
                status: 'active',
                updatedAt: now,
              );
        await store.proxyNodesDao.put(node);
        if (existing == null) {
          if (createCopy) {
            copies.add(node);
          } else {
            created.add(node);
          }
        } else {
          updated.add(node);
        }
        if (bind && profileId != null) {
          await store.proxyNodeBindingsDao.put(
            ProxyNodeBinding(profileId: profileId, nodeId: node.id),
          );
        }
      }
    });
    return NodeImportCommitResult(
      created: List.unmodifiable(created),
      updated: List.unmodifiable(updated),
      copies: List.unmodifiable(copies),
      issues: List.unmodifiable(issues),
    );
  }

  Future<void> bind({required int profileId, required int nodeId}) {
    return store.proxyNodeBindingsDao.put(
      ProxyNodeBinding(profileId: profileId, nodeId: nodeId),
    );
  }

  Future<void> unbind({required int profileId, required int nodeId}) {
    return store.proxyNodeBindingsDao.remove(profileId, nodeId);
  }

  Future<void> rename(int nodeId, String displayName) async {
    final node = await get(nodeId);
    if (node == null) return;
    await store.proxyNodesDao.put(
      node.copyWith(
        displayName: displayName.trim().isEmpty
            ? node.displayName
            : displayName.trim(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> delete(int nodeId) async {
    await store.proxyNodesDao.remove(nodeId);
    await Directory(
      await appPath.getNodeAssetsDirPath(nodeId),
    ).safeDelete(recursive: true);
  }

  Future<void> saveOverlay(
    int nodeId, {
    required Map<String, Object?> set,
    required List<String> remove,
  }) async {
    final node = await get(nodeId);
    if (node == null) return;
    await store.proxyNodesDao.put(
      node.copyWith(
        overlaySet: _asObjectMap(set),
        overlayRemove: List.unmodifiable(remove),
        updatedAt: DateTime.now(),
      ),
    );
    final updated = await get(nodeId);
    if (updated != null) {
      await _pruneAssets(nodeId, effectiveStoredNodeConfig(updated));
    }
  }

  Future<void> updateConfig(
    int nodeId,
    NodeDraft draft, {
    bool pruneAssets = true,
  }) async {
    final node = await get(nodeId);
    if (node == null) return;
    final config = _asObjectMap(draft.config);
    final sourceSnapshot = node.sourceSnapshot;
    final next = sourceSnapshot == null
        ? node.copyWith(
            displayName: _displayName(config, draft.type, node.displayName),
            type: draft.type,
            config: config,
            fingerprint: draft.fingerprint,
            status: 'active',
            updatedAt: DateTime.now(),
          )
        : node.copyWith(
            displayName: _displayName(config, draft.type, node.displayName),
            type: draft.type,
            config: config,
            overlaySet: _diffSet(sourceSnapshot, config),
            overlayRemove: _diffRemove(sourceSnapshot, config),
            fingerprint: draft.fingerprint,
            status: 'active',
            updatedAt: DateTime.now(),
          );
    await store.proxyNodesDao.put(next);
    if (pruneAssets) await _pruneAssets(nodeId, config);
  }

  Future<void> clearOverlay(int nodeId) async {
    final node = await get(nodeId);
    if (node == null) return;
    await store.proxyNodesDao.put(
      node.copyWith(
        overlaySet: const {},
        overlayRemove: const [],
        updatedAt: DateTime.now(),
      ),
    );
    final updated = await get(nodeId);
    if (updated != null) {
      await _pruneAssets(nodeId, effectiveStoredNodeConfig(updated));
    }
  }

  Future<void> _pruneAssets(int nodeId, Map<String, dynamic> config) async {
    final assets = await store.proxyNodeAssetsDao.query(nodeId).get();
    final root = await appPath.homeDirPath;
    for (final asset in assets) {
      final value = _valueAtConfigPath(config, asset.fieldPath);
      if (value == asset.relativePath) continue;
      await (store.delete(
        store.proxyNodeAssets,
      )..where((row) => row.id.equals(asset.id))).go();
      final relative = asset.relativePath.replaceAll('\\', '/');
      if (p.posix.isAbsolute(relative) ||
          p.posix.normalize(relative).startsWith('../')) {
        continue;
      }
      await File(p.joinAll([root, ...p.posix.split(relative)])).safeDelete();
    }
  }

  String _displayName(
    Map<String, dynamic> config,
    String type, [
    String? fallback,
  ]) {
    final name = config['name']?.toString().trim();
    if (name != null && name.isNotEmpty) return name;
    return fallback ?? '$type node';
  }
}

dynamic _valueAtConfigPath(Map<String, dynamic> config, String fieldPath) {
  dynamic current = config;
  for (final part in fieldPath.split('.')) {
    if (part.isEmpty || current is! Map || !current.containsKey(part)) {
      return null;
    }
    current = current[part];
  }
  return current;
}

class NodeSourceSyncReport {
  const NodeSourceSyncReport({
    this.created = const [],
    this.updated = const [],
    this.unchanged = const [],
    this.stale = const [],
    this.conflicts = const [],
    this.issues = const [],
  });

  final List<ProxyNode> created;
  final List<ProxyNode> updated;
  final List<ProxyNode> unchanged;
  final List<ProxyNode> stale;
  final List<NodeIssue> conflicts;
  final List<NodeIssue> issues;
}

class NodeSourceSyncService {
  const NodeSourceSyncService({NodeLibraryService? library})
    : _library = library ?? const NodeLibraryService();

  final NodeLibraryService _library;

  Future<NodeSourceSyncReport> syncProfile({
    required int profileId,
    required Map<String, dynamic> config,
    String? provider,
  }) {
    return _library.store.transaction(
      () => _syncProfile(
        profileId: profileId,
        config: config,
        provider: provider,
      ),
    );
  }

  Future<NodeSourceSyncReport> _syncProfile({
    required int profileId,
    required Map<String, dynamic> config,
    String? provider,
  }) async {
    final hasSourcePayload =
        config.containsKey('proxies') || config['type'] != null;
    final rawProxies = config['proxies'];
    final parsedEntries = config['type'] != null
        ? <Object?>[config]
        : _proxyEntries(rawProxies);
    final current = await _library.list();
    final sourceKind = provider == null ? 'profile' : 'provider';
    final sourceNodes = current.where((node) {
      final source = node.source;
      return source?.kind == sourceKind &&
          source?.profileId == profileId &&
          source?.provider == provider;
    }).toList();
    final matchedNodeIds = <int>{};
    final byFingerprint = <String, List<ProxyNode>>{};
    for (final node in sourceNodes) {
      byFingerprint.putIfAbsent(node.fingerprint, () => []).add(node);
      final snapshot = node.sourceSnapshot;
      if (snapshot != null) {
        final snapshotFingerprint = nodeFingerprint(
          Map<String, dynamic>.from(snapshot),
        );
        if (snapshotFingerprint != node.fingerprint) {
          byFingerprint.putIfAbsent(snapshotFingerprint, () => []).add(node);
        }
      }
    }
    final keyAllocator = SourceNodeKeyAllocator(
      kind: sourceKind,
      provider: provider,
    );
    final created = <ProxyNode>[];
    final updated = <ProxyNode>[];
    final unchanged = <ProxyNode>[];
    final conflicts = <NodeIssue>[];
    final issues = <NodeIssue>[];
    if (hasSourcePayload && config['type'] == null && parsedEntries == null) {
      issues.add(
        NodeIssue(
          code: 'invalid-source-payload',
          message: 'A source payload must contain a proxy collection.',
          source: provider ?? profileId.toString(),
        ),
      );
      return NodeSourceSyncReport(issues: List.unmodifiable(issues));
    }
    final entries = parsedEntries ?? const <Object?>[];
    var validEntries = 0;
    for (var index = 0; index < entries.length; index++) {
      final item = entries[index];
      if (item is! Map) {
        issues.add(
          NodeIssue(
            code: 'invalid-source-node',
            message: 'A source proxy entry must be a map.',
            source: provider ?? profileId.toString(),
            index: index,
          ),
        );
        continue;
      }
      final map = _asObjectMap(item);
      final validationDrafts = const RawMihomoCodec().parse(map);
      final validation = validationDrafts.firstOrNull;
      if (validation == null || validationDrafts.length != 1) {
        issues.add(
          NodeIssue(
            code: 'invalid-source-node',
            message: 'A source proxy entry must describe one node.',
            source: provider ?? profileId.toString(),
            index: index,
          ),
        );
        continue;
      }
      if (validation.issues.any((issue) => issue.isError)) {
        issues.addAll([
          for (final issue in validation.issues)
            NodeIssue(
              message: issue.message,
              severity: issue.severity,
              source: provider ?? profileId.toString(),
              code: issue.code,
              index: index,
            ),
        ]);
        continue;
      }
      final rawName = map['name']?.toString().trim();
      if (rawName == null || rawName.isEmpty) {
        issues.add(
          NodeIssue(
            code: 'missing-source-name',
            message: 'A source proxy entry requires a name.',
            source: provider ?? profileId.toString(),
            index: index,
          ),
        );
        continue;
      }
      validEntries++;
      final name = rawName;
      final key = keyAllocator.allocate(map, name);
      final draft = NodeDraft(config: map, sourceKey: key);
      final exact = sourceNodes
          .where(
            (node) =>
                node.source?.sourceKey == key &&
                !matchedNodeIds.contains(node.id),
          )
          .firstOrNull;
      final fingerprintMatches = (byFingerprint[draft.fingerprint] ?? const [])
          .where((node) => !matchedNodeIds.contains(node.id))
          .toList();
      if (exact == null && fingerprintMatches.length > 1) {
        conflicts.add(
          NodeIssue(
            code: 'source-fingerprint-conflict',
            message: 'Multiple source nodes match the same fingerprint.',
            severity: NodeIssueSeverity.warning,
            source: key,
            index: index,
          ),
        );
      }
      final old = exact ?? fingerprintMatches.firstOrNull;
      if (old != null) matchedNodeIds.add(old.id);
      final now = DateTime.now();
      final source = ProxyNodeSource(
        kind: sourceKind,
        profileId: profileId,
        provider: provider,
        sourceKey: key,
      );
      final oldSourceName = old == null
          ? null
          : old.sourceSnapshot?['name']?.toString() ??
                old.config['name']?.toString();
      final hasLocalRename =
          old != null &&
          oldSourceName != null &&
          old.displayName.trim().isNotEmpty &&
          old.displayName != oldSourceName;
      final displayName = hasLocalRename ? old.displayName : name;
      final node = old == null
          ? ProxyNode(
              id: snowflake.id,
              displayName: displayName,
              type: draft.type,
              config: deepCopyMap(map),
              sourceSnapshot: deepCopyMap(map),
              source: source,
              fingerprint: draft.fingerprint,
              createdAt: now,
              updatedAt: now,
            )
          : old.copyWith(
              displayName: displayName,
              type: draft.type,
              config: deepCopyMap(map),
              sourceSnapshot: deepCopyMap(map),
              source: source,
              fingerprint: draft.fingerprint,
              status: 'active',
              updatedAt: now,
            );
      final isUnchanged =
          old != null &&
          const DeepCollectionEquality().equals(old.sourceSnapshot, map) &&
          old.type == draft.type &&
          old.source == source &&
          old.status == 'active';
      if (!isUnchanged) await _library.store.proxyNodesDao.put(node);
      await _library.bind(profileId: profileId, nodeId: node.id);
      if (old == null) {
        created.add(node);
      } else if (isUnchanged) {
        unchanged.add(old);
      } else {
        updated.add(node);
      }
    }
    final stale = <ProxyNode>[];
    final hasErrors = issues.any((issue) => issue.isError);
    if (hasSourcePayload &&
        entries.isNotEmpty &&
        validEntries == 0 &&
        hasErrors) {
      return NodeSourceSyncReport(
        conflicts: List.unmodifiable(conflicts),
        issues: List.unmodifiable(issues),
      );
    }
    if (!hasSourcePayload || hasErrors) {
      return NodeSourceSyncReport(
        created: List.unmodifiable(created),
        updated: List.unmodifiable(updated),
        unchanged: List.unmodifiable(unchanged),
        conflicts: List.unmodifiable(conflicts),
        issues: List.unmodifiable(issues),
      );
    }
    for (final node in sourceNodes) {
      if (!matchedNodeIds.contains(node.id) && node.status != 'stale') {
        final next = node.copyWith(status: 'stale', updatedAt: DateTime.now());
        await _library.store.proxyNodesDao.put(next);
        stale.add(next);
      }
    }
    return NodeSourceSyncReport(
      created: List.unmodifiable(created),
      updated: List.unmodifiable(updated),
      unchanged: List.unmodifiable(unchanged),
      stale: List.unmodifiable(stale),
      conflicts: List.unmodifiable(conflicts),
      issues: List.unmodifiable(issues),
    );
  }

  Future<NodeSourceSyncReport> syncProfileFile({
    required int profileId,
    required File file,
    String? provider,
  }) async {
    if (!await file.exists()) return const NodeSourceSyncReport();
    final text = await file.readAsString();
    dynamic decoded;
    try {
      decoded = _convertYaml(loadYaml(text));
    } catch (_) {
      decoded = null;
    }
    if (decoded is Map) {
      return syncProfile(
        profileId: profileId,
        config: Map<String, dynamic>.from(decoded),
        provider: provider,
      );
    }
    final input = NodeInputDispatcher().importText(text, source: file.path);
    final nodes = [
      for (final draft in input.drafts)
        if (draft.issues.every((issue) => !issue.isError)) draft.config,
    ];
    if (nodes.isEmpty) return const NodeSourceSyncReport();
    return syncProfile(
      profileId: profileId,
      config: {'proxies': nodes},
      provider: provider,
    );
  }
}

List<Object?>? _proxyEntries(Object? raw) {
  if (raw is List) return List<Object?>.from(raw);
  if (raw is Map) {
    if (raw['type'] != null) return [raw];
    return raw.entries.map((entry) {
      if (entry.value is! Map) return entry.value;
      final value = deepCopyMap(entry.value as Map);
      value.putIfAbsent('name', () => entry.key.toString());
      return value;
    }).toList();
  }
  return null;
}

dynamic _convertYaml(dynamic value) {
  if (value is YamlMap) {
    return {
      for (final entry in value.entries)
        entry.key.toString(): _convertYaml(entry.value),
    };
  }
  if (value is YamlList) return value.map(_convertYaml).toList();
  if (value is Map) {
    return {
      for (final entry in value.entries)
        entry.key.toString(): _convertYaml(entry.value),
    };
  }
  if (value is List) return value.map(_convertYaml).toList();
  return value;
}

Map<String, Object?> _diffSet(Map source, Map target) {
  const equality = DeepCollectionEquality();
  final result = <String, Object?>{};
  for (final entry in target.entries) {
    final key = entry.key.toString();
    final sourceValue = source[key];
    final targetValue = entry.value;
    if (sourceValue is Map && targetValue is Map) {
      final child = _diffSet(sourceValue, targetValue);
      if (child.isNotEmpty) result[key] = child;
    } else if (!equality.equals(sourceValue, targetValue)) {
      result[key] = _copyValue(targetValue);
    }
  }
  return result;
}

List<String> _diffRemove(Map source, Map target, [String prefix = '']) {
  final result = <String>[];
  for (final entry in source.entries) {
    final key = entry.key.toString();
    final path = prefix.isEmpty ? key : '$prefix.$key';
    if (!target.containsKey(key)) {
      result.add(path);
      continue;
    }
    final sourceValue = entry.value;
    final targetValue = target[key];
    if (sourceValue is Map && targetValue is Map) {
      result.addAll(_diffRemove(sourceValue, targetValue, path));
    }
  }
  return result;
}

Map<String, Object?> _asObjectMap(Map<dynamic, dynamic> value) => {
  for (final entry in value.entries)
    entry.key.toString(): _copyValue(entry.value),
};

dynamic _copyValue(dynamic value) {
  if (value is Map) return _asObjectMap(value);
  if (value is List) return value.map(_copyValue).toList();
  return value;
}

extension on ProxyNodeBindingsDao {
  Future<void> remove(int profileId, int nodeId) async {
    await (delete(proxyNodeBindings)
          ..where((row) => row.profileId.equals(profileId))
          ..where((row) => row.nodeId.equals(nodeId)))
        .go();
  }
}

extension on ProxyNodesDao {
  Future<void> remove(int nodeId) async {
    await (delete(proxyNodes)..where((row) => row.id.equals(nodeId))).go();
  }
}
