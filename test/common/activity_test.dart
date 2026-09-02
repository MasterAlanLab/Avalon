import 'package:avalon/common/activity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('tracks lifecycle and window activity independently', () {
    final activity = AppActivityController();
    addTearDown(activity.dispose);

    expect(activity.value.isUiActive, isTrue);

    activity.setWindowFocused(false);
    expect(activity.value.isUiActive, isFalse);

    activity.setLifecycleResumed(false);
    expect(activity.value.isUiActive, isFalse);

    activity.setWindowState(visible: true, focused: true);
    expect(activity.value.isUiActive, isFalse);

    activity.setLifecycleResumed(true);
    expect(activity.value.isUiActive, isTrue);

    activity.setWindowState(visible: false, focused: false);
    expect(activity.value.isUiActive, isFalse);
    expect(activity.value.windowFocused, isFalse);
  });

  test('notifies only on effective state changes', () {
    final activity = AppActivityController();
    addTearDown(activity.dispose);

    var notifications = 0;
    activity.addListener(() => notifications++);

    activity.setWindowFocused(false);
    expect(notifications, 1);

    // Idempotent entry points must not wake up the telemetry scheduler again.
    activity.setWindowFocused(false);
    expect(notifications, 1);

    activity.setWindowState(visible: false, focused: false);
    expect(notifications, 2);

    activity.setWindowState(visible: false, focused: false);
    expect(notifications, 2);

    activity.setLifecycleResumed(true);
    expect(notifications, 2);
  });
}
