import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/features/nodes/nodes.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeLibraryView extends ConsumerStatefulWidget {
  const NodeLibraryView({super.key});

  @override
  ConsumerState<NodeLibraryView> createState() => _NodeLibraryViewState();
}

class _NodeLibraryViewState extends ConsumerState<NodeLibraryView> {
  String type = '';
  String source = '';
  String status = '';

  Future<void> _import() async {
    final input = await globalState.showCommonDialog<String>(
      child: InputDialog(
        title: context.appLocalizations.importNode,
        labelText: context.appLocalizations.nodeInput,
        hintText: context.appLocalizations.nodeInputHint,
        value: '',
        keyboardType: TextInputType.multiline,
        validator: (value) => value == null || value.trim().isEmpty
            ? context.appLocalizations.emptyTip('').trim()
            : null,
      ),
    );
    if (!mounted || input == null || input.trim().isEmpty) return;
    final result = NodeInputDispatcher().importText(input, source: 'manual');
    if (result.drafts.isEmpty) {
      context.showNotifier(
        result.issues.isEmpty
            ? context.appLocalizations.nodeImportNoDraft
            : result.issues.map((issue) => issue.message).join('\n'),
      );
      return;
    }
    final profileId = ref.read(currentProfileIdProvider);
    final selection = await globalState.showCommonDialog<NodeImportSelection>(
      child: NodeImportPreview(result: result, profileId: profileId),
    );
    if (!mounted || selection == null || selection.indexes.isEmpty) return;
    final committed = await const NodeLibraryService().commit(
      NodeImportResult(
        drafts: [for (final index in selection.indexes) result.drafts[index]],
        kind: result.kind,
      ),
      profileId: profileId,
      bind: selection.bind,
      createCopy: selection.createCopy,
    );
    if (selection.bind && profileId != null) {
      ref.read(setupActionProvider.notifier).applyProfileDebounce();
    }
    if (mounted) {
      context.showNotifier(
        context.appLocalizations.nodeImportCount(committed.all.length),
      );
    }
  }

  Future<void> _create() async {
    final config = await globalState.showCommonDialog<Map<String, dynamic>>(
      child: const _NodeFormDialog(),
    );
    if (!mounted || config == null) return;
    final drafts = NodeInputDispatcher().parseRaw(config);
    final draft = drafts.firstOrNull;
    if (draft == null || draft.issues.any((issue) => issue.isError)) {
      context.showNotifier(
        drafts
            .expand((item) => item.issues)
            .map((item) => item.message)
            .join('\n'),
      );
      return;
    }
    await const NodeLibraryService().commit(NodeImportResult(drafts: [draft]));
    if (mounted) context.showNotifier(context.appLocalizations.importSuccess);
  }

