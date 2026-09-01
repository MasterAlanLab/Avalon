<div align="center">
  <img src="../tool/branding/icon.svg" width="144" height="144" alt="Avalon Gate icon">
  <h1>Avalon</h1>
  <p><strong>Route · Connect · Control</strong></p>
  <p>
    <a href="https://github.com/MasterAlanLab/avalon/releases"><img src="https://img.shields.io/github/v/release/MasterAlanLab/avalon?display_name=tag&amp;style=flat-square&amp;label=Release&amp;color=E3A72F" alt="Latest release"></a>
    <a href="https://github.com/MasterAlanLab/avalon/actions/workflows/build.yaml"><img src="https://img.shields.io/github/actions/workflow/status/MasterAlanLab/avalon/build.yaml?style=flat-square&amp;label=Build&amp;color=4E9B76" alt="Build status"></a>
    <a href="../LICENSE"><img src="https://img.shields.io/badge/License-AGPL--3.0-17191D?style=flat-square" alt="AGPL-3.0 license"></a>
    <img src="https://img.shields.io/badge/Platforms-Android%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-777D85?style=flat-square" alt="Supported platforms">
  </p>
</div>

Ein Proxy-Client für Android, Windows, macOS und Linux auf Basis von [mihomo](https://github.com/MetaCubeX/mihomo). Unterstützt eigenständige Knoten, Abonnementverwaltung und mehrstufige Proxy-Ketten. Mit Flutter entwickelt.

> Avalon basiert auf [FlClash](https://github.com/chen08209/FlClash).

Das Installationspaket für die jeweilige Plattform steht unter [Releases](https://github.com/MasterAlanLab/avalon/releases) bereit.

## Funktionen

- Protokollunterstützung: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, HTTP(S) und weitere.
- Knotenverwaltung: einzelne Knoten unabhängig verwalten, hinzufügen, bearbeiten, duplizieren und mit Profilen verknüpfen.
- Abonnements: Profile über URLs oder lokale Dateien importieren, mit automatischer Aktualisierung von Abonnements.
- Proxy-Ketten: Knoten, Proxy-Gruppen und lokale Proxy-Endpunkte kombinieren; mit vorgeschalteten Proxys, mehrstufigen Verbindungen und Pfadvorschau.
- Profilerstellung: direkt nutzbare Profile aus Ketten erzeugen oder Ketten zu Proxy-Gruppen bestehender Profile hinzufügen.
- Import und Export: Knoten-URIs, QR-Codes und YAML / JSON; Knoten und Ketten lassen sich zusammen mit ihren Anhängen als Paket exportieren.
- Routing-Regeln: Rule-, Global- und Direct-Modus sowie bearbeitbare Routing-Regeln und Proxy-Gruppen.
- Netzwerkdiagnose: Latenztests für Knoten, laufende Verbindungsübersicht und Laufzeitprotokolle.
- Datensynchronisierung: lokale Sicherung und Wiederherstellung sowie Synchronisierung über WebDAV.
- Darstellung: Desktop- und Mobilansichten, Dunkelmodus und anpassbare Farben.

## Betriebsmodi

| Modus | Beschreibung |
| :--- | :--- |
| Rule | Ausgehende Verbindungen anhand der Regeln im Profil auswählen |
| Global | Den gesamten beim Kern eingehenden Datenverkehr über die in der globalen Proxy-Gruppe gewählte Verbindung leiten |
| Direct | Ziele direkt und ohne Proxy-Knoten verbinden |

Der Datenverkehr wird über den Systemproxy oder TUN eingebunden. Der Systemproxy bedient Anwendungen, die den Systemeinstellungen folgen. TUN übernimmt den Datenverkehr über eine virtuelle Netzwerkschnittstelle und leitet ihn gemäß dem gewählten Modus weiter.

## Kern-Engine

[mihomo](https://github.com/MetaCubeX/mihomo) übernimmt Proxy-Verbindungen, DNS-Auflösung, regelbasiertes Routing und TUN-Datenverkehr. Neben protokollspezifischen Formularen steht Raw YAML / JSON zur Konfiguration weiterer mihomo-Knotentypen zur Verfügung.

Abonnements, Knotenbibliothek und Proxy-Ketten werden zu einer gemeinsamen Laufzeitkonfiguration zusammengeführt. Ketten verbinden ihre Stationen über `dialer-proxy` in der Reihenfolge „Client → vorgeschalteter Proxy → Hauptknoten → nachgeschalteter Proxy → Ziel“ und laufen in einer einzigen Kerninstanz.

## Build

```bash
git clone --recurse-submodules https://github.com/MasterAlanLab/avalon.git
cd avalon
flutter pub get
```

Für den Build werden Flutter, Go und Rust benötigt. Die CI verwendet derzeit Flutter 3.44.4 und Go 1.26.4. Befehle und zusätzliche Abhängigkeiten je Plattform:

| Plattform | Build-Befehl | Zusätzliche Abhängigkeiten |
| :--- | :--- | :--- |
| Android | `dart setup.dart android` | Android SDK und NDK; `ANDROID_NDK` setzen |
| Windows | `dart setup.dart windows` | Visual Studio C++-Toolchain, GCC, Inno Setup |
| macOS | `dart setup.dart macos` | Xcode, CocoaPods, Node.js / npm |
| Linux | `dart setup.dart linux` | Das Skript installiert GTK, AppIndicator, Keybinder und weitere Abhängigkeiten über apt |

Desktop-Pakete werden auf dem jeweiligen Betriebssystem erstellt. Die Ausgabe liegt in `dist/`. Die vollständige Umgebungskonfiguration steht im [Build-Workflow](../.github/workflows/build.yaml).

## Tests

```bash
# Statische Analyse
flutter analyze --no-fatal-infos

# Unit- und Widget-Tests
flutter test

# Tests des Go-Core-Wrappers
(cd core && go test .)

# Tests der Rust-Komponenten
cargo test --manifest-path services/helper/Cargo.toml
cargo test --manifest-path plugins/rust_api/rust/Cargo.toml
```

## Technologie-Stack

- Sprachen: Dart, Go, Rust
- UI-Framework: Flutter / Material Design
- Zustandsverwaltung: Riverpod
- Datenbank: SQLite / Drift
- Proxy-Kern: mihomo
- Paketverwaltung: Pub, Go Modules, Cargo

## Empfohlene Ressourcen

Einige Links sind Affiliate-Links. Bei einer Registrierung oder einem Kauf darüber kann der Autor eine Provision erhalten. Leistungsumfang und Preise stehen auf den jeweiligen Websites.

| Kategorie | Projekt / Dienst | Beschreibung |
| :--- | :--- | :--- |
| Proxy-Pool | [Free Proxy](https://github.com/MasterAlanLab/free-proxy) | Selbst gehosteter Proxy-Pool für die Knotenbibliothek oder Proxy-Ketten |
| VPS | [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) | Hosting von Knoten und Anwendungen |
| Virtuelle Kreditkarten | [Internationale virtuelle Karten](https://cutt.ly/IyrMR4Mg) | Zahlungen für internationale Dienste |
| Ressourcensuche | [Telegram-Suchbot](https://cutt.ly/2yeh3GOE) | Ressourcen auf Telegram finden |
| Konten und SIM-Karten | [Internationale Konten und SIM-Karten](https://cutt.ly/dywt86NC) | Konto- und Kommunikationsdienste |
| Fingerprint-Browser | [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) | Getrennte Browserumgebungen verwalten |
| E-Mail-Hosting | [Emailbox](https://github.com/MasterAlanLab/emailbox) | Massenverwaltung von E-Mail-Konten und Proxy-Gruppierung |
| CAPTCHA-Dienste | [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0) | CAPTCHA-Erkennung |
| KI-APIs | [CC / GPT-Relay](https://cutt.ly/JywJG3G5) | Modell-API-Dienste |
| Abo-Sharing | [Plattform für Abo-Sharing](https://cutt.ly/5ywt8vb4) | Gemeinsam genutzte Abonnements |

## Lizenz

[AGPL-3.0](../LICENSE). Drittanbietercode behält seine jeweiligen Lizenzen. Hinweise zu Urheberrecht und Lizenzen stehen in [NOTICE](../NOTICE).

## Danksagung

- [FlClash](https://github.com/chen08209/FlClash)
- [mihomo](https://github.com/MetaCubeX/mihomo)
- [Surfboard](https://github.com/getsurfboard/surfboard)
