import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:avalon/common/yaml.dart';
import 'package:path/path.dart' as p;

import 'assets.dart';
import 'codec.dart';
import 'node.dart';

class NodeExportService {
  NodeExportService({NodeCodecRegistry? registry})
    : registry = registry ?? NodeCodecRegistry();

  final NodeCodecRegistry registry;

  Future<NodeExportResult> export(
    Iterable<ProxyNodeRecord> nodes, {
    bool includeZip = false,
    bool includeSecrets = true,
    Iterable<NodeAsset> assets = const [],
    NodeAssetManager? assetManager,
  }) async {
    final records = nodes.toList();
    final configs = records
        .map(effectiveNodeConfig)
        .map((config) => includeSecrets ? config : _redact(config))
        .toList();
    return _exportConfigs(
      configs,
      records: records,
      includeZip: includeZip,
      assets: assets.toList(),
      assetManager: assetManager,
    );
  }

  Future<NodeExportResult> exportConfigs(
    Iterable<Map<String, dynamic>> configs, {
    bool includeZip = false,
    bool includeSecrets = true,
    Iterable<String>? nodeIds,
    Iterable<NodeAsset> assets = const [],
    NodeAssetManager? assetManager,
    Iterable<Map<String, dynamic>> groups = const [],
  }) {
    final values = configs
        .map((config) => includeSecrets ? config : _redact(config))
        .toList();
    final ids = nodeIds?.toList();
    if (ids != null && ids.length != values.length) {
      throw ArgumentError.value(
        ids.length,
        'nodeIds',
        'Node ID count must match config count',
      );
    }
    return _exportConfigs(
      values,
      records: ids == null
          ? null
          : [
              for (var index = 0; index < values.length; index++)
                ProxyNodeRecord(id: ids[index], config: values[index]),
            ],
      includeZip: includeZip,
      assets: assets.toList(),
      assetManager: assetManager,
      groups: groups.toList(),
    );
  }

  Future<NodeExportResult> _exportConfigs(
    List<Map<String, dynamic>> configs, {
    List<ProxyNodeRecord>? records,
    required bool includeZip,
    List<NodeAsset> assets = const [],
    NodeAssetManager? assetManager,
    List<Map<String, dynamic>> groups = const [],
  }) async {
    final effectiveRecords =
        records ??
        [
          for (var index = 0; index < configs.length; index++)
            ProxyNodeRecord(id: 'export-$index', config: configs[index]),
        ];
    final uris = <String?>[];
    final issues = <NodeIssue>[];
    for (final config in configs) {
      final codec = registry[config['type']?.toString() ?? ''];
      final uri = codec?.exportUri(config);
      uris.add(uri);
      if (uri == null) {
        issues.add(
          NodeIssue(
            message: 'Protocol has no URI codec: ${config['type']}',
            severity: NodeIssueSeverity.warning,
          ),
        );
      }
    }
    final payload = <String, dynamic>{
      'proxies': configs,
      if (groups.isNotEmpty) 'proxy-groups': groups,
    };
    final jsonText = const JsonEncoder.withIndent('  ').convert(payload);
    final yamlText = yaml.encode(payload);
    final uriText = uris.whereType<String>().join('\n');
    final base64Text = base64Encode(
      utf8.encode(uriText.isEmpty ? yamlText : uriText),
    );
    final zipResult = includeZip
        ? await _zip(
            effectiveRecords,
            configs,
            uris,
            assets,
            assetManager,
            groups,
          )
        : null;
    issues.addAll(zipResult?.issues ?? const []);
    return NodeExportResult(
      uris: uris,
      base64: base64Text,
      yaml: yamlText,
      json: jsonText,
      zip: zipResult?.bytes,
      issues: issues,
    );
  }

