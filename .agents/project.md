# Project Context

Avalon is a multi-platform proxy client based on ClashMeta (mihomo), built with Flutter. It supports Android, Windows, macOS, and Linux, using a Material You design with Surfboard-like UI.

Avalon is a GPL-3.0 fork of [FlClash](https://github.com/chen08209/FlClash), branched at v0.8.96. On top
of upstream it adds a standalone node library (single nodes plus Raw records for every mihomo proxy type)
and multi-hop proxy chains compiled through `dialer-proxy` inside a single core. Contracts for both live in
`docs/tasks/`; attribution and the list of modifications live in `NOTICE`.

Identifiers: Dart package `avalon`, application id `com.masteralanlab.avalon`, executables `AvalonCore` and
`AvalonHelperService`, custom URL scheme `avalon://`.

## Version Notes

- Release CI pins Flutter 3.44.4. Local SDK may diverge, so trust the CI
  version as the source of truth for release builds.
- Dart SDK constraint: `>=3.8.0 <4.0.0`.

## Build Dependencies

Linux:

```bash
sudo apt-get install libayatana-appindicator3-dev libkeybinder-3.0-dev
```

Windows:

- GCC and Inno Setup.
- `ANDROID_NDK` env var for Android builds.

macOS:

```bash
npm install -g appdmg
```
