# 单节点与链式代理：开发进度

更新日期：2026-08-30（第三轮，复核后）。检查对象：`main` / `1a666fb` 开发快照之上的当前工作区。

## 总体状态

**R1–R9 的修复已逐项复核、无回退；本轮新发现 R10（外键级联未生效）；其余剩余工作集中在平台设备验收与长尾项。**

- 当前路线为单 Core + Mihomo `dialer-proxy`，保留全局节点库、链库和 Profile 绑定。
- Task 00–17 属于当前版本；Task 18 为后续扩展；Task 19 双 Core 方案已取消。
- 本轮为代码级复核 + 自动化全量复跑：逐项核对 R1–R9 的落点、各任务验收标准与仍标为剩余的工作项。
- 本轮复跑结果与上一轮一致，无回退：analyze 0 error / 0 warning / 28 info，
  根包 **791 项**、嵌套插件 26 项、构建工具 27 项通过；`core/` 的 `go build ./...` 与
  `go test -count=1 .`（6 项，非缓存）通过。
- 新发现 R10：`proxy_nodes`、`profile_proxy_nodes`、`proxy_chain_hops` 等表声明了
  `cascade` / `setNull`，但仓库未开启 `PRAGMA foreign_keys`，删除节点或 Profile 时不做级联清理。
  已用一次性探针在内存库上实测确认（`PRAGMA foreign_keys = 0`，删除后关联行全部残留）。
- 上一轮的 4 类缺口（SOCKS4/4a 往返、Rule 链入口、仅绑定链、同名来源节点）已修复并落到仓库内测试。
- 数据库 schema 为 **v4**（链绑定入口组），迁移只对既有 v3 追加列，并有升级用例。
- 上一轮已按 CI 固定的 Flutter 3.44.4 复验：analyze 与 791 项测试同样通过。
- 仍待验证：原生平台构建、真实 Core 连通性、TUN 与系统代理、真实 v2 数据迁移样本。
- 本轮复核见 [复核记录](verify-2026-08-30.md)；修复明细见 [修复记录](fixes-2026-08-30.md)；
  问题现场见 [检查记录](review-2026-08-30.md)。

## 状态口径

- **实现已落地，待验收**：主要代码路径存在且已有相关测试，不表示每条验收标准均已通过。
- **部分实现**：已有可用组成部分，但任务要求的部分入口、行为或验证仍缺失。
- **待修复**：存在已确认的功能缺陷，修复并补测后再进入验收。
- **后续 / 已取消**：不计入当前版本的待实现功能。

不依据文件数量、测试数量或代码行数换算完成百分比。

## 逐项进度

