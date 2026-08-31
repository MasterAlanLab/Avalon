# 链路领域契约

## 进度补充（2026-08-30）

下面「输出」列出的是草案类型名：`ProxyChainRecord` → `ProxyChain`、
`ProfileChainBinding` → `ProxyChainBinding`、`ChainTargetRef` 在持久化侧为 `ProxyChainHop`、
在编译期为 `ChainTarget`；`ChainDiagnostic` 与 `ChainCompileResult` 同名。
完整对照表见 [复核记录](verify-2026-08-30.md)。

分支上限、循环与本地端点已复核：`branchLimit` 默认 64、校验范围 1–1024、超限给
`branch-limit-exceeded` error，组循环给 `group-cycle`，本地端点接受 `http` / `socks` / `socks5`
（UI 的 HTTPS 落为 `type: http` + `tls: true`）。

## 目标

定义可变多跳、策略组分支和 Profile 绑定的全局链路模型，并固定单 Core 的编译语义。

## 输入

- Task 01 节点契约。
- Mihomo `dialer-proxy` 连接语义和单 Core 运行边界。
- v2rayN Prev/Main/Next 链路行为。

## 输出

- `ProxyChainRecord`、`ProxyChainHop`、`ChainTargetRef`。
- `ProfileChainBinding`、`ChainDiagnostic`、`ChainCompileResult`。
- 节点、全局组、Profile 组、本地 SOCKS/HTTP/HTTPS 端点四类 hop。
- 本地端点是外部已监听的 Mihomo-compatible upstream，不产生独立 Core 生命周期。

## 依赖

Task 01。

## 实现边界

- 展示方向固定为客户端 → 前置 → 主节点 → 后置 → 目标；列表顺序就是拨号嵌套顺序。
- 编译时每个路径克隆一份 hop 节点，后一个 hop 的 `dialer-proxy` 指向前一个 hop；最终入口为最后一个 hop 的生成节点。
- 单 hop 链等价于该节点的单 Core 运行，不额外生成辅助进程。
- 本地端点的 server/port 必须在 Core 运行期间可达；端点失效由 Core 连接错误反馈。
- 链路默认分支上限为 64，可配置为 1–1024。
- `error` 阻断保存应用，`warning` 经用户确认后继续。

## 验收标准

- 任意长度链路均能按 order 重建。
- 策略组 hop 可产生确定的分支矩阵。
- 默认链设置与原 Profile 选择互不覆盖，未绑定链路的 Profile 保持原有入口。
- 任意生成路径只依赖一个 Core 配置和一个 Core 生命周期。

## 测试

在 `test/nodes/chain_compiler_test.dart` 覆盖方向、分支、循环和上限。
