// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProxyNodeSource _$ProxyNodeSourceFromJson(Map<String, dynamic> json) =>
    _ProxyNodeSource(
      kind: json['kind'] as String,
      profileId: (json['profileId'] as num?)?.toInt(),
      provider: json['provider'] as String?,
      sourceKey: json['sourceKey'] as String?,
    );

Map<String, dynamic> _$ProxyNodeSourceToJson(_ProxyNodeSource instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'profileId': instance.profileId,
      'provider': instance.provider,
      'sourceKey': instance.sourceKey,
    };

_ProxyNode _$ProxyNodeFromJson(Map<String, dynamic> json) => _ProxyNode(
  id: (json['id'] as num).toInt(),
  displayName: json['displayName'] as String,
  type: json['type'] as String,
  config: json['config'] as Map<String, dynamic>? ?? const {},
  sourceSnapshot: json['sourceSnapshot'] as Map<String, dynamic>?,
  source: json['source'] == null
      ? null
      : ProxyNodeSource.fromJson(json['source'] as Map<String, dynamic>),
  overlaySet: json['overlaySet'] as Map<String, dynamic>? ?? const {},
  overlayRemove:
      (json['overlayRemove'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  fingerprint: json['fingerprint'] as String,
  status: json['status'] as String? ?? 'active',
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  order: (json['order'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProxyNodeToJson(_ProxyNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'type': instance.type,
      'config': instance.config,
      'sourceSnapshot': instance.sourceSnapshot,
      'source': instance.source,
      'overlaySet': instance.overlaySet,
      'overlayRemove': instance.overlayRemove,
      'metadata': instance.metadata,
      'fingerprint': instance.fingerprint,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'order': instance.order,
    };

_ProxyNodeBinding _$ProxyNodeBindingFromJson(Map<String, dynamic> json) =>
    _ProxyNodeBinding(
      profileId: (json['profileId'] as num).toInt(),
      nodeId: (json['nodeId'] as num).toInt(),
      alias: json['alias'] as String?,
      enabled: json['enabled'] as bool? ?? true,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProxyNodeBindingToJson(_ProxyNodeBinding instance) =>
    <String, dynamic>{
      'profileId': instance.profileId,
      'nodeId': instance.nodeId,
      'alias': instance.alias,
      'enabled': instance.enabled,
      'order': instance.order,
    };
