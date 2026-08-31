**🌐 Languages:** [中文](README.md) · [English](README.en.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [العربية](README.ar.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

# Avalon — 単体ノードとプロキシチェーンに対応したマルチプラットフォームプロキシクライアント

> Avalon は [FlClash](https://github.com/chen08209/FlClash) をベースにした派生プロジェクトで、コアには mihomo（Clash.Meta）を使用しています。従来のサブスクリプション方式に加えて、**独立したノードライブラリ**と**マルチホップのプロキシチェーン**を追加しました。VLESS、VMess、Shadowsocks、Trojan、Hysteria2、TUIC、AnyTLS、SOCKS4/4a/5、HTTP(S) のノードを単体で追加でき、それらを「クライアント → 前段 → メインノード → 後段 → 宛先」の経路として組み立てられます。すべて**単一のコアインスタンス**内で完結し、2 つ目のプロセスは起動しません。

> ⚠️ **本プロジェクトは学習・研究・技術交流のみを目的としており、いかなる違法な用途も固く禁止します。** 利用者は自国および居住地域の法令を遵守し、本ソフトウェアの利用によって生じる一切の責任を自ら負うものとします。詳細は[免責事項](#免責事項)をご覧ください。

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/License-GPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/対応-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/用途-学習・研究目的のみ-orange?style=flat-square">
</p>

技術的な仕組みや使い方、アップデート情報はチャンネルで発信しています:

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

デスクトップ:

<p style="text-align: center;">
    <img alt="desktop" src="snapshots/desktop.gif">
</p>

モバイル:

<p style="text-align: center;">
    <img alt="mobile" src="snapshots/mobile.gif">
</p>

---

## FlClash からの追加機能

### 1. 独立したノードライブラリ（単体ノード対応）

ノードを使うためにサブスクリプションを用意する必要はありません。ノードはグローバルなリソースとして、単体で追加・編集・グループ化・バインドできます:

- **プロトコル専用フォームと URI インポート**: VLESS、VMess、Shadowsocks、Trojan、Hysteria2、TUIC、AnyTLS、SOCKS4/4a/5、およびポートや認証情報を明示した HTTP(S)。
- **Raw YAML / JSON ノード**: mihomo が対応する**すべての** proxy type をカバーし、専用フォームが未対応の新しいプロトコルも扱えます。Raw ノードも保存・バインド・チェーン利用・エクスポートが可能です。
- **多様な追加方法**: URI の貼り付け、QR コードのスキャン、システムの URL スキーム、手動入力。
- **サブスクリプションと単体ノードの共存**: 通常の `http(s)://` はサブスクリプションとして同期し、ポート・認証情報・プロキシパラメータを含むアドレスは単体ノードとして解析します。判別が難しい入力は Raw エディタで直接扱えます。
- **エクスポート**: ノードとチェーンを Clash 設定または JSON として出力できます。

### 2. プロキシチェーン（マルチホップ / 前段プロキシ）

- 表示と接続の方向は **クライアント → 前段 → メインノード → 後段 → 宛先** に固定され、リストの順序がそのまま入れ子の順序になります。
- 各ホップにはノード、グローバルポリシーグループ、現在のサブスクリプションのグループ、または**既存のローカル SOCKS / HTTP / HTTPS エンドポイント**（同じ端末で別のクライアントが開いているポートなど）を指定できます。
- コンパイル時、後のホップの `dialer-proxy` が前のホップを指すため、生成されるのは**単一の設定と単一のコアライフサイクル**です。1 ホップのチェーンはそのノードを直接使う場合と等価です。
- ポリシーグループをホップにすると分岐マトリクスに展開されます。分岐上限は既定 64（1〜1024 で設定可能）で、保存前に経路数と診断結果をリアルタイムに確認できます。
- チェーンはグローバルなオブジェクトです。複製・リネーム・並べ替えができ、複数のサブスクリプションから同じチェーンをバインドできます。`error` の診断は実行設定への適用をブロックし、`warning` は確認後に続行します。
- バインド時に「チェーンの入口グループ」を明示的に選択でき、生成されたチェーンの selector がそれらのグループの末尾に追加されます。サブスクリプション本来の選択は変更されません。

### 3. FlClash から引き継いだ機能

✈️ マルチプラットフォーム: Android、Windows、macOS、Linux

💻 さまざまな画面サイズに対応、複数のカラーテーマ

💡 Material You デザイン、[Surfboard](https://github.com/getsurfboard/surfboard) 風の UI

☁️ WebDAV によるデータ同期

✨ サブスクリプションのワンクリックインポート、ダークモード

---

## インストール

### ダウンロード

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="snapshots/get-it-on-github.svg" width="200px"/></a>

### Linux の依存パッケージ

⚠️ 使用前に以下の依存パッケージをインストールしてください:

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### Android のブロードキャストアクション

以下の操作に対応しています:

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## クイックスタート

1. **設定を追加**: 「サブスクリプション」でリンクを貼り付けるか、「ノード」で `vless://`、`anytls://`、`socks5://` などの URI を直接貼り付ける、または QR コードを読み取ります。
2. **チェーンを作成**（任意）: 「チェーン」で前段 → メインノード → 後段 の順にノードやポリシーグループをドラッグし、保存前に経路数と診断を確認します。
3. **バインドして起動**: チェーンを現在のサブスクリプションにバインドして入口グループを選び、ホーム画面から起動します。チェーンをバインドしていないサブスクリプションの挙動は従来どおりです。

---

## ビルド

1. サブモジュールを更新

   ```bash
   git submodule update --init --recursive
   ```

2. `Flutter` と `Golang` の環境をインストール

3. アプリをビルド

    - android

        1. `Android SDK`、`Android NDK` をインストール

        2. `ANDROID_NDK` 環境変数を設定

        3. ビルドスクリプトを実行

           ```bash
           dart setup.dart android
           ```

    - windows

        1. Windows マシンが必要です

        2. `GCC`、`Inno Setup` をインストール

        3. ビルドスクリプトを実行

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. Linux マシンが必要です

        2. 依存パッケージは setup スクリプトが自動インストールします。手動の場合:

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. ビルドスクリプトを実行

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. macOS マシンが必要です

        2. ビルドスクリプトを実行

           ```bash
           dart setup.dart macos
           ```

---

## おすすめのリソース

自分が実際に使っている、または本プロジェクトと相性の良いサービスです。一部はプロモーション / アフィリエイトリンクで、そこから登録・購入すると作者に少額の報酬が入ることがありますが、**あなたの支払額が増えることはありません**。

- **自前のプロキシプール**: [Free Proxy](https://github.com/MasterAlanLab/free-proxy) — 自分の VPS で無料ノードプールを動かし SOCKS5 / HTTP を提供。Avalon の単体ノードやチェーンの 1 ホップとして利用できます
- **中国最適化回線の VPS**: [搬瓦工 BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — 自前ノードや出口サーバー向け
- **海外向けバーチャルクレジットカード**: [こちら](https://cutt.ly/IyrMR4Mg) — 海外サービスの支払いに
- **Telegram リソース検索ボット**: [こちら](https://cutt.ly/2yeh3GOE)
- **海外アカウント・SIM カード**: [こちら](https://cutt.ly/dywt86NC)
- **アンチディテクトブラウザ**: [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — チェーンプロキシと組み合わせた環境分離に
- **メールボックスの一括管理**: [Emailbox](https://github.com/MasterAlanLab/emailbox) — グループ単位のプロキシ設定に対応
- **CAPTCHA 解決サービス**: [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **GPT API 中継**: [CC / GPT 中継](https://cutt.ly/JywJG3G5)
- **サブスクの共同利用**: [こちら](https://cutt.ly/5ywt8vb4)

---

## 免責事項

- 本プロジェクトは**学習・研究・技術交流のみを目的としており、いかなる違法な用途も固く禁止します**。他者のシステムへの侵入、居住地域の法律が禁じるアクセス制限の回避、ネットワーク攻撃、違法な情報の配信、その他あらゆる犯罪行為を含みますが、これらに限りません。
- 利用者は自国および居住地域の法令を遵守してください。本プロジェクトの利用によって生じたすべての結果は利用者自身が負うものとし、作者およびコントリビューターは直接・間接を問わずいかなる損害についても責任を負いません。
- 本プロジェクトは**プロキシノードやサブスクリプションサービスの提供・販売・推奨を一切行いません**。第三者のノードの可用性・プライバシー・安全性についても保証しません。出所不明のノードで機密情報を送信しないでください。
- お住まいの国や地域でこの種のソフトウェアが禁止されている場合は、直ちに使用を中止し削除してください。
- 本文中の VPS、バーチャルクレジットカード、Telegram ボットなどのリンクはプロモーション / アフィリエイトリンクです。ご利用いただくと作者に少額の報酬が入ることがありますが、**追加費用は発生しません**。応援ありがとうございます ❤️

---

## ライセンス

本プロジェクトは上流プロジェクトと同じ **GPL-3.0** で提供されます。全文は [LICENSE](LICENSE) を参照してください。 フォークに関する告知と第三者コンポーネントは [NOTICE](NOTICE) に記載しています。

Avalon は [FlClash](https://github.com/chen08209/FlClash) の改変版（フォーク）です:

- 原著作物の著作権は FlClash の作者およびコントリビューターに帰属し、著作権表示とライセンス表示はすべて保持しています。
- 本プロジェクトは原著作物に改変を加えています。主な変更点は、独立したノードライブラリ、マルチホップのプロキシチェーン、単一コアでのチェーンコンパイル、およびプロジェクト名とアプリ識別子の変更です。概要は [CHANGELOG.md](CHANGELOG.md) を参照してください。
- GPL-3.0 に従い、本プロジェクトを元にした再配布も GPL-3.0 で公開し、上記の表示を保持する必要があります。
- Avalon は上流の FlClash プロジェクトとは**関係がありません**。本フォークに関する issue を上流に提出しないでください。

## 謝辞

- [FlClash](https://github.com/chen08209/FlClash) — 本プロジェクトの上流 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — プロキシコア
- [Surfboard](https://github.com/getsurfboard/surfboard) — UI デザインの参考

## 連絡先

- Telegram チャンネル: <https://t.me/MasterAlanLab_Channel>
- ビジネスのお問い合わせ: <masteralanlab@gmail.com>

## Star

開発者を応援する一番簡単な方法は、ページ上部のスター（⭐）をクリックすることです。

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
