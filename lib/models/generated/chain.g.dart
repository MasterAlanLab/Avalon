// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProxyChain _$ProxyChainFromJson(Map<String, dynamic> json) => _ProxyChain(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  branchLimit: (json['branchLimit'] as num?)?.toInt() ?? 64,
  order: (json['order'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProxyChainToJson(_ProxyChain instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'branchLimit': instance.branchLimit,
      'order': instance.order,
    };

_ProxyChainHop _$ProxyChainHopFromJson(Map<String, dynamic> json) =>
    _ProxyChainHop(
      id: (json['id'] as num).toInt(),
      chainId: (json['chainId'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      targetKind: json['targetKind'] as String,
      nodeId: (json['nodeId'] as num?)?.toInt(),
      groupId: (json['groupId'] as num?)?.toInt(),
      profileId: (json['profileId'] as num?)?.toInt(),
      groupName: json['groupName'] as String?,
      localEndpoint: json['localEndpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProxyChainHopToJson(_ProxyChainHop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chainId': instance.chainId,
      'order': instance.order,
      'targetKind': instance.targetKind,
      'nodeId': instance.nodeId,
      'groupId': instance.groupId,
      'profileId': instance.profileId,
      'groupName': instance.groupName,
      'localEndpoint': instance.localEndpoint,
    };

_ProxyChainBinding _$ProxyChainBindingFromJson(Map<String, dynamic> json) =>
    _ProxyChainBinding(
      profileId: (json['profileId'] as num).toInt(),
      chainId: (json['chainId'] as num).toInt(),
      enabled: json['enabled'] as bool? ?? true,
      isDefault: json['isDefault'] as bool? ?? false,
      selectorName: json['selectorName'] as String?,
      entryGroups:
          (json['entryGroups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProxyChainBindingToJson(_ProxyChainBinding instance) =>
    <String, dynamic>{
      'profileId': instance.profileId,
      'chainId': instance.chainId,
      'enabled': instance.enabled,
      'isDefault': instance.isDefault,
      'selectorName': instance.selectorName,
      'entryGroups': instance.entryGroups,
      'order': instance.order,
    };

_ProxyNodeAsset _$ProxyNodeAssetFromJson(Map<String, dynamic> json) =>
    _ProxyNodeAsset(
      id: (json['id'] as num).toInt(),
      nodeId: (json['nodeId'] as num).toInt(),
      fieldPath: json['fieldPath'] as String,
      fileName: json['fileName'] as String,
      relativePath: json['relativePath'] as String,
      sha256: json['sha256'] as String,
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProxyNodeAssetToJson(_ProxyNodeAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nodeId': instance.nodeId,
      'fieldPath': instance.fieldPath,
      'fileName': instance.fileName,
      'relativePath': instance.relativePath,
      'sha256': instance.sha256,
      'size': instance.size,
    };

_ProxyGroupMember _$ProxyGroupMemberFromJson(Map<String, dynamic> json) =>
    _ProxyGroupMember(
      id: (json['id'] as num).toInt(),
      groupId: (json['groupId'] as num).toInt(),
      nodeId: (json['nodeId'] as num?)?.toInt(),
      literalName: json['literalName'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProxyGroupMemberToJson(_ProxyGroupMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'nodeId': instance.nodeId,
      'literalName': instance.literalName,
      'order': instance.order,
    };
