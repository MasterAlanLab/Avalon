part of '../action.dart';

enum _SetupTaskResult { completed, handoffToCoreRestart }

class _RunRequest {
  final bool running;
  final bool initialize;

  const _RunRequest({required this.running, required this.initialize});
}

@Riverpod(keepAlive: true)
class SetupAction extends _$SetupAction {
  Timer? _runtimeTimer;
  Duration? _runtimeTimerInterval;
  bool _trafficRequestInFlight = false;
  bool _lastUiActive = appActivity.value.isUiActive;
  final _setupScheduler = SerialTaskScheduler();
  final _listenerScheduler = SerialTaskScheduler();
  _RunRequest? _latestRunRequest;
  DateTime? _startTime;

  bool get _isRunning => _startTime != null && _startTime!.isBeforeNow;

  @override
  void build() {
    appActivity.addListener(_handleActivityChanged);
    ref.onDispose(() {
      appActivity.removeListener(_handleActivityChanged);
      _runtimeTimer?.cancel();
      _runtimeTimer = null;
    });
    ref.listen(
      currentPageLabelProvider,
      (_, _) {
        _syncRuntimeTimer(
          refreshNow: appActivity.value.isUiActive,
        );
      },
      weak: false,
      fireImmediately: false,
    );
    ref.listen(
      appSettingProvider.select((state) => state.showTrayTitle),
      (_, _) {
        _syncRuntimeTimer(
          refreshNow: appActivity.value.isUiActive,
        );
      },
      weak: false,
      fireImmediately: false,
    );
    ref.listen(
      appSettingProvider.select((state) => state.dashboardWidgets),
      (_, _) {
        _syncRuntimeTimer(
          refreshNow: appActivity.value.isUiActive,
        );
      },
      weak: false,
      fireImmediately: false,
    );
  }

  SetupParams get _setupParams {
    final selectedMap = ref.read(selectedMapProvider);
    final testUrl = ref.read(
      appSettingProvider.select((state) => state.testUrl),
    );
    return SetupParams(selectedMap: selectedMap, testUrl: testUrl);
  }

  void fullSetup() {
    if (!ref.read(initProvider)) return;
    ref.read(delayDataSourceProvider.notifier).value = {};
    unawaited(_runSetup(force: true));
    ref.read(logsProvider.notifier).value = FixedList(500);
    ref.read(requestsProvider.notifier).value = FixedList(500);
  }

  void _setLocalRunning(bool running) {
    _runtimeTimer?.cancel();
    _runtimeTimer = null;
    _runtimeTimerInterval = null;
    if (!running) {
      _startTime = null;
      debouncer.cancel(FunctionTag.applyProfile);
      _updateRunTime();
      return;
    }

    _startTime ??= DateTime.now();
    if (appActivity.value.isUiActive) {
      _updateRunTime();
    }
    _syncRuntimeTimer(refreshNow: appActivity.value.isUiActive);
  }

  bool get _dashboardNeedsTraffic {
    if (ref.read(currentPageLabelProvider) != PageLabel.dashboard) {
      return false;
    }
    final widgets = ref.read(appSettingProvider).dashboardWidgets;
    return widgets.contains(DashboardWidget.networkSpeed) ||
        widgets.contains(DashboardWidget.trafficUsage);
  }

  /// The tray speed title is the only consumer that outlives an inactive UI,
  /// and it exists on macOS only. Elsewhere `showTrayTitle` must not keep the
  /// background sampler alive, otherwise nothing consumes the samples.
  @protected
  bool get supportsTrayTitle => system.isMacOS;

  bool get _trayNeedsTraffic {
    if (!supportsTrayTitle) {
      return false;
    }
    return ref.read(
      appSettingProvider.select((state) => state.showTrayTitle),
    );
  }

  bool get _needsTraffic {
    if (appActivity.value.isUiActive) {
      return _trayNeedsTraffic || _dashboardNeedsTraffic;
    }
    return _trayNeedsTraffic;
  }

  bool get _needsUiRuntime =>
      appActivity.value.isUiActive &&
      ref.read(currentPageLabelProvider) == PageLabel.dashboard;

