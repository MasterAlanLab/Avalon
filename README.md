**🌐 Languages:** [中文](README.md) · [English](docs/README.en.md) · [Deutsch](docs/README.de.md) · [Español](docs/README.es.md) · [العربية](docs/README.ar.md) · [Italiano](docs/README.it.md) · [日本語](docs/README.ja.md) · [한국어](docs/README.ko.md)

# Avalon — 支持单节点与代理链的多平台代理客户端

> Avalon 基于 [FlClash](https://github.com/chen08209/FlClash) 二次开发，内核为 mihomo（Clash.Meta）。在原有的订阅式配置之外，新增**独立节点库**和**多跳代理链**：可以单独添加 VLESS、VMess、Shadowsocks、Trojan、Hysteria2、TUIC、AnyTLS、SOCKS4/4a/5、HTTP(S) 节点，并把它们编排成「客户端 → 前置 → 主节点 → 后置 → 目标」的链路，全部在**单个内核实例**内完成，不额外拉起第二个进程。

> ⚠️ **本项目仅供学习、研究与技术交流使用，严禁用于任何非法用途。** 使用者须遵守所在国家和地区的法律法规，并自行承担使用本软件产生的全部责任。详见[免责声明](#免责声明)。

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/License-GPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/平台-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/用途-仅供学习研究-orange?style=flat-square">
</p>

我会在频道里分享技术原理、使用经验和产品更新：

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

桌面端：

<p style="text-align: center;">
    <img alt="desktop" src="snapshots/desktop.gif">
</p>

移动端：

<p style="text-align: center;">
    <img alt="mobile" src="snapshots/mobile.gif">
</p>

---

## 相比上游 FlClash 新增了什么

### 1. 独立节点库（单节点支持）

不再必须先有一条订阅才能用节点。节点是全局资源，可以单独添加、编辑、分组和绑定：

- **专用协议表单与 URI 导入**：VLESS、VMess、Shadowsocks、Trojan、Hysteria2、TUIC、AnyTLS、SOCKS4/4a/5，以及带端口或认证参数的 HTTP(S)。
- **Raw YAML / JSON 节点**：覆盖 mihomo 支持的**全部** proxy type，包括表单还没覆盖的新协议，同样可保存、绑定、参与链路和导出。
- **多种录入方式**：粘贴 URI、扫描二维码、系统 URL Scheme 唤起、手工填表。
- **订阅与单节点共存**：普通 `http(s)://` 地址按订阅同步；带显式端口、认证或代理参数的地址按单节点解析，歧义地址可直接用 Raw 编辑器处理。
- **导出**：节点与链路可导出为 Clash 配置或 JSON。

### 2. 代理链（多跳 / 前置代理）

- 展示与拨号方向固定为**客户端 → 前置 → 主节点 → 后置 → 目标**，列表顺序即嵌套顺序。
- 每一跳可以是：节点、全局策略组、当前订阅的策略组，或**本地已有的 SOCKS / HTTP / HTTPS 端点**（例如本机另一个客户端开的端口）。
- 编译时后一跳的 `dialer-proxy` 指向前一跳，最终只产出**一份配置、一个内核生命周期**；单跳链等价于直接使用该节点。
- 策略组作为一跳时会展开成分支矩阵，默认分支上限 64（可配 1–1024），并在保存前实时给出路径数量与诊断。
- 链路是全局对象：可复制、重命名、重排，多个订阅可绑定同一条链；`error` 级诊断会阻止应用到运行配置，`warning` 需确认后继续。
- 绑定时可显式选择「链路入口组」，生成的链 selector 追加到这些策略组末尾，不覆盖订阅原有的选择。

### 3. 其余保留自 FlClash 的能力

✈️ 多平台：Android、Windows、macOS、Linux

💻 自适应多种屏幕尺寸，多种配色主题

💡 基于 Material You 设计，类 [Surfboard](https://github.com/getsurfboard/surfboard) 的界面

☁️ 支持通过 WebDAV 同步数据

✨ 支持一键导入订阅、深色模式

---

## 安装

### 下载

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="snapshots/get-it-on-github.svg" width="200px"/></a>

### Linux 依赖

⚠️ 使用前请确保安装以下依赖：

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### Android 广播动作

支持下列操作：

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## 快速上手

1. **加内核配置**：既可以在「订阅」里粘贴订阅链接，也可以在「节点」里直接粘贴一条 `vless://`、`anytls://`、`socks5://` 等 URI，或扫码导入。
2. **建链路**（可选）：在「链路」里按 前置 → 主节点 → 后置 的顺序拖拽节点或策略组，保存前查看路径数与诊断。
3. **绑定并启动**：把链路绑定到当前订阅并选择入口组，回到首页启动即可；未绑定链路的订阅保持原有行为不变。

---

## 构建

1. 更新 submodules

   ```bash
   git submodule update --init --recursive
   ```

2. 安装 `Flutter` 与 `Golang` 环境

3. 构建应用

    - android

        1. 安装 `Android SDK`、`Android NDK`

        2. 设置 `ANDROID_NDK` 环境变量

        3. 运行构建脚本

           ```bash
           dart setup.dart android
           ```

    - windows

        1. 你需要一个 Windows 客户端

        2. 安装 `GCC`、`Inno Setup`

        3. 运行构建脚本

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. 你需要一个 Linux 客户端

        2. 依赖会由 setup 脚本自动安装，也可以手动安装：

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. 运行构建脚本

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. 你需要一个 macOS 客户端

        2. 运行构建脚本

           ```bash
           dart setup.dart macos
           ```

---

## 资源推荐

下面列出一些我自己使用过、或适合配合本项目使用的服务。部分链接属于推广 / 推荐（affiliate）链接；通过它们注册或购买可能为作者带来少量返佣，**不会额外增加你的花费**。

- **自建代理池**：[Free Proxy](https://github.com/MasterAlanLab/free-proxy) — 在自己的 VPS 上跑免费节点池，暴露 SOCKS5 / HTTP，可直接作为 Avalon 的单节点或链路中的一跳
- **三网优化线路 VPS**：[搬瓦工](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — 自建节点或做落地机
- **海外虚拟信用卡**：[点这里](https://cutt.ly/IyrMR4Mg) — 用于支付海外服务
- **Telegram 资源搜索机器人**：[点这里](https://cutt.ly/2yeh3GOE)
- **海外账号、电话卡**：[点这里](https://cutt.ly/dywt86NC)
- **指纹浏览器**：[比特指纹浏览器](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — 配合链式代理做环境隔离
- **批量邮箱托管**：[Emailbox](https://github.com/MasterAlanLab/emailbox) — 批量管理邮箱与分组代理
- **打码平台**：[Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **GPT 中转站**：[满血 CC / GPT 中转](https://cutt.ly/JywJG3G5)
- **订阅合租拼车**：[点这里](https://cutt.ly/5ywt8vb4)

---

## 免责声明

- 本项目**仅供学习、研究与技术交流使用，严禁用于任何非法用途**，包括但不限于入侵他人系统、绕过所在地区法律禁止的访问限制、实施网络攻击、传播违法信息或从事任何形式的犯罪活动。
- 使用者应遵守所在国家和地区的法律法规。因使用本项目造成的一切后果由使用者自行承担，项目作者与贡献者不对任何直接或间接损失负责。
- 本项目**不提供、不销售、不推荐任何代理节点或机场服务**，也不对第三方节点的可用性、隐私性与安全性作任何担保。请勿通过来源不明的节点传输敏感信息。
- 如果你所在的国家或地区禁止使用此类软件，请立即停止使用并删除本软件。
- 文中的 VPS、虚拟信用卡、Telegram 机器人等为推广 / 推荐（affiliate）链接，通过它们下单可能为作者带来少量返佣，**不会额外增加你的花费**，感谢支持 ❤️

---

## 开源许可

本项目以 **GPL-3.0** 授权，与上游项目保持一致，完整条款见 [LICENSE](LICENSE)。 分叉说明与第三方组件见 [NOTICE](NOTICE)。

Avalon 是 [FlClash](https://github.com/chen08209/FlClash) 的修改版本（fork）：

- 原项目版权归 FlClash 作者及其贡献者所有，相关版权与许可声明均已保留。
- 本项目在原项目基础上做了修改，主要包括独立节点库、多跳代理链、单内核链式编译，以及项目名称与应用标识的变更；变更概览见 [CHANGELOG.md](CHANGELOG.md)。
- 依据 GPL-3.0，任何基于本项目的再分发同样必须以 GPL-3.0 开源并保留上述声明。
- Avalon 与 FlClash 上游项目**没有隶属关系**，请不要就本项目的问题向上游提交 issue。

## 致谢

- [FlClash](https://github.com/chen08209/FlClash) — 本项目的上游，提供了完整的多平台客户端实现 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — 代理内核
- [Surfboard](https://github.com/getsurfboard/surfboard) — 界面设计参考

## 联系

- Telegram 频道：<https://t.me/MasterAlanLab_Channel>
- 商务合作：<masteralanlab@gmail.com>

## Star

支持开发者最简单的方式，是点击页面顶部的星标（⭐）。

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
