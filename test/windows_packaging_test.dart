import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  final config =
      loadYaml(
            File('windows/packaging/exe/make_config.yaml').readAsStringSync(),
          )
          as YamlMap;
  final options =
      loadYaml(File('distribute_options.yaml').readAsStringSync()) as YamlMap;
  final template = File(
    p.join('windows/packaging/exe', config['script_template'] as String),
  ).readAsStringSync();

  group('Windows installer packaging', () {
    for (final workspace in [r'D:\a\Avalon\Avalon', r'C:\build jobs\Avalon']) {
      test('installer icon resolves from the project root: $workspace', () {
        final icon = config['setup_icon_file'] as String;
        // MakeExeConfig.fromJson joins setup_icon_file to Directory.current.
        final resolved = p.windows.normalize(p.windows.join(workspace, icon));

        expect(
          resolved,
          p.windows.join(
            workspace,
            'windows',
            'runner',
            'resources',
            'app_icon.ico',
          ),
        );
        expect(
          File(p.joinAll(p.windows.split(icon))).existsSync(),
          isTrue,
          reason: 'The installer icon must exist in the checkout.',
        );
      });

      for (final arch in ['amd64', 'arm64']) {
        test('custom locales resolve from the $arch script: $workspace', () {
          // The packager writes <output>/<package>/_exe.iss. Locale paths
          // reach Inno Setup unchanged and are relative to that script.
          final scriptDirectory = p.windows.join(
            workspace,
            options['output'] as String,
            'Avalon-test-windows-$arch-setup',
          );
          final locales = (config['locales'] as YamlList).cast<YamlMap>();
          final chinese = locales.singleWhere(
            (locale) => locale['lang'] == 'zh',
          );
          final localePath = chinese['file'] as String;
          final resolved = p.windows.normalize(
            p.windows.join(scriptDirectory, localePath),
          );

          expect(
            resolved,
            p.windows.join(
              workspace,
              'windows',
              'packaging',
              'exe',
              'ChineseSimplified.isl',
            ),
          );
          final relative = p.windows.relative(resolved, from: workspace);
          expect(
            File(p.joinAll(p.windows.split(relative))).existsSync(),
            isTrue,
            reason: 'The custom language file must exist in the checkout.',
          );
        });
      }
    }

    test(
      'custom language filenames are quoted for paths containing spaces',
      () {
        expect(
          template,
          contains('MessagesFile: {% if locale.file %}"{{ locale.file }}"'),
        );
      },
    );
  });
}