  Duration? get _runtimeInterval {
    // Runtime and traffic sampling are UI telemetry; the proxy listener stays
    // alive independently of this timer.
    if (!_isRunning) {
      return null;
    }
    if (_needsTraffic) {
      return appActivity.value.isUiActive
          ? const Duration(seconds: 1)
          : const Duration(seconds: 5);
    }
    if (_needsUiRuntime) {
      return const Duration(seconds: 1);
    }
    return null;
  }

  /// The timer period the current activity/consumer mix asks for, or null when
  /// nothing needs a periodic tick. A non-null period does not imply traffic
  /// sampling: the dashboard run-time counter also needs a tick.
  @visibleForTesting
  Duration? get telemetryInterval => _runtimeInterval;

  /// Whether a tick currently issues traffic RPCs.
  @visibleForTesting
  bool get samplesTraffic => _needsTraffic;

  void _handleActivityChanged() {
    final isUiActive = appActivity.value.isUiActive;
    final becameActive = isUiActive && !_lastUiActive;
    _lastUiActive = isUiActive;
    _syncRuntimeTimer(refreshNow: becameActive);
  }

  void _syncRuntimeTimer({bool refreshNow = false}) {
    final interval = _runtimeInterval;
    if (interval == null) {
      _runtimeTimer?.cancel();
      _runtimeTimer = null;
      _runtimeTimerInterval = null;
      return;
    }

    if (_runtimeTimer == null || _runtimeTimerInterval != interval) {
      _runtimeTimer?.cancel();
      _runtimeTimerInterval = interval;
      _runtimeTimer = Timer.periodic(interval, (_) => _refreshRunningState());
    }
    if (refreshNow) {
      _refreshRunningState();
    }
  }

  void _refreshRunningState() {
    if (!_isRunning) {
      return;
    }
    if (appActivity.value.isUiActive) {
      _updateRunTime();
    }
    if (_needsTraffic) {
      unawaited(_refreshTraffic());
    }
  }

  Future<void> _refreshTraffic() async {
    // A slow Core response must not create a second in-flight sample.
    if (_trafficRequestInFlight || !_isRunning || !_needsTraffic) {
      return;
    }
    _trafficRequestInFlight = true;
    try {
      await ref.read(commonActionProvider.notifier).updateTraffic();
    } finally {
      _trafficRequestInFlight = false;
    }
  }

  void _updateRunTime() {
    final startTime = _startTime;
    ref.read(runTimeProvider.notifier).value = startTime == null
        ? null
        : DateTime.now().millisecondsSinceEpoch -
              startTime.millisecondsSinceEpoch;
  }

  Future<void> _updateStartTime() async {
    _startTime = await service?.getRunTime();
  }

  Future<void> initStatus() async {
    if (!globalState.needInitStatus) {
      commonPrint.log('init status cancel');
      return;
    }
    commonPrint.log('init status');
    if (system.isAndroid) {
      await _updateStartTime();
    }
    final shouldRun = _isRunning || ref.read(appSettingProvider).autoRun;
    if (shouldRun) {
      await setRunning(true, initialize: true);
    } else {
      await applyProfile(force: true);
    }
  }

  Future<void> setRunning(bool running, {bool initialize = false}) {
    if (running && !initialize && !ref.read(initProvider)) {
      return Future.value();
    }

    final request = _RunRequest(
      running: running,
      initialize: running && initialize,
    );
    _latestRunRequest = request;
    _setLocalRunning(running);
    if (request.initialize) {
      globalState.needInitStatus = false;
    }
    return running ? _start(request) : _stop(request);
  }

  Future<void> _start(_RunRequest request) async {
    if (request.initialize) {
      try {
        await applyProfile(
          force: true,
          preloadInvoke: () => _setCoreRunning(request),
        );
      } catch (_) {
        if (_isCurrent(request)) {
          await setRunning(false);
        }
      }
      return;
    }

    await _setCoreRunning(request);
    if (_isCurrent(request)) {
      applyProfileDebounce(force: true, silence: true);
    }
  }

  Future<void> _stop(_RunRequest request) async {
    await _setCoreRunning(request);
    if (!_isCurrent(request)) {
      return;
    }
    resetCoreTraffic();
    ref.read(trafficsProvider.notifier).clear();
    ref.read(totalTrafficProvider.notifier).value = const Traffic();
    ref.read(checkIpNumProvider.notifier).add();
  }

