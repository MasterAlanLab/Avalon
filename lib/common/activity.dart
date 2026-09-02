import 'package:flutter/foundation.dart';

/// Describes whether the app has a window and lifecycle state that can drive
/// interactive UI work. The proxy core remains independent of this state.
@immutable
class AppActivityState {
  final bool lifecycleResumed;
  final bool windowVisible;
  final bool windowFocused;

  const AppActivityState({
    this.lifecycleResumed = true,
    this.windowVisible = true,
    this.windowFocused = true,
  });

  bool get isUiActive =>
      lifecycleResumed && windowVisible && windowFocused;

  AppActivityState copyWith({
    bool? lifecycleResumed,
    bool? windowVisible,
    bool? windowFocused,
  }) {
    return AppActivityState(
      lifecycleResumed: lifecycleResumed ?? this.lifecycleResumed,
      windowVisible: windowVisible ?? this.windowVisible,
      windowFocused: windowFocused ?? this.windowFocused,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppActivityState &&
        other.lifecycleResumed == lifecycleResumed &&
        other.windowVisible == windowVisible &&
        other.windowFocused == windowFocused;
  }

  @override
  int get hashCode => Object.hash(
    lifecycleResumed,
    windowVisible,
    windowFocused,
  );
}

/// Process-wide activity state shared by window hooks, lifecycle observers and
/// the low-frequency telemetry scheduler.
class AppActivityController extends ValueNotifier<AppActivityState> {
  AppActivityController() : super(const AppActivityState());

  void setLifecycleResumed(bool resumed) {
    value = value.copyWith(lifecycleResumed: resumed);
  }

  void setWindowState({required bool visible, required bool focused}) {
    value = value.copyWith(
      windowVisible: visible,
      windowFocused: focused,
    );
  }

  void setWindowFocused(bool focused) {
    value = value.copyWith(windowFocused: focused);
  }
}

final appActivity = AppActivityController();
