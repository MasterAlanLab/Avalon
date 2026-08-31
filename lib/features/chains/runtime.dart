import 'package:avalon/common/common.dart';
import 'package:avalon/database/database.dart';
import 'package:avalon/models/models.dart';

import 'chains.dart';
import '../nodes/assets.dart' as runtime_asset;
import '../nodes/node.dart';

class ProfileEffectiveConfigService {
  const ProfileEffectiveConfigService({
    Database? store,
    String? nodeStorePath,
    bool materializeAssets = true,
  }) : _store = store,
       _nodeStorePath = nodeStorePath,
       _materializeAssets = materializeAssets;

  final Database? _store;
  final String? _nodeStorePath;
  final bool _materializeAssets;

  Database get store => _store ?? database;

  Future<ChainPreview> previewChain({
    required int profileId,
    required Map<String, dynamic> profileConfig,
    required ProxyChain chain,
    required List<ProxyChainHop> hops,
  }) async {
    final artifact = await assemble(
      profileId: profileId,
      profileConfig: profileConfig,
      chainHopOverrides: {chain.id: hops},
      previewChainIds: {chain.id},
    );
    final index = artifact.previewChainIndexes[chain.id];
    final result = index == null ? null : artifact.chainResults[index];
    return ChainPreview(
      pathCount: result?.paths.length ?? 0,
      diagnostics: [
        for (final diagnostic in artifact.diagnostics)
          if (diagnostic.path?.startsWith('${chain.id}:') == true ||
              diagnostic.path == chain.id.toString())
            diagnostic,
        ...?result?.diagnostics,
      ],
      generatedProxies: result?.generatedProxies ?? const {},
      generatedGroups: result?.generatedGroups ?? const [],
      generatedNodeIds: {
        for (final path in result?.paths ?? const <ChainPath>[])
          for (
            var index = 0;
            index < path.generatedNames.length && index < path.targets.length;
            index++
          )
            path.generatedNames[index]: path.targets[index],
      },
    );
  }

