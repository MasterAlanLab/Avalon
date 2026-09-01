## v1.0.0

- fix(windows): resolve installer locale path

- ci: drop unsupported build architectures

- chore: organize branding sources

- chore(release): bump version to 1.0.0

- ci: optimize release workflow

- feat: refresh cross-platform branding assets

- fix: update project links and About page

- fix: correct packaging paths and platform naming

- docs: rewrite README and sync translations

- chore: license Avalon additions under AGPLv3

- fix(android): update JNI exports for Avalon package

- refactor: drop the dead crash-reporting plumbing and unused strings

- Removing Firebase left a settings field, a shared-state field and four

- localized strings behind, kept alive only by a localization test. This drops

- them end to end: AppSettingProps.crashlytics/crashlyticsTip, SharedState.crashlytics

- on both the Dart and Kotlin sides, and the crashlytics, crashlyticsTip,

- dataCollectionTip and dataCollectionContent strings in all four locales. The

- shared-state provider now watches two fields instead of three.

- Also removes chainLibrary, importNodeDesc and chainHopHint, three strings that

- were never referenced, and renames plugins/rust_api/CLAUDE.md to NOTES.md so the

- flutter_rust_bridge integration notes survive without carrying an assistant

- config filename.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- chore: remove the remaining agent tooling files

- AGENTS.md and CLAUDE.md only routed into the deleted .agents directory, and

- .mcp.json and opencode.jsonc configured a codegraph MCP server this project

- no longer uses.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- chore: remove the JetBrains run configuration

- .run/main.dart.run.xml only provides a ready-made Flutter run entry for

- JetBrains IDEs and takes no part in building, testing or packaging.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- chore: stop ignoring docs/

- The directory now holds the translated READMEs, so new files under it must

- be trackable. Also drops the .claude/settings.local.json rule, which no

- longer has a directory to apply to.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- docs: move the translated READMEs under docs/

- Keeps the Chinese README at the repository root and relocates the seven

- translations to docs/. Language navigation, image sources and the LICENSE,

- NOTICE and CHANGELOG links are rewritten so every relative path still

- resolves from its new depth.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- chore: remove the .codegraph directory

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- chore: remove agent tooling configs

- Drops the .gemini, .codex, .claude, .agents and .zed directories, which

- carry per-tool assistant configuration rather than anything the project

- builds or ships.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

## v0.8.97

- chore(release): bump version to 0.8.97

- Artifact file names come from the pubspec version while the release body

- template builds its download links from the tag, so the two have to match.

- v0.8.96 is already taken by an upstream FlClash tag, hence 0.8.97 for

- Avalon's first release.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- ci: put a hitokoto quote in the release title

- Every release is named `<tag> -- "<quote>"`, matching how emailbox names

- its releases. The quote is fetched from v1.hitokoto.cn with a 5s timeout and

- falls back to a fixed string when the API is unreachable or returns something

- jq cannot parse. The value is stripped of newlines and quotes and capped at 80

- characters so remote content cannot inject extra step outputs or break the

- title.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

## v0.8.96-test.1

- refactor!: rename FlClash fork to Avalon and trim the release pipeline

- Rebrand this FlClash fork as Avalon, repoint every project-owned identifier,

- and reduce the inherited release pipeline to building installers and attaching

- them to a GitHub Release.

- Rename:

- - Dart package fl_clash -> avalon

- - application id com.follow.clash -> com.masteralanlab.avalon, with the Kotlin

-   package directories moved to match

- - executables FlClashCore / FlClashHelperService -> AvalonCore /

-   AvalonHelperService, keeping the Windows pipe name, unix socket path and

-   helper protocol header in sync between the Dart and Rust sides

- - custom URL scheme flclash:// -> avalon:// and generated chain group prefix

-   __flclash_ -> __avalon_

- - a fresh Inno Setup app id so the Windows installer is a distinct application

- Upstream references are deliberately left untouched: the Clash.Meta submodule

- branch, the flutter_distributor git ref and the chen08209 forks in pubspec.yaml

- still point at the upstream projects.

- Docs:

- - rewrite the README for Avalon in 8 languages, replacing README_zh_CN.md

- - add NOTICE carrying the GPL-3.0 attribution to FlClash and the list of

