# 最小测试与验收

## 当前进度（2026-08-30，第三轮）

检查记录列出的 R1–R9 已修复、补测并在第三轮复核无回退；第三轮新增 R10（外键级联未生效）待修复。
自动化基线中的 Dart 部分沿用第二轮结果，平台设备验收仍未开始。
逐项进度见 [开发进度总览](README.md)，问题现场见 [2026-08-30 检查记录](review-2026-08-30.md)，
修复明细见 [修复记录](fixes-2026-08-30.md)，复核结论见 [复核记录](verify-2026-08-30.md)。

## 目标

以极少的测试文件覆盖最关键的数据转换、链编译和迁移不变量。

## 输入

- Task 00–16 的公共契约和实现；Task 19 已取消，不作为依赖。

## 输出

- `test/nodes/node_codec_test.dart`。
- `test/nodes/chain_compiler_test.dart`。
- `test/database/node_chain_migration_test.dart`。
- `test/common/task_test.dart` 的少量有效配置断言。
- 桌面/Android 手工验收矩阵。

## 依赖

Task 00–16。

## 实现边界

- 协议测试采用一个表驱动文件。
- 链路所有异常分支采用一个编译器文件。
- 数据库、同步和备份核心路径采用一个迁移文件。
- UI、每个协议、每个 provider 分别建测试文件的做法不进入本轮。

## 验收标准

- VLESS Reality、VMess、SS、Trojan、Hysteria2、TUIC、AnyTLS、SOCKS5 有代表性样例。
- 链方向、组分支、循环、上限、重名和后 hop `dialer-proxy` 有断言。
- 单 hop、远端前置/主/后置和本地 SOCKS/HTTP/HTTPS endpoint 的单 Core 配置有断言或手工验收项。
- v2→v3、overlay、绑定和资产备份恢复有断言。
- `flutter analyze --no-fatal-infos` 与 `flutter test --reporter expanded` 通过。

## 测试

本文件本身就是最终测试清单。

## 本次实际执行结果

检查对象为 `main` 分支、`1a666fb` 开发快照之上的当前工作区。
使用 macOS 上的 Flutter 3.47.2 / Dart 3.13.2，并按 CI 固定的 Flutter 3.44.4 / Dart 3.12.2 复验。

| 检查 | 2026-08-30 第二轮结果 | 覆盖边界 |
| --- | --- | --- |
| `flutter pub get` | 通过 | 依赖文件内容与修复前一致 |
| `flutter analyze --no-fatal-infos` | 通过：0 error、0 warning、28 info | 根包分析范围，遵循现有排除配置 |
| `flutter test --reporter expanded` | 通过：791 项 | 根包 `test/`；不含原生平台测试 |
| `flutter test` on `plugins/proxy`、`plugins/wifi_ssid` | 通过：26 项 | 嵌套插件 Dart 测试 |
| `dart test`，工作目录 `plugins/setup/buildkit/build_tool` | 通过：27 项 | 构建工具 |
| `CGO_ENABLED=0 go build ./...`，工作目录 `core/` | 通过 | 子模块初始化后的 Go 包装层 |
| `CGO_ENABLED=0 go test .`，工作目录 `core/` | 通过：6 项 | `handleValidateConfig` 校验用例 |
| `git diff --check` | 通过 | Git 已跟踪文件的工作区差异 |
| CI 固定 SDK 复验（Flutter 3.44.4 / Dart 3.12.2） | 通过：analyze 0 error / 0 warning / 28 info，测试 791 项 | 独立 SDK 目录，复验后还原 `pubspec.lock` |
| Rust、原生构建、真实 Core 连通性 | 本次未执行 | 保留为后续验证 |

通过现有测试代表已有断言成立，不代表所有任务验收标准均已覆盖。
第二轮新增断言覆盖 R1–R9，明细见 [修复记录](fixes-2026-08-30.md)。

### 第三轮复核（同日）

用 Flutter 3.47.2 / Dart 3.13.2 全量复跑上表命令，结果与第二轮完全一致、无回退：
analyze 0 error / 0 warning / 28 info，根包 791 项、嵌套插件 26 项、构建工具 27 项通过，
`core/` 的 `go build ./...` 与 `go test -count=1 .`（6 项，非缓存）通过。
其余为代码级复核，结论见 [复核记录](verify-2026-08-30.md)。

已知测试缺口：`test/database/` 没有删除节点、删除 Profile 的级联/清理用例，
这正是 R10 能通过全部现有断言的原因——本轮用一次性探针实测确认外键未生效后即删除探针，
修复时应把该场景补成常驻用例。

## 平台手工验收矩阵

以下项目尚无本轮设备实测结果，均保留为待验收。每次执行应补记操作系统、应用构建、Core 版本和结果。

| 场景 | 核查点 | macOS | Windows | Linux | Android |
| --- | --- | --- | --- | --- | --- |
| 无订阅、仅单节点 | 创建本地 Profile，添加或导入节点，绑定并选用，实际流量通过节点 | 待验收 | 待验收 | 待验收 | 待验收 |
| 单 hop / 前置→主节点→后置 | 配置顺序与实际出口一致，只有一个 FlClash Core 生命周期 | 待验收 | 待验收 | 待验收 | 待验收 |
| 外部本地 SOCKS/HTTP/HTTPS 端点 | 端点可达时连通；端点停止后有错误反馈，外部进程保持独立 | 待验收 | 待验收 | 待验收 | 待验收 |
| 链绑定与默认选择 | 多 Profile 绑定、切换链、禁用和删除后行为一致，原 Profile 选择保留 | 待验收 | 待验收 | 待验收 | 待验收 |
| 快速编辑与校验失败 | 最新配置最终生效；错误配置保留上一份有效 YAML 与运行状态 | 待验收 | 待验收 | 待验收 | 待验收 |
| 输入入口 | 粘贴、文件、剪贴板、App Link；支持扫码的平台另验二维码；订阅 URL 分流正确 | 待验收 | 待验收 | 待验收 | 待验收 |
| 编辑与诊断 | 常用表单/Raw 编辑、未知字段保留、敏感值遮罩、warning 确认和 error 阻断 | 待验收 | 待验收 | 待验收 | 待验收 |
| 迁移与备份恢复 | 真实 v2 数据升级、旧/新 ZIP、节点资产与 overlay、损坏归档后的旧数据保留 | 待验收 | 待验收 | 待验收 | 待验收 |
| 生命周期与系统接入 | start/stop/restart、系统代理、TUN；Windows Helper；Android VPN 权限和撤销 | 待验收 | 待验收 | 待验收 | 待验收 |

## 收尾顺序

1. ~~按检查记录修复具体功能缺陷，并在现有测试文件补充对应断言。~~ 已完成，见 [修复记录](fixes-2026-08-30.md)。
2. ~~初始化锁定的 Core 子模块，补 Go 检查。~~ 已完成；各平台原生构建仍待执行。
3. ~~使用 CI 固定 SDK 执行 analyze 与 test。~~ 已完成；平台构建作业仍待执行。
4. 修复 R10 并补 `test/database/` 的删除用例，见 [复核记录](verify-2026-08-30.md)。
5. 执行上面的手工矩阵；真实结果补齐后再标记平台验收完成。
   已有改动中最需要设备验证的是链入口选用、应用失败补偿和 Windows 热链接三条路径。
