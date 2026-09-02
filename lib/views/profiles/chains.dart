import 'dart:async';

import 'package:avalon/common/common.dart';
import 'package:avalon/core/core.dart';
import 'package:avalon/database/database.dart';
import 'package:avalon/features/chains/chains.dart';
import 'package:avalon/features/chains/runtime.dart';
import 'package:avalon/features/chains/service.dart';
import 'package:avalon/features/nodes/nodes.dart';
import 'package:avalon/models/models.dart';
import 'package:avalon/providers/providers.dart';
import 'package:avalon/state.dart';
import 'package:avalon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Prompts for a chain name and opens its hop editor. Top-level so the
/// Profiles scaffold can drive it from the tab's floating action button.
Future<void> createChainAction(BuildContext context, int? profileId) async {
  final name = await globalState.showCommonDialog<String>(
    child: InputDialog(
      title: context.appLocalizations.createChain,
      labelText: context.appLocalizations.name,
      value: '',
      validator: (value) => value == null || value.trim().isEmpty
          ? context.appLocalizations.emptyTip('').trim()
          : null,
    ),
  );
  if (!context.mounted || name == null || name.trim().isEmpty) return;
  final chain = await const ChainLibraryService().create(name: name);
  if (!context.mounted) return;
  await const ChainLibraryView()._editHops(context, chain, profileId);
}

class ChainLibraryView extends ConsumerWidget {
  const ChainLibraryView({super.key});

  Future<void> _editHops(
    BuildContext context,
    ProxyChain chain,
    int? profileId,
  ) async {
    final values = await Future.wait([
      const ChainLibraryService().hops(chain.id),
      database.proxyNodesDao.query().get(),
      database.select(database.proxyGroups).get(),
    ]);
    if (!context.mounted) return;
    final value = await globalState.showCommonDialog<List<ProxyChainHop>>(
      context: context,
      dismissible: false,
      child: _ChainEditorDialog(
        chain: chain,
        initialHops: values[0] as List<ProxyChainHop>,
        nodes: values[1] as List<ProxyNode>,
        groups: values[2] as List<RawProxyGroup>,
        profileId: profileId,
      ),
    );
    if (value == null) return;
    await const ChainLibraryService().save(chain, value);
    globalState.container
        .read(setupActionProvider.notifier)
        .applyProfileDebounce();
  }