  Future<EffectiveConfigArtifact> assemble({
    required int profileId,
    required Map<String, dynamic> profileConfig,
    Map<int, List<ProxyChainHop>> chainHopOverrides = const {},
    Set<int> previewChainIds = const {},
  }) async {
    final diagnostics = <ChainDiagnostic>[];
    final allNodes = await store.proxyNodesDao.query().get();
    final assetManager = runtime_asset.NodeAssetManager(
      _nodeStorePath ?? await appPath.homeDirPath,
    );
    final nodeById = {for (final node in allNodes) node.id: node};
    final boundRows = await store.proxyNodeBindingsDao.query(profileId).get();
    final groupRows = await store.select(store.proxyGroups).get();
    final groupMemberRows = <int, List<ProxyGroupMember>>{};
    for (final group in groupRows) {
      groupMemberRows[group.id] = await store.proxyGroupMembersDao
          .query(group.id)
          .get();
    }
    final chainBindings = await store.proxyChainBindingsDao
        .query(profileId)
        .get();
    final enabledChainBindings =
        chainBindings.where((item) => item.enabled).toList()..sort((a, b) {
          if (a.isDefault != b.isDefault) return a.isDefault ? -1 : 1;
          return (a.order ?? a.chainId).compareTo(b.order ?? b.chainId);
        });
    for (final chainId in previewChainIds) {
      if (enabledChainBindings.any((item) => item.chainId == chainId)) continue;
      enabledChainBindings.add(
        ProxyChainBinding(profileId: profileId, chainId: chainId),
      );
    }
    final boundChains = <int, ProxyChain>{};
    final boundChainHops = <int, List<ProxyChainHop>>{};
    for (final binding in enabledChainBindings) {
      final chain = await store.proxyChainsDao.get(binding.chainId);
      if (chain == null) continue;
      boundChains[binding.chainId] = chain;
      boundChainHops[binding.chainId] =
          chainHopOverrides[binding.chainId] ??
          await store.proxyChainHopsDao.query(chain.id).get();
    }
    final visibleNodeIds = <int>{
      for (final node in allNodes)
        if (node.source?.profileId == profileId) node.id,
      for (final binding in boundRows)
        if (binding.enabled && nodeById[binding.nodeId]?.source == null)
          binding.nodeId,
      ..._chainLibraryNodeIds(
        hops: boundChainHops.values.expand((hops) => hops),
        nodeById: nodeById,
        groupRows: groupRows,
        groupMemberRows: groupMemberRows,
        profileId: profileId,
      ),
    };
    final staleNodeIds = {
      for (final node in allNodes)
        if (node.status == 'stale') node.id.toString(),
    };
    final nodeConfigs = <String, Map<String, dynamic>>{};
    final nodeByDisplayName = <String, String>{};
    final nodeAssetErrors = <int, Object>{};
    for (final node in allNodes) {
      final id = node.id.toString();
      if (!_materializeAssets) {
        nodeConfigs[id] = effectiveStoredNodeConfig(node);
      } else {
        final assets = await store.proxyNodeAssetsDao.query(node.id).get();
        try {
          nodeConfigs[id] = await assetManager.materialize(
            effectiveStoredNodeConfig(node),
            assets.map(
              (asset) => runtime_asset.NodeAsset(
                id: asset.id.toString(),
                nodeId: asset.nodeId.toString(),
                fieldPath: asset.fieldPath,
                relativePath: asset.relativePath,
                sha256: asset.sha256,
                size: asset.size ?? 0,
              ),
            ),
          );
        } on Object catch (error) {
          nodeAssetErrors[node.id] = error;
        }
      }
      final source = node.source;
      final isVisibleInProfile =
          source == null || source.profileId == profileId;
      if (isVisibleInProfile && visibleNodeIds.contains(node.id)) {
        nodeByDisplayName[node.displayName] = id;
      }
      final configName =
          nodeConfigs[id]?['name']?.toString() ??
          node.config['name']?.toString();
      if (isVisibleInProfile &&
          visibleNodeIds.contains(node.id) &&
          configName != null &&
          configName.isNotEmpty) {
        nodeByDisplayName[configName] = id;
      }
    }

    final effectiveProfileConfig = _copyMap(profileConfig);
    final profileSourceNodesByKey = <String, ProxyNode>{};
    final profileSourceNodesByName = <String, List<ProxyNode>>{};
    for (final node in allNodes) {
      final source = node.source;
      if (source?.profileId != profileId || source?.provider != null) {
        continue;
      }
      final sourceKey = source?.sourceKey;
      if (sourceKey != null && sourceKey.isNotEmpty) {
        profileSourceNodesByKey[sourceKey] = node;
      }
      final sourceName =
          node.sourceSnapshot?['name']?.toString() ??
          node.config['name']?.toString();
      if (sourceName != null && sourceName.isNotEmpty) {
        profileSourceNodesByName.putIfAbsent(sourceName, () => []).add(node);
      }
    }
    for (final nodes in profileSourceNodesByName.values) {
      nodes.sort((a, b) => a.id.compareTo(b.id));
    }
    final claimedSourceNodeIds = <int>{};
    final sourceKeyAllocator = SourceNodeKeyAllocator(kind: 'profile');
    final sourceNames = <String, String>{};
    final claimedSourceNames = <String>{};
    final embeddedNodeIds = <int>{};
    final materializedSourceProxies = <Map<String, dynamic>>[];
    final sourceProxies = _proxyEntries(effectiveProfileConfig['proxies']);
    if (sourceProxies != null) {
      for (var index = 0; index < sourceProxies.length; index++) {
        final raw = sourceProxies[index];
        if (raw is! Map) continue;
        final original = _copyMap(raw);
        final name = original['name']?.toString();
        if (name == null || name.isEmpty) {
          materializedSourceProxies.add(original);
          continue;
        }
        final storedNode = _claimSourceNode(
          config: original,
          name: name,
          allocator: sourceKeyAllocator,
          byKey: profileSourceNodesByKey,
          byName: profileSourceNodesByName,
          claimed: claimedSourceNodeIds,
        );
        final storedNodeConfig = storedNode == null
            ? null
            : nodeConfigs[storedNode.id.toString()];
        if (storedNode != null && storedNodeConfig == null) {
          diagnostics.add(
            ChainDiagnostic(
              severity: ChainDiagnosticSeverity.error,
              code: 'missing-node-asset',
              message: 'A source node asset could not be loaded.',
              path: storedNode.id.toString(),
            ),
          );
        }
        final config = storedNodeConfig ?? original;
        config['name'] = config['name']?.toString().trim().isNotEmpty == true
            ? config['name']
            : name;
        final id = storedNode?.id.toString() ?? 'source:$name';
        if (storedNode != null) embeddedNodeIds.add(storedNode.id);
        nodeConfigs[id] = config;
        for (final alias in {name, config['name'].toString()}) {
          if (!claimedSourceNames.add(alias)) continue;
          sourceNames[alias] = id;
          nodeByDisplayName[alias] = id;
        }
        materializedSourceProxies.add(config);
      }
      effectiveProfileConfig['proxies'] = materializedSourceProxies;
    }

    final boundIds = <String>[];
    final aliases = <String, String>{};
    for (final binding in boundRows.where((item) => item.enabled)) {
      final id = binding.nodeId.toString();
      if (!nodeConfigs.containsKey(id)) {
        diagnostics.add(
          ChainDiagnostic(
            severity: ChainDiagnosticSeverity.error,
            code: nodeAssetErrors.containsKey(binding.nodeId)
                ? 'missing-node-asset'
                : 'missing-bound-node',
            message: nodeAssetErrors.containsKey(binding.nodeId)
                ? 'A bound node asset could not be loaded.'
                : 'A bound node is missing from the node library.',
            path: id,
          ),
        );
        continue;
      }
      if (!visibleNodeIds.contains(binding.nodeId)) {
        diagnostics.add(
          ChainDiagnostic(
            severity: ChainDiagnosticSeverity.error,
            code: 'hidden-bound-node',
            message: 'A bound node is not available in this profile.',
            path: id,
          ),
        );
        continue;
      }
      final node = nodeById[binding.nodeId]!;
      if (node.status == 'stale') {
        diagnostics.add(
          ChainDiagnostic(
            severity: ChainDiagnosticSeverity.warning,
            code: 'stale-bound-node',
            message: 'A bound node is marked stale by its source.',
            path: id,
          ),
        );
        continue;
      }
      if (!embeddedNodeIds.contains(binding.nodeId)) boundIds.add(id);
      final alias = binding.alias?.trim();
      if (alias != null && alias.isNotEmpty) aliases[id] = alias;
    }

    final groups = await _collectGroups(
      profileId: profileId,
      profileConfig: profileConfig,
      sourceNames: sourceNames,
      nodeByDisplayName: nodeByDisplayName,
      visibleNodeIds: visibleNodeIds,
      providerNodeTargets: _providerNodeTargets(
        profileId,
        allNodes,
        nodeConfigs,
      ),
      groupRows: groupRows,
      groupMemberRows: groupMemberRows,
    );
    final chains = <ChainCompileRequest>[];
    final compiledBindings = <ProxyChainBinding>[];
    for (final binding in enabledChainBindings) {
      final chain = boundChains[binding.chainId];
      if (chain == null) {
        diagnostics.add(
          ChainDiagnostic(
            severity: ChainDiagnosticSeverity.error,
            code: 'missing-chain',
            message: 'A bound chain is missing from the chain library.',
            path: binding.chainId.toString(),
          ),
        );
        continue;
      }
      final hops = boundChainHops[binding.chainId] ?? const <ProxyChainHop>[];
      final targets = <ChainHop>[];
      for (final hop in hops) {
        final node = hop.nodeId == null ? null : nodeById[hop.nodeId];
        if (node?.status == 'stale') {
          diagnostics.add(
            ChainDiagnostic(
              severity: ChainDiagnosticSeverity.error,
              code: 'stale-chain-node',
              message: 'A chain references a stale source node.',
              path: '${chain.id}:${hop.order}',
            ),
          );
          continue;
        }
        final target = _targetForHop(
          hop,
          sourceNames: sourceNames,
          groups: groups,
          visibleNodeIds: visibleNodeIds,
        );
        if (target == null) {
          diagnostics.add(
            ChainDiagnostic(
              severity: ChainDiagnosticSeverity.error,
              code: 'invalid-hop',
              message: 'A chain hop has no usable target.',
              path: '${chain.id}:${hop.order}',
            ),
          );
          continue;
        }
        if (_targetContainsStaleNode(target, groups, staleNodeIds)) {
          diagnostics.add(
            ChainDiagnostic(
              severity: ChainDiagnosticSeverity.error,
              code: 'stale-chain-node',
              message: 'A chain references a stale source node.',
              path: '${chain.id}:${hop.order}',
            ),
          );
          continue;
        }
        targets.add(ChainHop(target: target));
      }
      compiledBindings.add(binding);
      chains.add(
        ChainCompileRequest(
          name: binding.selectorName?.trim().isNotEmpty == true
              ? binding.selectorName!.trim()
              : chain.name,
          hops: targets,
          nodes: nodeConfigs,
          groups: groups,
          branchLimit: chain.branchLimit,
          generatedPrefix: '__avalon_chain_${chain.id}',
        ),
      );
    }

    final artifact = EffectiveConfigAssembler().assemble(
      EffectiveConfigRequest(
        profileConfig: effectiveProfileConfig,
        nodes: nodeConfigs,
        nodeBindings: boundIds,
        nodeAliases: aliases,
        groups: groups,
        chains: chains,
      ),
    );
    final finalConfig = _copyMap(artifact.config);
    final generatedSelectors = <String>[];
    for (var index = 0; index < artifact.chainResults.length; index++) {
      final result = artifact.chainResults[index];
      if (!result.isValid || result.generatedGroups.isEmpty) continue;
      final selectorName = result.generatedGroups.first.name;
      generatedSelectors.add(selectorName);
      if (index >= compiledBindings.length) continue;
      diagnostics.addAll(
        _attachChainEntry(
          config: finalConfig,
          entryGroups: compiledBindings[index].entryGroups,
          selectorName: selectorName,
        ),
      );
    }
    if (generatedSelectors.isNotEmpty) {
      final groups = finalConfig['proxy-groups'] is List
          ? List<dynamic>.from(finalConfig['proxy-groups'] as List)
          : <dynamic>[];
      final usedNames = <String>{
        for (final group in groups)
          if (group is Map && group['name'] != null) group['name'].toString(),
      };
      final aggregateName = _allocateName('__avalon_chains', usedNames);
      groups.add({
        'name': aggregateName,
        'type': 'select',
        'proxies': generatedSelectors,
      });
      finalConfig['proxy-groups'] = groups;
    }
    return EffectiveConfigArtifact(
      config: finalConfig,
      digest: effectiveConfigDigest(finalConfig),
      chainResults: artifact.chainResults,
      diagnostics: [...diagnostics, ...artifact.diagnostics],
      previewChainIndexes: {
        for (var index = 0; index < compiledBindings.length; index++)
          compiledBindings[index].chainId: index,
      },
    );
  }