-   modifications made in this fork

- - state in every README that the project is for study and research only and

-   that any illegal use is prohibited, and add a recommended-resources section

- CI:

- - drop the F-Droid, Homebrew tap and Telegram publishing steps

- - skip Android signing when no keystore secret is configured instead of writing

-   an empty keystore over the build

- - export ANDROID_NDK from the setup-ndk output, which the Go core build tool

-   requires under that exact name

- - fall back to the runner default Xcode when the pinned version is absent

- Android:

- - remove Firebase Crashlytics and Analytics; crash-loop protection now reads

-   ActivityManager.getHistoricalProcessExitReasons on API 30+ and degrades to

-   no protection below it

- BREAKING CHANGE: the application identifiers changed, so Avalon installs

- alongside FlClash instead of upgrading it. Settings, profiles and the WebDAV

- backup directory are not migrated.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_018PvMz7SJGTDgSFovM66xPm

- Fix three codec outputs the Core rejects

- Device testing surfaced three configs that the Dart layer considered valid

- but the bundled Core refuses at apply time:

- - SOCKS nodes were emitted as `type: socks`. Mihomo registers `socks5`

-   only, so adapter.ParseProxy failed with "unsupport proxy type: socks"

-   and no SOCKS node could start. SOCKS4/4a keep their variant in

-   `version`, which _socksScheme already uses to restore the scheme.

- - `scheme://base64(user:password)@host` share links kept the undecoded

-   blob as the username and left the password empty, so servers rejected

-   the auth. Decode it in a shared _credentialParts, but only when the

-   decoded value carries a separator, so a literal username that happens

-   to be valid base64 is left alone. SOCKS and HTTP shared the bug.

- - `h2` transport was written to `http-opts`, and header values were

-   written as plain strings. Mihomo splits these: HTTPOptions takes

-   `path` as a list and `headers` values as lists, HTTP2Options takes

-   `host` as a list with a plain `path`, and WSOptions takes plain

-   strings throughout. Fixed on URI parse, VMess JSON parse and export.

- None of these were caught by the existing suite because it validates only

- within Dart. Two of them were in fact pinned as expected behaviour by

- codec tests asserting `type == 'socks'`. Those assertions are corrected

- here, and hub_validate_test.go now pins the SOCKS naming contract on the

- Go side.

- Found by feeding parsed sample URIs for every supported protocol to the

- real handleValidateConfig; the other 15 protocol/transport combinations

- tested clean.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_01GuY5bCnM5DDp2Qb5LHKCkS

- Replace the node import entry with create-from-chain

- Add Profile offered "Import node", which duplicated the button already on

- the Nodes tab, while there was no way at all to create a profile without a

- subscription URL or a config file. Nodes and chains are global, but binding

- either one needs a profile, so the no-subscription single-node flow was

- unreachable from the UI.

- Add Profile now lists the chain library instead: picking a chain creates a

- stub profile, binds the chain as default and sets the chain entry group.

- The stub ships an empty PROXY group on purpose. _attachChainEntry appends

- the generated selector and keeps the first member in place, so an empty

- group leaves the chain as the only member and therefore the default

- outbound; a DIRECT placeholder would silently win instead. Core validation

- accepts a select group with no members, verified against the bundled Core.

- Verified on an Android emulator: the entry lists the chain library, creates

- the profile and makes it current.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_01GuY5bCnM5DDp2Qb5LHKCkS

- Fix R1-R9 from the node library and chain review

- - R1: keep old files, database and settings on restore failure

- - R2: preserve SOCKS4/4a version across export round-trip

- - R3: include chains and generated groups in export

- - R4: show diagnostics and confirmation before saving a chain

- - R5: add explicit chain entry groups for rule profiles (schema v4)

- - R6: make manual nodes visible when only a chain is bound

- - R7: keep distinct endpoints for same-named source nodes

- - R8: retain last valid config when core apply fails

- - R9: forward Windows hot-start app links

- Also adds a unified node import preview, a backup manifest contract,

- a v2 database upgrade test, and loading/error states for the node and

- chain lists.

- Ignores the core/core build artifact and tracks the third-round

- verification record, which the docs/ ignore rule was hiding.

- Verified: analyze 0 error / 0 warning / 28 info; 791 root tests,