  Future<void> _setCoreRunning(_RunRequest request) {
    return _listenerScheduler.run(() async {
      if (!_isCurrent(request)) {
        return;
      }
      if (request.running && ref.read(suspendProvider)) {
        return;
      }
      await setCoreRunning(request.running);
    });
  }

  bool _isCurrent(_RunRequest request) => identical(_latestRunRequest, request);

  Future<void> updateConfigDebounce() async {
    debouncer.call(FunctionTag.updateConfig, updateConfig);
  }

  @protected
  Future<bool> setCoreRunning(bool running) {
    return running
        ? coreController.startListener()
        : coreController.stopListener();
  }

  @protected
  void resetCoreTraffic() {
    coreController.resetTraffic();
  }

  @visibleForTesting
  Future<void> updateConfig() async {
    await globalState.safeRun(() async {
      final updateParams = ref.read(updateParamsProvider);
      final shouldContinueSetup = await requestAdmin(updateParams.tun.enable);
      if (!shouldContinueSetup) {
        await _restartCoreAfterAuthorization();
        return;
      }
      final effectiveTunEnable = _getEffectiveTunEnable(updateParams.tun.enable);
      // 与 makeRealProfileTask 保持一致：不接管 IPv6 时不下发 inet6-address，
      // 也不替用户打开全局 ipv6。
      final tunTakesIpv6 = _tunTakesIpv6(
        updateParams.tun.copyWith(enable: effectiveTunEnable),
      );
      final message = await coreController.updateConfig(
        updateParams.copyWith(
          tun: updateParams.tun.copyWith(
            enable: effectiveTunEnable,
            inet6Address: tunTakesIpv6
                ? updateParams.tun.inet6Address
                : const [],
          ),
          ipv6: updateParams.ipv6 || tunTakesIpv6,
        ),
      );
      ref.read(checkIpNumProvider.notifier).add();
      if (message.isNotEmpty) throw message;
    });
  }

  void tryCheckIp() {
    final isTimeout = ref.read(
      networkDetectionProvider.select(
        (state) => state.ipInfo == null && state.isLoading == false,
      ),
    );
    if (!isTimeout) return;
    ref.read(checkIpNumProvider.notifier).add();
  }

  void applyProfileDebounce({bool silence = false, bool force = false}) {
    debouncer.call(FunctionTag.applyProfile, () async {
      try {
        await applyProfile(silence: silence, force: force);
      } catch (error) {
        commonPrint.log(error.toString(), logLevel: LogLevel.warning);
        if (!silence) globalState.showNotifier(error.toString());
      }
    });
  }

  void changeMode(Mode mode) {
    ref
        .read(patchClashConfigProvider.notifier)
        .update((state) => state.copyWith(mode: mode));
    if (mode == Mode.global) {
      ref
          .read(proxiesActionProvider.notifier)
          .updateCurrentGroupName(GroupName.GLOBAL.name);
    }
  }

