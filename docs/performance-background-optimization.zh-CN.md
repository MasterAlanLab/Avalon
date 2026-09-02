# Avalon 后台低资源占用优化方案

## 1. 目标与约束

目标是在 Avalon 窗口隐藏、最小化或进入托盘时，把 Flutter/Dart/插件侧的资源消耗降到最低，同时保持：

1. 代理、TUN、系统代理、DNS 和现有 mihomo 配置持续正常工作。
2. Avalon 回到前台后，导航、节点管理、连接/请求、日志、托盘菜单和 Dashboard 功能保持原有行为。
3. 前台仍然可以使用实时流量图和连接列表；后台只降低非必要的 UI 遥测、绘制和事件分发频率。

优化边界是 UI 和遥测层，不通过停止 mihomo listener、关闭 TUN 或清空代理连接来换取低占用。

## 2. 现状结论

### 2.1 已经具备页面生命周期控制的部分

`/Users/alan/code/Avalon/lib/widgets/active_polling.dart:24-60` 的 `ActivePollingMixin` 同时检查 `mounted`、Flutter 生命周期和 `PageActivityScope`。以下组件在切换页面或进入非 `resumed` 状态时会停止主动轮询：

- `/Users/alan/code/Avalon/lib/views/dashboard/widgets/memory_info.dart`（约 2 秒）
- `/Users/alan/code/Avalon/lib/views/connection/connections.dart`（约 1 秒）
- `/Users/alan/code/Avalon/lib/widgets/builder.dart`（`TickBuilder`）

现有测试 `/Users/alan/code/Avalon/test/widgets/builder_test.dart`、`/Users/alan/code/Avalon/test/widgets/memory_info_test.dart` 和 `/Users/alan/code/Avalon/test/widgets/connections_view_test.dart` 已覆盖页面 inactive 和 AppLifecycleState paused 的停止行为。

### 2.2 主要后台消耗来源

#### A. 全局 1 秒流量 Timer

`/Users/alan/code/Avalon/lib/providers/actions/setup.dart:41-62` 在代理运行时创建 `Timer.periodic(1s)`。每次执行：

```text
_refreshRunningState()
 ├─ 更新 runTimeProvider
 └─ updateTraffic()
      ├─ getTraffic()
      └─ getTotalTraffic()
```

这条 Timer 是 `SetupAction` 的 keep-alive 状态，当前只在 `setRunning(false)` 时取消；页面、窗口可见性、窗口焦点和生命周期都没有参与判断。

`/Users/alan/code/Avalon/lib/providers/actions/common.dart:30-44` 会写入 `trafficsProvider` 和 `totalTrafficProvider`。因此即使 Dashboard 图表已经移除，后台仍会产生 Dart 调度、两次 IPC 和 Provider 更新。

此外，Timer 使用 `unawaited` 启动请求，没有 in-flight 限制；当 Core RPC 超过 1 秒时，下一轮可能与上一轮重叠。

#### B. Dashboard 数据消费者和动画

- `/Users/alan/code/Avalon/lib/views/dashboard/widgets/network_speed.dart:48-87` 监听 `trafficsProvider`。
- `/Users/alan/code/Avalon/lib/views/dashboard/widgets/traffic_usage.dart:63-95` 监听 `totalTrafficProvider`。
- `TrafficUsage` 使用默认 300ms 的 `DonutChart` 过渡动画；每次数据更新都会触发新的绘制周期。
- Dashboard 页面在 `/Users/alan/code/Avalon/lib/common/navigation.dart:13-20` 设置为 `keep:false`，离开缓存范围后通常会释放，但这只影响图表 Widget，不会取消全局流量 Timer。

#### C. 托盘网速标题

macOS 下 `/Users/alan/code/Avalon/lib/providers/state.dart:159-167` 从 `trafficsProvider` 派生 `trayTitleState`，`/Users/alan/code/Avalon/lib/manager/tray_manager.dart:27-35` 再调用托盘插件更新标题。`showTrayTitle` 默认值为 true（`/Users/alan/code/Avalon/lib/models/config.dart:80-84`）。所以窗口隐藏后，流量采样仍可能每秒触发一次原生托盘调用。

#### D. 高频 RPC 日志

`/Users/alan/code/Avalon/lib/core/interface.dart:82-106` 在执行监控打开时为 RPC 记录开始和结束日志；当前 `/Users/alan/code/Avalon/lib/common/constant.dart` 的 `watchExecution` 默认关闭，因此发布构建通常不会产生这组成功日志。若调试构建开启该监控，流量 Timer 的两个 RPC 每秒可能产生约 4 条 App 日志；`/Users/alan/code/Avalon/lib/common/print.dart:17-25` 在已 attach 后还会写入 `logsProvider`。

