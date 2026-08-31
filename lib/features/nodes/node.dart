import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:avalon/models/node.dart' as stored;

enum NodeIssueSeverity { warning, error }

enum NodeInputKind { uri, base64, yaml, json, subscription, raw }

class NodeIssue {
  const NodeIssue({
    required this.message,
    this.severity = NodeIssueSeverity.error,
    this.source,
    this.code,
    this.index,
  });

  final String message;
  final NodeIssueSeverity severity;
  final String? source;
  final String? code;
  final int? index;

  bool get isError => severity == NodeIssueSeverity.error;
}

class NodeDraft {
  NodeDraft({
    required Map<String, dynamic> config,
    this.source,
    this.sourceKey,
    this.format = NodeInputKind.raw,
    this.issues = const [],
    this.metadata = const {},
  }) : config = deepCopyMap(config),
       fingerprint = nodeFingerprint(config);

  final Map<String, dynamic> config;
  final String? source;
  final String? sourceKey;
  final NodeInputKind format;
  final List<NodeIssue> issues;
  final Map<String, dynamic> metadata;
  final String fingerprint;

  String get name => config['name']?.toString() ?? '';
  String get type => config['type']?.toString().toLowerCase() ?? '';

  stored.ProxyNode toStored({required int id, stored.ProxyNodeSource? source}) {
    final now = DateTime.now();
    return stored.ProxyNode(
      id: id,
      displayName: name.isEmpty ? '$type node' : name,
      type: type,
      config: _asObjectMap(config),
      sourceSnapshot: source == null ? null : _asObjectMap(config),
      source: source,
      metadata: _asObjectMap(metadata),
      fingerprint: fingerprint,
      createdAt: now,
      updatedAt: now,
    );
  }
}

class ProxyNodeRecord {
  ProxyNodeRecord({
    required this.id,
    required this.config,
    this.displayName,
    this.sourceSnapshot,
    this.source,
    this.sourceKey,
    this.overlay = const {},
    String? fingerprint,
  }) : fingerprint = fingerprint ?? nodeFingerprint(config);

  final String id;
  final Map<String, dynamic> config;
  final String? displayName;
  final Map<String, dynamic>? sourceSnapshot;
  final String? source;
  final String? sourceKey;
  final Map<String, dynamic> overlay;
  final String fingerprint;

  String get name => displayName ?? config['name']?.toString() ?? id;
  String get type => config['type']?.toString().toLowerCase() ?? '';
}

class NodeImportResult {
  const NodeImportResult({
    this.drafts = const [],
    this.issues = const [],
    this.kind,
    this.subscriptionUrl,
  });

  final List<NodeDraft> drafts;
  final List<NodeIssue> issues;
  final NodeInputKind? kind;
  final String? subscriptionUrl;

  bool get isValid => issues.every((issue) => !issue.isError);
}

class NodeExportResult {
  const NodeExportResult({
    required this.uris,
    required this.base64,
    required this.yaml,
    required this.json,
    this.zip,
    this.issues = const [],
  });

  final List<String?> uris;
  final String base64;
  final String yaml;
  final String json;
  final List<int>? zip;
  final List<NodeIssue> issues;
}

class SourceNodeKeyAllocator {
  SourceNodeKeyAllocator({required this.kind, this.provider});

  final String kind;
  final String? provider;
  final Map<String, int> _counts = <String, int>{};

  String allocate(Map<String, dynamic> config, String name) {
    final identity = (config['id'] ?? config['uuid'] ?? name).toString().trim();
    final baseKey =
        '$kind:${provider ?? ''}:${identity.isEmpty ? name : identity}';
    final occurrence = _counts.update(
      baseKey,
      (value) => value + 1,
      ifAbsent: () => 0,
    );
    return occurrence == 0 ? baseKey : '$baseKey#$occurrence';
  }
}

String nodeFingerprint(Map<String, dynamic> config) {
  final normalized = _withoutRuntimeFields(config);
  final encoded = jsonEncode(_sortValue(normalized));
  return sha256.convert(utf8.encode(encoded)).toString();
}

Map<String, dynamic> _withoutRuntimeFields(Map<String, dynamic> input) {
  final result = <String, dynamic>{};
  for (final entry in input.entries) {
    if (entry.key == 'name' || entry.key == 'dialer-proxy') {
      continue;
    }
    result[entry.key] = entry.value;
  }
  return result;
}

dynamic _sortValue(dynamic value) {
  if (value is Map) {
    final entries = <String, dynamic>{
      for (final entry in value.entries) entry.key.toString(): entry.value,
    };
    final keys = entries.keys.toList()..sort();
    return <String, dynamic>{
      for (final key in keys) key: _sortValue(entries[key]),
    };
  }
  if (value is Iterable) return value.map(_sortValue).toList();
  return value;
}

Map<String, dynamic> effectiveNodeConfig(ProxyNodeRecord record) {
  final source = record.sourceSnapshot == null
      ? <String, dynamic>{...record.config}
      : deepCopyMap(record.sourceSnapshot!);
  final merged = deepMergeNode(source, record.overlay);
  final remove = record.overlay['remove'];
  if (remove is Iterable) {
    for (final path in remove) {
      if (path is String) _removePath(merged, path);
    }
  }
  return merged;
}

Map<String, dynamic> effectiveStoredNodeConfig(stored.ProxyNode node) {
  final snapshot = node.sourceSnapshot;
  final base = snapshot == null
      ? _asObjectMap(node.config)
      : _asObjectMap(snapshot);
  final merged = deepMergeNode(base, _asObjectMap(node.overlaySet));
  for (final path in node.overlayRemove) {
    _removePath(merged, path);
  }
  return merged;
}

Map<String, dynamic> deepMergeNode(
  Map<String, dynamic> base,
  Map<String, dynamic> overlay,
) {
  final result = deepCopyMap(base);
  for (final entry in overlay.entries) {
    final value = entry.value;
    if (value is Map && result[entry.key] is Map) {
      result[entry.key] = deepMergeNode(
        Map<String, dynamic>.from(result[entry.key] as Map),
        Map<String, dynamic>.from(value),
      );
    } else {
      result[entry.key] = _deepCopyValue(value);
    }
  }
  return result;
}

Map<String, dynamic> deepCopyMap(Map value) {
  return {
    for (final entry in value.entries)
      entry.key.toString(): _deepCopyValue(entry.value),
  };
}

Map<String, dynamic> _asObjectMap(Map value) {
  return {
    for (final entry in value.entries)
      entry.key.toString(): _deepCopyValue(entry.value),
  };
}

dynamic _deepCopyValue(dynamic value) {
  if (value is Map) return deepCopyMap(value);
  if (value is List) return value.map(_deepCopyValue).toList();
  if (value is Set) return value.map(_deepCopyValue).toList();
  return value;
}

void _removePath(Map<String, dynamic> map, String path) {
  final parts = path
      .split('.')
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList();
  if (parts.isEmpty) return;
  dynamic current = map;
  for (final part in parts.take(parts.length - 1)) {
    if (current is! Map || !current.containsKey(part)) return;
    current = current[part];
  }
  if (current is Map) current.remove(parts.last);
}