- 26 plugin tests, 27 build_tool tests, 6 go tests all passing.

- Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>

- Claude-Session: https://claude.ai/code/session_01LP2XvuTaTj9jo6CXZZyvTt

- Add node library and single-core chain development snapshot

- Include node storage, protocol import/export, chain configuration, UI, and platform link integration.

- Track task contracts, reviewed development progress, verification results, and remaining implementation gaps.

- Use synthetic values for the copied VLESS test fixture. Root tests passed (756); sanitized codec tests passed (15). Core and platform acceptance remain pending.

- Optimize commented policy

- Fix whole group delay test failing on Windows

- Optimize package icon loading and connections polling

- Optimize core service

- Optimize Android TV launcher icon

- Optimize back navigation

- Optimize more details

- Fix some issues

- Optimize app layout

- Optimize focus control

- Adjust android process

- Fix macos performance issue

- Support custom global-ua

- Update core

- Optimize some details

- Fix linux silent launching not working

- Support custom overwrite

- Support run on demand

- Optimize windows ipc

- Optimize windows arm64

- Optimize build

- Optimize some details

- Update core

- Add sqlite store

- Optimize android quick action

- Optimize backup and restore

- Optimize more details

- Fix windows some issues

- Optimize overwrite handle

- Optimize access control page

- Optimize some details

- Fix android tile service

- Support append system DNS

- Fix some issues

- Fix some issues

- Optimize Windows service mode

- Update core

- Add android separates the core process

- Support core status check and force restart

- Optimize proxies page and access page

- Update flutter and pub dependencies

- Update go version

- Optimize more details

- Optimize desktop view

- Optimize logs, requests, connection pages

- Optimize windows tray auto hide

- Optimize some details

- Update core

- Fix windows tun issues

- Optimize android get system dns

- Optimize more details

- Support override script

- Support proxies search

- Support svg display

- Optimize config persistence

- Add some scenes auto close connections

- Update core

- Optimize more details

- Fix issues that TUN repeat failed to open.

- Fix windows service verify issues

- Add windows server mode start process verify

- Add linux deb dependencies

- Add backup recovery strategy select

- Support custom text scaling

- Optimize the display of different text scale

- Optimize windows setup experience

- Optimize startTun performance

- Optimize android tv experience

- Optimize default option

- Optimize computed text size

- Optimize hyperOS freeform window

- Add developer mode

- Update core

- Optimize more details

- Add issues template

- Optimize android vpn performance

- Add custom primary color and color scheme

- Add linux nad windows arm release

- Optimize requests and logs page

- Fix map input page delete issues

- Add rule override

- Update core

- Optimize more details

- Optimize dashboard performance

- Fix some issues

- Fix unselected proxy group delay issues

- Fix asn url issues

- Fix tab delay view issues

- Fix tray action issues

- Fix get profile redirect client ua issues

- Fix proxy card delay view issues

- Add Russian, Japanese adaptation

- Fix some issues

- Fix list form input view issues

- Fix traffic view issues

- Optimize performance

- Update core

- Optimize core stability

- Fix linux tun authority check error

- Fix some issues

- Fix scroll physics error

- Add windows storage corruption detection

- Fix core crash caused by windows resource manager restart

- Optimize logs, requests, access to pages

- Fix macos bypass domain issues

- Fix some issues

- Update popup menu

- Add file editor

- Fix android service issues

- Optimize desktop background performance

- Optimize android main process performance

- Optimize delay test

- Optimize vpn protect

- Update core

- Fix some issues

- Remake dashboard

- Optimize theme

- Optimize more details

- Update flutter version

- Support better window position memory

- Add windows arm64 and linux arm64 build script

- Optimize some details

- Remake desktop

- Optimize change proxy

- Optimize network check

- Fix fallback issues

- Optimize lots of details

- Update change.yaml

- Fix android tile issues

- Fix windows tray issues

- Support setting bypassDomain

- Update flutter version

- Fix android service issues

- Fix macos dock exit button issues

- Add route address setting

- Optimize provider view

- Update CHANGELOG.md

- Add android shortcuts

- Fix init params issues

- Fix dynamic color issues

- Optimize navigator animate

- Optimize window init

- Optimize fab

- Optimize save