如果 Logs 页面已经访问过，它在 `/Users/alan/code/Avalon/lib/views/logs.dart:24-41,84-103` 继续监听并安排本地刷新。Requests 页面也有类似行为（`/Users/alan/code/Avalon/lib/views/connection/requests.dart:38-81`）。

#### E. 页面级持续动画

`/Users/alan/code/Avalon/lib/pages/home.dart:121-126` 使用 `ExcludeFocus`，它只控制焦点，不会关闭动画。当前页面层没有统一的 `TickerMode`；以下组件存在永久重复动画：

- `/Users/alan/code/Avalon/lib/widgets/loading.dart:117-136`
- `/Users/alan/code/Avalon/lib/widgets/wave.dart:23-32`

其他导航项默认由 `/Users/alan/code/Avalon/lib/widgets/keep_scope.dart:3-22` 保活，因此已经创建的非当前页面仍可能保留 Ticker 和 Provider 监听。

#### F. 隐藏窗口的帧暂停不等于后台暂停

`/Users/alan/code/Avalon/lib/common/window.dart:71-96` 和 `/Users/alan/code/Avalon/lib/manager/window_manager.dart:85-98` 在 hide/minimize 时调用 `render.pause()`。但 `/Users/alan/code/Avalon/lib/common/render.dart:24-53`：

- 延迟 5 秒才暂停；
- 只把 `onBeginFrame` / `onDrawFrame` 设为空；
- 不会取消 Timer、IPC、Provider 更新、日志或托盘调用。

当前窗口管理器实现了 `onWindowFocus`，没有实现 `onWindowBlur`。单纯失去焦点时，页面轮询是否停止取决于 Flutter 是否同时发出非 `resumed` 生命周期；全局流量 Timer 始终不受影响。

## 3. 设计原则

1. **代理核心与 UI 解耦**：后台阶段保留 mihomo listener、TUN、系统代理、DNS、节点连接和健康检查。
2. **统一活动状态**：用一个全局状态同时表示 Flutter lifecycle、窗口可见性和窗口焦点，避免每个 Widget 各自猜测。
3. **需求驱动遥测**：只有当前前台功能需要实时数据时才使用 1 秒采样；后台使用低频采样或暂停。
4. **恢复时即时刷新**：窗口恢复或页面重新激活时立即进行一次流量、连接和运行时长刷新，避免显示旧数据。
5. **保留诊断数据**：日志和请求事件采用有界缓存/批量刷新，不因页面隐藏而无限累积，也不因暂停 UI 而丢失核心功能所需的数据。

## 4. 分阶段优化方案

### P0：统一窗口活动状态，并控制全局遥测

新增一个长期存活的 `appActivityProvider`（名称可按项目风格调整），至少包含：

```text
isLifecycleResumed
isWindowVisible
isWindowFocused
isUiActive = 三者均为 true
```

状态来源：

- `AppStateManager.didChangeAppLifecycleState`；
- `WindowManager.onWindowFocus` / 新增 `onWindowBlur`；
- `onWindowMinimize` / `onWindowRestore`；
- `Window.show()` / `Window.hide()`；
- 启动时读取一次 `windowManager.isVisible()`，覆盖静默启动场景。

将 `SetupAction` 的流量调度改为“前台需求驱动”：

```text
代理运行中
 ├─ isUiActive && Dashboard 需要实时流量：1 秒采样
 ├─ 窗口隐藏但 showTrayTitle=true：5 秒左右低频采样
 └─ 窗口隐藏且无托盘速度需求：暂停采样

恢复前台：立即采样一次，然后恢复 1 秒周期
```

`runTimeProvider` 也不必在后台每秒写入；后台只保留 `_startTime`，恢复前台时根据当前时间计算一次即可。这样不会影响 StartButton 的显示精度。

同时给流量请求增加单飞保护：上一轮仍在执行时跳过下一轮，或者改为“请求完成后再安排下一轮”，避免慢 RPC 叠加。

### P0：页面统一使用 TickerMode

在 `/Users/alan/code/Avalon/lib/pages/home.dart:121-126` 的 `PageActivityScope` 内层加入：

```dart
TickerMode(
  enabled: isActive && appActivity.value.isUiActive,
  child: ExcludeFocus(...),
)
```

