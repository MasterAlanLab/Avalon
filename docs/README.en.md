# Avalon

A proxy client for Android, Windows, macOS, and Linux, powered by [mihomo](https://github.com/MetaCubeX/mihomo). Supports standalone nodes, subscription management, and multi-hop proxy chains. Built with Flutter.

> Avalon is based on [FlClash](https://github.com/chen08209/FlClash).

Download the package for your platform from [Releases](https://github.com/MasterAlanLab/Avalon/releases).

## Features

- Protocol support: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, HTTP(S), and more.
- Node management: manage individual nodes independently, with options to add, edit, duplicate, and bind them to profiles.
- Subscriptions: import profiles from URLs or local files, with automatic subscription updates.
- Proxy chains: combine nodes, proxy groups, and local proxy endpoints, with support for pre-proxies, multi-hop connections, and path previews.
- Profile generation: create ready-to-use profiles from chains, or add chains to proxy groups in existing profiles.
- Import and export: support for node URIs, QR codes, YAML / JSON, and packaged exports of nodes and chains with their attachments.
- Routing rules: Rule, Global, and Direct modes, with editable routing rules and proxy groups.
- Network diagnostics: node latency tests, live connection monitoring, and runtime logs.
- Data sync: local backup and restore, with WebDAV synchronization.
- Themes: desktop and mobile layouts, dark mode, and custom colors.

## Operating Modes

| Mode | Description |
| :--- | :--- |
| Rule | Select outbound routes according to the profile's rules |
| Global | Send all traffic entering the core through the outbound selected in the global proxy group |
| Direct | Connect directly to the destination without a proxy node |

Traffic can enter through the system proxy or TUN. The system proxy serves applications that follow the system settings; TUN captures traffic through a virtual network interface and routes it according to the selected mode.

## Core Engine

[mihomo](https://github.com/MetaCubeX/mihomo) handles proxy connections, DNS resolution, rule-based routing, and TUN traffic. In addition to protocol-specific forms, Raw YAML / JSON can be used to configure other mihomo node types.

Subscriptions, the node library, and proxy chains are combined into a single runtime configuration. Chains use `dialer-proxy` to connect each hop in the order “client → pre-proxy → main node → post-proxy → destination,” within a single core instance.

## Build

```bash
git clone --recurse-submodules https://github.com/MasterAlanLab/Avalon.git
cd Avalon
flutter pub get
```

Building requires Flutter, Go, and Rust. CI currently uses Flutter 3.44.4 and Go 1.26.4. Platform commands and additional dependencies:

| Platform | Build command | Additional dependencies |
| :--- | :--- | :--- |
| Android | `dart setup.dart android` | Android SDK and NDK; set `ANDROID_NDK` |
| Windows | `dart setup.dart windows` | Visual Studio C++ toolchain, GCC, Inno Setup |
| macOS | `dart setup.dart macos` | Xcode, CocoaPods, Node.js / npm |
| Linux | `dart setup.dart linux` | The script installs GTK, AppIndicator, Keybinder, and other dependencies through apt |

Build desktop packages on the corresponding operating system. Output is saved to `dist/`. See the [build workflow](../.github/workflows/build.yaml) for the full environment configuration.

## Tests

```bash
# Static analysis
flutter analyze --no-fatal-infos

# Unit and widget tests
flutter test

# Go core wrapper tests
(cd core && go test .)

# Rust component tests
cargo test --manifest-path services/helper/Cargo.toml
cargo test --manifest-path plugins/rust_api/rust/Cargo.toml
```

## Tech Stack

- Languages: Dart, Go, Rust
- UI framework: Flutter / Material Design
- State management: Riverpod
- Database: SQLite / Drift
- Proxy core: mihomo
- Package management: Pub, Go Modules, Cargo

## Recommended Resources

Some links are affiliate links. The author may earn a commission when you register or purchase through them. Service details and prices are listed on the respective websites.

| Category | Project / Service | Description |
| :--- | :--- | :--- |
| Proxy pool | [Free Proxy](https://github.com/MasterAlanLab/free-proxy) | Self-hosted proxy pool for use with the node library or proxy chains |
| VPS | [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) | Node and application hosting |
| Virtual credit cards | [International virtual cards](https://cutt.ly/IyrMR4Mg) | Payments for international services |
| Resource search | [Telegram search bot](https://cutt.ly/2yeh3GOE) | Find resources on Telegram |
| Accounts and SIM cards | [International accounts and SIM cards](https://cutt.ly/dywt86NC) | Account and communication services |
| Fingerprint browser | [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) | Manage isolated browser environments |
| Email hosting | [Emailbox](https://github.com/MasterAlanLab/emailbox) | Bulk email management and proxy grouping |
| CAPTCHA services | [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0) | CAPTCHA recognition |
| AI APIs | [CC / GPT relay](https://cutt.ly/JywJG3G5) | Model API services |
| Subscription sharing | [Subscription-sharing platform](https://cutt.ly/5ywt8vb4) | Shared subscriptions |

## License

[AGPL-3.0](../LICENSE). Third-party code retains its respective licenses. See [NOTICE](../NOTICE) for copyright and licensing information.

## Acknowledgments

- [FlClash](https://github.com/chen08209/FlClash)
- [mihomo](https://github.com/MetaCubeX/mihomo)
- [Surfboard](https://github.com/getsurfboard/surfboard)
