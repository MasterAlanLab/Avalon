# 产品与协议契约

## 目标

冻结单节点库、订阅同步和单 Core 链式代理的产品口径，作为后续任务的唯一协议清单与验收基线。

## 输入

- 当前 FlClash Profile、二维码、App Link 和运行配置流程。
- 当前项目锁定的 Mihomo 版本及其 `proxies` 配置字段。
- v2rayN 的节点编解码和前置/主节点/后置链路展示语义。
- 已确认的全局节点库、全局链库、单 Core 和最小测试决策。

## 输出

- 专用 URI/表单协议：VLESS、VMess、Shadowsocks、Trojan、Hysteria2、TUIC、AnyTLS、SOCKS4/4a/5。
- Raw YAML/JSON 覆盖所有 Mihomo proxy type，包括后续新类型。
- 普通 `http://`、`https://` 地址作为订阅地址；带显式端口、认证或代理参数的 HTTP(S) URI 作为单节点解析，歧义地址可使用 Raw 编辑器。
- 节点、来源、绑定、链路、hop、覆盖、stale、warning 和 error 的术语表。
- 桌面与 Android 共用的验收矩阵。
- 单节点直连和“前置 → 主节点 → 后置”链路的选择语义。

## 依赖

无。

## 实现边界

- 首期专用表单只覆盖上列常用协议；其他 Mihomo 类型通过 Raw 记录保存和运行。
- Raw 节点参与保存、绑定、链路、运行校验和 Clash/JSON 导出。
- 每条链路都在最终 Profile 中展开为生成代理，后一个 hop 的 `dialer-proxy` 指向前一个 hop；不启动第二个 Core。
- 本地 SOCKS/HTTP/HTTPS hop 表示已经存在的本地监听端点，FlClash 只把它作为 Mihomo proxy 使用，不负责启动、停止或接管该进程。
- 单节点未绑定链路时保持原始节点配置和直连行为；链路绑定只改变 Profile 的入口组。

## 验收标准

- 每个 Mihomo proxy type 至少具有 Raw 导入、编辑、绑定和运行校验路径。
- 每个专用协议具有 URI 导入和可用的表单字段，SOCKS4/4a/5 的 scheme 和默认端口明确。
- 订阅 URL 与节点 URI 的分流结果唯一。
- 绑定前置、主节点、后置 hop 后，最终选择链 selector 即可由单 Core 建立完整顺序。

## 测试

本任务只冻结契约，行为由 Task 17 的核心测试与手工矩阵覆盖。