  Future<void> _reorder(
    List<ProxyChain> chains,
    int oldIndex,
    int newIndex,
  ) async {
    final reordered = List<ProxyChain>.from(chains);
    final chain = reordered.removeAt(oldIndex);
    reordered.insert(newIndex, chain);
    await const ChainLibraryService().reorder(reordered);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ProxyChain>>(
      stream: database.proxyChainsDao.query().watch(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return NullStatus(label: snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text(context.appLocalizations.loading));
        }
        final chains = snapshot.data ?? const <ProxyChain>[];
        final profileId = ref.watch(currentProfileIdProvider);
        if (chains.isEmpty) {
          return Center(
            child: FilledButton.icon(
              onPressed: () => createChainAction(context, profileId),
              icon: const Icon(Icons.add),
              label: Text(context.appLocalizations.createChain),
            ),
          );
        }
        return StreamBuilder<List<ProxyChainBinding>>(
          stream: profileId == null
              ? Stream.value(const <ProxyChainBinding>[])
              : database.proxyChainBindingsDao.query(profileId).watch(),
          builder: (context, bindingSnapshot) {
            final bindings = {
              for (final binding
                  in bindingSnapshot.data ?? const <ProxyChainBinding>[])
                binding.chainId: binding,
            };
            return Column(
              children: [
                Expanded(
                  child: ReorderableListView.builder(
                    buildDefaultDragHandles: false,
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 96),
                    itemCount: chains.length,
                    onReorderItem: (oldIndex, newIndex) =>
                        _reorder(chains, oldIndex, newIndex),
                    itemBuilder: (context, index) {
                      final chain = chains[index];
                      return ChainLibraryItem(
                        key: ValueKey(chain.id),
                        chain: chain,
                        profileId: profileId,
                        binding: bindings[chain.id],
                        reorderIndex: index,
                        onEdit: () => _editHops(context, chain, profileId),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ChainEditorDialog extends StatefulWidget {
  const _ChainEditorDialog({
    required this.chain,
    required this.initialHops,
    required this.nodes,
    required this.groups,
    required this.profileId,
  });

  final ProxyChain chain;
  final List<ProxyChainHop> initialHops;
  final List<ProxyNode> nodes;
  final List<RawProxyGroup> groups;
  final int? profileId;

  @override
  State<_ChainEditorDialog> createState() => _ChainEditorDialogState();
}

class _ChainEditorDialogState extends State<_ChainEditorDialog> {
  late List<ProxyChainHop> _hops;
  ChainPreview? _preview;
  int _previewGeneration = 0;

  @override
  void initState() {
    super.initState();
    _hops = [...widget.initialHops]..sort((a, b) => a.order.compareTo(b.order));
    unawaited(_refreshPreview());
  }

  Future<void> _refreshPreview() async {
    final profileId = widget.profileId;
    if (profileId == null) return;
    final generation = ++_previewGeneration;
    final hops = [
      for (var index = 0; index < _hops.length; index++)
        _ordered(_hops[index], index),
    ];
    ChainPreview? preview;
    try {
      Map<String, dynamic> profileConfig;
      try {
        profileConfig = await coreController.getConfig(profileId);
      } catch (_) {
        profileConfig = <String, dynamic>{};
      }
      preview = await const ProfileEffectiveConfigService().previewChain(
        profileId: profileId,
        profileConfig: profileConfig,
        chain: widget.chain,
        hops: hops,
      );
    } catch (error) {
      preview = ChainPreview(
        pathCount: 0,
        diagnostics: [
          ChainDiagnostic(
            severity: ChainDiagnosticSeverity.warning,
            code: 'preview-unavailable',
            message: error.toString(),
          ),
        ],
      );
    }
    if (!mounted || generation != _previewGeneration) return;
    setState(() => _preview = preview);
  }

  Future<void> _save() async {
    final preview = _preview;
    if (preview != null && preview.diagnostics.isNotEmpty) {
      final confirmed = await globalState.showMessage(
        title: context.appLocalizations.chainDiagnostics,
        message: TextSpan(
          text: [
            context.appLocalizations.chainWarningConfirm,
            ...preview.diagnostics.map((item) => '· ${item.message}'),
          ].join('\n'),
        ),
      );
      if (confirmed != true) return;
    }
    if (!mounted) return;
    _normalizeOrders();
    Navigator.of(context).pop(_hops);
  }

  String _labelFor(ProxyChainHop hop) {
    if (hop.targetKind == 'node') {
      for (final node in widget.nodes) {
        if (node.id == hop.nodeId) return node.displayName;
      }
      return '${context.appLocalizations.node} #${hop.nodeId ?? '-'}';
    }
    if (hop.targetKind == 'profile-group' || hop.profileId != null) {
      return '${context.appLocalizations.profileGroup}: ${hop.groupName ?? '-'}';
    }
    if (hop.targetKind == 'group') {
      final group = widget.groups
          .where((item) => item.id == hop.groupId)
          .firstOrNull;
      return '${context.appLocalizations.globalGroup}: ${group?.name ?? hop.groupName ?? '-'}';
    }
    final endpoint = hop.localEndpoint ?? const <String, Object?>{};
    final type = endpoint['type'] == 'http' && endpoint['tls'] == true
        ? 'https'
        : endpoint['type']?.toString() ?? 'socks5';
    return '$type://${endpoint['server'] ?? '-'}:${endpoint['port'] ?? '-'}';
  }

  ProxyChainHop _ordered(ProxyChainHop hop, int order) {
    return hop.copyWith(chainId: widget.chain.id, order: order);
  }

  void _normalizeOrders() {
    _hops = [
      for (var index = 0; index < _hops.length; index++)
        _ordered(_hops[index], index),
    ];
  }

  Future<ProxyChainHop?> _pickHop() async {
    final choice = await globalState.showCommonDialog<_HopChoice>(
      context: context,
      child: CommonDialog(
        title: context.appLocalizations.selectChainTarget,
        overrideScroll: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.appLocalizations.cancel),
          ),
        ],
        child: ListView(
          shrinkWrap: true,
          children: [
            _TargetSection(title: context.appLocalizations.nodes),
            for (final node in widget.nodes)
              ListTile(
                leading: const Icon(Icons.dns_outlined),
                title: Text(node.displayName),
                subtitle: Text(node.type),
                onTap: () => Navigator.of(context).pop(_HopChoice.node(node)),
              ),
            _TargetSection(title: context.appLocalizations.globalGroup),
            for (final group in widget.groups.where(
              (item) => item.profileId == null,
            ))
              ListTile(
                leading: const Icon(Icons.hub_outlined),
                title: Text(group.name),
                onTap: () => Navigator.of(context).pop(_HopChoice.group(group)),
              ),
            if (widget.profileId != null) ...[
              _TargetSection(title: context.appLocalizations.profileGroup),
              for (final group in widget.groups.where(
                (item) => item.profileId == widget.profileId,
              ))
                ListTile(
                  leading: const Icon(Icons.account_tree_outlined),
                  title: Text(group.name),
                  onTap: () =>
                      Navigator.of(context).pop(_HopChoice.profileGroup(group)),
                ),
            ],
            _TargetSection(title: context.appLocalizations.localEndpoint),
            ListTile(
              leading: const Icon(Icons.lan_outlined),
              title: Text(context.appLocalizations.localEndpoint),
              subtitle: const Text('SOCKS5 / HTTP / HTTPS'),
              onTap: () => Navigator.of(context).pop(const _HopChoice.local()),
            ),
          ],
        ),
      ),
    );
    if (!mounted || choice == null) return null;
    final order = _hops.length;
    if (choice.node != null) {
      return ProxyChainHop(
        id: snowflake.id,
        chainId: widget.chain.id,
        order: order,
        targetKind: 'node',
        nodeId: choice.node!.id,
      );
    }
    if (choice.group != null) {
      final group = choice.group!;
      final isProfileGroup = group.profileId != null;
      return ProxyChainHop(
        id: snowflake.id,
        chainId: widget.chain.id,
        order: order,
        targetKind: isProfileGroup ? 'profile-group' : 'group',
        groupId: isProfileGroup ? null : group.id,
        profileId: group.profileId,
        groupName: group.name,
      );
    }
    final endpoint = await globalState.showCommonDialog<Map<String, Object?>>(
      context: context,
      dismissible: false,
      child: const _LocalEndpointDialog(),
    );
    if (endpoint == null) return null;
    return ProxyChainHop(
      id: snowflake.id,
      chainId: widget.chain.id,
      order: order,
      targetKind: 'local-endpoint',
      localEndpoint: endpoint,
    );
  }

  Future<void> _add() async {
    final hop = await _pickHop();
    if (!mounted || hop == null) return;
    setState(() => _hops.add(hop));
    await _refreshPreview();
  }

  Future<void> _edit(int index) async {
    final current = _hops[index];
    if (current.targetKind != 'local-endpoint') {
      final replacement = await _pickHop();
      if (!mounted || replacement == null) return;
      setState(() => _hops[index] = _ordered(replacement, index));
      await _refreshPreview();
      return;
    }
    final endpoint = await globalState.showCommonDialog<Map<String, Object?>>(
      context: context,
      dismissible: false,
      child: _LocalEndpointDialog(initial: current.localEndpoint),
    );
    if (!mounted || endpoint == null) return;
    setState(() => _hops[index] = current.copyWith(localEndpoint: endpoint));
    await _refreshPreview();
  }

  @override
  Widget build(BuildContext context) {
    final path = [
      context.appLocalizations.chainClient,
      ..._hops.map(_labelFor),
      context.appLocalizations.chainTarget,
    ].join(' → ');
    return CommonDialog(
      title: widget.chain.name,
      overrideScroll: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(context.appLocalizations.save),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${context.appLocalizations.chainHop}: ${_hops.length} · '
            '${context.appLocalizations.branchLimit}: ${widget.chain.branchLimit}'
            '${_preview == null ? '' : ' · ${context.appLocalizations.chainPathCount(_preview!.pathCount)}'}',
            style: context.textTheme.labelLarge,
          ),
          const SizedBox(height: 6),
          Text(path, style: context.textTheme.bodySmall),
          if (_preview?.diagnostics.isNotEmpty == true) ...[
            const SizedBox(height: 6),
            for (final diagnostic in _preview!.diagnostics)
              Text(
                '· ${diagnostic.message}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: diagnostic.isError
                      ? context.colorScheme.error
                      : context.colorScheme.tertiary,
                ),
              ),
          ],
          const SizedBox(height: 12),
          Expanded(
            child: _hops.isEmpty
                ? Center(child: Text(context.appLocalizations.chainEmpty))
                : ReorderableListView.builder(
                    buildDefaultDragHandles: false,
                    itemCount: _hops.length,
                    onReorderItem: (oldIndex, newIndex) {
                      setState(() {
                        final hop = _hops.removeAt(oldIndex);
                        _hops.insert(newIndex, hop);
                        _normalizeOrders();
                      });
                      unawaited(_refreshPreview());
                    },
                    itemBuilder: (context, index) {
                      final hop = _hops[index];
                      return ListTile(
                        key: ValueKey(hop.id),
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text(_labelFor(hop)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _edit(index),
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _hops.removeAt(index);
                                  _normalizeOrders();
                                });
                                unawaited(_refreshPreview());
                              },
                              icon: const Icon(Icons.delete_outline),
                            ),
                            ReorderableDragStartListener(
                              index: index,
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.drag_handle),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _add,
            icon: const Icon(Icons.add),
            label: Text(context.appLocalizations.addChainHop),
          ),
        ],
      ),
    );
  }
}

class _TargetSection extends StatelessWidget {
  const _TargetSection({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(title, style: context.textTheme.labelLarge),
    );
  }
}

class _HopChoice {
  const _HopChoice.node(this.node) : group = null;

  const _HopChoice.group(this.group) : node = null;

  const _HopChoice.profileGroup(this.group) : node = null;

  const _HopChoice.local() : node = null, group = null;

  final ProxyNode? node;
  final RawProxyGroup? group;
}

class _LocalEndpointDialog extends StatefulWidget {
  const _LocalEndpointDialog({this.initial});

  final Map<String, Object?>? initial;

  @override
  State<_LocalEndpointDialog> createState() => _LocalEndpointDialogState();
}

class _LocalEndpointDialogState extends State<_LocalEndpointDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _serverController;
  late final TextEditingController _portController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late String _scheme;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial ?? const <String, Object?>{};
    final type = initial['type']?.toString().toLowerCase();
    _scheme = type == 'http'
        ? initial['tls'] == true
              ? 'https'
              : 'http'
        : 'socks5';
    _serverController = TextEditingController(
      text: initial['server']?.toString() ?? '',
    );
    _portController = TextEditingController(
      text: initial['port']?.toString() ?? '',
    );
    _usernameController = TextEditingController(
      text: initial['username']?.toString() ?? '',
    );
    _passwordController = TextEditingController(
      text: initial['password']?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _serverController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    final endpoint = Map<String, Object?>.from(
      widget.initial ?? const <String, Object?>{},
    );
    endpoint
      ..['name'] =
          endpoint['name'] ??
          'local_${_serverController.text.trim()}_${_portController.text.trim()}'
      ..['type'] = _scheme == 'socks5' ? 'socks5' : 'http'
      ..['server'] = _serverController.text.trim()
      ..['port'] = int.parse(_portController.text.trim());
    if (_scheme == 'https') {
      endpoint['tls'] = true;
    } else {
      endpoint.remove('tls');
    }
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.isEmpty) {
      endpoint.remove('username');
    } else {
      endpoint['username'] = username;
    }
    if (password.isEmpty) {
      endpoint.remove('password');
    } else {
      endpoint['password'] = password;
    }
    Navigator.of(context).pop(endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: context.appLocalizations.localEndpoint,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(context.appLocalizations.save),
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: _scheme,
              decoration: InputDecoration(
                labelText: context.appLocalizations.endpointType,
              ),
              items: const [
                DropdownMenuItem(value: 'socks5', child: Text('SOCKS5')),
                DropdownMenuItem(value: 'http', child: Text('HTTP')),
                DropdownMenuItem(value: 'https', child: Text('HTTPS')),
              ],
              onChanged: (value) => setState(() => _scheme = value ?? _scheme),
            ),
            TextFormField(
              controller: _serverController,
              decoration: InputDecoration(
                labelText: context.appLocalizations.address,
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? context.appLocalizations.invalidEndpoint
                  : null,
            ),
            TextFormField(
              controller: _portController,
              decoration: InputDecoration(
                labelText: context.appLocalizations.port,
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                final port = int.tryParse(value ?? '');
                return port == null || port < 1 || port > 65535
                    ? context.appLocalizations.invalidEndpoint
                    : null;
              },
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: context.appLocalizations.username,
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: context.appLocalizations.password,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChainLibraryItem extends StatelessWidget {
  const ChainLibraryItem({
    super.key,
    required this.chain,
    required this.profileId,
    required this.binding,
    required this.reorderIndex,
    required this.onEdit,
  });

  final ProxyChain chain;
  final int? profileId;
  final ProxyChainBinding? binding;
  final int reorderIndex;
  final VoidCallback onEdit;

  Future<void> _delete(BuildContext context) async {
    final confirmed = await globalState.showMessage(
      title: context.appLocalizations.delete,
      message: TextSpan(text: context.appLocalizations.deleteTip(chain.name)),
    );
    if (confirmed == true) {
      await const ChainLibraryService().delete(chain.id);
      _applyProfile();
    }
  }

  Future<void> _rename(BuildContext context) async {
    final name = await globalState.showCommonDialog<String>(
      child: InputDialog(
        title: context.appLocalizations.rename,
        labelText: context.appLocalizations.name,
        value: chain.name,
      ),
    );
    if (name != null) {
      await const ChainLibraryService().rename(chain.id, name);
      _applyProfile();
    }
  }

  Future<void> _setBranchLimit(BuildContext context) async {
    final value = await globalState.showCommonDialog<String>(
      child: InputDialog(
        title: context.appLocalizations.branchLimit,
        labelText: context.appLocalizations.branchLimit,
        value: chain.branchLimit.toString(),
        keyboardType: TextInputType.number,
        validator: (value) {
          final number = int.tryParse(value ?? '');
          return number == null || number < 1 || number > 1024
              ? '1–1024'
              : null;
        },
      ),
    );
    final limit = int.tryParse(value ?? '');
    if (limit != null && limit >= 1 && limit <= 1024) {
      await const ChainLibraryService().setBranchLimit(chain.id, limit);
      _applyProfile();
    }
  }

  void _applyProfile() {
    globalState.container
        .read(setupActionProvider.notifier)
        .applyProfileDebounce();
  }

  Future<void> _toggleBinding() async {
    final id = profileId;
    if (id == null) return;
    if (binding == null) {
      await const ChainLibraryService().bind(profileId: id, chainId: chain.id);
    } else {
      await const ChainLibraryService().unbind(
        profileId: id,
        chainId: chain.id,
      );
    }
    _applyProfile();
  }

  Future<void> _editEntryGroups(BuildContext context) async {
    final id = profileId;
    if (id == null) return;
    final groups = await (database.select(
      database.proxyGroups,
    )..where((row) => row.profileId.equals(id))).get();
    if (!context.mounted) return;
    final names = groups.map((group) => group.name).toList();
    final selected = await globalState.showCommonDialog<List<String>>(
      context: context,
      child: _ChainEntryGroupsDialog(
        names: names,
        initial: binding?.entryGroups ?? const [],
      ),
    );
    if (selected == null) return;
    await const ChainLibraryService().setEntryGroups(
      profileId: id,
      chainId: chain.id,
      entryGroups: selected,
    );
    _applyProfile();
  }

  Future<NodeExportResult?> _exportResult({bool includeZip = false}) async {
    final id = profileId;
    if (id == null) return null;
    final hops = await const ChainLibraryService().hops(chain.id);
    Map<String, dynamic> profileConfig;
    try {
      profileConfig = await coreController.getConfig(id);
    } catch (_) {
      profileConfig = <String, dynamic>{};
    }
    final preview =
        await const ProfileEffectiveConfigService(
          materializeAssets: false,
        ).previewChain(
          profileId: id,
          profileConfig: profileConfig,
          chain: chain,
          hops: hops,
        );
    final names = preview.generatedProxies.keys.toList();
    final assets = <NodeAsset>[];
    for (final name in names) {
      final nodeId = int.tryParse(preview.generatedNodeIds[name] ?? '');
      if (nodeId == null) continue;
      for (final asset in await const StoredNodeAssetService().list(nodeId)) {
        assets.add(
          NodeAsset(
            id: '$name-${asset.id}',
            nodeId: name,
            fieldPath: asset.fieldPath,
            relativePath: asset.relativePath,
            sha256: asset.sha256,
            size: asset.size ?? 0,
          ),
        );
      }
    }
    return NodeExportService().exportConfigs(
      [for (final name in names) preview.generatedProxies[name]!],
      nodeIds: names,
      groups: preview.generatedGroups.map((group) => group.toConfig()),
      assets: assets,
      assetManager: NodeAssetManager(await appPath.homeDirPath),
      includeZip: includeZip,
    );
  }

  Future<void> _export(BuildContext context, bool asJson) async {
    final output = await _exportResult();
    if (output == null || !context.mounted) return;
    await Clipboard.setData(
      ClipboardData(text: asJson ? output.json : output.yaml),
    );
    if (!context.mounted) return;
    context.showNotifier(
      output.issues.isEmpty
          ? context.appLocalizations.copySuccess
          : output.issues.map((issue) => issue.message).join('\n'),
    );
  }

  Future<void> _exportZip(BuildContext context) async {
    final output = await _exportResult(includeZip: true);
    final bytes = output?.zip;
    if (bytes == null) return;
    final path = await picker.saveFile(
      'chain-${chain.id}.zip',
      Uint8List.fromList(bytes),
    );
    if (!context.mounted || path == null) return;
    context.showNotifier(
      output!.issues.isEmpty
          ? context.appLocalizations.exportSuccess
          : output.issues.map((issue) => issue.message).join('\n'),
    );
  }

  Future<void> _setDefault() async {
    final id = profileId;
    if (id == null) return;
    if (binding == null) {
      await const ChainLibraryService().bind(
        profileId: id,
        chainId: chain.id,
        isDefault: true,
      );
    }
    await const ChainLibraryService().setDefault(
      profileId: id,
      chainId: chain.id,
    );
    _applyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CommonCard(
        child: StreamBuilder<List<ProxyChainHop>>(
          stream: database.proxyChainHopsDao.query(chain.id).watch(),
          builder: (context, snapshot) => ListItem(
            leading: const Icon(Icons.route),
            title: Text(chain.name),
            subtitle: Text(
              '${snapshot.data?.length ?? 0} ${context.appLocalizations.chainHop} · '
              '${context.appLocalizations.branchLimit}: ${chain.branchLimit}'
              '${binding?.isDefault == true ? ' · ${context.appLocalizations.defaultText}' : ''}'
              '${binding?.entryGroups.isNotEmpty == true ? ' · ${context.appLocalizations.chainEntryGroups}: ${binding!.entryGroups.join(', ')}' : ''}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReorderableDragStartListener(
                  index: reorderIndex,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.drag_handle),
                  ),
                ),
                CommonPopupBox(
                  popup: CommonPopupMenu(
                    items: [
                      PopupMenuItemData(
                        icon: Icons.edit_outlined,
                        label: context.appLocalizations.edit,
                        onPressed: onEdit,
                      ),
                      PopupMenuItemData(
                        icon: Icons.drive_file_rename_outline,
                        label: context.appLocalizations.rename,
                        onPressed: () => _rename(context),
                      ),
                      PopupMenuItemData(
                        icon: Icons.account_tree_outlined,
                        label: context.appLocalizations.branchLimit,
                        onPressed: () => _setBranchLimit(context),
                      ),
                      PopupMenuItemData(
                        icon: Icons.copy,
                        label: context.appLocalizations.copy,
                        onPressed: () =>
                            const ChainLibraryService().duplicate(chain.id),
                      ),
                      if (profileId != null)
                        PopupMenuItemData(
                          icon: binding == null ? Icons.link : Icons.link_off,
                          label: binding == null
                              ? context.appLocalizations.bind
                              : context.appLocalizations.unbind,
                          onPressed: _toggleBinding,
                        ),
                      if (profileId != null)
                        PopupMenuItemData(
                          icon: Icons.alt_route,
                          label: context.appLocalizations.chainEntryGroups,
                          onPressed: () => _editEntryGroups(context),
                        ),
                      if (profileId != null)
                        PopupMenuItemData(
                          icon: Icons.ios_share_outlined,
                          label: context.appLocalizations.export,
                          subItems: [
                            PopupMenuItemData(
                              icon: Icons.description_outlined,
                              label: context.appLocalizations.exportYaml,
                              onPressed: () => _export(context, false),
                            ),
                            PopupMenuItemData(
                              icon: Icons.data_object,
                              label: context.appLocalizations.exportJson,
                              onPressed: () => _export(context, true),
                            ),
                            PopupMenuItemData(
                              icon: Icons.archive_outlined,
                              label: context.appLocalizations.exportZip,
                              onPressed: () => _exportZip(context),
                            ),
                          ],
                        ),
                      if (profileId != null && binding?.isDefault != true)
                        PopupMenuItemData(
                          icon: Icons.star_outline,
                          label: context.appLocalizations.setDefault,
                          onPressed: _setDefault,
                        ),
                      PopupMenuItemData(
                        danger: true,
                        icon: Icons.delete_outline,
                        label: context.appLocalizations.delete,
                        onPressed: () => _delete(context),
                      ),
                    ],
                  ),
                  targetBuilder: (open) => IconButton(
                    onPressed: open,
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChainEntryGroupsDialog extends StatefulWidget {
  const _ChainEntryGroupsDialog({required this.names, required this.initial});

  final List<String> names;
  final List<String> initial;

  @override
  State<_ChainEntryGroupsDialog> createState() =>
      _ChainEntryGroupsDialogState();
}

class _ChainEntryGroupsDialogState extends State<_ChainEntryGroupsDialog> {
  late final Set<String> _selected = {...widget.initial};

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: context.appLocalizations.chainEntryGroups,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_selected.toList()),
          child: Text(context.appLocalizations.save),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.appLocalizations.chainEntryGroupsTip,
            style: context.textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          if (widget.names.isEmpty)
            Text(context.appLocalizations.chainEntryGroupsEmpty)
          else
            for (final name in widget.names)
              CheckboxListTile(
                value: _selected.contains(name),
                title: Text(name),
                onChanged: (value) => setState(() {
                  value == true ? _selected.add(name) : _selected.remove(name);
                }),
              ),
        ],
      ),
    );
  }
}
