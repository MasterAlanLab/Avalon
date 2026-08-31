import 'dart:io';

import 'package:avalon/common/constant.dart';
import 'package:avalon/common/request.dart';
import 'package:avalon/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    globalState.packageInfo = PackageInfo(
      appName: 'Avalon',
      packageName: 'com.masteralanlab.avalon',
      version: '0.8.0',
      buildNumber: '1',
    );
  });

  test(
    'all application links use the current project and Telegram account',
    () {
      expect(repository, 'MasterAlanLab/avalon');
      expect(projectUrl, 'https://github.com/MasterAlanLab/avalon');
      expect(telegramUrl, 'https://t.me/masteralanlab');
      expect(contributorsUrl, '$projectUrl/graphs/contributors');
      expect(coreSourceUrl, '$projectUrl/tree/main/core');
      expect(latestReleaseUrl, '$projectUrl/releases/latest');
      expect(
        latestReleaseApiUrl,
        'https://api.github.com/repos/MasterAlanLab/avalon/releases/latest',
      );
    },
  );

  test('package and installer metadata use the application project URL', () {
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
    final installer =
        loadYaml(
              File('windows/packaging/exe/make_config.yaml').readAsStringSync(),
            )
            as YamlMap;
    expect(pubspec['homepage'], projectUrl);
    expect(pubspec['repository'], projectUrl);
    expect(pubspec['issue_tracker'], '$projectUrl/issues');
    expect(installer['publisher_url'], projectUrl);
  });

  test('GitHub contact entry uses the application Telegram account', () {
    final config =
        loadYaml(File('.github/ISSUE_TEMPLATE/config.yml').readAsStringSync())
            as YamlMap;
    final contacts = (config['contact_links'] as YamlList).cast<YamlMap>();
    expect(contacts.map((contact) => contact['url']), contains(telegramUrl));
  });

  for (final (tag, hasUpdate) in [
    ('v0.9.0', true),
    ('v0.8.0', false),
    ('v0.7.0', false),
  ]) {
    test(
      'update check reads the current repository and compares $tag',
      () async {
        final client = Request();
        addTearDown(() => client.dio.close(force: true));
        final requests = <Uri>[];
        client.dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              requests.add(options.uri);
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 200,
                  data: {'tag_name': tag, 'body': '- Release note'},
                ),
              );
            },
          ),
        );

        final result = await client.checkForUpdate();

        expect(requests, [Uri.parse(latestReleaseApiUrl)]);
        expect(result?['tag_name'], hasUpdate ? tag : null);
      },
    );
  }
}
