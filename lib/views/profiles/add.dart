import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/features/chains/service.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/pages/scan.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddProfileView extends StatelessWidget {
  final BuildContext context;

  const AddProfileView({super.key, required this.context});

  Future<void> _handleAddProfileFormFile() async {
    globalState.container
        .read(profilesActionProvider.notifier)
        .addProfileFormFile();
  }

  Future<void> _handleAddProfileFormURL(String url) async {
    globalState.container
        .read(profilesActionProvider.notifier)
        .addProfileFormURL(url);
  }

  Future<void> _handleCreateFromChain() async {
    final appLocalizations = context.appLocalizations;
    final chains = await const ChainLibraryService().list();
    if (chains.isEmpty) {
      globalState.showNotifier(appLocalizations.createFromChainEmpty);
      return;
    }
    final chain = await globalState.showCommonDialog<ProxyChain>(
      child: ChainPickerDialog(chains: chains),
    );
    if (chain == null) return;
    await globalState.container
        .read(profilesActionProvider.notifier)
        .addProfileFromChain(chainId: chain.id, label: chain.name);
  }

  Future<void> _toScan() async {
    if (system.isDesktop) {
      globalState.container
          .read(profilesActionProvider.notifier)
          .addProfileFormQrCode();
      return;
    }
    final url = await BaseNavigator.push(context, const ScanPage());
    if (url != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        globalState.container
            .read(profilesActionProvider.notifier)
            .addProfileFormInput(url);
      });
    }
  }

  Future<void> _toAdd() async {
    final appLocalizations = context.appLocalizations;
    final url = await globalState.showCommonDialog<String>(
      child: InputDialog(
        autovalidateMode: AutovalidateMode.onUnfocus,
        title: appLocalizations.importFromURL,
        labelText: appLocalizations.url,
        value: '',
        inputFormatters: TextInputLimits.limit(TextInputLimits.url),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return appLocalizations.emptyTip('').trim();
          }
          if (!value.isUrl) {
            return appLocalizations.urlTip('').trim();
          }
          return null;
        },
      ),
    );
    if (url != null) {
      _handleAddProfileFormURL(url);
    }
  }

  @override
  Widget build(context) {
    final appLocalizations = context.appLocalizations;
    return ListView(
      children: [
        ListItem(
          leading: const Icon(Icons.qr_code_sharp),
          title: Text(appLocalizations.qrcode),
          subtitle: Text(appLocalizations.qrcodeDesc),
          onTap: _toScan,
        ),
        ListItem(
          leading: const Icon(Icons.upload_file_sharp),
          title: Text(appLocalizations.file),
          subtitle: Text(appLocalizations.fileDesc),
          onTap: _handleAddProfileFormFile,
        ),
        ListItem(
          leading: const Icon(Icons.cloud_download_sharp),
          title: Text(appLocalizations.url),
          subtitle: Text(appLocalizations.urlDesc),
          onTap: _toAdd,
        ),
        ListItem(
          leading: const Icon(Icons.hub_outlined),
          title: Text(appLocalizations.createFromChain),
          subtitle: Text(appLocalizations.createFromChainDesc),
          onTap: _handleCreateFromChain,
        ),
      ],
    );
  }
}

class ChainPickerDialog extends StatelessWidget {
  final List<ProxyChain> chains;

  const ChainPickerDialog({super.key, required this.chains});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return CommonDialog(
      title: appLocalizations.createFromChain,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.cancel),
        ),
      ],
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                appLocalizations.createFromChainTip,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            for (final chain in chains)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.link_sharp),
                title: Text(chain.name, maxLines: 1),
                onTap: () => Navigator.of(context).pop(chain),
              ),
          ],
        ),
      ),
    );
  }
}

class URLFormDialog extends StatefulWidget {
  const URLFormDialog({super.key});

  @override
  State<URLFormDialog> createState() => _URLFormDialogState();
}

class _URLFormDialogState extends State<URLFormDialog> {
  final _urlController = TextEditingController();

  Future<void> _handleAddProfileFormURL() async {
    final url = _urlController.value.text;
    if (url.isEmpty) return;
    Navigator.of(context).pop<String>(url);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return CommonDialog(
      title: appLocalizations.importFromURL,
      actions: [
        TextButton(
          onPressed: _handleAddProfileFormURL,
          child: Text(appLocalizations.submit),
        ),
      ],
      child: SizedBox(
        width: 300,
        child: Wrap(
          runSpacing: 16,
          children: [
            TextField(
              keyboardType: TextInputType.url,
              minLines: 1,
              maxLines: 5,
              inputFormatters: TextInputLimits.limit(TextInputLimits.url),
              onSubmitted: (_) {
                _handleAddProfileFormURL();
              },
              onEditingComplete: _handleAddProfileFormURL,
              controller: _urlController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalizations.url,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
