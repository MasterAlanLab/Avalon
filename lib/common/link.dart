import 'dart:async';

import 'package:app_links/app_links.dart';

import 'print.dart';

typedef InstallConfigCallBack = void Function(String url);

class LinkManager {
  static LinkManager? _instance;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? subscription;
  List<String> _startupArguments = const [];
  int _listenGeneration = 0;
  bool _initialLinkResolved = false;
  String? _streamLinkBeforeInitial;
  final Set<String> _startupLinks = {};
  final Set<String> _startupArgumentLinks = {};
  final Set<String> _initialStreamLinks = {};

  LinkManager._internal() {
    _appLinks = AppLinks();
  }

  void setStartupArguments(Iterable<String> arguments) {
    _startupArguments = arguments.toList(growable: false);
  }

  Future<void> initAppLinksListen(
    Function(String url) installConfigCallBack,
  ) async {
    commonPrint.log('initAppLinksListen');
    destroy();
    final generation = _listenGeneration;
    _initialLinkResolved = false;
    _streamLinkBeforeInitial = null;
    _startupLinks.clear();
    _startupArgumentLinks.clear();
    _initialStreamLinks.clear();
    subscription = _appLinks.uriLinkStream.listen((uri) {
      if (generation != _listenGeneration) return;
      final link = uri.toString();
      if (!_initialLinkResolved) {
        if (_streamLinkBeforeInitial == link || _startupLinks.contains(link)) {
          return;
        }
        _streamLinkBeforeInitial = link;
        _startupLinks.add(link);
      } else if (_initialStreamLinks.remove(link)) {
        return;
      }
      _dispatch(link, installConfigCallBack);
    });

    for (final argument in _startupArguments) {
      final link = _normalizeIncomingLink(argument);
      if (link == null || !_startupLinks.add(link)) continue;
      _startupArgumentLinks.add(link);
      _dispatch(link, installConfigCallBack);
    }
    _startupArguments = const [];

    Uri? initialLink;
    try {
      initialLink = await _appLinks.getInitialLink();
    } catch (error) {
      commonPrint.log('getInitialLink failed: $error');
    }
    if (generation != _listenGeneration) return;
    _initialLinkResolved = true;
    _initialStreamLinks.addAll(_startupArgumentLinks);
    if (initialLink != null) {
      final link = initialLink.toString();
      if (!_startupLinks.contains(link)) {
        _startupLinks.add(link);
        _initialStreamLinks.add(link);
        _dispatch(link, installConfigCallBack);
      }
    }
  }

  void destroy() {
    _listenGeneration++;
    subscription?.cancel();
    subscription = null;
  }

  void _dispatch(String value, InstallConfigCallBack callback) {
    final link = _normalizeIncomingLink(value);
    if (link == null) return;
    final uri = Uri.tryParse(link);
    if (uri == null) return;
    commonPrint.log('onAppLink: $link');
    if (uri.host == 'install-config') {
      final url = uri.queryParameters['url'];
      if (url != null && url.isNotEmpty) callback(url);
      return;
    }
    if (uri.host == 'import-node') {
      final data = uri.queryParameters['data'] ?? uri.queryParameters['value'];
      if (data != null && data.isNotEmpty) callback(data);
      return;
    }
    if (_nodeSchemes.contains(uri.scheme.toLowerCase())) callback(link);
  }

  String? _normalizeIncomingLink(String value) {
    final link = value.trim();
    if (link.isEmpty) return null;
    final normalized = link.replaceAll(RegExp(r'\\(?=[:@?#&=])'), '');
    return Uri.tryParse(normalized) == null ? null : normalized;
  }

  factory LinkManager() {
    _instance ??= LinkManager._internal();
    return _instance!;
  }
}

const _nodeSchemes = {
  'vless',
  'vmess',
  'ss',
  'trojan',
  'hysteria2',
  'hy2',
  'tuic',
  'anytls',
  'socks',
  'socks5',
  'socks4',
  'socks4a',
};

final linkManager = LinkManager();
