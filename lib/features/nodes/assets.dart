import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:fl_clash/common/file.dart';
import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/common/snowflake.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/models/models.dart';
import 'package:path/path.dart' as p;

import 'node.dart';
import 'service.dart';

class NodeAsset {
  const NodeAsset({
    required this.id,
    required this.nodeId,
    required this.fieldPath,
    required this.relativePath,
    required this.sha256,
    required this.size,
  });

  final String id;
  final String nodeId;
  final String fieldPath;
  final String relativePath;
  final String sha256;
  final int size;

  Map<String, dynamic> toJson() => {
    'id': id,
    'nodeId': nodeId,
    'fieldPath': fieldPath,
    'relativePath': relativePath,
    'sha256': sha256,
    'size': size,
  };
}

class NodeAssetManager {
  const NodeAssetManager(this.rootPath);

  final String rootPath;

  Future<NodeAsset> copyAsset({
    required String nodeId,
    required String fieldPath,
    required String sourcePath,
    String? assetId,
  }) async {
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(nodeId)) {
      throw ArgumentError.value(nodeId, 'nodeId');
    }
    final source = File(sourcePath);
    if (!await source.exists()) {
      throw StateError('Asset does not exist: $sourcePath');
    }
    final bytes = await source.readAsBytes();
    final digest = sha256.convert(bytes).toString();
    final id = assetId ?? digest.substring(0, 16);
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(id)) {
      throw ArgumentError.value(id, 'assetId');
    }
    final extension = p.extension(source.path);
    final relative = p.posix.join('nodes', nodeId, 'assets', '$id$extension');
    final target = File(p.joinAll([rootPath, ...p.posix.split(relative)]));
    await target.parent.create(recursive: true);
    await target.writeAsBytes(bytes, flush: true);
    return NodeAsset(
      id: id,
      nodeId: nodeId,
      fieldPath: fieldPath,
      relativePath: relative,
      sha256: digest,
      size: bytes.length,
    );
  }

  String resolve(NodeAsset asset) {
    final root = p.normalize(p.absolute(rootPath));
    final portablePath = asset.relativePath.replaceAll('\\', '/');
    if (p.posix.isAbsolute(portablePath) ||
        p.posix.normalize(portablePath).startsWith('../')) {
      throw StateError('Asset path is outside the node store');
    }
    final target = p.normalize(
      p.absolute(p.joinAll([root, ...p.posix.split(portablePath)])),
    );
    if (!p.isWithin(root, target)) {
      throw StateError('Asset path is outside the node store');
    }
    return target;
  }

  Future<Map<String, dynamic>> materialize(
    Map<String, dynamic> config,
    Iterable<NodeAsset> assets,
  ) async {
    final result = jsonDecode(jsonEncode(config)) as Map<String, dynamic>;
    for (final asset in assets) {
      final path = resolve(asset);
      final file = File(path);
      if (!await file.exists()) throw StateError('Node asset is missing');
      final bytes = await file.readAsBytes();
      if (sha256.convert(bytes).toString() != asset.sha256) {
        throw StateError('Node asset hash does not match');
      }
      _setPath(result, asset.fieldPath.split('.'), path);
    }
    return result;
  }

  void _setPath(Map<String, dynamic> map, List<String> path, String value) {
    if (path.isEmpty) return;
    var current = map;
    for (final key in path.take(path.length - 1)) {
      final child = current[key];
      if (child is Map<String, dynamic>) {
        current = child;
      } else {
        final next = <String, dynamic>{};
        current[key] = next;
        current = next;
      }
    }
    current[path.last] = value;
  }
}

class StoredNodeAssetService {
  const StoredNodeAssetService({Database? store, String? rootPath})
    : _store = store,
      _rootPath = rootPath;

  final Database? _store;
  final String? _rootPath;

  Database get store => _store ?? database;

  Future<List<ProxyNodeAsset>> list(int nodeId) {
    return store.proxyNodeAssetsDao.query(nodeId).get();
  }