  Future<Map<String, List<ChainTarget>>> _collectGroups({
    required int profileId,
    required Map<String, dynamic> profileConfig,
    required Map<String, String> sourceNames,
    required Map<String, String> nodeByDisplayName,
    required Set<int> visibleNodeIds,
    required Map<String, List<ChainTarget>> providerNodeTargets,
    required List<RawProxyGroup> groupRows,
    required Map<int, List<ProxyGroupMember>> groupMemberRows,
  }) async {
    final memberNames = <String, List<String>>{};
    final directMembers = <String, List<ChainTarget>>{};
    final persistedByGroup = <String, List<ProxyGroupMember>>{};
    final dbNames = <String, String>{};
    for (final group in groupRows) {
      if (group.profileId != null && group.profileId != profileId) continue;
      final key = 'db:${group.id}';
      final rows = groupMemberRows[group.id] ?? const <ProxyGroupMember>[];
      final names = rows.isEmpty
          ? List<String>.from(group.proxies ?? const [])
          : <String>[];
      if (rows.isNotEmpty) {
        persistedByGroup[key] = rows;
      }
      final providerMembers = <ChainTarget>[];
      for (final provider in group.use ?? const []) {
        providerMembers.addAll(providerNodeTargets[provider] ?? const []);
      }
      directMembers[key] = providerMembers;
      memberNames[key] = names;
      if (group.name.isNotEmpty) dbNames[group.name] = key;
    }
    final profileNames = <String, String>{};
    final raw = profileConfig['proxy-groups'];
    if (raw is List) {
      for (final item in raw) {
        if (item is! Map) continue;
        final name = item['name']?.toString();
        if (name == null || name.isEmpty) continue;
        final key = 'profile:$name';
        profileNames[name] = key;
        final names = item['proxies'] is List
            ? (item['proxies'] as List)
                  .map((value) => value.toString())
                  .toList()
            : <String>[];
        final providerMembers = <ChainTarget>[];
        if (item['use'] is List) {
          for (final provider in item['use'] as List) {
            providerMembers.addAll(
              providerNodeTargets[provider.toString()] ?? const [],
            );
          }
        }
        directMembers[key] = providerMembers;
        memberNames[key] = names;
      }
    }
    ChainTarget? targetForName(String name) {
      final nodeId = sourceNames[name] ?? nodeByDisplayName[name];
      if (nodeId != null) return ChainTarget.node(nodeId);
      final profileGroupId = profileNames[name];
      if (profileGroupId != null) return ChainTarget.group(profileGroupId);
      final dbGroupId = dbNames[name];
      if (dbGroupId != null) return ChainTarget.group(dbGroupId);
      return null;
    }

    final result = <String, List<ChainTarget>>{};
    for (final entry in memberNames.entries) {
      final targets = <ChainTarget>[];
      final persisted = persistedByGroup[entry.key];
      if (persisted != null) {
        for (final member in persisted) {
          final target = member.nodeId == null
              ? (member.literalName == null
                    ? null
                    : targetForName(member.literalName!.trim()))
              : visibleNodeIds.contains(member.nodeId)
              ? ChainTarget.node(member.nodeId.toString())
              : null;
          if (target != null) targets.add(target);
        }
      } else {
        for (final name in entry.value) {
          final target = targetForName(name);
          if (target != null) targets.add(target);
        }
      }
      targets.addAll(directMembers[entry.key] ?? const []);
      result[entry.key] = targets;
    }
    for (final entry in dbNames.entries) {
      result['name:${entry.key}'] = result[entry.value] ?? const [];
    }
    return result;
  }