- Fix the collapse issues

- Add fontFamily options

- Update core version

- Update flutter version

- Optimize ip check

- Optimize url-test

- Update release message

- Init auto gen changelog

- Fix windows tray issues

- Fix urltest issues

- Add auto changelog

- Fix windows admin auto launch issues

- Add android vpn options

- Support proxies icon configuration

- Optimize android immersion display

- Fix some issues

- Optimize ip detection

- Support android vpn ipv6 inbound switch

- Support log export

- Optimize more details

- Fix android system dns issues

- Optimize dns default option

- Fix some issues

- Update readme

- Fix build error2

- Fix build error

- Support desktop hotkey

- Support android ipv6 inbound

- Support android system dns

- fix some bugs

- Fix delete profile error

- Fix submit error 2

- Fix submit error

- Optimize DNS strategy

- Fix the problem that the tray is not displayed in some cases

- Optimize tray

- Update core

- Fix some error

- Fix tun update issues

- Add DNS override

- Fixed some bugs

- Optimize more detail

- Add Hosts override

- fix android tip error

- fix windows auto launch error

- Fix windows tray issues

- Optimize windows logic

- Optimize app logic

- Support windows administrator auto launch

- Support android close vpn

- Change flutter version

- Support profiles sort

- Support windows country flags display

- Optimize proxies page and profiles page columns

- Update flutter version

- Update version

- Update timeout time

- Update access control page

- Fix bug

- Optimize provider page

- Optimize delay test

- Support local backup and recovery

- Fix android tile service issues

- Fix linux core build error

- Add proxy-only traffic statistics

- Update core

- Optimize more details

- Add fdroid-repo

- Optimize proxies page

- Fix ua issues

- Optimize more details

- Fix windows build error

- Update app icon

- Fix desktop backup error

- Optimize request ua

- Change android icon

- Optimize dashboard

- Remove request validate certificate

- Sync core

- Fix windows error

- Fix setup.dart error

- Fix android system proxy not effective

- Add macos arm64

- Optimize proxies page

- Support mouse drag scroll

- Adjust desktop ui

- Revert "Fix android vpn issues"

- This reverts commit 891977408e6938e2acd74e9b9adb959c48c79988.

- Fix android vpn issues

- Fix android vpn issues

- Rollback partial modification

- Fix the problem that ui can't be synchronized when android vpn is occupied by an external

- Override default socksPort,port

- Fix fab issues

- Update version

- Fix the problem that vpn cannot be started in some cases

- Fix the problem that geodata url does not take effect

- Update ua

- Fix change outbound mode without check ip issues

- Separate android ui and vpn

- Fix url validate issues 2

- Add android hidden from the recent task

- Add geoip file

- Support modify geoData URL

- Fix url validate issues

- Fix check ip performance problem

- Optimize resources page

- Add ua selector

- Support modify test url

- Optimize android proxy

- Fix the error that async proxy provider could not selected the proxy

- Fix android proxy error

- Fix submit error

- Add windows tun

- Optimize android proxy

- Optimize change profile

- Update application ua

- Optimize delay test

- Fix android repeated request notification issues

- Fix memory overflow issues

- Optimize proxies expansion panel 2

- Fix android scan qrcode error

- Optimize proxies expansion panel

- Fix text error

- Optimize proxy

- Optimize delayed sorting performance

- Add expansion panel proxies page

- Support to adjust the proxy card size

- Support to adjust proxies columns number

- Fix autoRun show issues

- Fix Android 10 issues

- Optimize ip show

- Add intranet IP display

- Add connections page

- Add search in connections, requests

- Add keyword search in connections, requests, logs

- Add basic viewing editing capabilities

- Optimize update profile

- Update version

- Fix the problem of excessive memory usage in traffic usage.

- Add lightBlue theme color

- Fix start unable to update profile issues

- Fix flashback caused by process

- Add build version

- Optimize quick start

- Update system default option

- Update build.yml

- Fix android vpn close issues

- Add requests page

- Fix checkUpdate dark mode style error

- Fix quickStart error open app

- Add memory proxies tab index

- Support hidden group

- Optimize logs

- Fix externalController hot load error

- Add tcp concurrent switch

- Add system proxy switch

- Add geodata loader switch

- Add external controller switch

