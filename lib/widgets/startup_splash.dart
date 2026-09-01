import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const startupSplashDuration = Duration(milliseconds: 1000);

const _obsidian = Color(0xFF17191D);
const _saffron = Color(0xFFE3A72F);
const _warmNode = Color(0xFFF3D58A);
const _linen = Color(0xFFF1EEE7);
const _muted = Color(0xFFA9A39A);

/// The animated Flutter version of the V4 brand package's splash_animation.svg.
///
/// Android's system splash can display a static icon, but it does not execute
/// SVG SMIL animations. Rendering the same timeline here keeps the full-screen
/// ladder build and wordmark fade consistent across Android API levels.
class StartupSplash extends StatefulWidget {
  final VoidCallback? onComplete;

  const StartupSplash({super.key, this.onComplete});

  @override
  State<StartupSplash> createState() => _StartupSplashState();
}

class _StartupSplashState extends State<StartupSplash>
    with SingleTickerProviderStateMixin {
  static const _startupSplashChannel = MethodChannel(
    'com.masteralanlab.avalon/startup_splash',
  );

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: startupSplashDuration,
      animationBehavior: AnimationBehavior.preserve,
    )..addStatusListener(_handleStatus);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAfterSystemSplash();
    });
  }

  void _handleStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onComplete?.call();
    }
  }

  Future<void> _startAfterSystemSplash() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      while (mounted) {
        try {
          final visible =
              await _startupSplashChannel.invokeMethod<bool>(
                'isSystemSplashVisible',
              ) ??
              false;
          if (!visible) break;
        } on PlatformException {
          break;
        } on MissingPluginException {
          break;
        }
        await Future<void>.delayed(const Duration(milliseconds: 16));
      }
    }
    if (mounted) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: _obsidian,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: _obsidian,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: ColoredBox(
        color: _obsidian,
        child: CustomPaint(
          painter: _StartupSplashPainter(_controller),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _StartupSplashPainter extends CustomPainter {
  static const _designWidth = 1080.0;
  static const _designHeight = 1920.0;
  static const _animationMilliseconds = 1000.0;

  final Animation<double> animation;

  _StartupSplashPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(
      size.width / _designWidth,
      size.height / _designHeight,
    );
    final offset = Offset(
      (size.width - _designWidth * scale) / 2,
      (size.height - _designHeight * scale) / 2,
    );
    final elapsed = animation.value * _animationMilliseconds;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);

    _drawSegment(
      canvas,
      const Offset(370, 930),
      const Offset(480, 540),
      progress: _segmentProgress(elapsed, start: 80, duration: 240),
      width: 76,
    );
    _drawSegment(
      canvas,
      const Offset(600, 540),
      const Offset(710, 930),
      progress: _segmentProgress(elapsed, start: 240, duration: 240),
      width: 76,
    );

    _drawSegment(
      canvas,
      const Offset(430, 800),
      const Offset(650, 800),
      progress: _segmentProgress(elapsed, start: 410, duration: 140),
      width: 58,
    );
    _drawSegment(
      canvas,
      const Offset(450, 720),
      const Offset(630, 720),
      progress: _segmentProgress(elapsed, start: 500, duration: 140),
      width: 58,
    );
    _drawSegment(
      canvas,
      const Offset(470, 640),
      const Offset(610, 640),
      progress: _segmentProgress(elapsed, start: 590, duration: 140),
      width: 58,
    );

    _drawNode(
      canvas,
      const Offset(370, 930),
      _segmentProgress(elapsed, start: 220, duration: 120),
    );
    _drawNode(
      canvas,
      const Offset(710, 930),
      _segmentProgress(elapsed, start: 360, duration: 120),
    );

    final textProgress = _segmentProgress(elapsed, start: 730, duration: 180);
    _drawText(
      canvas,
      text: 'Avalon',
      baseline: 1160,
      fontSize: 74,
      fontWeight: FontWeight.w700,
      letterSpacing: 2,
      color: _linen,
      opacity: textProgress,
    );
    _drawText(
      canvas,
      text: 'ROUTE · CONNECT · CONTROL',
      baseline: 1218,
      fontSize: 22,
      letterSpacing: 5,
      color: _muted,
      opacity: textProgress,
    );

    canvas.restore();
  }

  double _segmentProgress(
    double elapsed, {
    required double start,
    required double duration,
  }) {
    return ((elapsed - start) / duration).clamp(0.0, 1.0).toDouble();
  }

  void _drawSegment(
    Canvas canvas,
    Offset start,
    Offset end, {
    required double progress,
    required double width,
  }) {
    if (progress <= 0) return;
    final current = Offset.lerp(start, end, progress)!;
    final paint = Paint()
      ..color = _saffron
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, current, paint);
  }

  void _drawNode(Canvas canvas, Offset center, double opacity) {
    if (opacity <= 0) return;
    final fill = Paint()..color = _warmNode.withValues(alpha: opacity);
    final outline = Paint()
      ..color = _saffron.withValues(alpha: opacity)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, 25, fill);
    canvas.drawCircle(center, 25, outline);
  }

  void _drawText(
    Canvas canvas, {
    required String text,
    required double baseline,
    required double fontSize,
    FontWeight? fontWeight,
    required double letterSpacing,
    required Color color,
    required double opacity,
  }) {
    if (opacity <= 0) return;
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: opacity),
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();
    final actualBaseline = painter.computeDistanceToActualBaseline(
      TextBaseline.alphabetic,
    );
    painter.paint(
      canvas,
      Offset(_designWidth / 2 - painter.width / 2, baseline - actualBaseline),
    );
  }

  @override
  bool shouldRepaint(covariant _StartupSplashPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
