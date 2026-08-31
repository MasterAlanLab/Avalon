**🌐 Languages:** [中文](../README.md) · [English](README.en.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [العربية](README.ar.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

# Avalon — A Multi-Platform Proxy Client With Standalone Nodes and Proxy Chains

> Avalon is a fork of [FlClash](https://github.com/chen08209/FlClash), powered by the mihomo (Clash.Meta) core. On top of the original subscription-based workflow it adds a **standalone node library** and **multi-hop proxy chains**: you can add a single VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5 or HTTP(S) node on its own, then arrange nodes into a `client → prepend → main → append → target` path — all inside a **single core instance**, with no second process.

> ⚠️ **This project is provided for study, research and technical exchange only. Any illegal use is strictly prohibited.** Users must comply with the laws and regulations of their country or region and take full responsibility for how they use this software. See the [Disclaimer](#disclaimer).

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="../LICENSE"><img alt="License" src="https://img.shields.io/badge/License-GPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/Platforms-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/Purpose-Study%20%26%20Research%20Only-orange?style=flat-square">
</p>

I share the technical background, usage notes and product updates on these channels:

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

Desktop:

<p style="text-align: center;">
    <img alt="desktop" src="../snapshots/desktop.gif">
</p>

Mobile:

<p style="text-align: center;">
    <img alt="mobile" src="../snapshots/mobile.gif">
</p>

---

## What Avalon Adds on Top of FlClash

### 1. Standalone Node Library (Single-Node Support)

A subscription is no longer required before you can use a node. Nodes are global objects that can be added, edited, grouped and bound on their own:

- **Protocol-specific forms and URI import**: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, plus HTTP(S) URIs that carry an explicit port or credentials.
- **Raw YAML / JSON nodes**: cover **every** mihomo proxy type, including protocols the dedicated forms do not model yet. Raw nodes can still be saved, bound, used in chains and exported.
- **Several ways to add a node**: paste a URI, scan a QR code, open a system URL scheme, or fill in the form by hand.
- **Subscriptions and single nodes coexist**: a plain `http(s)://` address is synced as a subscription, while an address with an explicit port, credentials or proxy parameters is parsed as a single node. Ambiguous input can always go through the Raw editor.
- **Export**: nodes and chains can be exported as Clash config or JSON.

### 2. Proxy Chains (Multi-Hop / Upstream Proxy)

- The display and dial direction is fixed as **client → prepend → main → append → target**; the list order is the nesting order.
- Every hop can be a node, a global proxy group, a group from the current subscription, or an **existing local SOCKS / HTTP / HTTPS endpoint** (for example a port opened by another client on the same machine).
- At compile time each hop's `dialer-proxy` points at the previous hop, so the result is **one config and one core lifecycle**. A single-hop chain behaves exactly like using that node directly.
- A proxy group used as a hop expands into a branch matrix, with a default branch limit of 64 (configurable from 1 to 1024) and a live preview of path count and diagnostics before saving.
- Chains are global objects: copy, rename and reorder them, and bind one chain to several subscriptions. `error` level diagnostics block the chain from reaching the runtime config; `warning` level requires confirmation.
- When binding, you explicitly choose the *entry groups*: the generated chain selector is appended to those proxy groups, leaving the subscription's own selection untouched.

### 3. Everything Inherited From FlClash

✈️ Multi-platform: Android, Windows, macOS and Linux

💻 Adapts to many screen sizes, multiple color themes

💡 Material You design with a [Surfboard](https://github.com/getsurfboard/surfboard)-like UI

☁️ Data sync via WebDAV

✨ One-click subscription import, dark mode

---

## Install

### Download

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="../snapshots/get-it-on-github.svg" width="200px"/></a>

### Linux Dependencies

⚠️ Make sure the following dependencies are installed first:

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### Android Broadcast Actions

The following actions are supported:

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## Quick Start

1. **Add a configuration**: paste a subscription link under "Profiles", or paste a `vless://`, `anytls://`, `socks5://` … URI directly under "Nodes" — or import it by scanning a QR code.
2. **Build a chain** (optional): under "Chains", drag nodes or proxy groups into prepend → main → append order and check the path count and diagnostics before saving.
3. **Bind and start**: bind the chain to the current profile, pick the entry groups, then start from the home page. Profiles without a bound chain keep their original behavior.

---

## Build

1. Update submodules

   ```bash
   git submodule update --init --recursive
   ```

2. Install the `Flutter` and `Golang` toolchains

3. Build the application

    - android

        1. Install `Android SDK` and `Android NDK`

        2. Set the `ANDROID_NDK` environment variable

        3. Run the build script

           ```bash
           dart setup.dart android
           ```

    - windows

        1. Requires a Windows machine

        2. Install `GCC` and `Inno Setup`

        3. Run the build script

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. Requires a Linux machine

        2. Dependencies are installed by the setup script, or manually:

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. Run the build script

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. Requires a macOS machine

        2. Run the build script

           ```bash
           dart setup.dart macos
           ```

---

## Recommended Resources

Services I use myself or that pair well with this project. Some links are promotional / affiliate links: signing up or buying through them may earn the author a small commission at **no extra cost to you**.

- **Self-hosted proxy pool**: [Free Proxy](https://github.com/MasterAlanLab/free-proxy) — runs a free node pool on your own VPS and exposes SOCKS5 / HTTP, which Avalon can use as a standalone node or as one hop in a chain
- **VPS with China-optimized routes**: [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — for self-hosted nodes or landing servers
- **Virtual credit cards**: [here](https://cutt.ly/IyrMR4Mg) — for paying overseas services
- **Telegram resource search bot**: [here](https://cutt.ly/2yeh3GOE)
- **Overseas accounts and SIM cards**: [here](https://cutt.ly/dywt86NC)
- **Anti-detect browser**: [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — environment isolation on top of chained proxies
- **Bulk mailbox hosting**: [Emailbox](https://github.com/MasterAlanLab/emailbox) — manage mailboxes in bulk with per-group proxies
- **Captcha solving**: [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **GPT API relay**: [CC / GPT relay](https://cutt.ly/JywJG3G5)
- **Shared subscriptions**: [here](https://cutt.ly/5ywt8vb4)

---

## Disclaimer

- This project is **for study, research and technical exchange only, and any illegal use is strictly prohibited** — including but not limited to intruding into other people's systems, bypassing access restrictions where local law forbids it, carrying out network attacks, distributing unlawful content, or any other criminal activity.
- Users must comply with the laws and regulations of their country or region. All consequences of using this project are borne by the user; the authors and contributors are not liable for any direct or indirect damage.
- This project **does not provide, sell or endorse any proxy nodes or subscription services**, and makes no guarantee about the availability, privacy or security of third-party nodes. Never send sensitive information through nodes of unknown origin.
- If software of this kind is prohibited in your country or region, stop using it and delete it immediately.
- The VPS, virtual credit card, Telegram bot and similar links above are promotional / affiliate links. Ordering through them may earn the author a small commission at **no extra cost to you** — thanks for the support ❤️

---

## License

This project is licensed under **GPL-3.0**, the same license as the upstream project. See [LICENSE](../LICENSE) for the full terms. The fork notice and third-party components are listed in [NOTICE](../NOTICE).

Avalon is a modified version (fork) of [FlClash](https://github.com/chen08209/FlClash):

- Copyright of the original work belongs to the FlClash authors and contributors; all original copyright and license notices are retained.
- This project modifies the original work, mainly by adding the standalone node library, multi-hop proxy chains and single-core chain compilation, and by changing the project name and application identifiers. See [CHANGELOG.md](../CHANGELOG.md) for an overview.
- Under GPL-3.0, any redistribution based on this project must also be released under GPL-3.0 and keep the notices above.
- Avalon is **not affiliated** with the upstream FlClash project — please do not file issues about this fork there.

## Acknowledgements

- [FlClash](https://github.com/chen08209/FlClash) — the upstream project this fork is built on 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — the proxy core
- [Surfboard](https://github.com/getsurfboard/surfboard) — UI design reference

## Contact

- Telegram channel: <https://t.me/MasterAlanLab_Channel>
- Business enquiries: <masteralanlab@gmail.com>

## Star

The easiest way to support the developer is to click the star (⭐) at the top of the page.

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