页面重新激活时 Flutter 会自动恢复动画；前台交互保持原样，也不需要每个动画组件单独实现生命周期逻辑。

### P1：后台事件批量化，保持日志/请求语义

1. `LogsView` 和 `RequestsView` 的 Provider listener 在页面 inactive 时只更新有界缓存，不更新 `ValueNotifier` 和列表布局；页面重新激活后一次性提交最新快照。
2. 保留 Core 的日志/请求事件通道，避免代理诊断功能发生语义变化；UI 层使用批量合并和最大长度限制。
3. 对 `getTraffic`、`getTotalTraffic` 的成功 RPC 日志做采样或关闭，仅保留异常和耗时超阈值日志。其他用户可见操作日志保持不变。

### P1：托盘标题降频与去重

在 `/Users/alan/code/Avalon/lib/common/tray.dart` 或 `TrayManager` 增加：

- 只有格式化后的 `trayTitle` 真正变化时才调用原生插件；
- 前台可维持 1 秒更新；后台改为 3–5 秒更新；
- 用户关闭“托盘网速显示”时完全停止该消费者。

托盘菜单的启动/停止、模式切换、显示窗口等操作保持原样。

需要注意托盘网速标题只有 macOS 有实现（`Tray.updateTrayTitle` 在 `!isMacOS` 时直接返回，`TrayManager` 的监听也包在 `if (system.isMacOS)` 内），而 `showTrayTitle` 默认值为 true。因此“后台是否需要流量”必须先判断平台，否则 Windows/Linux/Android 会为一个并不存在的消费者维持后台采样。

### P1：Dashboard 遥测需求声明

利用已有 `dashboardWidgets` 状态（`/Users/alan/code/Avalon/lib/providers/state.dart:198-204`）建立两个派生条件：

```text
dashboardNeedsTraffic = 当前页为 Dashboard 且包含 networkSpeed 或 trafficUsage
dashboardNeedsMemory  = 当前页为 Dashboard 且包含 memoryInfo
```

这样关闭 Dashboard 图表后，流量曲线和总流量的高频 Provider 更新自然停止；保留代理运行、托盘和其他非图表功能。

### P2：合并 Core 流量查询

新增一个 Core 方法，例如 `getTrafficSnapshot`，一次返回当前速度和累计流量，替代每秒两个 RPC。此项需要同步 Dart/Core 接口和测试，收益小于前述生命周期门控，建议在 P0/P1 验证有效后实施。

### P2：收紧隐藏帧暂停策略

保留现有 `Render` 作为兜底，但在确认窗口已 hidden/minimized 后把 5 秒延迟缩短到 200–500ms；Tray 菜单交互和恢复窗口路径需要回归测试。单纯失焦是否暂停帧，建议由统一 `appActivityProvider` 控制，不再依靠零散调用。

关于“失焦是否暂停帧”，结论是**不暂停**：窗口失焦后仍然可见，macOS 允许对非活动窗口滚动和悬停，一旦停止提交帧这些交互会表现为画面冻结。失焦只用于关闭遥测和 Ticker，帧暂停只在 hidden/minimized 后触发。

## 5. 恢复行为与兼容性

### 代理功能

后台状态只影响 UI 遥测和绘制，不调用 `stopListener()`，不修改 TUN、系统代理、DNS、规则、节点连接或健康检查。因此 HTTP/HTTPS/SOCKS 代理和 TUN 流量保持连续。

### Dashboard

回到前台时：

1. 立即拉取一次当前速度和累计流量；
2. 使用 Core 累计值更新 `TrafficUsage`；
3. 以最新样本继续 `NetworkSpeed` 曲线；
4. 恢复 1 秒采样和前台动画。

后台暂停期间的曲线可能出现时间间隔，但不会影响代理统计的累计值。若产品要求曲线无间隔，可保留 5–10 秒低频采样作为折中。

### 日志和请求

使用有界环形缓存并在恢复时批量刷新，避免后台事件无限增长。恢复后日志、请求列表仍包含后台期间已经产生的事件；高频 RPC 的内部成功日志属于噪声，可单独降采样。

## 6. 预期收益排序

