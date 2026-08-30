import 'package:fl_clash/common/snowflake.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/chain.freezed.dart';
part 'generated/chain.g.dart';

@freezed
abstract class ProxyChain with _$ProxyChain {
  const factory ProxyChain({
    required int id,
    required String name,
    String? description,
    @Default(64) int branchLimit,
    int? order,
  }) = _ProxyChain;

  factory ProxyChain.fromJson(Map<String, Object?> json) =>
      _$ProxyChainFromJson(json);

  factory ProxyChain.normal({
    required String name,
    String? description,
    int branchLimit = 64,
  }) {
    return ProxyChain(
      id: snowflake.id,
      name: name,
      description: description,
      branchLimit: branchLimit,
    );
  }
}

@freezed
abstract class ProxyChainHop with _$ProxyChainHop {
  const factory ProxyChainHop({
    required int id,
    required int chainId,
    required int order,
    required String targetKind,
    int? nodeId,
    int? groupId,
    int? profileId,
    String? groupName,
    Map<String, Object?>? localEndpoint,
  }) = _ProxyChainHop;

  factory ProxyChainHop.fromJson(Map<String, Object?> json) =>
      _$ProxyChainHopFromJson(json);
}

@freezed
abstract class ProxyChainBinding with _$ProxyChainBinding {
  const factory ProxyChainBinding({
    required int profileId,
    required int chainId,
    @Default(true) bool enabled,
    @Default(false) bool isDefault,
    String? selectorName,
    int? order,
  }) = _ProxyChainBinding;

  factory ProxyChainBinding.fromJson(Map<String, Object?> json) =>
      _$ProxyChainBindingFromJson(json);
}

@freezed
abstract class ProxyNodeAsset with _$ProxyNodeAsset {
  const factory ProxyNodeAsset({
    required int id,
    required int nodeId,
    required String fieldPath,
    required String fileName,
    required String relativePath,
    required String sha256,
    int? size,
  }) = _ProxyNodeAsset;

  factory ProxyNodeAsset.fromJson(Map<String, Object?> json) =>
      _$ProxyNodeAssetFromJson(json);
}

@freezed
abstract class ProxyGroupMember with _$ProxyGroupMember {
  const factory ProxyGroupMember({
    required int id,
    required int groupId,
    int? nodeId,
    String? literalName,
    int? order,
  }) = _ProxyGroupMember;

  factory ProxyGroupMember.fromJson(Map<String, Object?> json) =>
      _$ProxyGroupMemberFromJson(json);
}