  @override
  Widget build(BuildContext context) {
    final profileId = ref.watch(currentProfileIdProvider);
    return StreamBuilder<List<ProxyNode>>(
      stream: database.proxyNodesDao.query().watch(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return NullStatus(label: snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text(context.appLocalizations.loading));
        }
        final nodes = snapshot.data ?? const <ProxyNode>[];
        if (nodes.isEmpty) {
          return _NodeEmpty(onImport: _import, onCreate: _create);
        }
        final types = nodes.map((node) => node.type).toSet().toList()..sort();
        final sources = nodes.map(_sourceKind).toSet().toList()..sort();
        final visible = nodes.where((node) {
          return (type.isEmpty || node.type == type) &&
              (source.isEmpty || _sourceKind(node) == source) &&
              (status.isEmpty ||
                  (status == 'override'
                      ? _hasOverlay(node)
                      : node.status == status));
        }).toList();
        return StreamBuilder<List<ProxyNodeBinding>>(
          stream: profileId == null
              ? Stream.value(const <ProxyNodeBinding>[])
              : database.proxyNodeBindingsDao.query(profileId).watch(),
          builder: (context, bindingSnapshot) {
            final boundIds = {
              for (final binding
                  in bindingSnapshot.data ?? const <ProxyNodeBinding>[])
                if (binding.enabled) binding.nodeId,
            };
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
              itemCount: visible.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _Toolbar(
                    types: types,
                    sources: sources,
                    type: type,
                    source: source,
                    status: status,
                    onType: (value) => setState(() => type = value),
                    onSource: (value) => setState(() => source = value),
                    onStatus: (value) => setState(() => status = value),
                    onImport: _import,
                    onCreate: _create,
                  );
                }
                final node = visible[index - 1];
                return NodeLibraryItem(
                  node: node,
                  profileId: profileId,
                  isBound: boundIds.contains(node.id),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({
    required this.types,
    required this.sources,
    required this.type,
    required this.source,
    required this.status,
    required this.onType,
    required this.onSource,
    required this.onStatus,
    required this.onImport,
    required this.onCreate,
  });

  final List<String> types;
  final List<String> sources;
  final String type;
  final String source;
  final String status;
  final ValueChanged<String> onType;
  final ValueChanged<String> onSource;
  final ValueChanged<String> onStatus;
  final VoidCallback onImport;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _Filter(
            label: context.appLocalizations.protocol,
            value: type,
            values: types,
            text: (value) => value.toUpperCase(),
            onChanged: onType,
          ),
          _Filter(
            label: context.appLocalizations.source,
            value: source,
            values: sources,
            text: (value) =>
                value == 'manual' ? context.appLocalizations.manual : value,
            onChanged: onSource,
          ),
          _Filter(
            label: context.appLocalizations.status,
            value: status,
            values: const ['active', 'stale', 'override'],
            text: (value) => switch (value) {
              'active' => context.appLocalizations.active,
              'stale' => context.appLocalizations.stale,
              _ => context.appLocalizations.localOverride,
            },
            onChanged: onStatus,
          ),
          OutlinedButton.icon(
            onPressed: onCreate,
            icon: const Icon(Icons.add_circle_outline),
            label: Text(context.appLocalizations.createNode),
          ),
          FilledButton.tonalIcon(
            onPressed: onImport,
            icon: const Icon(Icons.add),
            label: Text(context.appLocalizations.importNode),
          ),
        ],
      ),
    );
  }
}

class _Filter extends StatelessWidget {
  const _Filter({
    required this.label,
    required this.value,
    required this.values,
    required this.text,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> values;
  final String Function(String) text;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      underline: const SizedBox.shrink(),
      items: [
        DropdownMenuItem(
          value: '',
          child: Text('$label: ${context.appLocalizations.all}'),
        ),
        for (final item in values)
          DropdownMenuItem(value: item, child: Text(text(item))),
      ],
      onChanged: (value) => onChanged(value ?? ''),
    );
  }
}

class _NodeEmpty extends StatelessWidget {
  const _NodeEmpty({required this.onImport, required this.onCreate});

