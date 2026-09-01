import 'dart:async';
import 'dart:io';

import 'package:avalon/pages/error.dart';
import 'package:avalon/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rust_api/rust_api.dart';

import 'application.dart';
import 'common/common.dart';
import 'widgets/startup_splash.dart';

Future<void> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  linkManager.setStartupArguments(arguments);
  runApp(_BootstrapApp(initialization: _initialize()));
}

Future<_InitializationResult> _initialize() async {
  try {
    if (system.isDesktop) {
      await RustLib.init();
    }
    final version = await system.init();
    final container = await globalState.init(version);
    HttpOverrides.global = AvalonHttpOverrides();
    return _InitializationResult.success(container);
  } catch (e, s) {
    return _InitializationResult.failure(e, s);
  }
}

class _InitializationResult {
  final ProviderContainer? container;
  final Object? error;
  final StackTrace? stack;

  const _InitializationResult._({this.container, this.error, this.stack});

  const _InitializationResult.success(ProviderContainer container)
    : this._(container: container);

  const _InitializationResult.failure(Object error, StackTrace stack)
    : this._(error: error, stack: stack);
}

class _BootstrapApp extends StatefulWidget {
  final Future<_InitializationResult> initialization;

  const _BootstrapApp({required this.initialization});

  @override
  State<_BootstrapApp> createState() => _BootstrapAppState();
}

class _BootstrapAppState extends State<_BootstrapApp> {
  final Completer<void> _splashComplete = Completer<void>();
  late final Future<_InitializationResult> _ready;

  @override
  void initState() {
    super.initState();
    _ready = _waitForSplashAndInitialization();
  }

  Future<_InitializationResult> _waitForSplashAndInitialization() async {
    final result = await widget.initialization;
    await _splashComplete.future;
    return result;
  }

  void _handleSplashComplete() {
    if (!_splashComplete.isCompleted) {
      _splashComplete.complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_InitializationResult>(
      future: _ready,
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (result == null) {
          return StartupSplash(onComplete: _handleSplashComplete);
        }

        if (result.error != null || result.container == null) {
          return MaterialApp(
            home: InitErrorScreen(
              error:
                  result.error ?? StateError('Startup initialization failed'),
              stack: result.stack ?? StackTrace.current,
            ),
          );
        }

        return UncontrolledProviderScope(
          container: result.container!,
          child: const Application(),
        );
      },
    );
  }
}
