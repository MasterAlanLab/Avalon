# 单节点与链式代理：开发进度

更新日期：2026-08-30。检查对象：`main` / `62addf7` 基线之上的当前工作区，包括未提交和未跟踪代码。

## 总体状态

**开发主体已落地，自动化基线通过；仍需修复已确认问题、补齐功能闭环和完成平台验收。**

- 当前路线为单 Core + Mihomo `dialer-proxy`，保留全局节点库、链库和 Profile 绑定。
- Task 00–17 属于当前版本；Task 18 为后续扩展；Task 19 双 Core 方案已取消。
- 本次实际执行：依赖解析通过，静态分析 0 error / 0 warning / 28 info，根包全量 **756 项测试通过**。
- 另用 5 条工作区外验收断言复现 4 类缺口：SOCKS4/4a 往返、Rule 链入口、仅绑定链、同名来源节点。
- Go 检查受未初始化的 `core/Clash.Meta` 子模块阻塞；平台构建、真实连通性、TUN 和系统代理仍待验证。
- 测试使用 Flutter 3.47.2 / Dart 3.13.2，尚未补验 CI 固定的 Flutter 3.44.4。
- 本次更新的是检查结果与进度，业务源码保持原样；详细问题见 [检查记录](review-2026-08-30.md)。

## 状态口径

- **实现已落地，待验收**：主要代码路径存在且已有相关测试，不表示每条验收标准均已通过。
- **部分实现**：已有可用组成部分，但任务要求的部分入口、行为或验证仍缺失。
- **待修复**：存在本次确认的功能缺陷，修复并补测后再进入验收。
- **后续 / 已取消**：不计入当前版本的待实现功能。

不依据文件数量、测试数量或代码行数换算完成百分比。

## 逐项进度