- Add auto gc on trim memory

- Fix android notification error

- Fix ipv6 error

- Fix android udp direct error

- Add ipv6 switch

- Add access all selected button

- Remove android low version splash

- Update version

- Add allowBypass

- Fix Android only pick .text file issues

- Fix search issues

- Fix LoadBalance, Relay load error

- Fix build.yml4

- Fix build.yml3

- Fix build.yml2

- Fix build.yml

- Add search function at access control

- Fix the issues with the profile add button to cover the edit button

- Adapt LoadBalance and Relay

- Add arm

- Fix android notification icon error

- Add one-click update all profiles

- Add expire show

- Temp remove tun mode

- Remove macos in workflow

- Change go version

- Update Version

- Fix tun unable to open

- Optimize delay test2

- Optimize delay test

- Add check ip

- add check ip request

- Fix the problem that the download of remote resources failed after GeodataMode was turned on, which caused the application to flash back.

- Fix edit profile error

- Fix quickStart change proxy error

- Fix core version

- Fix core version

- Update file_picker

- Add resources page

- Optimize more detail

- Add access selected sorted

- Fix notification duplicate creation issue

- Fix AccessControl click issue

- Fix Workflow

- Fix Linux unable to open

- Update README.md 3

- Create LICENSE

- Update README.md 2

- Update README.md

- Optimize workFlow

- optimize checkUpdate

- Fix submit error

- add WebDAV

- add Auto check updates

- Optimize more details

- optimize delayTest

- upgrade flutter version

- Update kernel

- Add import profile via QR code image

- Add compatibility mode and adapt clash scheme.

- update Version

- Reconstruction application proxy logic

- Fix Tab destroy error

- Optimize repeat healthcheck

- Optimize Direct mode ui

- Optimize Healthcheck

- Remove proxies position animation, improve performance

- Add Telegram Link

- Update healthcheck policy

- New Check URLTest

- Fix the problem of invalid auto-selection

- New Async UpdateConfig

- add changeProfileDebounce

- Update Workflow

- Fix ChangeProfile block

- Fix Release Message Error

- Update Selector 2

- Update Version

- Fix Proxies Select Error

- Fix the problem that the proxy group is empty in global mode.

- Fix the problem that the proxy group is empty in global mode.

- Add ProxyProvider2

- Add ProxyProvider

- Update Version

- Update ProxyGroup Sort

- Fix Android quickStart VpnService some problems

- Update version

- Set Android notification low importance

- Fix the issue that VpnService can't be closed correctly in special cases

- Fix the problem that TileService is not destroyed correctly in some cases

- Adjust tab animation defaults

- Add Telegram in README_zh_CN.md

- Add Telegram

- update mobile_scanner

- Initial commit

## Unreleased (Avalon)

