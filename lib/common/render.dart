import 'package:avalon/common/common.dart';
import 'package:avalon/enum/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class Render {
  /// Used when the window may still be on screen, so the grace period has to
  /// outlive tray menu interactions and other short-lived native round trips.
  static const idlePauseDelay = Duration(seconds: 5);

  /// Used once the window is confirmed hidden or minimized; nothing can be
  /// observed at that point, so frames stop almost immediately.
  static const hiddenPauseDelay = Duration(milliseconds: 300);

  static Render? _instance;
  bool _isPaused = false;
  Duration? _pendingPauseDelay;
  final _dispatcher = SchedulerBinding.instance.platformDispatcher;
  FrameCallback? _beginFrame;
  VoidCallback? _drawFrame;

  Render._internal();

  factory Render() {
    _instance ??= Render._internal();
    return _instance!;
  }

  @visibleForTesting
  bool get isPaused => _isPaused;

  @visibleForTesting
  Duration? get pendingPauseDelay => _pendingPauseDelay;

  void active() {
    resume();
    pause();
  }

  void pause({Duration delay = idlePauseDelay}) {
    final pending = _pendingPauseDelay;
    // The throttler keeps the first pending timer, so a shorter delay only
    // wins if the pending one is dropped first.
    if (pending != null && delay >= pending) {
      return;
    }
    throttler.cancel(FunctionTag.renderPause);
    _pendingPauseDelay = delay;
    throttler.call(FunctionTag.renderPause, _pause, duration: delay);
  }

  void resume() {
    throttler.cancel(FunctionTag.renderPause);
    _pendingPauseDelay = null;
    _resume();
  }

  void _pause() async {
    _pendingPauseDelay = null;
    if (_isPaused) return;
    _isPaused = true;
    _beginFrame = _dispatcher.onBeginFrame;
    _drawFrame = _dispatcher.onDrawFrame;
    _dispatcher.onBeginFrame = null;
    _dispatcher.onDrawFrame = null;
    commonPrint.log('pause');
  }

  void _resume() {
    if (!_isPaused) return;
    _isPaused = false;
    _dispatcher.onBeginFrame = _beginFrame;
    _dispatcher.onDrawFrame = _drawFrame;
    _dispatcher.scheduleFrame();
    commonPrint.log('resume');
  }
}

final Render? render = system.isDesktop ? Render() : null;