  Map<String, List<ChainTarget>> _providerNodeTargets(
    int profileId,
    Iterable<ProxyNode> nodes,
    Map<String, Map<String, dynamic>> nodeConfigs,
  ) {
    final result = <String, List<ChainTarget>>{};
    for (final node in nodes) {
      final source = node.source;
      final provider = source?.provider;
      if (source?.profileId != profileId ||
          provider == null ||
          node.status == 'stale' ||
          !nodeConfigs.containsKey(node.id.toString())) {
        continue;
      }
      result
          .putIfAbsent(provider, () => [])
          .add(ChainTarget.node(node.id.toString()));
    }
    return result;
  }

  ChainTarget? _targetForHop(
    ProxyChainHop hop, {
    required Map<String, String> sourceNames,
    required Map<String, List<ChainTarget>> groups,
    required Set<int> visibleNodeIds,
  }) {
    final kind = hop.targetKind.toLowerCase();
    if (kind == 'node' &&
        hop.nodeId != null &&
        visibleNodeIds.contains(hop.nodeId)) {
      return ChainTarget.node(hop.nodeId.toString());
    }
    if (kind == 'group') {
      if (hop.profileId != null && hop.groupName != null) {
        final profileGroup = 'profile:${hop.groupName!}';
        if (groups.containsKey(profileGroup)) {
          return ChainTarget.group(profileGroup);
        }
      }
      if (hop.groupId != null) return ChainTarget.group('db:${hop.groupId}');
      if (hop.groupName != null) {
        final name = hop.groupName!;
        if (groups.containsKey('profile:$name')) {
          return ChainTarget.group('profile:$name');
        }
        if (groups.containsKey('name:$name')) {
          return ChainTarget.group('name:$name');
        }
      }
    }
    if (kind == 'profile-group' || kind == 'profilegroup') {
      final name = hop.groupName;
      if (name != null && groups.containsKey('profile:$name')) {
        return ChainTarget.group('profile:$name');
      }
    }
    if (kind == 'local-endpoint' ||
        kind == 'localendpoint' ||
        kind == 'local') {
      final endpoint = hop.localEndpoint;
      if (endpoint != null) {
        return ChainTarget.localEndpoint(_copyMap(endpoint));
      }
    }
    if (kind == 'node' &&
        hop.groupName != null &&
        sourceNames[hop.groupName!] != null) {
      return ChainTarget.node(sourceNames[hop.groupName!]!);
    }
    return null;
  }
}