| 优化项 | 预期收益 | 说明 |
| --- | --- | --- |
| 页面级 `TickerMode` + 关闭 Dashboard 图表 | 高 | 直接减少 Flutter frame、动画 tick 和图表重绘，对 GPU/WindowServer 最敏感 |
| `SetupAction` 前台按需采样 | 中到高 | 去掉后台固定 1 秒 Timer、Provider 通知和 IPC；对 Dart CPU、消息量最有效 |
| 日志批量化与高频 RPC 日志降采样 | 中 | 减少对象创建、列表复制和 LogsView 调度，后台事件多时收益更明显 |
| 托盘标题限频/去重 | 低到中 | 保留托盘功能，减少 macOS 原生插件调用 |
| 合并两个流量 RPC | 中 | 需要改 Dart/Core 协议，适合作为后续专项优化 |

预期结果是：代理核心的必要开销基本保持，Avalon 的 UI、Dart 调度和 WindowServer 额外开销明显下降。实际幅度以前台/后台、图表开关和托盘标题开关的基线测试为准。

## 7. 验证计划与目标

### 功能回归

- 后台持续访问网页，确认系统代理/TUN、DNS、连接复用和节点切换正常。
- 托盘菜单可以启动/停止、切换模式、显示窗口。
- 前台打开 Dashboard、Connections、Requests、Logs，确认数据立即恢复。
- 切换 Dashboard 图表配置，确认图表重新启用后实时更新。

### 资源指标

分别测试“Dashboard 图表开启/关闭”“窗口前台/失焦/最小化/托盘”“托盘网速标题开启/关闭”：

| 指标 | 目标 |
| --- | --- |
| 隐藏 30 秒后的 Avalon CPU | 接近空闲，避免持续 1 秒 UI 更新 |
| 隐藏后的 Flutter frame | 无持续帧提交；恢复时立即可绘制 |
| 后台流量 RPC | 暂停或降到 3–5 秒一次，无重叠请求 |
| AvalonCore | 仅保留代理/TUN 必需工作，UI 优化前后都应保持连接连续 |
| WindowServer | 窗口隐藏后明显低于前台 Dashboard 状态 |
| 日志/请求缓存 | 有界，无持续增长 |

建议使用 Activity Monitor、Flutter DevTools Timeline 和 Instruments 分别记录 Avalon、AvalonCore、WindowServer、GPU、IPC 次数及帧提交数。

## 8. 风险、回滚与实施顺序

| 风险 | 处理方式 |
| --- | --- |
| 后台托盘速度变旧 | 保留 3–5 秒低频采样，恢复前台立即刷新 |
| 暂停 UI 时日志/请求丢失 | 采用有界缓存，恢复时批量提交 |
| 生命周期事件顺序不稳定 | 状态机去重，所有入口幂等；启动时主动读取窗口可见性 |
| 修改 Render 影响托盘交互 | 先只做 Timer/Provider/Ticker 门控，Render 延迟策略放到 P2 |
| 合并 Core RPC 引入协议回归 | 作为独立 P2 变更，保留旧接口作为回滚路径 |

推荐实施顺序：

1. P0 活动状态 + `SetupAction` 遥测门控 + 单飞保护。
2. P0 页面级 `TickerMode`。
3. P1 日志/请求批量刷新和高频 RPC 日志降采样。
4. P1 托盘标题限频、Dashboard 遥测需求声明。
5. 用实测 CPU/WindowServer 数据决定是否实施 P2 Core RPC 合并和更短的 Render pause。

## 9. 落地状态

### 第一轮改动

已完成的第一轮改动：

- `AppActivityController` 统一维护 Flutter lifecycle、窗口可见性和窗口焦点。
- `SetupAction` 根据前台状态、Dashboard 图表需求和托盘网速需求选择 1 秒、5 秒或暂停，并加入流量请求单飞保护。
- Dashboard 页面通过 `TickerMode` 关闭非活动页面的动画 tick。
- Application 根节点也通过 `TickerMode` 暂停全局状态提示和其他后台动画。
- NetworkSpeed/TrafficUsage 在窗口非活动时暂时解除流量 Provider 订阅，恢复时重建数据视图。
- 接入 `onWindowBlur`，并在 show/hide/minimize/restore 路径同步活动状态。
- Logs/Requests 页面在非当前页时保留缓存，恢复页面后再提交 UI 快照。
- Logs/Requests 监听直接使用有界状态，避免后台事件经过额外的深度列表比较。
- 托盘标题在 `Tray.updateTrayTitle` 集中做格式化结果去重，覆盖状态更新和流量更新路径。
- `getTraffic` / `getTotalTraffic` 绕过调试 RPC 成功日志的计时包装，保留错误处理和用户可见操作日志。

本轮状态对象实现于 `/Users/alan/code/Avalon/lib/common/activity.dart`，通过 `appActivity` 全局 `ValueNotifier` 提供给窗口、生命周期、轮询和页面树；行为等价于前文设计中的 `appActivityProvider`。