| Task | 状态 | 已核实的实现 / 证据 | 剩余工作 |
| --- | --- | --- | --- |
| [00 产品与协议契约](00-product-protocol-contract.md) | 契约已整理，入口语义待补齐 | 节点/订阅分流、Raw、单 Core 和外部本地端点边界已定义 | **R5：Rule 模式显式选用链的入口**；锁定 Core 协议及平台验收 |
| [01 节点领域契约](01-node-domain-contract.md) | 实现已落地，待验收 | `ProxyNode`、来源、绑定、overlay、指纹和去重实现存在 | 补未知字段/覆盖端到端用例；收敛草案类型名与实际模型/API |
| [02 链路领域契约](02-chain-domain-contract.md) | 部分实现 | 持久化链/hop/绑定、四类目标、分支上限；编译方向有断言 | **R5、R6：入口选用与仅绑定链的节点可见性**；补绑定上下文验收 |
| [03 Drift 存储](03-drift-node-storage.md) | 实现已落地，迁移待验收 | schema v3、新表/DAO/生成代码；内存库新建、存取和恢复参数测试通过 | 真实 v2→v3 样本、旧数据保留、外键清理与索引验收 |
| [04 输入分流](04-input-dispatch-and-normalization.md) | 部分实现 | URI/Base64/YAML/JSON dispatcher；文件、粘贴、二维码、App Link 已接入 | 节点库外的直接导入入口仍绕过统一预览与去重策略选择；补平台入口验证 |
| [05 VLESS / VMess](05-codec-vless-vmess.md) | 实现已落地，待兼容性验收 | Reality、VMess JSON/URI、transport 映射和代表性解析/导出测试 | 扩展字段往返、真实 Core 校验与连接验证 |
| [06 SS / Trojan / HTTP / SOCKS](06-codec-ss-trojan-socks.md) | 待修复 | SS 多格式、Trojan、HTTP(S)、SOCKS 解析及节点导出存在 | **R2：SOCKS4/4a 导出丢失版本**；补保留字符/版本往返与 Core 验证 |
| [07 Hysteria2 / TUIC / AnyTLS](07-codec-hysteria2-tuic-anytls.md) | 实现已落地，待兼容性验收 | codec、别名和代表性样例测试存在 | 完整 TLS/obfs/端口跳跃字段往返及实际连接验收 |
| [08 Raw 与资产](08-raw-mihomo-and-assets.md) | 实现已落地，待端到端验收 | Raw 嵌套解析、资产管理、相对路径、哈希、运行路径展开和相关测试 | 资产替换/删除/恢复闭环，配合 R1 补恢复失败一致性 |
| [09 来源同步](09-subscription-provider-sync.md) | 实现已落地，待端到端验收 | Profile/Provider 快照、overlay/stale；空 payload、null、混合无效项有测试 | **R7：同名来源到运行组装的衔接**；来源重排、重现、覆盖保留与真实 Provider 刷新 |
| [10 有效配置组装](10-effective-config-assembly.md) | 待修复 | 深拷贝、绑定节点、名称分配、链路与自定义组/规则已接入；相关断言通过 | **R5–R8：链入口、节点可见性、同名端点保持、应用失败一致性** |
| [11 链编译器](11-dialer-chain-compiler.md) | 实现已落地，待运行验收 | 后 hop 指向前 hop；组展开、循环、上限、重名、既有 dialer 清理和本地 SOCKS 有测试 | HTTP/HTTPS 本地端点、warning 交互及实际多跳连接验证 |
| [12 节点库 UI](12-node-library-ui.md) | 部分实现 | 节点 Tab、筛选、表单/Raw、绑定、复制、重命名、资产和节点导出已接入 | 加载/错误状态、移动端编辑布局、统一导入预览及手工操作验收 |
| [13 链路 UI / 绑定](13-chain-ui-and-binding.md) | 部分实现 | 链 CRUD、拖拽 hop、目标选择、本地端点、绑定和默认标志已接入 | **R4–R6：诊断/确认、显式选用入口和 Profile 可见性**；设备交互验收 |
| [14 节点与链路导出](14-export.md) | 部分实现 | 节点 URI/Base64/YAML/JSON/ZIP、manifest 与资产哈希测试存在 | **R2、R3：SOCKS 往返及链路/生成组/关联资产导出** |
| [15 备份恢复](15-backup-migration.md) | 待修复 | DB snapshot、节点/链表、资产归档、路径与哈希验证已接入 | **R1：失败时文件/数据库/设置统一保留**；manifest 契约、真实备份与失败注入测试 |
| [16 平台运行时](16-platform-runtime.md) | 待修复，平台待验收 | 既有单 Core 生命周期、配置校验/替换、平台 URI 注册及输入接入存在 | **R5、R6、R8、R9：链闭环、应用失败补偿、Windows 热链接**；原生构建与实际流量 |
| [17 测试与验收](17-minimal-tests-and-acceptance.md) | 自动化基线通过，验收未完成 | 本次根包 756 项测试及静态分析通过，已建立平台矩阵 | 修复项补测、真实迁移、Core 子模块、CI SDK、嵌套组件及设备验证 |
| [18 长尾协议扩展](18-follow-up-codec-expansion.md) | 后续 | 扩展清单已保留；Raw 通道是当前入口 | 按样本与锁定 Core 逐项扩充 codec / 表单 |
| [19 辅助 Core](19-follow-up-auxiliary-presocks.md) | 已取消 | 已记录单 Core 决策与外部本地端点边界 | 不再安排双 Core 开发 |

## 下一轮优先级

1. 先修复备份恢复失败一致性，补失败注入测试，避免旧数据在失败路径被部分替换。
2. 补 Rule 链选用入口、链节点可见性、同名节点保持和 Core 应用失败补偿。
3. 补 SOCKS4/4a 往返、链路/策略组导出、链编辑诊断和 Windows 热链接；执行真实迁移与平台矩阵。
4. 按 CI SDK 和完整组件范围复验，整理提交代码与文档。

完整检查证据、问题优先级见 [检查记录](review-2026-08-30.md)；
自动化记录与设备矩阵见 [Task 17](17-minimal-tests-and-acceptance.md)。

## Git 状态说明

本次开发快照提交同时纳入当前代码与 `docs/tasks/` 下现有的 Markdown 任务文档。
`docs/` 的原忽略规则保留；已跟踪任务文档的后续修改可正常记录，新建文档需显式纳入版本管理。
提交前将转义 VLESS 链接测试中的原始节点值替换为固定虚构值，保留原解析断言与转义形式。
