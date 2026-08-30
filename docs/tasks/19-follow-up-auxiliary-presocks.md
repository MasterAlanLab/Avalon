# Task 19：取消辅助 Core 方案

## 状态

取消，不进入当前版本实施。单 Core + Mihomo `dialer-proxy` 已覆盖远端前置、主节点、后置链路。

## 原目标

设计并实施与 v2rayN 第二 Core 类似的完整本地 PreSocks/TUN 外围链路。

## 输入

- 本轮单 Core local endpoint 模型。
- v2rayN `GetPreSocksItem` 和双 Core 启停顺序。
- FlClash Desktop lifecycle、Windows Helper、Android ServiceState 与 TUN hook。

## 原输出（归档）

- 独立 Core home、配置、socket、PID/session/lease 契约。
- Desktop 主/辅 Core 启停和崩溃收敛。
- Android 独立进程、Binder、VPN 保护和 TUN 所有权方案。
- 从单 Core local endpoint 到辅助 Core 的兼容迁移。

## 输出

- 取消双 Core 实施记录。
- 单 Core `dialer-proxy` 的范围和本地端点边界说明。

## 依赖

- 无；本任务仅保留决策记录，不进入实现依赖图。

## 原依赖

Task 16。

## 原实现边界（归档）

- 主 Core 与辅助 Core 使用独立运行目录和状态。
- Android 辅助 Core 通过独立进程隔离 Go 包级状态。
- 最新用户意图仍由唯一平台状态机收敛。

## 取消原因

- 双 Core 会引入第二套进程、socket、配置目录和生命周期收敛，增加桌面、Android、TUN/helper 的交叉状态。
- 当前需求的远端链路可以由 Task 11 生成代理的 `dialer-proxy` 表达，并由 Task 16 的既有 Core 生命周期加载。
- 本地 SOCKS/HTTP/HTTPS hop 保留为配置型端点；端点进程的管理超出当前极简范围。

## 验收标准

- 本任务不再新增主/辅 Core 的 start、stop、restart、crash 和升级顺序。
- TUN fd、socket hook、系统代理和 helper PID 各有唯一所有者。
- Task 16 的单 Core 远端 `dialer-proxy` 链路继续工作。

## 测试

不新增本任务测试；生命周期和链路测试归入 Task 16/17。
