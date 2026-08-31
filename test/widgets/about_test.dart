import 'package:avalon/common/common.dart';
import 'package:avalon/common/theme.dart';
import 'package:avalon/l10n/l10n.dart';
import 'package:avalon/providers/providers.dart';
import 'package:avalon/state.dart';
import 'package:avalon/views/about.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const launcher = MethodChannel('plugins.flutter.io/url_launcher');
  late List<String> launchedUrls;

  setUpAll(() {
    globalState.packageInfo = PackageInfo(
      appName: 'Avalon',
      packageName: 'com.masteralanlab.avalon',
      version: '0.8.0',
      buildNumber: '1',
    );
  });

  setUp(() {
    launchedUrls = [];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(launcher, (call) async {
          if (call.method == 'launch') {
            launchedUrls.add((call.arguments as Map)['url'] as String);
          }
          return true;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(launcher, null);
  });

  for (final entry in {
    'Project': 'https://github.com/MasterAlanLab/avalon',
    'Telegram': 'https://t.me/masteralanlab',
    'Core': 'https://github.com/MasterAlanLab/avalon/tree/main/core',
    'Contributors':
        'https://github.com/MasterAlanLab/avalon/graphs/contributors',
  }.entries) {
    testWidgets('about opens the current ${entry.key} URL', (tester) async {
      await _pumpAbout(tester);
      expect(find.text('June2'), findsNothing);
      expect(find.text('Arue'), findsNothing);
      expect(find.byType(CircleAvatar), findsNothing);

      await tester.tap(find.text(entry.key));
      await tester.pumpAndSettle();
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SelectableText &&
              widget.textSpan?.toPlainText() == entry.value,
        ),
        findsOneWidget,
      );

      await tester.tap(find.text(currentAppLocalizations.go));
      await tester.pumpAndSettle();

      expect(launchedUrls, [entry.value]);
      expect(tester.takeException(), isNull);
    });
  }

  for (final automatic in [false, true]) {
    testWidgets(
      '${automatic ? 'automatic' : 'manual'} update check downloads from Avalon',
      (tester) async {
        final requests = <Uri>[];
        final interceptor = InterceptorsWrapper(
          onRequest: (options, handler) {
            requests.add(options.uri);
            handler.resolve(
              Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 200,
                data: {'tag_name': 'v0.9.0', 'body': '- Release note'},
              ),
            );
          },
        );
        request.dio.interceptors.add(interceptor);
        addTearDown(() => request.dio.interceptors.remove(interceptor));
        final container = await _pumpAbout(tester);

        if (automatic) {
          final check = container
              .read(commonActionProvider.notifier)
              .autoCheckUpdate();
          await tester.pumpAndSettle();
          await check;
        } else {
          await tester.tap(find.text(currentAppLocalizations.checkUpdate));
          await tester.pumpAndSettle();
        }

        expect(requests, [
          Uri.parse(
            'https://api.github.com/repos/MasterAlanLab/avalon/releases/latest',
          ),
        ]);
        expect(
          find.text(currentAppLocalizations.discoverNewVersion),
          findsOneWidget,
        );
        await tester.tap(find.text(currentAppLocalizations.goDownload));
        await tester.pumpAndSettle();

        expect(launchedUrls, [
          'https://github.com/MasterAlanLab/avalon/releases/latest',
        ]);
        expect(tester.takeException(), isNull);
      },
    );
  }
}

Future<ProviderContainer> _pumpAbout(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1000, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final container = ProviderContainer();
  addTearDown(container.dispose);
  globalState.container = container;
  container
      .read(viewSizeProvider.notifier)
      .update((_) => const Size(1000, 1000));

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        navigatorKey: globalState.navigatorKey,
        locale: const Locale('en'),
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
        home: const AboutView(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}