List<ChainDiagnostic> _attachChainEntry({
  required Map<String, dynamic> config,
  required List<String> entryGroups,
  required String selectorName,
}) {
  if (entryGroups.isEmpty) return const [];
  final groups = config['proxy-groups'];
  final diagnostics = <ChainDiagnostic>[];
  for (final entryGroup in entryGroups) {
    final name = entryGroup.trim();
    if (name.isEmpty) continue;
    final target = groups is List
        ? groups
              .whereType<Map>()
              .where((item) => item['name']?.toString() == name)
              .firstOrNull
        : null;
    if (target is! Map) {
      diagnostics.add(
        ChainDiagnostic(
          severity: ChainDiagnosticSeverity.warning,
          code: 'missing-chain-entry-group',
          message: 'A chain entry group is missing from this profile.',
          path: name,
        ),
      );
      continue;
    }
    final members = target['proxies'] is List
        ? List<dynamic>.from(target['proxies'] as List)
        : <dynamic>[];
    if (members.any((item) => item.toString() == selectorName)) continue;
    members.add(selectorName);
    target['proxies'] = members;
  }
  return diagnostics;
}

Set<int> _chainLibraryNodeIds({
  required Iterable<ProxyChainHop> hops,
  required Map<int, ProxyNode> nodeById,
  required List<RawProxyGroup> groupRows,
  required Map<int, List<ProxyGroupMember>> groupMemberRows,
  required int profileId,
}) {
  final visibleGroups = [
    for (final group in groupRows)
      if (group.profileId == null || group.profileId == profileId) group,
  ];
  final groupsById = {for (final group in visibleGroups) group.id: group};
  final groupsByName = <String, RawProxyGroup>{};
  for (final group in visibleGroups) {
    if (group.name.isNotEmpty) {
      groupsByName.putIfAbsent(group.name, () => group);
    }
  }
  final result = <int>{};
  final visitedGroups = <int>{};
  void collectGroup(RawProxyGroup? group) {
    if (group == null || !visitedGroups.add(group.id)) return;
    final rows = groupMemberRows[group.id] ?? const <ProxyGroupMember>[];
    for (final member in rows) {
      final nodeId = member.nodeId;
      if (nodeId != null) {
        final node = nodeById[nodeId];
        if (node != null && node.source == null) result.add(nodeId);
        continue;
      }
      final literal = member.literalName?.trim();
      if (literal != null && literal.isNotEmpty) {
        collectGroup(groupsByName[literal]);
      }
    }
    for (final name in group.proxies ?? const <String>[]) {
      collectGroup(groupsByName[name]);
    }
  }

  for (final hop in hops) {
    final nodeId = hop.nodeId;
    final node = nodeId == null ? null : nodeById[nodeId];
    if (nodeId != null && node != null && node.source == null) {
      result.add(nodeId);
    }
    final groupId = hop.groupId;
    if (groupId != null) collectGroup(groupsById[groupId]);
    final groupName = hop.groupName?.trim();
    if (hop.profileId == null && groupName != null && groupName.isNotEmpty) {
      collectGroup(groupsByName[groupName]);
    }
  }
  return result;
}

