import 'dart:convert';

import 'codec.dart';
import 'node.dart';
import 'raw.dart';

class NodeInputDispatcher {
  NodeInputDispatcher({NodeCodecRegistry? registry, RawMihomoCodec? rawCodec})
    : registry = registry ?? NodeCodecRegistry(),
      rawCodec = rawCodec ?? const RawMihomoCodec();

  final NodeCodecRegistry registry;
  final RawMihomoCodec rawCodec;

  NodeImportResult importText(String input, {String? source}) {
    final text = _normalizeInput(input);
    if (text.isEmpty) {
      return const NodeImportResult(
        issues: [NodeIssue(message: 'Input is empty')],
      );
    }
    final uri = Uri.tryParse(text);
    // http(s) is never a node scheme, so any such URI is a subscription. This
    // is what keeps subscription links with an explicit port from being read
    // as proxy nodes.
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      return NodeImportResult(
        kind: NodeInputKind.subscription,
        subscriptionUrl: text,
      );
    }
    final lines = text
        .split(RegExp(r'[\r\n]+'))
        .map(_normalizeInput)
        .where((line) => line.isNotEmpty)
        .toList();
    if (lines.length > 1 &&
        (lines.every(_looksLikeUri) || lines.any(_isKnownScheme))) {
      return _parseUris(lines, source);
    }
    if (_isKnownScheme(text) || _looksLikeUri(text)) {
      return _parseUris([text], source);
    }
    final decoded = _decodeBase64(text);
    if (decoded != null && decoded.trim() != text) {
      final result = importText(decoded, source: source);
      if ((result.drafts.isNotEmpty || result.subscriptionUrl != null) &&
          (_looksLikeUri(decoded) ||
              decoded.trimLeft().startsWith('{') ||
              decoded.trimLeft().startsWith('[') ||
              decoded.trimLeft().startsWith('proxies:'))) {
        return NodeImportResult(
          drafts: result.drafts,
          issues: result.issues,
          kind: NodeInputKind.base64,
          subscriptionUrl: result.subscriptionUrl,
        );
      }
    }
    final drafts = rawCodec.parseText(text, source: source);
    return NodeImportResult(
      drafts: drafts,
      issues: drafts.expand((draft) => draft.issues).toList(),
      kind: _looksJson(text) ? NodeInputKind.json : NodeInputKind.yaml,
    );
  }

  List<NodeDraft> parseRaw(Object value, {String? source}) =>
      rawCodec.parse(value, source: source);

  bool _isKnownScheme(String value) {
    final uri = Uri.tryParse(value.trim());
    if (uri == null) return false;
    return registry[uri.scheme] != null;
  }

  bool _looksLikeUri(String value) =>
      RegExp(r'^[a-zA-Z][a-zA-Z0-9+.-]*://').hasMatch(value.trim());

  String _normalizeInput(String value) {
    return normalizeNodeUri(value);
  }

  NodeImportResult _parseUris(List<String> uris, String? source) {
    final drafts = <NodeDraft>[];
    final issues = <NodeIssue>[];
    for (var index = 0; index < uris.length; index++) {
      final value = uris[index];
      final normalized = _normalizeInput(value);
      final draft = registry.parse(normalized);
      final indexedIssues = [
        for (final issue in draft.issues)
          NodeIssue(
            message: issue.message,
            severity: issue.severity,
            source: issue.source ?? source ?? normalized,
            code: issue.code,
            index: index,
          ),
      ];
      drafts.add(
        NodeDraft(
          config: draft.config,
          source: draft.source ?? source,
          sourceKey: draft.sourceKey,
          format: draft.format,
          issues: indexedIssues,
          metadata: draft.metadata,
        ),
      );
      issues.addAll(indexedIssues);
    }
    return NodeImportResult(
      drafts: drafts,
      issues: issues,
      kind: NodeInputKind.uri,
    );
  }

  bool _looksJson(String text) => text.startsWith('{') || text.startsWith('[');

  String? _decodeBase64(String value) {
    try {
      final normalized = value
          .replaceAll(RegExp(r'\s+'), '')
          .replaceAll('-', '+')
          .replaceAll('_', '/');
      final padded = normalized.padRight((normalized.length + 3) ~/ 4 * 4, '=');
      return utf8.decode(base64.decode(padded));
    } catch (_) {
      return null;
    }
  }
}
