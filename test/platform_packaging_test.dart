import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

String _read(String path) => File(path).readAsStringSync();

YamlMap _config(String path) => loadYaml(_read(path)) as YamlMap;

String _capture(String source, String pattern) =>
    RegExp(pattern, multiLine: true).firstMatch(source)!.group(1)!;

// Check every component, even on a case-insensitive development filesystem.
void _expectResource(String path) {
  final relative = p.normalize(path);
  expect(p.isRelative(relative), isTrue);
  var directory = Directory.current;
  for (final component in p.split(relative)) {
    expect(
      directory.listSync().map((entry) => p.basename(entry.path)),
      contains(component),
      reason: 'Missing or incorrectly capitalized resource: $path',
    );
    directory = Directory(p.join(directory.path, component));
  }
  expect(File(relative).existsSync(), isTrue);
}

void main() {
  final appName = _config('distribute_options.yaml')['app_name'] as String;

  group('Linux packaging', () {
    for (final format in ['deb', 'rpm', 'appimage']) {
      test('$format icon resolves from the project root', () {
        final config = _config('linux/packaging/$format/make_config.yaml');
        // All three makers read icon paths from the project working directory,
        // not from linux/packaging or the generated dist directory.
        _expectResource(config['icon'] as String);
      });
    }

    test('DEB package identifier follows Debian control field syntax', () {
      final config = _config('linux/packaging/deb/make_config.yaml');
      // Debian Policy 5.6.1: lowercase, at least two characters, alphanumeric
      // first character. This is independent of the display/executable name.
      expect(config['package_name'], matches(r'^[a-z0-9][a-z0-9+.-]+$'));
    });

    test('packaging name matches the CMake executable name', () {
      final binaryName = _capture(
        _read('linux/CMakeLists.txt'),
        r'set\(BINARY_NAME\s+"([^"]+)"\)',
      );
      // AppImage uses app_name in AppRun; DEB/RPM read BINARY_NAME from CMake.
      expect(appName, binaryName);
    });
  });

  group('macOS packaging', () {
    final productName = _capture(
      _read('macos/Runner/Configs/AppInfo.xcconfig'),
      r'^PRODUCT_NAME\s*=\s*(\S+)\s*$',
    );
    final project = _read('macos/Runner.xcodeproj/project.pbxproj');

    test('DMG content resolves beside the generated configuration', () {
      final config = _config('macos/packaging/dmg/make_config.yaml');
      final contents = (config['contents'] as YamlList).cast<YamlMap>();
      final app = contents.singleWhere((entry) => entry['type'] == 'file');
      // The DMG maker stages the .app beside make_config.json, rather than
      // resolving this path against the repository root.
      expect(app['path'], '$productName.app');
      expect(appName, productName);
      final applications = contents.singleWhere(
        (entry) => entry['type'] == 'link',
      );
      expect(applications['path'], '/Applications');
      for (final key in ['icon', 'background']) {
        if (config[key] != null) {
          _expectResource(p.join('macos/packaging/dmg', config[key] as String));
        }
      }
    });

    test('Xcode product and scheme use the actual bundle name', () {
      expect(project, contains('path = $productName.app;'));
      final scheme = _read(
        'macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme',
      );
      final bundles = RegExp(
        r'BuildableName\s*=\s*"([^"]+\.app)"',
      ).allMatches(scheme).map((match) => match.group(1));
      expect(bundles, isNotEmpty);
      expect(bundles, everyElement('$productName.app'));
    });

    test('all native test hosts match the product name including case', () {
      final hosts = RegExp(
        r'TEST_HOST\s*=\s*"([^"]+)";',
      ).allMatches(project).map((match) => match.group(1));
      final expected =
          '\$(BUILT_PRODUCTS_DIR)/$productName.app/'
          '\$(BUNDLE_EXECUTABLE_FOLDER_PATH)/$productName';
      expect(hosts, hasLength(3)); // Debug, Release, Profile.
      expect(hosts, everyElement(expected));
    });

    test('every app icon catalog entry has a matching resource', () {
      const directory = 'macos/Runner/Assets.xcassets/AppIcon.appiconset';
      final catalog = jsonDecode(_read('$directory/Contents.json')) as Map;
      final images = catalog['images'] as List;
      expect(images, isNotEmpty);
      for (final entry in images.cast<Map>()) {
        _expectResource(p.join(directory, entry['filename'] as String));
      }
    });
  });

  group('Android packaging', () {
    final gradle = _read('android/app/build.gradle.kts');

    test('Flutter source resolves from the app module to the project', () {
      final source = _capture(gradle, r'flutter\s*\{\s*source\s*=\s*"([^"]+)"');
      final project = p.normalize(p.join('android/app', source));
      expect(project, '.');
      _expectResource(p.join(project, 'pubspec.yaml'));
    });

    test('CI signing outputs match Gradle input paths', () {
      final workflow = _read('.github/workflows/build.yaml');
      final keystore = _capture(
        gradle,
        r'releaseStoreFile\s*=\s*file\("([^"]+)"\)',
      );
      final properties = _capture(gradle, r'rootProject\.file\("([^"]+)"\)');
      final ciKeystore = _capture(workflow, r'base64 --decode > (\S+)');
      final ciProperties = _capture(workflow, r'\}\s*>> (\S+)');
      expect(
        p.posix.normalize(p.posix.join('android/app', keystore)),
        ciKeystore,
      );
      expect(
        p.posix.normalize(p.posix.join('android', properties)),
        ciProperties,
      );
    });

    test('release ProGuard rules exist relative to the app module', () {
      final rules = _capture(gradle, r'"([^"\r\n]+\.pro)"');
      _expectResource(p.join('android/app', rules));
    });
  });
}