Avalon is a fork of [FlClash](https://github.com/chen08209/FlClash) (GPL-3.0), branched at `v0.8.96`.
The entries in this section describe the changes made in this fork; everything from `v0.8.96` down is
upstream FlClash history, kept for traceability.

- Rename the project to Avalon: application name, Dart package (`fl_clash` → `avalon`), application
  identifiers (`com.follow.clash` → `com.masteralanlab.avalon`), core and helper executables
  (`FlClashCore` / `FlClashHelperService` → `AvalonCore` / `AvalonHelperService`) and the custom URL
  scheme (`flclash://` → `avalon://`)

- Add a standalone node library: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS,
  SOCKS4/4a/5 and HTTP(S), plus Raw YAML/JSON nodes covering every mihomo proxy type

- Add multi-hop proxy chains: client → prepend → main → append → target, with proxy groups and existing
  local SOCKS/HTTP/HTTPS endpoints as hops, compiled through `dialer-proxy` inside a single core

- Add chain-to-profile binding with explicit entry groups, compile diagnostics and path preview

- Export nodes and chains as Clash config or JSON

## v0.8.96

- Optimize commented policy

- Fix whole group delay test failing on Windows

- Optimize package icon loading and connections polling

## v0.8.95

- Optimize core service

- Optimize Android TV launcher icon

- Optimize back navigation

- Optimize more details

- Fix some issues

- Optimize app layout

- Optimize focus control

- Adjust android process

## v0.8.94

- Fix macos performance issue

- Support custom global-ua

- Update core

- Optimize some details

- Fix linux silent launching not working

## v0.8.93

- Support custom overwrite

- Support run on demand

- Optimize windows ipc

- Optimize windows arm64

- Optimize build

- Optimize some details

- Update core

## v0.8.92

- Add sqlite store

- Optimize android quick action

- Optimize backup and restore

- Optimize more details

## v0.8.91

- Fix windows some issues

- Optimize overwrite handle

- Optimize access control page

- Optimize some details

## v0.8.90

- Fix android tile service

- Support append system DNS

- Fix some issues

- Update changelog

## v0.8.89

- Fix some issues

- Optimize Windows service mode

- Update core

- Update changelog

## v0.8.88

- Add android separates the core process

- Support core status check and force restart

- Optimize proxies page and access page

- Update flutter and pub dependencies

- Update go version

- Optimize more details

- Update changelog

## v0.8.87

- Optimize desktop view

- Optimize logs, requests, connection pages

- Optimize windows tray auto hide

- Optimize some details

- Update core

- Update changelog

## v0.8.86

- Fix windows tun issues

- Optimize android get system dns

- Optimize more details

- Update changelog

## v0.8.85

- Support override script

- Support proxies search

- Support svg display

- Optimize config persistence

- Add some scenes auto close connections

- Update core

- Optimize more details

## v0.8.84

- Fix windows service verify issues

- Update changelog

## v0.8.83

- Add windows server mode start process verify

- Add linux deb dependencies

- Add backup recovery strategy select

- Support custom text scaling

- Optimize the display of different text scale

- Optimize windows setup experience

- Optimize startTun performance

- Optimize android tv experience

- Optimize default option

- Optimize computed text size

- Optimize hyperOS freeform window

- Add developer mode

- Update core

- Optimize more details

- Add issues template

- Update changelog

## v0.8.82

- Optimize android vpn performance

- Add custom primary color and color scheme

- Add linux nad windows arm release

- Optimize requests and logs page

- Fix map input page delete issues

- Update changelog

## v0.8.81

- Add rule override

- Update core

- Optimize more details

- Update changelog

## v0.8.80

- Optimize dashboard performance

- Fix some issues

- Fix unselected proxy group delay issues

- Fix asn url issues

- Update changelog

## v0.8.79

- Fix tab delay view issues

- Fix tray action issues

- Fix get profile redirect client ua issues

- Fix proxy card delay view issues

- Add Russian, Japanese adaptation

- Fix some issues

- Update changelog

## v0.8.78

- Fix list form input view issues

- Fix traffic view issues

- Update changelog

## v0.8.77

- Optimize performance

- Update core

- Optimize core stability

- Fix linux tun authority check error

- Fix some issues

- Fix scroll physics error

- Update changelog

## v0.8.75

- Add windows storage corruption detection

- Fix core crash caused by windows resource manager restart

- Optimize logs, requests, access to pages

- Fix macos bypass domain issues

- Update changelog

## v0.8.74

- Fix some issues

- Update changelog

## v0.8.73

- Update popup menu

- Add file editor

- Fix android service issues

- Optimize desktop background performance

- Optimize android main process performance

- Optimize delay test

- Optimize vpn protect

- Update changelog

## v0.8.72

- Update core

- Fix some issues

- Update changelog

## v0.8.71

- Remake dashboard

- Optimize theme

- Optimize more details

- Update flutter version

- Update changelog

## v0.8.70

- Support better window position memory

- Add windows arm64 and linux arm64 build script

- Optimize some details

## v0.8.69

- Remake desktop

- Optimize change proxy

- Optimize network check

- Fix fallback issues

- Optimize lots of details

- Update change.yaml

- Fix android tile issues

- Fix windows tray issues

- Support setting bypassDomain

- Update flutter version

- Fix android service issues

- Fix macos dock exit button issues

- Add route address setting

- Optimize provider view

- Update changelog

- Update CHANGELOG.md

## v0.8.67

- Add android shortcuts

- Fix init params issues

- Fix dynamic color issues

- Optimize navigator animate

- Optimize window init

- Optimize fab

- Optimize save

## v0.8.66

- Fix the collapse issues

- Add fontFamily options

## v0.8.65

- Update core version

- Update flutter version

- Optimize ip check

- Optimize url-test

## v0.8.64

- Update release message

- Init auto gen changelog

- Fix windows tray issues

- Fix urltest issues

- Add auto changelog

- Fix windows admin auto launch issues

- Add android vpn options

- Support proxies icon configuration

- Optimize android immersion display

- Fix some issues

- Optimize ip detection

- Support android vpn ipv6 inbound switch

- Support log export

- Optimize more details

- Fix android system dns issues

- Optimize dns default option

- Fix some issues

- Update readme

## v0.8.60

- Fix build error2

- Fix build error

- Support desktop hotkey

- Support android ipv6 inbound

- Support android system dns

- fix some bugs

## v0.8.59

- Fix delete profile error

## v0.8.58

- Fix submit error 2

- Fix submit error

- Optimize DNS strategy

- Fix the problem that the tray is not displayed in some cases

- Optimize tray

- Update core

- Fix some error

## v0.8.57

- Fix tun update issues

- Add DNS override
- Fixed some bugs
- Optimize more detail

- Add Hosts override

## v0.8.56

- fix android tip error
- fix windows auto launch error

## v0.8.55

- Fix windows tray issues

- Optimize windows logic

- Optimize app logic

- Support windows administrator auto launch

- Support android close vpn

## v0.8.53

- Change flutter version

- Support profiles sort

- Support windows country flags display

- Optimize proxies page and profiles page columns

## v0.8.52

- Update flutter version

- Update version

- Update timeout time

- Update access control page

- Fix bug

## v0.8.51

- Optimize provider page

- Optimize delay test

- Support local backup and recovery

- Fix android tile service issues

## v0.8.49

- Fix linux core build error

- Add proxy-only traffic statistics

- Update core

- Optimize more details

- Merge pull request #140 from txyyh/main

- 添加自建 F-Droid 仓库相关 workflow
- Rename readme fingerprint

- Rename workflow deploy repo name

- Add download guide to README

- Add push release files to fdroid-repo

## v0.8.48

- Optimize proxies page

- Fix ua issues

- Optimize more details

## v0.8.47

- Fix windows build error

## v0.8.46

- Update app icon

- Fix desktop backup error

- Optimize request ua

- Change android icon

- Optimize dashboard

## v0.8.44

- Remove request validate certificate

- Sync core

## v0.8.43

- Fix windows error

## v0.8.42

- Fix setup.dart error

- Fix android system proxy not effective

- Add macos arm64

## v0.8.41

- Optimize proxies page

- Support mouse drag scroll

- Adjust desktop ui

- Revert "Fix android vpn issues"

- This reverts commit 891977408e6938e2acd74e9b9adb959c48c79988.

## v0.8.40

- Fix android vpn issues

- Fix android vpn issues

- Rollback partial modification

## v0.8.39

- Fix the problem that ui can't be synchronized when android vpn is occupied by an external

- Override default socksPort,port

## v0.8.38

- Fix fab issues

## v0.8.37

- Update version

- Fix the problem that vpn cannot be started in some cases

- Fix the problem that geodata url does not take effect

## v0.8.36

- Update ua

- Fix change outbound mode without check ip issues

- Separate android ui and vpn

- Fix url validate issues 2

- Add android hidden from the recent task

- Add geoip file

- Support modify geoData URL

## v0.8.35

- Fix url validate issues

- Fix check ip performance problem

- Optimize resources page

## v0.8.34

- Add ua selector

- Support modify test url

- Optimize android proxy

- Fix the error that async proxy provider could not selected the proxy

## v0.8.33

- Fix android proxy error

- Fix submit error

- Add windows tun

- Optimize android proxy

- Optimize change profile

- Update application ua

- Optimize delay test

## v0.8.32

- Fix android repeated request notification issues

## v0.8.31

- Fix memory overflow issues

## v0.8.30

- Optimize proxies expansion panel 2

- Fix android scan qrcode error

## v0.8.29

- Optimize proxies expansion panel

- Fix text error

## v0.8.28

- Optimize proxy

- Optimize delayed sorting performance

- Add expansion panel proxies page

- Support to adjust the proxy card size

- Support to adjust proxies columns number

- Fix autoRun show issues

- Fix Android 10 issues

- Optimize ip show

## v0.8.26

- Add intranet IP display

- Add connections page

- Add search in connections, requests

- Add keyword search in connections, requests, logs

- Add basic viewing editing capabilities

- Optimize update profile

## v0.8.25

- Update version

- Fix the problem of excessive memory usage in traffic usage.

- Add lightBlue theme color

- Fix start unable to update profile issues

- Fix flashback caused by process

## v0.8.23

- Add build version

- Optimize quick start

- Update system default option

## v0.8.22

- Update build.yml

- Fix android vpn close issues

- Add requests page

- Fix checkUpdate dark mode style error

- Fix quickStart error open app

- Add memory proxies tab index

- Support hidden group

- Optimize logs

- Fix externalController hot load error

## v0.8.21

- Add tcp concurrent switch

- Add system proxy switch

- Add geodata loader switch

- Add external controller switch

- Add auto gc on trim memory

- Fix android notification error

## v0.8.20

- Fix ipv6 error

- Fix android udp direct error

- Add ipv6 switch

- Add access all selected button

- Remove android low version splash

## v0.8.19

- Update version

- Add allowBypass

- Fix Android only pick .text file issues

## v0.8.18

- Fix search issues

## v0.8.17

- Fix LoadBalance, Relay load error

- Fix build.yml4

- Fix build.yml3

- Fix build.yml2

- Fix build.yml

- Add search function at access control

- Fix the issues with the profile add button to cover the edit button

- Adapt LoadBalance and Relay

- Add arm

- Fix android notification icon error

## v0.8.16

- Add one-click update all profiles
- Add expire show

## v0.8.15

- Temp remove tun mode

- Remove macos in workflow

- Change go version

## v0.8.14

- Update Version

- Fix tun unable to open

## v0.8.13

- Optimize delay test2

- Optimize delay test

- Add check ip

- add check ip request

## v0.8.12

- Fix the problem that the download of remote resources failed after GeodataMode was turned on, which caused the
  application to flash back.

- Fix edit profile error

- Fix quickStart change proxy error

- Fix core version

## v0.8.10

- Fix core version

## v0.8.9

- Update file_picker

- Add resources page

- Optimize more detail

- Add access selected sorted

- Fix notification duplicate creation issue

- Fix AccessControl click issue

## v0.8.7

- Fix Workflow

- Fix Linux unable to open

- Update README.md 3

- Create LICENSE
- Update README.md 2

- Update README.md

- Optimize workFlow

## v0.8.6

- optimize checkUpdate

## v0.8.5

- Fix submit error

## v0.8.4

- add WebDAV

- add Auto check updates

- Optimize more details

- optimize delayTest

## v0.8.2

- upgrade flutter version

## v0.8.1

- Update kernel
- Add import profile via QR code image

## v0.8.0

- Add compatibility mode and adapt clash scheme.

## v0.7.14

- update Version

- Reconstruction application proxy logic

## v0.7.13

- Fix Tab destroy error

## v0.7.12

- Optimize repeat healthcheck

## v0.7.11

- Optimize Direct mode ui

## v0.7.10

- Optimize Healthcheck

- Remove proxies position animation, improve performance
- Add Telegram Link

- Update healthcheck policy

- New Check URLTest

- Fix the problem of invalid auto-selection

## v0.7.8

- New Async UpdateConfig

- add changeProfileDebounce

- Update Workflow

- Fix ChangeProfile block

- Fix Release Message Error

## v0.7.7

- Update Selector 2

## v0.7.6

- Update Version

- Fix Proxies Select Error

## v0.7.5

- Fix the problem that the proxy group is empty in global mode.

- Fix the problem that the proxy group is empty in global mode.

## v0.7.4

- Add ProxyProvider2

## v0.7.3

- Add ProxyProvider

- Update Version

- Update ProxyGroup Sort

- Fix Android quickStart VpnService some problems

## v0.7.1

- Update version

- Set Android notification low importance

- Fix the issue that VpnService can't be closed correctly in special cases

- Fix the problem that TileService is not destroyed correctly in some cases

- Adjust tab animation defaults

- Add Telegram in README_zh_CN.md

- Add Telegram

## v0.7.0

- update mobile_scanner

- Initial commit