import 'dart:convert';

import 'package:yaml/yaml.dart';

import 'node.dart';

class RawMihomoCodec {
  const RawMihomoCodec();

  List<NodeDraft> parse(Object? value, {String? source}) {
    final converted = _convert(value);
    if (converted is Map<String, dynamic>) {
      if (converted['type'] != null) {
        return [_draft(converted, source)];
      }
      final proxies = converted['proxies'];
      if (proxies != null) return _parseProxyCollection(proxies, source);
      final proxy = converted['proxy'];
      if (proxy is Map) {
        return [_draft(_convert(proxy) as Map<String, dynamic>, source)];
      }
    }
    if (converted is List) return _parseProxyCollection(converted, source);
    return [
      NodeDraft(
        config: const {},
        source: source,
        format: NodeInputKind.raw,
        issues: [
          NodeIssue(message: 'Raw input does not contain a Mihomo node'),
        ],
      ),
    ];
  }

  List<NodeDraft> parseText(String text, {String? source}) {
    final trimmed = text.trim();
    try {
      return parse(jsonDecode(trimmed), source: source);
    } catch (_) {
      try {
        return parse(loadYaml(trimmed), source: source);
      } catch (error) {
        return [
          NodeDraft(
            config: const {},
            source: source,
            format: NodeInputKind.raw,
            issues: [NodeIssue(message: 'Invalid YAML or JSON: $error')],
          ),
        ];
      }
    }
  }

  List<NodeDraft> _parseProxyCollection(Object value, String? source) {
    if (value is List) {
      if (value.isEmpty) return [_emptyCollectionDraft(source)];
      return [
        for (var index = 0; index < value.length; index++)
          value[index] is Map
              ? _draft(
                  Map<String, dynamic>.from(_convert(value[index]) as Map),
                  source,
                  index: index,
                )
              : _invalidItemDraft(source, index),
      ];
    }
    if (value is Map) {
      if (value.isEmpty) return [_emptyCollectionDraft(source)];
      final entries = value.entries.toList();
      return [
        for (var index = 0; index < entries.length; index++)
          if (entries[index].value is Map)
            _draft(
              Map<String, dynamic>.from(_convert(entries[index].value) as Map)
                ..putIfAbsent('name', () => entries[index].key.toString()),
              source,
              index: index,
            )
          else
            _invalidItemDraft(source, index),
      ];
    }
    return [_emptyCollectionDraft(source)];
  }

  NodeDraft _draft(Map<String, dynamic> config, String? source, {int? index}) {
    final issues = <NodeIssue>[];
    final type = config['type']?.toString().trim();
    final name = config['name']?.toString().trim();
    if (name == null || name.isEmpty) {
      issues.add(
        const NodeIssue(
          code: 'missing-name',
          message: 'A raw Mihomo node requires a name.',
        ).withLocation(index, source),
      );
    }
    if (type == null || type.isEmpty) {
      issues.add(
        const NodeIssue(
          code: 'missing-type',
          message: 'A raw Mihomo node requires a type.',
        ).withLocation(index, source),
      );
    }
    if (type != null && type.isNotEmpty) config['type'] = type.toLowerCase();
    return NodeDraft(
      config: config,
      source: source,
      format: NodeInputKind.raw,
      issues: issues,
    );
  }

  NodeDraft _invalidItemDraft(String? source, int index) {
    return NodeDraft(
      config: const {},
      source: source,
      format: NodeInputKind.raw,
      issues: [
        NodeIssue(
          code: 'invalid-proxy-item',
          message: 'A Mihomo proxy entry must be a map.',
          index: index,
          source: source,
        ),
      ],
    );
  }

  NodeDraft _emptyCollectionDraft(String? source) {
    return NodeDraft(
      config: const {},
      source: source,
      format: NodeInputKind.raw,
      issues: [
        NodeIssue(
          code: 'empty-proxy-collection',
          message: 'Raw input does not contain a Mihomo node.',
          source: source,
        ),
      ],
    );
  }

  static dynamic _convert(dynamic value) {
    if (value is YamlMap) {
      return <String, dynamic>{
        for (final entry in value.entries)
          entry.key.toString(): _convert(entry.value),
      };
    }
    if (value is YamlList) return value.map(_convert).toList();
    if (value is Map) {
      return <String, dynamic>{
        for (final entry in value.entries)
          entry.key.toString(): _convert(entry.value),
      };
    }
    if (value is List) return value.map(_convert).toList();
    return value;
  }
}

extension on NodeIssue {
  NodeIssue withLocation(int? index, String? source) {
    return NodeIssue(
      message: message,
      severity: severity,
      source: this.source ?? source,
      code: code,
      index: index,
    );
  }
}