  final VoidCallback onImport;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.appLocalizations.nodeLibrary),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: onCreate,
                icon: const Icon(Icons.add_circle_outline),
                label: Text(context.appLocalizations.createNode),
              ),
              FilledButton.icon(
                onPressed: onImport,
                icon: const Icon(Icons.add),
                label: Text(context.appLocalizations.importNode),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NodeLibraryItem extends StatelessWidget {
  const NodeLibraryItem({
    super.key,
    required this.node,
    required this.profileId,
    required this.isBound,
  });

  final ProxyNode node;
  final int? profileId;
  final bool isBound;

  Future<void> _toggleBinding() async {
    final id = profileId;
    if (id == null) return;
    if (isBound) {
      await const NodeLibraryService().unbind(profileId: id, nodeId: node.id);
    } else {
      await const NodeLibraryService().bind(profileId: id, nodeId: node.id);
    }
    globalState.container
        .read(setupActionProvider.notifier)
        .applyProfileDebounce();
  }

  Future<void> _rename(BuildContext context) async {
    final value = await globalState.showCommonDialog<String>(
      child: InputDialog(
        title: context.appLocalizations.rename,
        labelText: context.appLocalizations.name,
        value: node.displayName,
      ),
    );
    if (value == null || value.trim().isEmpty) return;
    await const NodeLibraryService().rename(node.id, value);
  }

  Future<void> _edit(BuildContext context) async {
    final value = await globalState.showCommonDialog<String>(
      child: InputDialog(
        title: context.appLocalizations.rawConfig,
        labelText: context.appLocalizations.rawConfig,
        value: yaml.encode(effectiveStoredNodeConfig(node)),
        keyboardType: TextInputType.multiline,
      ),
    );
    if (value == null || value.trim().isEmpty) return;
    final result = NodeInputDispatcher().importText(value, source: 'editor');
    final draft = result.drafts.firstOrNull;
    if (draft == null || draft.issues.any((item) => item.isError)) {
      if (context.mounted) {
        context.showNotifier(
          result.issues.map((item) => item.message).join('\n'),
        );
      }
      return;
    }
    await const NodeLibraryService().updateConfig(node.id, draft);
  }

  Future<NodeExportResult> _exportResult({
    bool includeZip = false,
    bool includeSecrets = true,
  }) async {
    final storedAssets = await const StoredNodeAssetService().list(node.id);
    final assets = [
      for (final asset in storedAssets)
        NodeAsset(
          id: asset.id.toString(),
          nodeId: asset.nodeId.toString(),
          fieldPath: asset.fieldPath,
          relativePath: asset.relativePath,
          sha256: asset.sha256,
          size: asset.size ?? 0,
        ),
    ];
    return NodeExportService().exportConfigs(
      [effectiveStoredNodeConfig(node)],
      includeZip: includeZip,
      includeSecrets: includeSecrets,
      nodeIds: [node.id.toString()],
      assets: assets,
      assetManager: NodeAssetManager(await appPath.homeDirPath),
    );
  }

  Future<void> _export(BuildContext context, _ExportFormat format) async {
    final output = await _exportResult();
    final text = switch (format) {
      _ExportFormat.uri => output.uris.first ?? output.yaml,
      _ExportFormat.base64 => output.base64,
      _ExportFormat.yaml => output.yaml,
      _ExportFormat.json => output.json,
    };
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      context.showNotifier(
        output.issues.isEmpty
            ? context.appLocalizations.copySuccess
            : output.issues.map((issue) => issue.message).join('\n'),
      );
    }
  }

  Future<void> _exportZip(BuildContext context) async {
    final output = await _exportResult(includeZip: true);
    final bytes = output.zip;
    if (bytes == null) return;
    final path = await picker.saveFile(
      'node-${node.id}.zip',
      Uint8List.fromList(bytes),
    );
    if (context.mounted && path != null) {
      context.showNotifier(
        output.issues.isEmpty
            ? context.appLocalizations.exportSuccess
            : output.issues.map((issue) => issue.message).join('\n'),
      );
    }
  }

  Future<void> _copyDiagnostics(BuildContext context) async {
    final output = await _exportResult(includeSecrets: false);
    final issues = output.issues
        .map((issue) => '${issue.code ?? 'export'}: ${issue.message}')
        .join('\n');
    await Clipboard.setData(
      ClipboardData(
        text: issues.isEmpty ? output.yaml : '${output.yaml}\n$issues',
      ),
    );
    if (context.mounted) {
      context.showNotifier(context.appLocalizations.copySuccess);
    }
  }

  Future<void> _duplicate(BuildContext context) async {
    final result = await const NodeLibraryService().commit(
      NodeImportResult(
        drafts: [NodeDraft(config: effectiveStoredNodeConfig(node))],
      ),
      profileId: profileId,
      bind: isBound,
      createCopy: true,
    );
    if (isBound) {
      globalState.container
          .read(setupActionProvider.notifier)
          .applyProfileDebounce();
    }
    if (context.mounted) {
      context.showNotifier(
        context.appLocalizations.nodeImportCount(result.all.length),
      );
    }
  }

  Future<void> _clearOverlay(BuildContext context) async {
    await const NodeLibraryService().clearOverlay(node.id);
    if (context.mounted) {
      context.showNotifier(context.appLocalizations.localOverrideCleared);
    }
  }

  Future<void> _assets(BuildContext context) async {
    await globalState.showCommonDialog<void>(
      child: _NodeAssetsDialog(node: node),
    );
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await globalState.showMessage(
      title: context.appLocalizations.delete,
      message: TextSpan(
        text: context.appLocalizations.deleteTip(node.displayName),
      ),
    );
    if (confirmed == true) await const NodeLibraryService().delete(node.id);
  }

  @override
  Widget build(BuildContext context) {
    final labels = <String>[
      node.type.toUpperCase(),
      node.source?.kind ?? context.appLocalizations.manual,
      if (node.source?.provider case final provider?) provider,
      if (node.status == 'stale') context.appLocalizations.stale,
      if (_hasOverlay(node)) context.appLocalizations.localOverride,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CommonCard(
        child: ListItem(
          leading: Icon(_iconForType(node.type)),
          title: Text(
            node.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            labels.join(' · '),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: CommonPopupBox(
            popup: CommonPopupMenu(
              items: [
                PopupMenuItemData(
                  icon: Icons.edit_outlined,
                  label: context.appLocalizations.edit,
                  onPressed: () => _edit(context),
                ),
                PopupMenuItemData(
                  icon: Icons.drive_file_rename_outline,
                  label: context.appLocalizations.rename,
                  onPressed: () => _rename(context),
                ),
                PopupMenuItemData(
                  icon: Icons.copy_all_outlined,
                  label: context.appLocalizations.createCopy,
                  onPressed: () => _duplicate(context),
                ),
                if (_hasOverlay(node))
                  PopupMenuItemData(
                    icon: Icons.layers_clear_outlined,
                    label: context.appLocalizations.clearLocalOverride,
                    onPressed: () => _clearOverlay(context),
                  ),
                PopupMenuItemData(
                  icon: Icons.attach_file,
                  label: context.appLocalizations.nodeAssets,
                  onPressed: () => _assets(context),
                ),
                if (profileId != null)
                  PopupMenuItemData(
                    icon: isBound ? Icons.link_off : Icons.link,
                    label: isBound
                        ? context.appLocalizations.unbind
                        : context.appLocalizations.bind,
                    onPressed: _toggleBinding,
                  ),
                PopupMenuItemData(
                  icon: Icons.ios_share_outlined,
                  label: context.appLocalizations.export,
                  subItems: [
                    PopupMenuItemData(
                      icon: Icons.link,
                      label: context.appLocalizations.exportUri,
                      onPressed: () => _export(context, _ExportFormat.uri),
                    ),
                    PopupMenuItemData(
                      icon: Icons.code,
                      label: context.appLocalizations.exportBase64,
                      onPressed: () => _export(context, _ExportFormat.base64),
                    ),
                    PopupMenuItemData(
                      icon: Icons.description_outlined,
                      label: context.appLocalizations.exportYaml,
                      onPressed: () => _export(context, _ExportFormat.yaml),
                    ),
                    PopupMenuItemData(
                      icon: Icons.data_object,
                      label: context.appLocalizations.exportJson,
                      onPressed: () => _export(context, _ExportFormat.json),
                    ),
                    PopupMenuItemData(
                      icon: Icons.archive_outlined,
                      label: context.appLocalizations.exportZip,
                      onPressed: () => _exportZip(context),
                    ),
                    PopupMenuItemData(
                      icon: Icons.health_and_safety_outlined,
                      label: context.appLocalizations.exportDiagnostics,
                      onPressed: () => _copyDiagnostics(context),
                    ),
                  ],
                ),
                PopupMenuItemData(
                  danger: true,
                  icon: Icons.delete_outline,
                  label: context.appLocalizations.delete,
                  onPressed: () => _delete(context),
                ),
              ],
            ),
            targetBuilder: (open) =>
                IconButton(onPressed: open, icon: const Icon(Icons.more_vert)),
          ),
        ),
      ),
    );
  }
}

class _NodeAssetsDialog extends StatefulWidget {
  const _NodeAssetsDialog({required this.node});

  final ProxyNode node;

  @override
  State<_NodeAssetsDialog> createState() => _NodeAssetsDialogState();
}

class _NodeAssetsDialogState extends State<_NodeAssetsDialog> {
  final service = const StoredNodeAssetService();
  late Future<List<ProxyNodeAsset>> assets = service.list(widget.node.id);

  void _reload() {
    setState(() => assets = service.list(widget.node.id));
  }

  Future<void> _attach() async {
    final fieldPath = await globalState.showCommonDialog<String>(
      child: InputDialog(
        title: context.appLocalizations.attachAsset,
        labelText: context.appLocalizations.assetFieldPath,
        hintText: 'tls.client-certificate',
        value: '',
        validator: (value) => value == null || value.trim().isEmpty
            ? context.appLocalizations.emptyTip('').trim()
            : null,
      ),
    );
    if (!mounted || fieldPath == null) return;
    final selected = await picker.pickerFile();
    final sourcePath = selected?.path;
    if (!mounted || sourcePath == null) return;
    try {
      await service.attach(
        nodeId: widget.node.id,
        fieldPath: fieldPath,
        sourcePath: sourcePath,
      );
      _reload();
    } on Object catch (error) {
      if (mounted) context.showNotifier(error.toString());
    }
  }

  Future<void> _remove(ProxyNodeAsset asset) async {
    await service.remove(asset.id);
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: context.appLocalizations.nodeAssets,
      actions: [
        TextButton.icon(
          onPressed: _attach,
          icon: const Icon(Icons.attach_file),
          label: Text(context.appLocalizations.attachAsset),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.appLocalizations.confirm),
        ),
      ],
      child: FutureBuilder<List<ProxyNodeAsset>>(
        future: assets,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(context.appLocalizations.loading);
          }
          final values = snapshot.data ?? const <ProxyNodeAsset>[];
          if (values.isEmpty) {
            return Text(context.appLocalizations.noNodeAssets);
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final asset in values)
                ListTile(
                  title: Text(asset.fileName),
                  subtitle: Text('${asset.fieldPath} · ${asset.size ?? 0} B'),
                  trailing: IconButton(
                    onPressed: () => _remove(asset),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _NodeFormDialog extends StatefulWidget {
  const _NodeFormDialog();

  @override
  State<_NodeFormDialog> createState() => _NodeFormDialogState();
}

class _NodeFormDialogState extends State<_NodeFormDialog> {
  static const types = [
    'vless',
    'vmess',
    'trojan',
    'ss',
    'hysteria2',
    'tuic',
    'anytls',
    'socks5',
    'raw',
  ];
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final server = TextEditingController();
  final port = TextEditingController();
  final credential = TextEditingController();
  final secondary = TextEditingController();
  final raw = TextEditingController();
  String type = types.first;
  String? error;

  @override
  void dispose() {
    name.dispose();
    server.dispose();
    port.dispose();
    credential.dispose();
    secondary.dispose();
    raw.dispose();
    super.dispose();
  }

  void _submit() {
    if (type == 'raw') {
      final result = NodeInputDispatcher().importText(raw.text, source: 'form');
      final draft = result.drafts.length == 1 ? result.drafts.single : null;
      if (draft == null || draft.issues.any((issue) => issue.isError)) {
        setState(() {
          error = result.issues.isEmpty
              ? context.appLocalizations.nodeImportNoDraft
              : result.issues.map((issue) => issue.message).join('\n');
        });
        return;
      }
      Navigator.of(context).pop(draft.config);
      return;
    }
    if (formKey.currentState?.validate() != true) return;
    final config = <String, dynamic>{
      'name': name.text.trim(),
      'type': type,
      'server': server.text.trim(),
      'port': int.parse(port.text),
    };
    switch (type) {
      case 'vless':
        config.addAll({'uuid': credential.text, 'encryption': 'none'});
      case 'vmess':
        config.addAll({
          'uuid': credential.text,
          'alterId': 0,
          'cipher': 'auto',
        });
      case 'trojan' || 'hysteria2' || 'anytls':
        config['password'] = credential.text;
      case 'tuic':
        config.addAll({'uuid': credential.text, 'password': secondary.text});
      case 'ss':
        config.addAll({'cipher': 'aes-128-gcm', 'password': credential.text});
      case 'socks5':
        config.addAll({
          'username': credential.text,
          'password': secondary.text,
        });
    }
    Navigator.of(context).pop(config);
  }

  @override
  Widget build(BuildContext context) {
    final isRaw = type == 'raw';
    final showSecondary = type == 'tuic' || type == 'socks5';
    final credentialLabel = switch (type) {
      'vless' || 'vmess' || 'tuic' => 'UUID',
      'socks5' => context.appLocalizations.username,
      _ => context.appLocalizations.password,
    };
    return CommonDialog(
      title: context.appLocalizations.createNode,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(context.appLocalizations.add),
        ),
      ],
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: type,
              decoration: InputDecoration(
                labelText: context.appLocalizations.protocol,
              ),
              items: [
                for (final value in types)
                  DropdownMenuItem(
                    value: value,
                    child: Text(value.toUpperCase()),
                  ),
              ],
              onChanged: (value) => setState(() => type = value ?? type),
            ),
            if (isRaw)
              TextFormField(
                controller: raw,
                minLines: 8,
                maxLines: 16,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: context.appLocalizations.rawConfig,
                  hintText: 'name: NODE\ntype: wireguard\nserver: HOST',
                ),
              )
            else ...[
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: context.appLocalizations.name,
                ),
                validator: _required,
              ),
              TextFormField(
                controller: server,
                decoration: InputDecoration(
                  labelText: context.appLocalizations.server,
                ),
                validator: _required,
              ),
              TextFormField(
                controller: port,
                decoration: InputDecoration(
                  labelText: context.appLocalizations.port,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final parsed = int.tryParse(value ?? '');
                  return parsed == null || parsed < 1 || parsed > 65535
                      ? context.appLocalizations.invalidEndpoint
                      : null;
                },
              ),
              TextFormField(
                controller: credential,
                decoration: InputDecoration(labelText: credentialLabel),
                obscureText:
                    credentialLabel == context.appLocalizations.password,
                validator: type == 'socks5' ? null : _required,
              ),
              if (showSecondary)
                TextFormField(
                  controller: secondary,
                  decoration: InputDecoration(
                    labelText: context.appLocalizations.password,
                  ),
                  obscureText: true,
                  validator: type == 'tuic' ? _required : null,
                ),
            ],
            if (error != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) {
    return value == null || value.trim().isEmpty
        ? context.appLocalizations.emptyTip('').trim()
        : null;
  }
}

bool _hasOverlay(ProxyNode node) =>
    node.overlaySet.isNotEmpty || node.overlayRemove.isNotEmpty;

String _sourceKind(ProxyNode node) => node.source?.kind ?? 'manual';

IconData _iconForType(String type) {
  return switch (type.toLowerCase()) {
    'vless' || 'vmess' || 'trojan' => Icons.bolt,
    'ss' || 'socks' || 'socks5' => Icons.swap_horiz,
    'hysteria2' || 'tuic' || 'anytls' => Icons.speed,
    _ => Icons.public,
  };
}

enum _ExportFormat { uri, base64, yaml, json }