### 第二轮改动（修复第一轮遗留缺口）

第一轮复查发现四个缺口，均已修复：

1. **托盘需求缺少平台判断**。`_needsTraffic` 直接读 `showTrayTitle`，而该标题只有 macOS 实现，默认值又是 true，导致 Windows/Linux/Android 后台永远降到 5 秒而不是暂停，且这 5 秒的 IPC 没有任何消费者。现在通过 `SetupAction.supportsTrayTitle`（默认 `system.isMacOS`）先判断平台，再读取设置。
2. **失焦即暂停帧超出方案范围**。`onWindowBlur` 原本调用 `render?.pause()`，会让可见但未聚焦的窗口在 5 秒后停止提交帧，滚动和悬停表现为冻结。现在失焦只更新 `appActivity`，帧暂停交给 hidden/minimized 路径。
3. **Logs/Requests 只按页面活动门控**。两个视图原本只看 `PageActivityScope`，窗口隐藏但停留在 Logs 页时，节流器和最多 500 条的深度列表比较照常运行。现在抽出 `ActiveSnapshotMixin`（`/Users/alan/code/Avalon/lib/widgets/active_snapshot.dart`），把“当前页”和 `appActivity.isUiActive` 合并成一个可观测状态，两者同时满足才提交 UI 快照。
4. **`AppActivityController.setWindowVisible` 是死代码**，`lib/` 下无调用点，已删除。

同时落地了 P2 的帧暂停收紧：`Render.pause` 接受 `delay` 参数，`Render.idlePauseDelay` 保持 5 秒（托盘菜单交互等仍在屏幕上的场景），`Render.hiddenPauseDelay` 为 300ms，由 `Window.hide()` 和 `onWindowMinimize` 使用。由于 `Throttler` 会保留先到的定时器，`pause` 在收到更短的延迟时会先取消再重新计时，保证隐藏路径不会被托盘路径的 5 秒拖住。

### 验证结果

- `flutter analyze`：无 error。
- `flutter test`：851 项全部通过，其中新增 `test/providers/telemetry_gating_test.dart`（10 项，覆盖 1 秒/5 秒/暂停的区间选择、平台判断、Dashboard 图表开关、单飞保护、恢复即刻补采样、后台不写 runTime）、`test/widgets/active_snapshot_test.dart`（5 项）、`test/common/render_test.dart`（5 项），并扩充了 `test/common/activity_test.dart`。
- Android 模拟器（Pixel，API 36，arm64）实测。Android 没有托盘，`supportsTrayTitle` 为 false，是缺口 1 的最直接验证场景：

| 阶段 | 观测 |
| --- | --- |
| 前台停留 Dashboard | `interval=1000ms`，稳定 1 次/秒 |
| 按 HOME 进入后台 | `ui=false needsTraffic=false interval=null` → `interval=stopped`，**25 秒内 0 次 tick** |
| 切回前台 | `ui=true needsTraffic=true interval=1s` → 立即补采样一次，随后恢复约 1 次/秒（10 秒 12 次） |

修复前同样场景会是 `interval=5000ms` 并持续采样。另外由于模拟器上 Core 未启动，首个流量 RPC 一直挂起，日志显示后续 tick 全部没有发起新请求——这也在真机路径上验证了单飞保护。

### 已放弃

**P2 Core 流量快照合并（`getTrafficSnapshot`）不再实施。** 该改动要动 `core/constant.go`、`core/method.go`、`core/lib.go` 和 Dart 侧接口，并为 macOS/Windows/Linux/Android 分别重建原生核心。按第 8 节的约定，它由实测数据决定，而实测结论是：后台已经完全停止采样，只剩前台每秒省下 1 次 IPC，收益与协议回归风险和跨平台重建成本不成正比。此项关闭，不再作为后续项跟踪。

### 仍未实施

后台事件更细粒度的批处理（合并连续事件而非仅推迟提交）保留为后续项。目前 Logs/Requests 在非活动期间已经不做列表比较和 UI 提交，事件本身由 `FixedList(500)` 有界承接，进一步合并的收益需要在事件高频场景下另行测量。

该方案的关键点是：**关闭 Dashboard 图表后，不只是隐藏图表 Widget，还要让流量遥测从“固定 1 秒全局刷新”变成“前台按需刷新、后台低频或暂停、恢复立即补采样”。** 这样才能在代理持续工作的前提下，把 Avalon 挂在后台时的资源占用降到最低。
