import 'package:avalon/widgets/startup_splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the animated ladder splash timeline', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    var completed = false;
    await tester.pumpWidget(StartupSplash(onComplete: () => completed = true));
    expect(find.byType(CustomPaint), findsOneWidget);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(completed, isFalse);
    expect(tester.takeException(), isNull);

    await tester.pump(startupSplashDuration);
    expect(completed, isTrue);
    expect(tester.takeException(), isNull);
    debugDefaultTargetPlatformOverride = null;
  });
}
