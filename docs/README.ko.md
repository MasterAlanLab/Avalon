<div align="center">
  <img src="../tool/branding/icon.svg" width="144" height="144" alt="Avalon Gate icon">
  <h1>Avalon</h1>
  <p><strong>Route · Connect · Control</strong></p>
  <p>
    <a href="https://github.com/MasterAlanLab/avalon/releases"><img src="https://img.shields.io/github/v/release/MasterAlanLab/avalon?display_name=tag&amp;style=flat-square&amp;logo=github&amp;logoColor=white&amp;label=Release&amp;color=E3A72F&amp;cacheSeconds=300" alt="Latest release"></a>
    <a href="https://github.com/MasterAlanLab/avalon/actions/workflows/build.yaml"><img src="https://img.shields.io/github/actions/workflow/status/MasterAlanLab/avalon/build.yaml?style=flat-square&amp;logo=githubactions&amp;logoColor=white&amp;label=Build" alt="Build status"></a>
    <a href="../LICENSE"><img src="https://img.shields.io/badge/License-AGPL--3.0-17191D?style=flat-square&amp;logo=gnu&amp;logoColor=white" alt="AGPL-3.0 license"></a>
    <a href="https://github.com/MasterAlanLab/avalon/releases"><img src="https://img.shields.io/badge/Android-arm64%20%7C%20armv7%20%7C%20x86__64-3DDC84?style=flat-square&amp;logo=android&amp;logoColor=white" alt="Android: arm64, armv7, x86_64"></a>
    <a href="https://github.com/MasterAlanLab/avalon/releases"><img src="https://img.shields.io/badge/Windows-x64-0078D4?style=flat-square&amp;logo=windows11&amp;logoColor=white" alt="Windows: x64"></a>
    <a href="https://github.com/MasterAlanLab/avalon/releases"><img src="https://img.shields.io/badge/macOS-ARM64-000000?style=flat-square&amp;logo=apple&amp;logoColor=white" alt="macOS: ARM64"></a>
    <a href="https://github.com/MasterAlanLab/avalon/releases"><img src="https://img.shields.io/badge/Linux-x64-FCC624?style=flat-square&amp;logo=linux&amp;logoColor=17191D" alt="Linux: x64"></a>
  </p>
</div>

