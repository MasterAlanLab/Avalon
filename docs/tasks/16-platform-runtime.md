# 全平台运行时接入

## 目标

把有效配置组装、输入入口和单 Core 链路接入桌面与 Android 生命周期，形成最小可用闭环。

## 输入

- `EffectiveConfigArtifact`。
- `CoreController`、`SetupAction`、Desktop lifecycle、Android `ServiceState`。
- 二维码、剪贴板和 App Link 输入。

## 输出

- revision-aware 防抖应用。
- Core 校验后的原子配置替换。
- QR/App Link 到 dispatcher 的接入。
- 本地 SOCKS/HTTP/HTTPS hop 的单 Core `dialer-proxy` 实现。

## 依赖

Task 10、11、15。

## 实现边界

- Desktop Core 进程所有权继续位于 `lib/core/desktop/`。
- Android 启停意图继续由 `ServiceState` 串行收敛。
- UI/provider 只请求配置或生命周期转换。
- 快速连续编辑时只应用最新 revision。
- 链路由最终 YAML 中的生成代理和 `dialer-proxy` 表达，桌面与 Android 共用同一组装结果。
- 本地端点必须由用户或系统已有服务监听；平台层不新增辅助 Core、独立进程、TUN owner 或 socket hook owner。
- 单节点、单 hop 链和多 hop 链共用同一 Core start/stop/restart 路径。

## 验收标准

- 运行中保存可更新最终 YAML。
- 校验 error 保留上一份有效配置和运行状态。
- 桌面、Android 的输入、绑定和链路结果一致。
- 配置中可检查后 hop 的 `dialer-proxy` 指向前 hop，运行期间只有一个 FlClash Core 生命周期。

## 测试

复用现有 lifecycle/provider 测试；本地监听端点可用性、真实 TUN 和系统代理采用手工验收。
