**🌐 Languages:** [中文](../README.md) · [English](README.en.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [العربية](README.ar.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

# Avalon — 단일 노드와 프록시 체인을 지원하는 멀티플랫폼 프록시 클라이언트

> Avalon 은 [FlClash](https://github.com/chen08209/FlClash) 를 기반으로 개발한 파생 프로젝트이며, 코어로 mihomo(Clash.Meta) 를 사용합니다. 기존의 구독 기반 방식에 더해 **독립적인 노드 라이브러리**와 **멀티홉 프록시 체인**을 추가했습니다. VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, HTTP(S) 노드를 개별적으로 추가하고 "클라이언트 → 전단 → 메인 노드 → 후단 → 목적지" 경로로 구성할 수 있으며, 이 모든 과정이 **하나의 코어 인스턴스** 안에서 처리되어 두 번째 프로세스를 띄우지 않습니다.

> ⚠️ **본 프로젝트는 학습, 연구 및 기술 교류 목적으로만 제공되며, 어떠한 불법적인 용도로도 사용하는 것을 엄격히 금지합니다.** 사용자는 자신이 속한 국가와 지역의 법률을 준수해야 하며, 본 소프트웨어 사용으로 발생하는 모든 책임은 사용자 본인에게 있습니다. 자세한 내용은 [면책 조항](#면책-조항)을 참고하세요.

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="../LICENSE"><img alt="License" src="https://img.shields.io/badge/License-GPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/지원-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/용도-학습·연구용-orange?style=flat-square">
</p>

기술 원리와 사용 경험, 업데이트 소식을 채널에서 공유하고 있습니다:

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

데스크톱:

<p style="text-align: center;">
    <img alt="desktop" src="../snapshots/desktop.gif">
</p>

모바일:

<p style="text-align: center;">
    <img alt="mobile" src="../snapshots/mobile.gif">
</p>

---

## FlClash 대비 추가된 기능

### 1. 독립 노드 라이브러리(단일 노드 지원)

노드를 쓰기 위해 구독을 먼저 등록할 필요가 없습니다. 노드는 전역 리소스로서 개별적으로 추가, 편집, 그룹화, 바인딩할 수 있습니다:

- **프로토콜 전용 폼과 URI 가져오기**: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, 그리고 포트나 인증 정보가 명시된 HTTP(S).
- **Raw YAML / JSON 노드**: mihomo 가 지원하는 **모든** proxy type 을 포괄하며, 전용 폼이 아직 다루지 않는 새 프로토콜도 저장·바인딩·체인 사용·내보내기가 가능합니다.
- **다양한 입력 방식**: URI 붙여넣기, QR 코드 스캔, 시스템 URL 스킴, 직접 입력.
- **구독과 단일 노드 공존**: 일반 `http(s)://` 주소는 구독으로 동기화하고, 포트·인증 정보·프록시 파라미터가 포함된 주소는 단일 노드로 해석합니다. 모호한 입력은 Raw 편집기로 처리할 수 있습니다.
- **내보내기**: 노드와 체인을 Clash 설정이나 JSON 으로 내보낼 수 있습니다.

### 2. 프록시 체인(멀티홉 / 전단 프록시)

- 표시 및 연결 방향은 **클라이언트 → 전단 → 메인 노드 → 후단 → 목적지** 로 고정되며, 목록 순서가 곧 중첩 순서입니다.
- 각 홉은 노드, 전역 정책 그룹, 현재 구독의 그룹, 또는 **이미 열려 있는 로컬 SOCKS / HTTP / HTTPS 엔드포인트**(예: 같은 기기에서 다른 클라이언트가 연 포트)가 될 수 있습니다.
- 컴파일 시 뒤쪽 홉의 `dialer-proxy` 가 앞쪽 홉을 가리키므로 결과는 **하나의 설정과 하나의 코어 라이프사이클**입니다. 단일 홉 체인은 해당 노드를 그대로 쓰는 것과 동일합니다.
- 정책 그룹을 홉으로 지정하면 분기 매트릭스로 확장되며, 기본 분기 상한은 64(1~1024 로 설정 가능)이고 저장 전에 경로 수와 진단 결과를 실시간으로 확인할 수 있습니다.
- 체인은 전역 객체입니다. 복제, 이름 변경, 순서 변경이 가능하고 여러 구독이 같은 체인을 바인딩할 수 있습니다. `error` 진단은 실행 설정 적용을 차단하고, `warning` 은 확인 후 진행합니다.
- 바인딩 시 "체인 진입 그룹"을 직접 선택할 수 있으며, 생성된 체인 selector 가 해당 그룹 끝에 추가되고 구독 본래의 선택은 그대로 유지됩니다.

### 3. FlClash 에서 이어받은 기능

✈️ 멀티플랫폼: Android, Windows, macOS, Linux

💻 다양한 화면 크기에 대응, 여러 컬러 테마 제공

💡 Material You 디자인, [Surfboard](https://github.com/getsurfboard/surfboard) 스타일 UI

☁️ WebDAV 를 통한 데이터 동기화

✨ 구독 원클릭 가져오기, 다크 모드

---

## 설치

### 다운로드

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="../snapshots/get-it-on-github.svg" width="200px"/></a>

### Linux 의존성

⚠️ 사용 전에 다음 패키지를 설치하세요:

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### Android 브로드캐스트 액션

다음 동작을 지원합니다:

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## 빠른 시작

1. **설정 추가**: "구독"에서 구독 링크를 붙여넣거나, "노드"에서 `vless://`, `anytls://`, `socks5://` 등의 URI 를 직접 붙여넣거나 QR 코드로 가져옵니다.
2. **체인 구성**(선택): "체인"에서 전단 → 메인 노드 → 후단 순서로 노드나 정책 그룹을 끌어다 놓고, 저장 전에 경로 수와 진단을 확인합니다.
3. **바인딩 후 실행**: 체인을 현재 구독에 바인딩하고 진입 그룹을 선택한 뒤 홈 화면에서 실행합니다. 체인을 바인딩하지 않은 구독은 기존 동작을 그대로 유지합니다.

---

## 빌드

1. 서브모듈 업데이트

   ```bash
   git submodule update --init --recursive
   ```

2. `Flutter` 와 `Golang` 환경 설치

3. 애플리케이션 빌드

    - android

        1. `Android SDK`, `Android NDK` 설치

        2. `ANDROID_NDK` 환경 변수 설정

        3. 빌드 스크립트 실행

           ```bash
           dart setup.dart android
           ```

    - windows

        1. Windows 머신이 필요합니다

        2. `GCC`, `Inno Setup` 설치

        3. 빌드 스크립트 실행

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. Linux 머신이 필요합니다

        2. 의존성은 setup 스크립트가 자동 설치하며, 수동 설치도 가능합니다:

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. 빌드 스크립트 실행

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. macOS 머신이 필요합니다

        2. 빌드 스크립트 실행

           ```bash
           dart setup.dart macos
           ```

---

## 추천 리소스

직접 사용해 봤거나 이 프로젝트와 함께 쓰기 좋은 서비스들입니다. 일부는 프로모션 / 제휴(affiliate) 링크이며, 이를 통해 가입하거나 구매하면 작성자에게 소액의 수수료가 지급될 수 있지만 **추가 비용은 발생하지 않습니다**.

- **자체 프록시 풀**: [Free Proxy](https://github.com/MasterAlanLab/free-proxy) — 자신의 VPS 에서 무료 노드 풀을 운영하고 SOCKS5 / HTTP 를 제공하며, Avalon 의 단일 노드나 체인의 한 홉으로 사용할 수 있습니다
- **중국 최적화 회선 VPS**: [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — 자체 노드나 랜딩 서버용
- **해외 가상 신용카드**: [여기](https://cutt.ly/IyrMR4Mg) — 해외 서비스 결제용
- **텔레그램 리소스 검색 봇**: [여기](https://cutt.ly/2yeh3GOE)
- **해외 계정 및 유심**: [여기](https://cutt.ly/dywt86NC)
- **안티디텍트 브라우저**: [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — 체인 프록시와 함께 환경 격리에 활용
- **대량 메일박스 관리**: [Emailbox](https://github.com/MasterAlanLab/emailbox) — 그룹별 프록시 설정 지원
- **캡차 해결 서비스**: [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **GPT API 중계**: [CC / GPT 중계](https://cutt.ly/JywJG3G5)
- **구독 공유**: [여기](https://cutt.ly/5ywt8vb4)

---

## 면책 조항

- 본 프로젝트는 **학습, 연구 및 기술 교류 목적으로만 제공되며 어떠한 불법적인 용도로도 사용할 수 없습니다**. 여기에는 타인의 시스템 침입, 거주 지역 법률이 금지하는 접근 제한 우회, 네트워크 공격, 위법 정보 유포 및 기타 모든 범죄 행위가 포함되며 이에 국한되지 않습니다.
- 사용자는 자신이 속한 국가와 지역의 법률을 준수해야 합니다. 본 프로젝트 사용으로 발생한 모든 결과는 사용자 본인이 부담하며, 작성자와 기여자는 직간접적인 손해에 대해 책임지지 않습니다.
- 본 프로젝트는 **어떠한 프록시 노드나 구독 서비스도 제공, 판매, 추천하지 않으며**, 제3자 노드의 가용성·프라이버시·보안을 보장하지 않습니다. 출처가 불분명한 노드로 민감한 정보를 전송하지 마세요.
- 거주 국가나 지역에서 이러한 소프트웨어가 금지되어 있다면 즉시 사용을 중단하고 삭제하세요.
- 본문의 VPS, 가상 신용카드, 텔레그램 봇 등의 링크는 프로모션 / 제휴 링크입니다. 이를 통해 주문하면 작성자에게 소액의 수수료가 지급될 수 있으나 **추가 비용은 없습니다**. 응원해 주셔서 감사합니다 ❤️

---

## 라이선스

본 프로젝트는 상위 프로젝트와 동일하게 **GPL-3.0** 으로 배포됩니다. 전체 조항은 [LICENSE](../LICENSE) 를 참고하세요. 포크 고지와 서드파티 구성 요소는 [NOTICE](../NOTICE) 에 정리되어 있습니다.

Avalon 은 [FlClash](https://github.com/chen08209/FlClash) 의 수정 버전(fork)입니다:

- 원저작물의 저작권은 FlClash 작성자와 기여자에게 있으며, 모든 저작권 및 라이선스 고지를 그대로 유지하고 있습니다.
- 본 프로젝트는 원저작물을 수정했습니다. 주요 변경 사항은 독립 노드 라이브러리, 멀티홉 프록시 체인, 단일 코어 체인 컴파일, 그리고 프로젝트 이름과 애플리케이션 식별자 변경입니다. 개요는 [CHANGELOG.md](../CHANGELOG.md) 를 참고하세요.
- GPL-3.0 에 따라 본 프로젝트를 기반으로 한 재배포 역시 GPL-3.0 으로 공개하고 위 고지를 유지해야 합니다.
- Avalon 은 상위 FlClash 프로젝트와 **제휴 관계가 없습니다**. 이 포크에 대한 이슈를 상위 저장소에 제출하지 마세요.

## 감사의 말

- [FlClash](https://github.com/chen08209/FlClash) — 본 프로젝트의 상위 프로젝트 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — 프록시 코어
- [Surfboard](https://github.com/getsurfboard/surfboard) — UI 디자인 참고

## 연락처

- 텔레그램 채널: <https://t.me/MasterAlanLab_Channel>
- 비즈니스 문의: <masteralanlab@gmail.com>

## Star

개발자를 응원하는 가장 쉬운 방법은 페이지 상단의 별(⭐)을 누르는 것입니다.

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
