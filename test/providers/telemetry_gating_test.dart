import 'dart:async';

import 'package:avalon/common/activity.dart';
import 'package:avalon/enum/enum.dart';
import 'package:avalon/providers/action.dart';
import 'package:avalon/providers/app.dart';
import 'package:avalon/providers/config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

const _foregroundInterval = Duration(seconds: 1);
const _backgroundInterval = Duration(seconds: 5);

void main() {
  setUp(_resetActivity);
  tearDown(_resetActivity);

  group('SetupAction telemetry gating', () {
    test('samples every second while the dashboard shows traffic', () async {
      final harness = await _Harness.start(pageLabel: PageLabel.dashboard);
      addTearDown(harness.dispose);

      expect(harness.action.telemetryInterval, _foregroundInterval);
    });

    test('drops to the low-frequency period when the window is hidden', () async {
      final harness = await _Harness.start(
        pageLabel: PageLabel.dashboard,
        supportsTrayTitle: true,
      );
      addTearDown(harness.dispose);

      appActivity.setWindowState(visible: false, focused: false);

      expect(harness.action.telemetryInterval, _backgroundInterval);
    });

    test('stops sampling when hidden and the tray title is disabled', () async {
      final harness = await _Harness.start(
        pageLabel: PageLabel.dashboard,
        supportsTrayTitle: true,
      );
      addTearDown(harness.dispose);
      harness.setShowTrayTitle(false);

      appActivity.setWindowState(visible: false, focused: false);

      expect(harness.action.telemetryInterval, isNull);
    });

    test(
      'stops sampling when hidden on platforms without a tray title',
      () async {
        // showTrayTitle defaults to true, but only macOS renders it. Elsewhere
        // the background sampler would run with no consumer at all.
        final harness = await _Harness.start(
          pageLabel: PageLabel.dashboard,
          supportsTrayTitle: false,
        );
        addTearDown(harness.dispose);
        expect(harness.showTrayTitle, isTrue);

        appActivity.setWindowState(visible: false, focused: false);

        expect(harness.action.telemetryInterval, isNull);
      },
    );

    test('stops traffic RPCs when the dashboard drops both traffic widgets', () async {
      final harness = await _Harness.start(
        pageLabel: PageLabel.dashboard,
        supportsTrayTitle: false,
      );
      addTearDown(harness.dispose);
      expect(harness.action.samplesTraffic, isTrue);

      harness.setDashboardWidgets([
        DashboardWidget.outboundMode,
        DashboardWidget.networkDetection,
      ]);

      expect(harness.action.samplesTraffic, isFalse);
      // The dashboard still renders the run-time counter, so the tick stays.
      expect(harness.action.telemetryInterval, _foregroundInterval);

      final before = harness.common.updateTrafficCount;
      await Future<void>.delayed(const Duration(milliseconds: 1200));
      expect(harness.common.updateTrafficCount, before);
      expect(harness.container.read(runTimeProvider), isNotNull);
    });

    test('stops every tick away from the dashboard with no tray title', () async {
      final harness = await _Harness.start(
        pageLabel: PageLabel.proxies,
        supportsTrayTitle: false,
      );
      addTearDown(harness.dispose);

      expect(harness.action.samplesTraffic, isFalse);
      expect(harness.action.telemetryInterval, isNull);
    });

    test('stops sampling once the proxy is no longer running', () async {
      final harness = await _Harness.start(pageLabel: PageLabel.dashboard);
      addTearDown(harness.dispose);

      await harness.action.setRunning(false);

      expect(harness.action.telemetryInterval, isNull);
    });

    test('samples immediately when the window becomes active again', () async {
      final harness = await _Harness.start(
        pageLabel: PageLabel.dashboard,
        supportsTrayTitle: false,
      );
      addTearDown(harness.dispose);

      appActivity.setWindowState(visible: false, focused: false);
      expect(harness.action.telemetryInterval, isNull);

      final before = harness.common.updateTrafficCount;
      appActivity.setWindowState(visible: true, focused: true);

      expect(harness.action.telemetryInterval, _foregroundInterval);
      expect(harness.common.updateTrafficCount, before + 1);
    });

    test('does not resample while a slow request is still in flight', () async {
      final harness = await _Harness.start(pageLabel: PageLabel.dashboard);
      addTearDown(harness.dispose);

      // start() already took the immediate sample, so count from here.
      final before = harness.common.updateTrafficCount;
      final pending = Completer<void>();
      harness.common.pending = pending;

      // Cover more than two foreground periods with one unfinished request:
      // the first tick hangs, every later tick must be skipped.
      await Future<void>.delayed(const Duration(milliseconds: 2400));
      expect(harness.common.updateTrafficCount, before + 1);

      pending.complete();
      harness.common.pending = null;
      await Future<void>.delayed(const Duration(milliseconds: 1200));
      expect(harness.common.updateTrafficCount, greaterThan(before + 1));
    });

    test('stops writing the run time while the window is hidden', () async {
      final harness = await _Harness.start(
        pageLabel: PageLabel.dashboard,
        supportsTrayTitle: true,
      );
      addTearDown(harness.dispose);

      appActivity.setWindowState(visible: false, focused: false);
      final hiddenRunTime = harness.container.read(runTimeProvider);

      await Future<void>.delayed(const Duration(milliseconds: 1200));

      expect(harness.container.read(runTimeProvider), hiddenRunTime);
    });
  });
}

void _resetActivity() {
  appActivity.setLifecycleResumed(true);
  appActivity.setWindowState(visible: true, focused: true);
}

class _Harness {
  final ProviderContainer container;
  final _GatingSetupAction action;
  final _GatingCommonAction common;

  _Harness({
    required this.container,
    required this.action,
    required this.common,
  });

  static Future<_Harness> start({
    required PageLabel pageLabel,
    bool supportsTrayTitle = true,
  }) async {
    final container = ProviderContainer(
      overrides: [
        initProvider.overrideWithBuild((_, _) => true),
        currentPageLabelProvider.overrideWithBuild((_, _) => pageLabel),
        commonActionProvider.overrideWith(_GatingCommonAction.new),
        setupActionProvider.overrideWith(_GatingSetupAction.new),
      ],
    );
    final action =
        container.read(setupActionProvider.notifier) as _GatingSetupAction;
    action.trayTitleSupported = supportsTrayTitle;
    final common =
        container.read(commonActionProvider.notifier) as _GatingCommonAction;
    await action.setRunning(true);
    return _Harness(container: container, action: action, common: common);
  }

  bool get showTrayTitle => container.read(appSettingProvider).showTrayTitle;

  void setShowTrayTitle(bool value) {
    container
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(showTrayTitle: value));
  }

  void setDashboardWidgets(List<DashboardWidget> widgets) {
    container
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(dashboardWidgets: widgets));
  }

  void setPageLabel(PageLabel label) {
    container.read(currentPageLabelProvider.notifier).value = label;
  }

  void dispose() {
    container.dispose();
  }
}

class _GatingSetupAction extends SetupAction {
  bool trayTitleSupported = true;

  @override
  bool get supportsTrayTitle => trayTitleSupported;

  @override
  void applyProfileDebounce({bool silence = false, bool force = false}) {}

  @override
  Future<bool> setCoreRunning(bool running) async => true;

  @override
  void resetCoreTraffic() {}
}

class _GatingCommonAction extends CommonAction {
  int updateTrafficCount = 0;
  Completer<void>? pending;

  @override
  Future<void> updateTraffic() async {
    updateTrafficCount++;
    await pending?.future;
  }
}