  Future<ProxyNodeAsset> attach({
    required int nodeId,
    required String fieldPath,
    required String sourcePath,
  }) async {
    final normalizedFieldPath = fieldPath.trim();
    if (normalizedFieldPath.isEmpty ||
        normalizedFieldPath
            .split('.')
            .any((segment) => segment.trim().isEmpty)) {
      throw ArgumentError.value(fieldPath, 'fieldPath');
    }
    final library = NodeLibraryService(store: store);
    final node = await library.get(nodeId);
    if (node == null) throw StateError('Node does not exist');
    final root = _rootPath ?? await appPath.homeDirPath;
    final assetId = snowflake.id;
    final copied = await NodeAssetManager(root).copyAsset(
      nodeId: nodeId.toString(),
      fieldPath: normalizedFieldPath,
      sourcePath: sourcePath,
      assetId: assetId.toString(),
    );
    final stored = ProxyNodeAsset(
      id: assetId,
      nodeId: nodeId,
      fieldPath: normalizedFieldPath,
      fileName: p.basename(sourcePath),
      relativePath: copied.relativePath,
      sha256: copied.sha256,
      size: copied.size,
    );
    final config = effectiveStoredNodeConfig(node);
    final replaced = (await list(
      nodeId,
    )).where((asset) => asset.fieldPath == normalizedFieldPath).toList();
    _setStoredPath(config, normalizedFieldPath.split('.'), copied.relativePath);
    try {
      await store.transaction(() async {
        await library.updateConfig(
          nodeId,
          NodeDraft(config: config),
          pruneAssets: false,
        );
        for (final asset in replaced) {
          await (store.delete(
            store.proxyNodeAssets,
          )..where((item) => item.id.equals(asset.id))).go();
        }
        await store
            .into(store.proxyNodeAssets)
            .insertOnConflictUpdate(stored.toCompanion());
      });
      for (final asset in replaced) {
        await _deleteStoredFile(root, asset);
      }
      return stored;
    } catch (_) {
      await File(NodeAssetManager(root).resolve(copied)).safeDelete();
      rethrow;
    }
  }

  Future<void> remove(int assetId) async {
    final rows = await store.select(store.proxyNodeAssets).get();
    final row = rows.where((item) => item.id == assetId).firstOrNull;
    if (row == null) return;
    final asset = row.toProxyNodeAsset();
    final library = NodeLibraryService(store: store);
    final node = await library.get(asset.nodeId);
    await store.transaction(() async {
      if (node != null) {
        final config = effectiveStoredNodeConfig(node);
        if (_storedValueAtPath(config, asset.fieldPath.split('.')) ==
            asset.relativePath) {
          _removeStoredPath(config, asset.fieldPath.split('.'));
          await library.updateConfig(
            node.id,
            NodeDraft(config: config),
            pruneAssets: false,
          );
        }
      }
      await (store.delete(
        store.proxyNodeAssets,
      )..where((item) => item.id.equals(assetId))).go();
    });
    final root = _rootPath ?? await appPath.homeDirPath;
    await _deleteStoredFile(root, asset);
  }
}

Future<void> _deleteStoredFile(String root, ProxyNodeAsset asset) async {
  await File(
    NodeAssetManager(root).resolve(
      NodeAsset(
        id: asset.id.toString(),
        nodeId: asset.nodeId.toString(),
        fieldPath: asset.fieldPath,
        relativePath: asset.relativePath,
        sha256: asset.sha256,
        size: asset.size ?? 0,
      ),
    ),
  ).safeDelete();
}

void _setStoredPath(
  Map<String, dynamic> config,
  List<String> path,
  String value,
) {
  var current = config;
  for (final key in path.take(path.length - 1)) {
    final child = current[key];
    if (child is Map) {
      final next = Map<String, dynamic>.from(child);
      current[key] = next;
      current = next;
    } else {
      final next = <String, dynamic>{};
      current[key] = next;
      current = next;
    }
  }
  current[path.last] = value;
}

dynamic _storedValueAtPath(Map<String, dynamic> config, List<String> path) {
  dynamic current = config;
  for (final key in path) {
    if (current is! Map || !current.containsKey(key)) return null;
    current = current[key];
  }
  return current;
}

void _removeStoredPath(Map<String, dynamic> config, List<String> path) {
  dynamic current = config;
  for (final key in path.take(path.length - 1)) {
    if (current is! Map || !current.containsKey(key)) return;
    current = current[key];
  }
  if (current is Map) current.remove(path.last);
}
