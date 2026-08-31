import 'package:avalon/common/snowflake.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/node.freezed.dart';
part 'generated/node.g.dart';

@freezed
abstract class ProxyNodeSource with _$ProxyNodeSource {
  const factory ProxyNodeSource({
    required String kind,
    int? profileId,
    String? provider,
    String? sourceKey,
  }) = _ProxyNodeSource;

  factory ProxyNodeSource.fromJson(Map<String, Object?> json) =>
      _$ProxyNodeSourceFromJson(json);
}

@freezed
abstract class ProxyNode with _$ProxyNode {
  const factory ProxyNode({
    required int id,
    required String displayName,
    required String type,
    @Default({}) Map<String, Object?> config,
    Map<String, Object?>? sourceSnapshot,
    ProxyNodeSource? source,
    @Default({}) Map<String, Object?> overlaySet,
    @Default([]) List<String> overlayRemove,
    @Default({}) Map<String, Object?> metadata,
    required String fingerprint,
    @Default('active') String status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? order,
  }) = _ProxyNode;

  factory ProxyNode.fromJson(Map<String, Object?> json) =>
      _$ProxyNodeFromJson(json);

  factory ProxyNode.normal({
    required String displayName,
    required String type,
    required Map<String, Object?> config,
    required String fingerprint,
  }) {
    final now = DateTime.now();
    return ProxyNode(
      id: snowflake.id,
      displayName: displayName,
      type: type,
      config: config,
      fingerprint: fingerprint,
      createdAt: now,
      updatedAt: now,
    );
  }
}

@freezed
abstract class ProxyNodeBinding with _$ProxyNodeBinding {
  const factory ProxyNodeBinding({
    required int profileId,
    required int nodeId,
    String? alias,
    @Default(true) bool enabled,
    int? order,
  }) = _ProxyNodeBinding;

  factory ProxyNodeBinding.fromJson(Map<String, Object?> json) =>
      _$ProxyNodeBindingFromJson(json);
}