Android, Windows, macOS, Linux용 프록시 클라이언트입니다. [mihomo](https://github.com/MetaCubeX/mihomo) 코어를 기반으로 독립 노드, 구독 관리, 멀티홉 프록시 체인을 지원하며 Flutter로 개발되었습니다.

> Avalon은 [FlClash](https://github.com/chen08209/FlClash)를 기반으로 개발되었습니다.

[Releases](https://github.com/MasterAlanLab/avalon/releases)에서 플랫폼에 맞는 설치 패키지를 다운로드할 수 있습니다.

## 주요 기능

- 프로토콜 지원: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, HTTP(S) 등.
- 노드 관리: 개별 노드를 독립적으로 관리하며 추가, 편집, 복제, 프로필 연결을 지원합니다.
- 구독 관리: URL이나 로컬 파일에서 프로필을 가져오고 구독을 자동으로 업데이트합니다.
- 프록시 체인: 노드, 프록시 그룹, 로컬 프록시 엔드포인트를 조합하며 앞단 프록시, 멀티홉 연결, 경로 미리보기를 지원합니다.
- 프로필 생성: 체인에서 바로 실행할 수 있는 프로필을 만들거나 기존 프로필의 프록시 그룹에 체인을 추가합니다.
- 가져오기 및 내보내기: 노드 URI, QR 코드, YAML / JSON을 지원하며 노드와 체인을 첨부 파일과 함께 패키지로 내보낼 수 있습니다.
- 라우팅 규칙: Rule, Global, Direct 모드를 지원하며 라우팅 규칙과 프록시 그룹을 편집할 수 있습니다.
- 네트워크 진단: 노드 지연 시간 테스트, 실시간 연결 확인, 실행 로그를 제공합니다.
- 데이터 동기화: 로컬 백업 및 복원, WebDAV 동기화를 지원합니다.
- 테마: 데스크톱 및 모바일 레이아웃, 다크 모드, 사용자 지정 색상을 지원합니다.

## 동작 모드

| 모드 | 설명 |
| :--- | :--- |
| Rule | 프로필의 규칙에 따라 아웃바운드 경로 선택 |
| Global | 코어로 들어오는 모든 트래픽을 전역 프록시 그룹에서 선택한 아웃바운드로 전송 |
| Direct | 프록시 노드 없이 대상에 직접 연결 |

시스템 프록시와 TUN 두 가지 트래픽 수신 방식을 지원합니다. 시스템 프록시는 시스템 설정을 따르는 앱에 적용됩니다. TUN은 가상 네트워크 인터페이스로 트래픽을 수신한 뒤 선택한 모드에 따라 라우팅합니다.

## 코어 엔진

[mihomo](https://github.com/MetaCubeX/mihomo)가 프록시 연결, DNS 조회, 규칙 기반 라우팅, TUN 트래픽을 처리합니다. 프로토콜별 입력 양식 외에도 Raw YAML / JSON으로 다른 mihomo 노드 유형을 설정할 수 있습니다.

구독, 노드 라이브러리, 프록시 체인을 통합해 하나의 실행 구성을 생성합니다. 체인은 `dialer-proxy`로 각 홉을 연결하며, 단일 코어 인스턴스에서 ‘클라이언트 → 앞단 프록시 → 메인 노드 → 뒷단 프록시 → 대상’ 순서로 연결합니다.

## 빌드

```bash
git clone --recurse-submodules https://github.com/MasterAlanLab/avalon.git
cd avalon
flutter pub get
```

빌드에는 Flutter, Go, Rust가 필요합니다. 현재 CI는 Flutter 3.44.4와 Go 1.26.4를 사용합니다. 플랫폼별 명령과 추가 의존성은 다음과 같습니다.

| 플랫폼 | 빌드 명령 | 추가 의존성 |
| :--- | :--- | :--- |
| Android | `dart setup.dart android` | Android SDK, NDK 및 `ANDROID_NDK` 설정 |
| Windows | `dart setup.dart windows` | Visual Studio C++ 도구 체인, GCC, Inno Setup |
| macOS | `dart setup.dart macos` | Xcode, CocoaPods, Node.js / npm |
| Linux | `dart setup.dart linux` | 스크립트가 apt로 GTK, AppIndicator, Keybinder 등의 의존성을 설치 |

데스크톱 패키지는 해당 운영체제에서 빌드하며 결과물은 `dist/`에 저장됩니다. 전체 환경 설정은 [빌드 워크플로](../.github/workflows/build.yaml)를 참고하세요.

## 테스트

```bash
# 정적 분석
flutter analyze --no-fatal-infos

# 단위 및 위젯 테스트
flutter test

# Go 코어 래퍼 테스트
(cd core && go test .)

# Rust 컴포넌트 테스트
cargo test --manifest-path services/helper/Cargo.toml
cargo test --manifest-path plugins/rust_api/rust/Cargo.toml
```

## 기술 스택

- 언어: Dart, Go, Rust
- UI 프레임워크: Flutter / Material Design
- 상태 관리: Riverpod
- 데이터베이스: SQLite / Drift
- 프록시 코어: mihomo
- 패키지 관리: Pub, Go Modules, Cargo

## 추천 리소스

일부 링크는 제휴 링크입니다. 해당 링크를 통해 가입하거나 구매하면 작성자가 수수료를 받을 수 있습니다. 서비스 내용과 가격은 각 웹사이트를 참고하세요.

| 분류 | 프로젝트 / 서비스 | 설명 |
| :--- | :--- | :--- |
| 프록시 풀 | [Free Proxy](https://github.com/MasterAlanLab/free-proxy) | 노드 라이브러리나 프록시 체인에 연결할 수 있는 자체 호스팅 프록시 풀 |
| VPS | [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) | 노드 및 애플리케이션 호스팅 |
| 가상 신용카드 | [해외 가상 카드](https://cutt.ly/IyrMR4Mg) | 해외 서비스 결제 |
| 리소스 검색 | [Telegram 검색 봇](https://cutt.ly/2yeh3GOE) | Telegram 리소스 검색 |
| 계정 및 SIM 카드 | [해외 계정 및 SIM 카드](https://cutt.ly/dywt86NC) | 계정 및 통신 서비스 |
| 핑거프린트 브라우저 | [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) | 독립된 브라우저 환경 관리 |
| 이메일 호스팅 | [Emailbox](https://github.com/MasterAlanLab/emailbox) | 이메일 일괄 관리 및 프록시 그룹화 |
| CAPTCHA 서비스 | [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0) | CAPTCHA 인식 |
| AI API | [CC / GPT 중계](https://cutt.ly/JywJG3G5) | 모델 API 서비스 |
| 구독 공유 | [구독 공유 플랫폼](https://cutt.ly/5ywt8vb4) | 구독 공동 이용 |

## 라이선스

[AGPL-3.0](../LICENSE). 서드파티 코드는 각각의 라이선스를 유지합니다. 저작권 및 라이선스 정보는 [NOTICE](../NOTICE)를 참고하세요.

## 감사의 말

- [FlClash](https://github.com/chen08209/FlClash)
- [mihomo](https://github.com/MetaCubeX/mihomo)
- [Surfboard](https://github.com/getsurfboard/surfboard)