  Future<({List<int> bytes, List<NodeIssue> issues})> _zip(
    List<ProxyNodeRecord> records,
    List<Map<String, dynamic>> configs,
    List<String?> uris,
    List<NodeAsset> assets,
    NodeAssetManager? assetManager,
    List<Map<String, dynamic>> groups,
  ) async {
    final archive = Archive();
    final issues = <NodeIssue>[];
    final zipConfigs = configs.map(deepCopyMap).toList();
    final selectedNodeIds = records.map((record) => record.id).toSet();
    final assetEntries = <String, List<Map<String, dynamic>>>{};
    if (assets.isNotEmpty && assetManager == null) {
      issues.add(
        const NodeIssue(
          message: 'Node asset manager is missing',
          code: 'missing-asset-manager',
        ),
      );
    }
    if (assetManager != null) {
      final configIndexes = <String, int>{
        for (var index = 0; index < records.length; index++)
          records[index].id: index,
      };
      for (final asset in assets) {
        if (!selectedNodeIds.contains(asset.nodeId)) continue;
        final configIndex = configIndexes[asset.nodeId];
        if (configIndex == null) continue;
        final fieldPath = asset.fieldPath.split('.');
        if (_valueAtPath(zipConfigs[configIndex], fieldPath) == '***') continue;
        try {
          final bytes = await File(assetManager.resolve(asset)).readAsBytes();
          final digest = sha256.convert(bytes).toString();
          if (digest != asset.sha256) {
            issues.add(
              NodeIssue(
                message: 'Node asset hash does not match: ${asset.id}',
                code: 'asset-hash-mismatch',
                source: asset.relativePath,
              ),
            );
            continue;
          }
          final extension = p.extension(asset.relativePath);
          final archivePath = p.posix.join(
            'assets',
            _safePathSegment(asset.nodeId),
            '${_safePathSegment(asset.id)}$extension',
          );
          archive.addFile(ArchiveFile(archivePath, bytes.length, bytes));
          _setPath(zipConfigs[configIndex], fieldPath, archivePath);
          assetEntries.putIfAbsent(asset.nodeId, () => []).add({
            'id': asset.id,
            'fieldPath': asset.fieldPath,
            'path': archivePath,
            'sha256': digest,
            'size': bytes.length,
          });
        } on Object catch (error) {
          issues.add(
            NodeIssue(
              message: 'Node asset export failed: ${asset.id}: $error',
              code: 'asset-export-failed',
              source: asset.relativePath,
            ),
          );
        }
      }
    }
    final zipPayload = <String, dynamic>{
      'proxies': zipConfigs,
      if (groups.isNotEmpty) 'proxy-groups': groups,
    };
    final zipJsonText = const JsonEncoder.withIndent('  ').convert(zipPayload);
    final zipYamlText = yaml.encode(zipPayload);
    final manifest = <String, dynamic>{
      'version': 1,
      'nodes': [
        for (var index = 0; index < records.length; index++)
          {
            'id': records[index].id,
            'name': configs[index]['name'],
            'type': configs[index]['type'],
            'uri': uris[index],
            'assets': assetEntries[records[index].id] ?? const [],
          },
      ],
      if (groups.isNotEmpty)
        'groups': [
          for (final group in groups)
            {
              'name': group['name'],
              'type': group['type'],
              'proxies': group['proxies'],
            },
        ],
    };
    void add(String path, List<int> bytes) {
      archive.addFile(ArchiveFile(path, bytes.length, bytes));
    }

    add('nodes.yaml', utf8.encode(zipYamlText));
    add('nodes.json', utf8.encode(zipJsonText));
    add(
      'manifest.json',
      utf8.encode(const JsonEncoder.withIndent('  ').convert(manifest)),
    );
    final uriText = uris.whereType<String>().join('\n');
    add('nodes.txt', utf8.encode(uriText));
    return (bytes: ZipEncoder().encode(archive), issues: issues);
  }
}

dynamic _valueAtPath(Map<String, dynamic> map, List<String> path) {
  dynamic current = map;
  for (final key in path) {
    if (current is! Map || !current.containsKey(key)) return null;
    current = current[key];
  }
  return current;
}

void _setPath(Map<String, dynamic> map, List<String> path, String value) {
  if (path.isEmpty) return;
  var current = map;
  for (final key in path.take(path.length - 1)) {
    final child = current[key];
    if (child is Map<String, dynamic>) {
      current = child;
    } else if (child is Map) {
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

String _safePathSegment(String value) {
  final result = value.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
  return result.isEmpty || result == '.' || result == '..' ? 'asset' : result;
}

const _secretFields = {
  'password',
  'uuid',
  'private-key',
  'client-key',
  'token',
  'auth',
  'psk',
};

Map<String, dynamic> _redact(Map<String, dynamic> config) {
  return {
    for (final entry in config.entries)
      entry.key: _secretFields.contains(entry.key.toLowerCase())
          ? '***'
          : entry.value is Map
          ? _redact(Map<String, dynamic>.from(entry.value as Map))
          : entry.value is List
          ? (entry.value as List)
                .map(
                  (value) => value is Map
                      ? _redact(Map<String, dynamic>.from(value))
                      : value,
                )
                .toList()
          : entry.value,
  };
}
