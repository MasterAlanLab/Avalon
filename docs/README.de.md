**🌐 Languages:** [中文](../README.md) · [English](README.en.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [العربية](README.ar.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

# Avalon — Ein plattformübergreifender Proxy-Client mit Einzelknoten und Proxy-Ketten

> Avalon ist ein Fork von [FlClash](https://github.com/chen08209/FlClash) und nutzt den mihomo-Kern (Clash.Meta). Zusätzlich zum bisherigen Abo-basierten Workflow bietet Avalon eine **eigenständige Knotenbibliothek** und **mehrstufige Proxy-Ketten**: Einzelne Knoten für VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5 oder HTTP(S) lassen sich separat anlegen und zu einem Pfad `Client → Vorstufe → Hauptknoten → Nachstufe → Ziel` verketten – alles innerhalb **einer einzigen Kern-Instanz**, ohne einen zweiten Prozess zu starten.

> ⚠️ **Dieses Projekt dient ausschließlich dem Lernen, der Forschung und dem technischen Austausch. Jede illegale Nutzung ist strikt untersagt.** Nutzerinnen und Nutzer müssen die Gesetze ihres Landes bzw. ihrer Region einhalten und tragen die volle Verantwortung für die Verwendung dieser Software. Siehe [Haftungsausschluss](#haftungsausschluss).

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="../LICENSE"><img alt="License" src="https://img.shields.io/badge/License-AGPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/Plattformen-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/Zweck-Nur%20Lernen%20%26%20Forschung-orange?style=flat-square">
</p>

Technische Hintergründe, Praxiserfahrungen und Produkt-Updates teile ich hier:

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

Desktop:

<p style="text-align: center;">
    <img alt="desktop" src="../snapshots/desktop.gif">
</p>

Mobil:

<p style="text-align: center;">
    <img alt="mobile" src="../snapshots/mobile.gif">
</p>

---

## Was Avalon gegenüber FlClash ergänzt

### 1. Eigenständige Knotenbibliothek (Einzelknoten-Unterstützung)

Ein Abonnement ist keine Voraussetzung mehr, um einen Knoten zu nutzen. Knoten sind globale Objekte und lassen sich einzeln anlegen, bearbeiten, gruppieren und binden:

- **Protokollspezifische Formulare und URI-Import**: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5 sowie HTTP(S) mit explizitem Port oder Zugangsdaten.
- **Raw-YAML-/JSON-Knoten**: decken **alle** von mihomo unterstützten Proxy-Typen ab, auch solche, für die es noch kein eigenes Formular gibt. Raw-Knoten lassen sich ebenso speichern, binden, in Ketten verwenden und exportieren.
- **Mehrere Eingabewege**: URI einfügen, QR-Code scannen, System-URL-Schema öffnen oder Formular ausfüllen.
- **Abos und Einzelknoten nebeneinander**: Eine einfache `http(s)://`-Adresse wird als Abo synchronisiert, eine Adresse mit explizitem Port, Zugangsdaten oder Proxy-Parametern als Einzelknoten geparst. Mehrdeutige Eingaben können über den Raw-Editor verarbeitet werden.
- **Export**: Knoten und Ketten lassen sich als Clash-Konfiguration oder JSON exportieren.

### 2. Proxy-Ketten (Multi-Hop / vorgeschalteter Proxy)

- Darstellung und Verbindungsrichtung sind fest als **Client → Vorstufe → Hauptknoten → Nachstufe → Ziel** definiert; die Listenreihenfolge ist zugleich die Verschachtelungsreihenfolge.
- Jeder Hop kann ein Knoten, eine globale Policy-Gruppe, eine Gruppe des aktuellen Abos oder ein **bereits vorhandener lokaler SOCKS-/HTTP-/HTTPS-Endpunkt** sein (etwa ein Port, den ein anderer Client auf demselben Rechner geöffnet hat).
- Beim Kompilieren zeigt der `dialer-proxy` jedes Hops auf den vorherigen Hop, sodass **eine Konfiguration und ein Kern-Lebenszyklus** entstehen. Eine Kette mit nur einem Hop verhält sich wie die direkte Nutzung dieses Knotens.
- Eine Policy-Gruppe als Hop expandiert zu einer Verzweigungsmatrix; das Standardlimit liegt bei 64 Pfaden (einstellbar von 1 bis 1024), und Pfadanzahl sowie Diagnosen werden vor dem Speichern live angezeigt.
- Ketten sind globale Objekte: kopierbar, umbenennbar, sortierbar, und mehrere Abos können dieselbe Kette binden. Diagnosen der Stufe `error` verhindern die Übernahme in die Laufzeitkonfiguration, `warning` erfordert eine Bestätigung.
- Beim Binden wählst du ausdrücklich die *Eingangsgruppen*: Der erzeugte Ketten-Selector wird an diese Policy-Gruppen angehängt, die ursprüngliche Auswahl des Abos bleibt unverändert.

### 3. Übernommen aus FlClash

✈️ Plattformübergreifend: Android, Windows, macOS und Linux

💻 Passt sich vielen Bildschirmgrößen an, mehrere Farbthemen

💡 Material-You-Design mit einer [Surfboard](https://github.com/getsurfboard/surfboard)-ähnlichen Oberfläche

☁️ Datensynchronisierung über WebDAV

✨ Abo-Import mit einem Klick, Dunkelmodus

---

## Installation

### Download

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="../snapshots/get-it-on-github.svg" width="200px"/></a>

### Linux-Abhängigkeiten

⚠️ Vor der Nutzung bitte folgende Pakete installieren:

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### Android-Broadcast-Aktionen

Folgende Aktionen werden unterstützt:

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## Schnellstart

1. **Konfiguration hinzufügen**: Abo-Link unter „Abos“ einfügen oder unter „Knoten“ direkt eine URI wie `vless://`, `anytls://`, `socks5://` einfügen bzw. per QR-Code importieren.
2. **Kette bauen** (optional): Unter „Ketten“ Knoten oder Policy-Gruppen in der Reihenfolge Vorstufe → Hauptknoten → Nachstufe anordnen und vor dem Speichern Pfadanzahl und Diagnosen prüfen.
3. **Binden und starten**: Kette an das aktuelle Abo binden, Eingangsgruppen auswählen und auf der Startseite starten. Abos ohne gebundene Kette verhalten sich unverändert.

---

## Build

1. Submodule aktualisieren

   ```bash
   git submodule update --init --recursive
   ```

2. `Flutter`- und `Golang`-Umgebung installieren

3. Anwendung bauen

    - android

        1. `Android SDK` und `Android NDK` installieren

        2. Umgebungsvariable `ANDROID_NDK` setzen

        3. Build-Skript ausführen

           ```bash
           dart setup.dart android
           ```

    - windows

        1. Erfordert einen Windows-Rechner

        2. `GCC` und `Inno Setup` installieren

        3. Build-Skript ausführen

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. Erfordert einen Linux-Rechner

        2. Abhängigkeiten installiert das Setup-Skript automatisch, manuell geht es so:

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. Build-Skript ausführen

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. Erfordert einen macOS-Rechner

        2. Build-Skript ausführen

           ```bash
           dart setup.dart macos
           ```

---

## Empfohlene Ressourcen

Dienste, die ich selbst nutze oder die gut zu diesem Projekt passen. Einige Links sind Werbe- bzw. Affiliate-Links: Eine Registrierung oder Bestellung darüber kann dem Autor eine kleine Provision einbringen – **ohne Mehrkosten für dich**.

- **Eigener Proxy-Pool**: [Free Proxy](https://github.com/MasterAlanLab/free-proxy) — betreibt auf deinem eigenen VPS einen kostenlosen Knotenpool mit SOCKS5-/HTTP-Ausgang, den Avalon als Einzelknoten oder als einen Hop einer Kette verwenden kann
- **VPS mit China-optimierten Routen**: [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — für eigene Knoten oder Landing-Server
- **Virtuelle Kreditkarten**: [hier](https://cutt.ly/IyrMR4Mg) — zum Bezahlen ausländischer Dienste
- **Telegram-Suchbot für Ressourcen**: [hier](https://cutt.ly/2yeh3GOE)
- **Auslandskonten und SIM-Karten**: [hier](https://cutt.ly/dywt86NC)
- **Anti-Detect-Browser**: [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — Umgebungstrennung zusätzlich zu verketteten Proxys
- **Massen-Postfachverwaltung**: [Emailbox](https://github.com/MasterAlanLab/emailbox) — Postfächer im Bulk verwalten, mit Proxys pro Gruppe
- **Captcha-Lösung**: [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **GPT-API-Relay**: [CC / GPT Relay](https://cutt.ly/JywJG3G5)
- **Geteilte Abos**: [hier](https://cutt.ly/5ywt8vb4)

---

## Haftungsausschluss

- Dieses Projekt dient **ausschließlich dem Lernen, der Forschung und dem technischen Austausch; jede illegale Nutzung ist strikt untersagt** – unter anderem das Eindringen in fremde Systeme, das Umgehen von Zugangsbeschränkungen, wo das lokale Recht dies verbietet, Netzwerkangriffe, die Verbreitung rechtswidriger Inhalte sowie jede andere strafbare Handlung.
- Nutzerinnen und Nutzer müssen die Gesetze ihres Landes bzw. ihrer Region einhalten. Alle Folgen der Nutzung trägt die nutzende Person; Autoren und Mitwirkende haften nicht für direkte oder indirekte Schäden.
- Dieses Projekt **stellt keine Proxy-Knoten oder Abo-Dienste bereit, verkauft und empfiehlt sie nicht** und gibt keine Garantie für Verfügbarkeit, Privatsphäre oder Sicherheit fremder Knoten. Übertrage niemals sensible Daten über Knoten unbekannter Herkunft.
- Ist Software dieser Art in deinem Land oder deiner Region verboten, beende die Nutzung sofort und lösche sie.
- Die oben genannten Links zu VPS, virtuellen Kreditkarten, Telegram-Bots und Ähnlichem sind Werbe- bzw. Affiliate-Links. Bestellungen darüber können dem Autor eine kleine Provision einbringen – **ohne Mehrkosten für dich**. Danke für die Unterstützung ❤️

---

## Lizenz

Die von Avalon verfassten Ergänzungen und Änderungen stehen unter **AGPL-3.0**. Der FlClash-Upstream, mihomo und andere Drittanbieter-Komponenten bleiben unter ihren jeweiligen Lizenzen. Die AGPL-Bedingungen stehen in [LICENSE](../LICENSE), der Upstream-GPLv3-Text in [LICENSE-GPL-3.0](../LICENSE-GPL-3.0) und die Hinweise zu Fork und Drittanbieter-Komponenten in [NOTICE](../NOTICE).

Avalon ist eine veränderte Fassung (Fork) von [FlClash](https://github.com/chen08209/FlClash):

- Das Urheberrecht am Originalwerk liegt bei den Autoren und Mitwirkenden von FlClash; alle ursprünglichen Copyright- und Lizenzhinweise bleiben erhalten.
- Dieses Projekt verändert das Originalwerk, im Wesentlichen durch die eigenständige Knotenbibliothek, die mehrstufigen Proxy-Ketten, die Ketten-Kompilierung in einem einzigen Kern sowie die geänderten Projekt- und Anwendungsbezeichner. Einen Überblick gibt [CHANGELOG.md](../CHANGELOG.md).
- Für Avalon-eigene Ergänzungen und Änderungen gilt AGPL-3.0; bei der Weiterverbreitung sind die Anforderungen an Quellcode und Netzwerkinteraktion sowie die genannten Hinweise einzuhalten.
- Avalon steht in **keiner Verbindung** zum Upstream-Projekt FlClash – bitte melde Probleme dieses Forks nicht dort.

## Danksagung

- [FlClash](https://github.com/chen08209/FlClash) — das Upstream-Projekt dieses Forks 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — der Proxy-Kern
- [Surfboard](https://github.com/getsurfboard/surfboard) — Referenz für das UI-Design

## Kontakt

- Telegram-Kanal: <https://t.me/MasterAlanLab_Channel>
- Geschäftliche Anfragen: <masteralanlab@gmail.com>

## Star

Der einfachste Weg, die Entwicklung zu unterstützen, ist ein Klick auf den Stern (⭐) oben auf der Seite.

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
