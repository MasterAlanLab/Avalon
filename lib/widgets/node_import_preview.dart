import 'package:avalon/common/common.dart';
import 'package:avalon/features/nodes/nodes.dart';
import 'package:flutter/material.dart';

import 'dialog.dart';

class NodeImportSelection {
  const NodeImportSelection({
    required this.indexes,
    required this.createCopy,
    required this.bind,
  });

  final List<int> indexes;
  final bool createCopy;
  final bool bind;
}

class NodeImportPreview extends StatefulWidget {
  const NodeImportPreview({
    super.key,
    required this.result,
    required this.profileId,
    this.bind = true,
  });

  final NodeImportResult result;
  final int? profileId;
  final bool bind;

  @override
  State<NodeImportPreview> createState() => _NodeImportPreviewState();
}

class _NodeImportPreviewState extends State<NodeImportPreview> {
  late final Set<int> selected = {
    for (var index = 0; index < widget.result.drafts.length; index++)
      if (widget.result.drafts[index].issues.every((issue) => !issue.isError))
        index,
  };
  bool createCopy = false;
  late bool bind = widget.bind;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: context.appLocalizations.importPreview,
      overrideScroll: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: selected.isEmpty
              ? null
              : () => Navigator.of(context).pop(
                  NodeImportSelection(
                    indexes: selected.toList()..sort(),
                    createCopy: createCopy,
                    bind: bind && widget.profileId != null,
                  ),
                ),
          child: Text(context.appLocalizations.importNode),
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.result.drafts.length,
              itemBuilder: (context, index) {
                final draft = widget.result.drafts[index];
                final valid = draft.issues.every((issue) => !issue.isError);
                final details = draft.issues
                    .map(
                      (issue) =>
                          '#${issue.index ?? index} ${issue.code ?? issue.severity.name}: ${issue.message}',
                    )
                    .join('\n');
                return CheckboxListTile(
                  value: selected.contains(index),
                  onChanged: valid
                      ? (value) => setState(() {
                          if (value == true) {
                            selected.add(index);
                          } else {
                            selected.remove(index);
                          }
                        })
                      : null,
                  title: Text(
                    '#$index · ${draft.type.toUpperCase()} · ${draft.name}',
                  ),
                  subtitle: details.isEmpty ? null : Text(details),
                );
              },
            ),
          ),
          RadioGroup<bool>(
            groupValue: createCopy,
            onChanged: (value) => setState(() => createCopy = value ?? false),
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    value: false,
                    title: Text(context.appLocalizations.updateExisting),
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    value: true,
                    title: Text(context.appLocalizations.createCopy),
                  ),
                ),
              ],
            ),
          ),
          if (widget.profileId != null)
            CheckboxListTile(
              value: bind,
              onChanged: (value) => setState(() => bind = value ?? false),
              title: Text(context.appLocalizations.bindCurrentProfile),
            ),
        ],
      ),
    );
  }
}
