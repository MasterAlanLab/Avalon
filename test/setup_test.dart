import 'package:test/test.dart';

import '../setup.dart' as setup;

void main() {
  group('setup.dart', () {
    test('parses -v as verbose mode', () {
      final results = setup.createSetupArgParser().parse(['android', '-v']);

      expect(results['verbose'], isTrue);
      expect(results.rest, ['android']);
    });

    test('accepts dev application environment', () {
      final results = setup.createSetupArgParser().parse([
        'android',
        '--env',
        'dev',
      ]);

      expect(results['env'], 'dev');
    });

    test('Flutter build environment does not depend on Core SHA256', () {
      expect(setup.createBuildEnvironment('dev'), {'APP_ENV': 'dev'});
    });

    test('omits verbose from flutter build args by default', () {
      final args = setup.createFlutterBuildArgs(
        platform: 'android',
        verbose: false,
      );

      expect(args, ['dart-define-from-file=env.json', 'split-per-abi']);
    });

    test('packaging environment only carries the Android arch by default', () {
      expect(setup.createPackagingEnvironment(androidArch: 'arm64'), {
        'ANDROID_ARCH': 'arm64',
      });
      expect(setup.createPackagingEnvironment(), isEmpty);
    });

    test('packaging environment puts the hdiutil shim first on PATH', () {
      final env = setup.createPackagingEnvironment(
        hdiutilShimDir: '/repo/tool/macos_hdiutil_shim',
        parentPath: '/usr/bin:/bin',
      );

      expect(env['PATH'], '/repo/tool/macos_hdiutil_shim:/usr/bin:/bin');
    });

    test('packaging environment keeps a PATH without a parent PATH', () {
      final env = setup.createPackagingEnvironment(
        hdiutilShimDir: '/repo/tool/macos_hdiutil_shim',
      );

      expect(env['PATH'], '/repo/tool/macos_hdiutil_shim');
    });

    test('adds verbose to flutter build args with -v', () {
      final args = setup.createFlutterBuildArgs(
        platform: 'android',
        verbose: true,
      );

      expect(args, [
        'verbose',
        'dart-define-from-file=env.json',
        'split-per-abi',
      ]);
    });
  });
}
