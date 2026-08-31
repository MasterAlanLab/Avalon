import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/native.dart';
import 'package:avalon/common/common.dart';
import 'package:avalon/database/database.dart';
import 'package:avalon/l10n/l10n.dart';
import 'package:avalon/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await AppLocalizations.load(const Locale('en'));
  });

  group('restored node assets', () {
    late Directory restoreDir;

    setUp(() async {
      restoreDir = await Directory.systemTemp.createTemp('restore-assets');
    });

    tearDown(() async {
      await restoreDir.safeDelete(recursive: true);
    });

    Future<ProxyNodeAsset> writeAsset(
      String content, {
      String? sha256Hex,
    }) async {
      const relativePath = 'nodes/100/assets/cert.pem';
      final file = File(join(restoreDir.path, relativePath));
      await file.create(recursive: true);
      await file.writeAsString(content);
      return ProxyNodeAsset(
        id: 300,
        nodeId: 100,
        fieldPath: 'tls.cert',
        fileName: 'cert.pem',
        relativePath: relativePath,
        sha256: sha256Hex ?? sha256.convert(utf8.encode(content)).toString(),
        size: content.length,
      );
    }

    test('accepts an asset whose digest matches', () async {
      final asset = await writeAsset('CERT');
      await expectLater(
        verifyRestoredNodeAssets(
          restoreDirPath: restoreDir.path,
          assets: [asset],
        ),
        completes,
      );
    });

    test('rejects a digest mismatch', () async {
      final asset = await writeAsset('CERT', sha256Hex: 'deadbeef');
      await expectLater(
        verifyRestoredNodeAssets(
          restoreDirPath: restoreDir.path,
          assets: [asset],
        ),
        throwsA(isA<String>()),
      );
    });

    test('rejects a missing asset file', () async {
      final asset = await writeAsset('CERT');
      await File(join(restoreDir.path, asset.relativePath)).delete();
      await expectLater(
        verifyRestoredNodeAssets(
          restoreDirPath: restoreDir.path,
          assets: [asset],
        ),
        throwsA(isA<String>()),
      );
    });

    test('rejects a path outside the restore directory', () async {
      final asset = (await writeAsset(
        'CERT',
      )).copyWith(relativePath: '../nodes/escape.pem');
      await expectLater(
        verifyRestoredNodeAssets(
          restoreDirPath: restoreDir.path,
          assets: [asset],
        ),
        throwsA(isA<String>()),
      );
    });
  });

  group('restored profile files', () {
    late Directory restoreDir;
    late Directory homeDir;

    const profile = Profile(
      id: 1,
      label: 'Profile',
      autoUpdateDuration: Duration.zero,
    );
    final script = Script(
      id: 2,
      label: 'Script',
      lastUpdateTime: DateTime(2026),
    );

    setUp(() async {
      restoreDir = await Directory.systemTemp.createTemp('restore-home-src');
      homeDir = await Directory.systemTemp.createTemp('restore-home-dst');
      final sourceProfile = File(join(restoreDir.path, 'profiles', '1.yaml'));
      await sourceProfile.create(recursive: true);
      await sourceProfile.writeAsString('restored profile');
      final sourceScript = File(join(restoreDir.path, 'scripts', '2.js'));
      await sourceScript.create(recursive: true);
      await sourceScript.writeAsString('restored script');
    });

    tearDown(() async {
      await restoreDir.safeDelete(recursive: true);
      await homeDir.safeDelete(recursive: true);
    });

    Future<void> writeExisting() async {
      final existing = File(join(homeDir.path, 'profiles', '1.yaml'));
      await existing.create(recursive: true);
      await existing.writeAsString('previous profile');
    }

    test('restores the previous file content on rollback', () async {
      await writeExisting();
      final transaction = await applyRestoredProfileFiles(
        restoreDirPath: restoreDir.path,
        homeDirPath: homeDir.path,
        profiles: const [profile],
        scripts: [script],
      );
      expect(
        await File(join(homeDir.path, 'profiles', '1.yaml')).readAsString(),
        'restored profile',
      );

      await transaction.rollback();
      expect(
        await File(join(homeDir.path, 'profiles', '1.yaml')).readAsString(),
        'previous profile',
      );
      expect(
        await File(join(homeDir.path, 'scripts', '2.js')).exists(),
        isFalse,
      );
      expect(
        Directory(
          join(homeDir.path, 'profiles'),
        ).listSync().map((item) => basename(item.path)).toList(),
        ['1.yaml'],
      );
    });

    test('keeps the restored content and drops backups on commit', () async {
      await writeExisting();
      final transaction = await applyRestoredProfileFiles(
        restoreDirPath: restoreDir.path,
        homeDirPath: homeDir.path,
        profiles: const [profile],
        scripts: [script],
      );
      await transaction.commit();

      expect(
        await File(join(homeDir.path, 'profiles', '1.yaml')).readAsString(),
        'restored profile',
      );
      expect(
        await File(join(homeDir.path, 'scripts', '2.js')).readAsString(),
        'restored script',
      );
      expect(
        Directory(
          join(homeDir.path, 'profiles'),
        ).listSync().map((item) => basename(item.path)).toList(),
        ['1.yaml'],
      );
    });
  });

  group('backup manifest', () {
    late Directory restoreDir;

    setUp(() async {
      restoreDir = await Directory.systemTemp.createTemp('restore-manifest');
    });

    tearDown(() async {
      await restoreDir.safeDelete(recursive: true);
    });

    Future<void> writeManifest(Object? manifest) async {
      await File(
        join(restoreDir.path, backupManifestName),
      ).writeAsString(json.encode(manifest));
    }

    Future<Map<String, Object?>> writeEntry(
      String path,
      String content, {
      String? sha256Hex,
    }) async {
      final file = File(join(restoreDir.path, path));
      await file.create(recursive: true);
      await file.writeAsString(content);
      return {
        'path': path,
        'sha256': sha256Hex ?? sha256.convert(utf8.encode(content)).toString(),
        'size': content.length,
      };
    }

    test('accepts a backup without a manifest', () async {
      await expectLater(verifyBackupManifest(restoreDir.path), completes);
    });

    test('accepts entries whose digests match', () async {
      final entry = await writeEntry('profiles/1.yaml', 'profile');
      await writeManifest({
        'version': backupManifestVersion,
        'entries': [entry],
      });
      await expectLater(verifyBackupManifest(restoreDir.path), completes);
    });

    test('rejects a digest mismatch', () async {
      final entry = await writeEntry(
        'profiles/1.yaml',
        'profile',
        sha256Hex: 'deadbeef',
      );
      await writeManifest({
        'version': backupManifestVersion,
        'entries': [entry],
      });
      await expectLater(
        verifyBackupManifest(restoreDir.path),
        throwsA(isA<String>()),
      );
    });

    test('rejects a listed file that is missing', () async {
      final entry = await writeEntry('profiles/1.yaml', 'profile');
      await File(join(restoreDir.path, 'profiles/1.yaml')).delete();
      await writeManifest({
        'version': backupManifestVersion,
        'entries': [entry],
      });
      await expectLater(
        verifyBackupManifest(restoreDir.path),
        throwsA(isA<String>()),
      );
    });

    test('rejects an escaping entry path', () async {
      await writeManifest({
        'version': backupManifestVersion,
        'entries': [
          {'path': '../escape.yaml', 'sha256': 'deadbeef', 'size': 1},
        ],
      });
      await expectLater(
        verifyBackupManifest(restoreDir.path),
        throwsA(isA<String>()),
      );
    });

    test('rejects a newer manifest version', () async {
      await writeManifest({
        'version': backupManifestVersion + 1,
        'entries': const [],
      });
      await expectLater(
        verifyBackupManifest(restoreDir.path),
        throwsA(isA<String>()),
      );
    });
  });

  group('atomic file replacement', () {
    late Directory root;

    setUp(() async {
      root = await Directory.systemTemp.createTemp('replace-config');
    });

    tearDown(() async {
      await root.safeDelete(recursive: true);
    });

    test('keeps the previous content when the caller rolls back', () async {
      final path = join(root.path, 'config.yaml');
      await File(path).writeAsString('previous');

      final replacement = await replaceFileAtomically(path, 'next');
      expect(replacement.hasPrevious, isTrue);
      expect(await File(path).readAsString(), 'next');

      await replacement.rollback();
      expect(await File(path).readAsString(), 'previous');
      expect(root.listSync().map((item) => basename(item.path)).toList(), [
        'config.yaml',
      ]);
    });

    test('removes a newly created file when the caller rolls back', () async {
      final path = join(root.path, 'nested', 'config.yaml');

      final replacement = await replaceFileAtomically(path, 'next');
      expect(replacement.hasPrevious, isFalse);
      expect(await File(path).readAsString(), 'next');

      await replacement.rollback();
      expect(await File(path).exists(), isFalse);
    });

    test('drops the backup once the caller commits', () async {
      final path = join(root.path, 'config.yaml');
      await File(path).writeAsString('previous');

      final replacement = await replaceFileAtomically(path, 'next');
      await replacement.commit();

      expect(await File(path).readAsString(), 'next');
      expect(root.listSync().map((item) => basename(item.path)).toList(), [
        'config.yaml',
      ]);
    });
  });

  group('database snapshot', () {
    late Database store;

    setUp(() {
      store = Database(NativeDatabase.memory());
    });

    tearDown(() async {
      await store.close();
    });

    test('restores the previous rows after a failed restore', () async {
      const previousProfile = Profile(
        id: 1,
        label: 'Previous',
        autoUpdateDuration: Duration.zero,
      );
      const previousNode = ProxyNode(
        id: 100,
        displayName: 'Previous',
        type: 'socks',
        config: {'name': 'Previous', 'type': 'socks', 'server': 'OLD_HOST'},
        fingerprint: 'previous',
      );
      await store.profilesDao.putAll([previousProfile.toCompanion()]);
      await store.restore(
        const [],
        const [],
        const [],
        const [],
        const [],
        proxyNodes: const [previousNode],
        proxyNodeBindings: const [ProxyNodeBinding(profileId: 1, nodeId: 100)],
      );
      final snapshot = await store.snapshot();

      const restoredNode = ProxyNode(
        id: 200,
        displayName: 'Restored',
        type: 'socks',
        config: {'name': 'Restored', 'type': 'socks', 'server': 'NEW_HOST'},
        fingerprint: 'restored',
      );
      await store.restore(
        const [],
        const [],
        const [],
        const [],
        const [],
        proxyNodes: const [restoredNode],
        isOverride: true,
      );
      expect((await store.proxyNodesDao.query().get()).map((item) => item.id), [
        200,
      ]);

      await store.restoreSnapshot(snapshot);
      expect((await store.proxyNodesDao.query().get()).map((item) => item.id), [
        100,
      ]);
      expect(
        (await store.proxyNodeBindingsDao.query(1).get()).map(
          (item) => item.nodeId,
        ),
        [100],
      );
      expect(
        (await store.profilesDao.query().get()).map((item) => item.label),
        ['Previous'],
      );
    });
  });
}
