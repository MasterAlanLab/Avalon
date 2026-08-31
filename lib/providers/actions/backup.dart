part of '../action.dart';

@Riverpod(keepAlive: true)
class BackupAction extends _$BackupAction {
  @override
  void build() {}

  Future<String> backup() async {
    final res = await Future.wait([
      database.profilesDao.fileNames().get(),
      database.scriptsDao.fileNames().get(),
    ]);
    final profileFileNames = res[0];
    final scriptFileNames = res[1];
    final configMap = ref.read(configProvider).toJson();
    configMap['version'] = await preferences.getVersion();
    final snapshot = File('${await appPath.tempFilePath}.sqlite');
    await snapshot.safeDelete();
    try {
      await database.customStatement('VACUUM INTO ?;', [snapshot.path]);
      return await backupTask(configMap, [
        ...profileFileNames,
        ...scriptFileNames,
      ], databaseSnapshotPath: snapshot.path);
    } finally {
      await snapshot.safeDelete();
    }
  }

  Future<void> restore(RestoreOption option) async {
    final restoreDirPath = await appPath.restoreDirPath;
    final restoreDir = Directory(restoreDirPath);
    final restoreStrategy = ref.read(
      appSettingProvider.select((state) => state.restoreStrategy),
    );
    final isOverride = restoreStrategy == RestoreStrategy.override;
    try {
      final migrationData = await restoreTask();
      if (!await restoreDir.exists()) {
        throw currentAppLocalizations.restoreException;
      }
      final configMap = migrationData.configMap;
      final restoredConfig =
          option == RestoreOption.onlyProfiles || configMap == null
          ? null
          : Config.fromJson(configMap);
      final previousDatabase = await database.snapshot();
      final previousConfig = ref.read(configProvider);
      final files = await applyRestoredProfileFiles(
        restoreDirPath: restoreDirPath,
        homeDirPath: await appPath.homeDirPath,
        profiles: migrationData.profiles,
        scripts: migrationData.scripts,
      );
      try {
        await database.restore(
          migrationData.profiles,
          migrationData.scripts,
          migrationData.rules,
          migrationData.links,
          migrationData.proxyGroups,
          proxyNodes: migrationData.proxyNodes,
          proxyNodeBindings: migrationData.proxyNodeBindings,
          proxyChains: migrationData.proxyChains,
          proxyChainHops: migrationData.proxyChainHops,
          proxyChainBindings: migrationData.proxyChainBindings,
          proxyNodeAssets: migrationData.proxyNodeAssets,
          groupMembers: migrationData.proxyGroupMembers,
          isOverride: isOverride,
        );
        await installRestoredNodeAssets(isOverride: isOverride);
        if (restoredConfig != null) _applyConfig(restoredConfig);
      } catch (_) {
        await files.rollback();
        await database.restoreSnapshot(previousDatabase);
        if (restoredConfig != null) _applyConfig(previousConfig);
        rethrow;
      }
      await files.commit();
      return;
    } finally {
      await restoreDir.safeDelete(recursive: true);
    }
  }

  void _applyConfig(Config config) {
    ref.read(davSettingProvider.notifier).update((_) => config.davProps);
    ref.read(patchClashConfigProvider.notifier).value = config.patchClashConfig;
    ref.read(appSettingProvider.notifier).value = config.appSettingProps;
    ref.read(currentProfileIdProvider.notifier).value = config.currentProfileId;
    ref.read(themeSettingProvider.notifier).value = config.themeProps;
    ref.read(windowSettingProvider.notifier).value = config.windowProps;
    ref.read(vpnSettingProvider.notifier).value = config.vpnProps;
    ref.read(proxiesStyleSettingProvider.notifier).value =
        config.proxiesStyleProps;
    ref.read(overrideDnsProvider.notifier).value = config.overrideDns;
    ref.read(networkSettingProvider.notifier).value = config.networkProps;
    ref.read(hotKeyActionsProvider.notifier).value = config.hotKeyActions;
  }
}
