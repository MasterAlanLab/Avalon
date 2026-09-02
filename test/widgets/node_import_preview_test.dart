import 'package:avalon/common/common.dart';
import 'package:avalon/common/theme.dart';
import 'package:avalon/features/nodes/nodes.dart';
import 'package:avalon/l10n/l10n.dart';
import 'package:avalon/providers/providers.dart';
import 'package:avalon/state.dart';
import 'package:avalon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

NodeImportResult _result() {
  return NodeImportResult(
    drafts: [
      NodeDraft(
        config: const {
          'name': 'FIRST',
          'type': 'socks5',
          'server': 'HOST_A',
          'port': 1080,
        },
      ),
      NodeDraft(
        config: const {
          'name': 'SECOND',
          'type': 'socks5',
          'server': 'HOST_B',
          'port': 1080,
        },
      ),
    ],
    kind: NodeInputKind.uri,
  );
}

/// Captures what the preview pops, so tests can assert the payload it hands
/// back to the import action.
NodeImportSelection? popped;

Future<void> pumpPreview(
  WidgetTester tester, {
  int? profileId,
  bool bind = true,
}) async {
  popped = null;
  tester.view.physicalSize = const Size(900, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final container = ProviderContainer(
    overrides: [
      viewSizeProvider.overrideWithBuild((_, _) => const Size(900, 900)),
    ],
  );
  addTearDown(container.dispose);
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox());
  });
  globalState.container = container;

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        builder: (context, child) {
          globalState.measure = Measure.of(context, 1);
          globalState.theme = CommonTheme.of(context, 1);
          return child!;
        },
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                popped = await Navigator.of(context)
                    .push<NodeImportSelection>(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          body: NodeImportPreview(
                            result: _result(),
                            profileId: profileId,
                            bind: bind,
                          ),
                        ),
                      ),
                    );
              },
              child: const Text('open preview'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open preview'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('selects every valid draft by default', (tester) async {
    await pumpPreview(tester, profileId: 1);

    final checkboxes = tester
        .widgetList<CheckboxListTile>(find.byType(CheckboxListTile))
        .toList();
    // Two drafts plus the "bind to current profile" toggle.
    expect(checkboxes, hasLength(3));
    expect(checkboxes[0].value, isTrue);
    expect(checkboxes[1].value, isTrue);
    expect(checkboxes[2].value, isTrue);
  });

  testWidgets('hides the bind toggle without a current profile', (
    tester,
  ) async {
    await pumpPreview(tester, profileId: null);

    expect(find.byType(CheckboxListTile), findsNWidgets(2));
  });

  testWidgets('never asks how to handle duplicates', (tester) async {
    await pumpPreview(tester, profileId: 1);

    // Importing always adds; a re-imported link becomes a copy, so there is
    // no overwrite-or-copy question to answer.
    expect(find.byType(RadioListTile<bool>), findsNothing);
    expect(find.byType(RadioGroup<bool>), findsNothing);
  });

  testWidgets('returns the kept drafts and the bind choice', (tester) async {
    await pumpPreview(tester, profileId: 1);

    // Drop the second draft, keep the bind toggle on.
    await tester.tap(find.byType(CheckboxListTile).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(popped?.indexes, [0]);
    expect(popped?.bind, isTrue);
  });

  testWidgets('disables the import action once nothing is selected', (
    tester,
  ) async {
    await pumpPreview(tester, profileId: 1);

    await tester.tap(find.byType(CheckboxListTile).at(0));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckboxListTile).at(1));
    await tester.pumpAndSettle();

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });
}