| Task | 状态 | 已核实的实现 / 证据 | 剩余工作 |
| --- | --- | --- | --- |
| [00 产品与协议契约](00-product-protocol-contract.md) | 契约已整理，入口语义已补齐 | 节点/订阅分流、Raw、单 Core 和外部本地端点边界已定义；R5 链入口已落地 | 锁定 Core 协议及平台验收 |
| [01 节点领域契约](01-node-domain-contract.md) | 实现已落地，待验收 | `ProxyNode`、来源、绑定、overlay、指纹和去重实现存在；来源键分配已统一 | 补未知字段/覆盖端到端用例；按[复核记录](verify-2026-08-30.md)的对照表收敛草案类型名与实际模型/API |
| [02 链路领域契约](02-chain-domain-contract.md) | 实现已落地，待验收 | 持久化链/hop/绑定、四类目标、分支上限；入口选用与链节点可见性已修复 | 绑定上下文的设备验收 |
| [03 Drift 存储](03-drift-node-storage.md) | 待修复（R10） | schema v4、新表/DAO/生成代码与查询索引；内存库存取、恢复参数与 v2→v4、v3→v4 升级测试通过 | R10：外键动作声明了但运行期未启用，删除节点/Profile 留下悬挂行（已实测）且无测试；真实用户 v2 样本 |
| [04 输入分流](04-input-dispatch-and-normalization.md) | 实现已落地，待平台验收 | URI/Base64/YAML/JSON dispatcher；文件、粘贴、二维码、App Link 已接入；Windows 热链接已转发；所有入口共用统一导入预览 | 各平台入口的设备验证 |
| [05 VLESS / VMess](05-codec-vless-vmess.md) | 实现已落地，待兼容性验收 | Reality、VMess JSON/URI、transport 映射和代表性解析/导出测试 | 扩展字段往返、真实 Core 校验与连接验证 |
| [06 SS / Trojan / HTTP / SOCKS](06-codec-ss-trojan-socks.md) | 实现已落地，待兼容性验收 | SS 多格式、Trojan、HTTP(S)、SOCKS 解析及导出；SOCKS4/4a 往返已修复并补测 | 更多保留字符/扩展字段往返与 Core 验证 |
| [07 Hysteria2 / TUIC / AnyTLS](07-codec-hysteria2-tuic-anytls.md) | 实现已落地，待兼容性验收 | codec、别名和代表性样例测试存在 | 完整 TLS/obfs/端口跳跃字段往返及实际连接验收 |
| [08 Raw 与资产](08-raw-mihomo-and-assets.md) | 实现已落地，待端到端验收 | Raw 嵌套解析、资产管理、相对路径、哈希、运行路径展开和相关测试 | 资产替换/删除/恢复闭环的设备验收 |
| [09 来源同步](09-subscription-provider-sync.md) | 实现已落地，待端到端验收 | Profile/Provider 快照、overlay/stale；同名来源节点端点保持已修复 | 来源重排、重现、覆盖保留与真实 Provider 刷新 |
| [10 有效配置组装](10-effective-config-assembly.md) | 实现已落地，待验收 | 深拷贝、绑定节点、名称分配、链路与自定义组/规则；R5–R8 已修复并补测 | 真实 Core 应用与多 Profile 切换验收 |
| [11 链编译器](11-dialer-chain-compiler.md) | 实现已落地，待运行验收 | 后 hop 指向前 hop；组展开、循环、上限、重名、既有 dialer 清理和本地 SOCKS 有测试；本轮复核 HTTP/HTTPS 本地端点代码路径完整 | 本地端点与多跳的实际连通性验证 |
| [12 节点库 UI](12-node-library-ui.md) | 部分实现 | 节点 Tab、筛选、表单/Raw、绑定、复制、重命名、资产和节点导出；加载/错误状态与统一导入预览已补；密钥遮罩本轮已复核 | 移动端全屏编辑布局（现为固定宽度 `CommonDialog`）及手工操作验收 |
| [13 链路 UI / 绑定](13-chain-ui-and-binding.md) | 实现已落地，待设备验收 | 链 CRUD、拖拽 hop、目标选择、本地端点、绑定、默认标志；入口组、编译预览与 warning 确认已补 | 设备交互验收 |
| [14 节点与链路导出](14-export.md) | 实现已落地，待验收 | 节点 URI/Base64/YAML/JSON/ZIP、manifest 与资产哈希；链路与生成组导出已接入 | 导出件在其他客户端再导入的语义验收 |
| [15 备份恢复](15-backup-migration.md) | 实现已落地，待端到端验收 | DB snapshot、节点/链表、资产归档、路径与哈希；失败统一回滚与备份 manifest 已补测 | 真实备份恢复端到端验收 |
| [16 平台运行时](16-platform-runtime.md) | 实现已落地，平台待验收 | 单 Core 生命周期、配置校验/替换、平台 URI 注册；应用失败补偿与 Core 侧 proxies 预校验已补 | 原生构建、实际流量、Windows Helper/热链接实机验收 |
| [17 测试与验收](17-minimal-tests-and-acceptance.md) | 自动化基线通过，设备验收未完成 | 本轮复跑：根包 791 项、插件 26 项、构建工具 27 项、Go 6 项通过，analyze 0/0/28；平台矩阵已建立 | 补 R10 的删除/级联用例、真实迁移样本、设备矩阵执行 |
| [18 长尾协议扩展](18-follow-up-codec-expansion.md) | 后续 | 扩展清单已保留；Raw 通道是当前入口 | 按样本与锁定 Core 逐项扩充 codec / 表单 |
| [19 辅助 Core](19-follow-up-auxiliary-presocks.md) | 已取消 | 已记录单 Core 决策与外部本地端点边界 | 不再安排双 Core 开发 |

## 下一轮优先级

1. 修复 R10：开启 `PRAGMA foreign_keys` 或在 service 层显式清理关联行，
   并在 `test/database/` 补删除节点与删除 Profile 的用例。
2. 执行 [Task 17](17-minimal-tests-and-acceptance.md) 的平台手工矩阵，尤其是链入口选用、
   应用失败补偿、统一导入预览与 Windows 热链接四条上一轮新改动路径。
3. 用真实用户 v2 数据样本复核迁移与备份恢复（当前只有构造样本）。
4. 补 Task 12 的移动端全屏编辑布局。
5. 按[复核记录](verify-2026-08-30.md)的对照表收敛领域类型命名，并按 Task 18 逐项扩充长尾协议。

本轮复核见 [复核记录](verify-2026-08-30.md)，完整修复明细见 [修复记录](fixes-2026-08-30.md)，
问题现场见 [检查记录](review-2026-08-30.md)，
自动化记录与设备矩阵见 [Task 17](17-minimal-tests-and-acceptance.md)。

## Git 状态说明

开发快照与 `docs/tasks/` 下的 Markdown 任务文档一并纳入版本管理。
`docs/` 的原忽略规则保留；新建文档需显式纳入版本管理，
本轮新增的 [复核记录](verify-2026-08-30.md) 尚未纳管，需要 `git add -f docs/tasks/verify-2026-08-30.md`。
测试夹具中的分享链接使用固定虚构值，不含真实节点信息。