ProxyNode? _claimSourceNode({
  required Map<String, dynamic> config,
  required String name,
  required SourceNodeKeyAllocator allocator,
  required Map<String, ProxyNode> byKey,
  required Map<String, List<ProxyNode>> byName,
  required Set<int> claimed,
}) {
  final key = allocator.allocate(config, name);
  final keyed = byKey[key];
  if (keyed != null && claimed.add(keyed.id)) return keyed;
  final candidate = byName[name]
      ?.where((node) => !claimed.contains(node.id))
      .firstOrNull;
  if (candidate == null) return null;
  claimed.add(candidate.id);
  return candidate;
}

Map<String, dynamic> _copyMap(Map value) => {
  for (final entry in value.entries)
    entry.key.toString(): entry.value is Map
        ? _copyMap(entry.value as Map)
        : entry.value is List
        ? (entry.value as List)
              .map((item) => item is Map ? _copyMap(item) : item)
              .toList()
        : entry.value,
};

List<Object?>? _proxyEntries(Object? raw) {
  if (raw is List) return List<Object?>.from(raw);
  if (raw is Map) {
    if (raw['type'] != null) return [raw];
    return raw.entries.map((entry) {
      if (entry.value is! Map) return entry.value;
      final value = _copyMap(entry.value as Map);
      value.putIfAbsent('name', () => entry.key.toString());
      return value;
    }).toList();
  }
  return null;
}

String _allocateName(String desired, Set<String> used) {
  if (!used.contains(desired)) return desired;
  var index = 2;
  while (used.contains('$desired ($index)')) {
    index++;
  }
  return '$desired ($index)';
}

bool _targetContainsStaleNode(
  ChainTarget target,
  Map<String, List<ChainTarget>> groups,
  Set<String> staleNodeIds, [
  Set<String> groupStack = const {},
]) {
  if (target.kind == ChainTargetKind.node) {
    return staleNodeIds.contains(target.id);
  }
  if (target.kind != ChainTargetKind.group || target.id == null) return false;
  final groupId = target.id!;
  if (groupStack.contains(groupId)) return false;
  final members = groups[groupId];
  if (members == null) return false;
  final nextStack = {...groupStack, groupId};
  return members.any(
    (member) =>
        _targetContainsStaleNode(member, groups, staleNodeIds, nextStack),
  );
}