  void autoApplyProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      applyProfile();
    });
  }

  Future<void> applyProfile({
    bool silence = false,
    bool force = false,
    Future<void> Function()? preloadInvoke,
  }) {
    return _runSetup(
      force: force,
      silence: silence,
      preloadInvoke: preloadInvoke,
    );
  }

  Future<void> _runSetup({
    bool silence = false,
    bool force = false,
    Future<void> Function()? preloadInvoke,
  }) async {
    final result = await _setupScheduler.run(() {
      return _setupConfig(
        force: force,
        silence: silence,
        preloadInvoke: preloadInvoke,
        onUpdated: () async {
          await ref.read(proxiesActionProvider.notifier).updateGroups();
          await ref.read(providersProvider.notifier).syncProviders();
          await ref
              .read(proxiesActionProvider.notifier)
              .syncProviderSources(ref.read(providersProvider));
        },
      );
    });
    if (result != _SetupTaskResult.handoffToCoreRestart) {
      return;
    }
    // Release the current serial task before restartCore reapplies the profile.
    await _restartCoreAfterAuthorization();
  }

  Future<void> _restartCoreAfterAuthorization() async {
    try {
      await ref.read(coreActionProvider.notifier).restartCore();
    } catch (_) {
      ref.read(authorizedTunEnableProvider.notifier).value =
          TunAuthorizationState.none;
      rethrow;
    }
  }

  Future<VM2<String, String>> getProfile({
    required SetupState setupState,
    required PatchClashConfig patchConfig,
  }) async {
    final profileId = setupState.profileId;
    if (profileId == null) return const VM2('', '');
    final defaultUA = globalState.packageInfo.ua;
    final networkVM2 = ref.read(
      networkSettingProvider.select(
        (state) => VM2(state.appendSystemDns, state.routeMode),
      ),
    );
    final overrideDns = ref.read(overrideDnsProvider);
    final tunTakesIpv6 = _tunTakesIpv6(patchConfig.tun);
    final appendSystemDns = networkVM2.a;
    final routeMode = networkVM2.b;
    final configMap = await coreController.getConfig(profileId);
    String? scriptContent;
    final List<Rule> addedRules = [];
    final List<ProxyGroup> proxyGroups = [];
    final List<Rule> rules = [];
    if (setupState.overwriteType == OverwriteType.script) {
      scriptContent = await setupState.script?.content;
    } else if (setupState.overwriteType == OverwriteType.standard) {
      addedRules.addAll(setupState.addedRules);
    } else {
      proxyGroups.addAll(setupState.proxyGroups);
      rules.addAll(setupState.rules);
    }
    final realPatchConfig = patchConfig.copyWith(
      tun: patchConfig.tun.getRealTun(routeMode),
    );
    Map<String, dynamic> rawConfig = configMap;
    if (scriptContent?.isNotEmpty == true) {
      rawConfig = await handleEvaluate(scriptContent!, rawConfig);
    }
    if (proxyGroups.isNotEmpty) {
      rawConfig = Map<String, dynamic>.from(rawConfig)
        ..['proxy-groups'] = proxyGroups
            .map(_proxyGroupConfig)
            .toList(growable: false);
    }
    final effectiveArtifact = await const ProfileEffectiveConfigService()
        .assemble(profileId: profileId, profileConfig: rawConfig);
    final chainErrors = effectiveArtifact.diagnostics
        .where((item) => item.isError)
        .toList();
    if (chainErrors.isNotEmpty) {
      throw StateError(chainErrors.map((item) => item.message).join('\n'));
    }
    for (final diagnostic in effectiveArtifact.diagnostics.where(
      (item) => !item.isError,
    )) {
      commonPrint.log(
        '${diagnostic.code}: ${diagnostic.message}',
        logLevel: LogLevel.warning,
      );
    }
    rawConfig = effectiveArtifact.config;
    final directory = await appPath.profilesPath;
    final res = makeRealProfileTask(
      MakeRealProfileState(
        rules: rules,
        proxyGroups: proxyGroups,
        profilesPath: directory,
        profileId: profileId,
        rawConfig: rawConfig,
        realPatchConfig: realPatchConfig,
        tunTakesIpv6: tunTakesIpv6,
        overrideDns: overrideDns,
        appendSystemDns: appendSystemDns,
        addedRules: addedRules,
        defaultUA: defaultUA,
      ),
    );
    return res;
  }

  Future<String> getProfileWithId(int profileId) async {
    try {
      final setupState = await ref.read(setupStateProvider(profileId).future);
      final patchClashConfig = ref.read(patchClashConfigProvider);
      final res = await getProfile(
        setupState: setupState,
        patchConfig: patchClashConfig,
      );
      return res.a;
    } catch (e) {
      globalState.showNotifier(e.toString());
    }
    return '';
  }

  bool _getEffectiveTunEnable(bool enableTun) {
    final authorizationState = ref.read(authorizedTunEnableProvider);
    return enableTun && authorizationState == TunAuthorizationState.authorized;
  }

  /// 虚拟网卡是否接管 IPv6。
  ///
  /// 桌面端由 TUN 开关和 TUN IPv6 开关共同决定。Android 上虚拟网卡由 VpnService
  /// 建立、`tun.enable` 恒为 false，接管与否写在 VPN 的 IPv6 开关里；不跟着它走的话
  /// VpnService 已经把 ::/0 指向了虚拟网卡，内核那边 `ipv6` 却还是关的，路由接管了
  /// 但没人能用。
  bool _tunTakesIpv6(Tun tun) {
    if (system.isDesktop) {
      return tun.enable && tun.ipv6;
    }
    final vpnSetting = ref.read(vpnSettingProvider);
    return vpnSetting.enable && vpnSetting.ipv6;
  }

  @protected
  Future<AuthorizeCode> authorizeCore() {
    return system.authorizeCore();
  }

  @visibleForTesting
  Future<bool> requestAdmin(bool enableTun) async {
    if (!enableTun) {
      return true;
    }
    final authorizationState = ref.read(authorizedTunEnableProvider);
    if (authorizationState != TunAuthorizationState.none) {
      return true;
    }

    final authorizationNotifier = ref.read(
      authorizedTunEnableProvider.notifier,
    );
    authorizationNotifier.value = TunAuthorizationState.unauthorized;

    final code = await authorizeCore();

    switch (code) {
      case AuthorizeCode.success:
        authorizationNotifier.value = TunAuthorizationState.authorized;
        return false;
      case AuthorizeCode.none:
        authorizationNotifier.value = TunAuthorizationState.authorized;
        return true;
      case AuthorizeCode.error:
        return true;
    }
  }

  Future<_SetupTaskResult> _setupConfig({
    bool force = false,
    bool silence = false,
    Future<void> Function()? preloadInvoke,
    FutureOr Function()? onUpdated,
  }) async {
    var profile = ref.read(currentProfileProvider);
    final nextProfile = await profile?.checkAndUpdateAndCopy();
    if (nextProfile != null) {
      profile = nextProfile;
      ref.read(profilesProvider.notifier).put(nextProfile);
    }
    commonPrint.log('setup ===> ${profile?.realLabel}');
    final patchConfig = ref.read(patchClashConfigProvider);
    final shouldContinueSetup = await requestAdmin(patchConfig.tun.enable);
    if (!shouldContinueSetup) {
      return _SetupTaskResult.handoffToCoreRestart;
    }
    final effectiveTunEnable = _getEffectiveTunEnable(patchConfig.tun.enable);
    final realPatchConfig = patchConfig.copyWith.tun(
      enable: effectiveTunEnable,
    );
    final setupState = await ref.read(setupStateProvider(profile?.id).future);
    final vm2 = await getProfile(
      setupState: setupState,
      patchConfig: realPatchConfig,
    );
    final yamlString = vm2.a;
    final yamlMd5 = vm2.b;
    if (yamlMd5 == globalState.lastConfigMd5 && force == false) {
      return _SetupTaskResult.completed;
    }
    if (system.isAndroid) {
      globalState.lastVpnState = ref.read(vpnStateProvider);
      final sharedState = ref.read(sharedStateProvider);
      await preferences.saveShareState(sharedState);
    }
    await globalState.loadingRun(
      () async {
        if (yamlString.trim().isNotEmpty) {
          final validationMessage = await coreController.validateConfigWithData(
            yamlString,
          );
          if (validationMessage.isNotEmpty &&
              !validationMessage.endsWith('is empty')) {
            throw StateError(validationMessage);
          }
        }
        final configFilePath = await appPath.configFilePath;
        final replacement = await replaceFileAtomically(
          configFilePath,
          yamlString,
        );
        try {
          final message = await coreController.setupConfig(
            params: _setupParams,
            preloadInvoke: preloadInvoke,
          );
          if (message.isNotEmpty && !message.endsWith('is empty')) {
            throw message;
          }
        } catch (_) {
          await replacement.rollback();
          await _reloadLastValidConfig(replacement);
          rethrow;
        }
        await replacement.commit();
        globalState.lastConfigMd5 = yamlMd5;
        ref.read(checkIpNumProvider.notifier).add();
        await onUpdated?.call();
      },
      silence: true,
      tag: !silence ? LoadingTag.proxies : null,
    );
    return _SetupTaskResult.completed;
  }

  Map<String, dynamic> _proxyGroupConfig(ProxyGroup group) {
    final config = Map<String, dynamic>.from(group.toJson())
      ..remove('id')
      ..remove('profileId')
      ..remove('order');
    return config;
  }

  Future<void> _reloadLastValidConfig(FileReplacement replacement) async {
    if (!replacement.hasPrevious) return;
    try {
      await coreController.setupConfig(params: _setupParams);
    } catch (error) {
      commonPrint.log(
        'unable to reload the last valid config: $error',
        logLevel: LogLevel.error,
      );
    }
  }
}
