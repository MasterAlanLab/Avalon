import 'package:avalon/common/render.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Render reads the platform dispatcher off the binding when constructed.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Render is a process-wide singleton wrapping the platform dispatcher, so
  // every test leaves it resumed and with no pause timer armed.
  tearDown(() => Render().resume());

  test('arms the long grace period for an on-screen window', () {
    final render = Render();
    render.pause();
    expect(render.pendingPauseDelay, Render.idlePauseDelay);
  });

  test('a hidden window preempts a pending idle pause', () {
    final render = Render();
    render.pause();
    expect(render.pendingPauseDelay, Render.idlePauseDelay);

    render.pause(delay: Render.hiddenPauseDelay);
    expect(render.pendingPauseDelay, Render.hiddenPauseDelay);
  });

  test('an idle pause never extends a pending hidden pause', () {
    final render = Render();
    render.pause(delay: Render.hiddenPauseDelay);

    // Tray interactions call the long pause; it must not delay a hidden window.
    render.pause();
    expect(render.pendingPauseDelay, Render.hiddenPauseDelay);
  });

  test('resuming disarms the pending pause', () {
    final render = Render();
    render.pause(delay: Render.hiddenPauseDelay);
    render.resume();

    expect(render.pendingPauseDelay, isNull);
    expect(render.isPaused, isFalse);
  });

  test('pauses frames once the hidden delay elapses, then resumes', () async {
    final render = Render();
    render.pause(delay: Render.hiddenPauseDelay);

    await Future<void>.delayed(
      Render.hiddenPauseDelay + const Duration(milliseconds: 150),
    );
    expect(render.isPaused, isTrue);
    expect(render.pendingPauseDelay, isNull);

    render.resume();
    expect(render.isPaused, isFalse);
  });
}
