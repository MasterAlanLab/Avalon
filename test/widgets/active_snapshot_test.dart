import 'package:avalon/common/activity.dart';
import 'package:avalon/widgets/active_snapshot.dart';
import 'package:avalon/widgets/inherited.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(_resetActivity);
  tearDown(_resetActivity);

  Future<_ProbeState> pump(WidgetTester tester, {required bool isActive}) async {
    await tester.pumpWidget(
      PageActivityScope(
        isActive: isActive,
        child: const _Probe(),
      ),
    );
    return tester.state<_ProbeState>(find.byType(_Probe));
  }

  testWidgets('is active when the page is current and the UI is active', (
    tester,
  ) async {
    final probe = await pump(tester, isActive: true);
    expect(probe.isSnapshotActive, isTrue);
    expect(probe.events, isEmpty);
  });

  testWidgets('suspends when the window stops being active', (tester) async {
    final probe = await pump(tester, isActive: true);

    appActivity.setWindowFocused(false);
    expect(probe.isSnapshotActive, isFalse);
    expect(probe.events, ['suspended']);

    appActivity.setWindowFocused(true);
    expect(probe.isSnapshotActive, isTrue);
    expect(probe.events, ['suspended', 'resumed']);
  });

  testWidgets('suspends when the page stops being current', (tester) async {
    final probe = await pump(tester, isActive: true);

    await pump(tester, isActive: false);
    expect(probe.isSnapshotActive, isFalse);
    expect(probe.events, ['suspended']);

    await pump(tester, isActive: true);
    expect(probe.events, ['suspended', 'resumed']);
  });

  testWidgets('stays suspended until both conditions come back', (
    tester,
  ) async {
    final probe = await pump(tester, isActive: true);

    appActivity.setWindowState(visible: false, focused: false);
    await pump(tester, isActive: false);
    expect(probe.events, ['suspended']);

    // Only the page returns; the window is still hidden.
    await pump(tester, isActive: true);
    expect(probe.isSnapshotActive, isFalse);
    expect(probe.events, ['suspended']);

    appActivity.setWindowState(visible: true, focused: true);
    expect(probe.isSnapshotActive, isTrue);
    expect(probe.events, ['suspended', 'resumed']);
  });

  testWidgets('drops its activity listener when disposed', (tester) async {
    final probe = await pump(tester, isActive: true);
    await tester.pumpWidget(const SizedBox.shrink());

    appActivity.setWindowFocused(false);

    expect(probe.events, isEmpty);
  });
}

void _resetActivity() {
  appActivity.setLifecycleResumed(true);
  appActivity.setWindowState(visible: true, focused: true);
}

class _Probe extends StatefulWidget {
  const _Probe();

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> with ActiveSnapshotMixin<_Probe> {
  final events = <String>[];

  @override
  void onSnapshotSuspended() => events.add('suspended');

  @override
  void onSnapshotResumed() => events.add('resumed');

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
