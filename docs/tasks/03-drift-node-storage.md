# Drift 节点与链路存储

## 进度补充（2026-08-30）

实际 schema 已到 **v4**：v3 建立本任务的全部新表，v4 只为 `profile_proxy_chains`
追加 `entry_groups` 列（Task 13 的链入口组，见 [修复记录](fixes-2026-08-30.md) R5）。
迁移对 `from < 3` 建表、对 `from >= 3 && from < 4` 追加列，两条路径都有升级用例。

索引已按下面的查询路径声明：`proxy_nodes(fingerprint)`、`proxy_nodes(source_kind, source_key)`、
`profile_proxy_nodes(profile_id, order)`、`proxy_chains(order)` 及 hop / binding 索引；
`proxy_node_assets` 目前无 `node_id` 索引。

**待修复 R10**：外键的 `KeyAction.cascade` / `KeyAction.setNull` 已在表定义中声明，
但仓库没有任何位置执行 `PRAGMA foreign_keys = ON`，SQLite 默认关闭该开关，drift 也不会自动打开。
因此下面「Profile 删除时来源 Profile 置空，显式绑定随 Profile 级联清理」与
「节点删除时节点绑定、hop 和资产记录按外键策略清理」两条实现边界当前不成立。
已在内存库上实测：`PRAGMA foreign_keys` 为 `0`；删除节点后 `profile_proxy_nodes`、
`proxy_chain_hops`（`node_id` 仍指向已删节点）、`proxy_node_assets` 各残留 1 行；
删除 Profile 后节点绑定与链绑定残留、来源节点的 `source_profile_id` 未置空。
`test/database/` 目前无对应用例。现场与修复方向见 [复核记录](verify-2026-08-30.md) R10。

## 目标

将数据库从 schema v2 升级到 v3，并持久化节点、来源、绑定、链路和资产。

## 输入

- 当前 Drift schema v2。
- Task 01、02 的领域模型。

## 输出

- `proxy_nodes`、`profile_proxy_nodes`。
- `proxy_chains`、`proxy_chain_hops`、`profile_proxy_chains`。
- `proxy_node_assets`、`proxy_group_members`。
- DAO、索引、外键、v2→v3 migration 和生成代码。

## 依赖

Task 01、02。

## 实现边界

- 主键使用现有 Snowflake 整数 ID。
- Profile 删除时来源 Profile 置空，显式绑定随 Profile 级联清理。
- 节点删除时节点绑定、hop 和资产记录按外键策略清理。
- 多表写入使用 transaction。

## 验收标准

- 空库可直接创建 v3。
- v2 数据升级后 Profile、规则、脚本和组数据保持一致。
- 全局查询、按 Profile 查询、按来源查询和按指纹查询均有索引。

## 测试

集中在 `test/database/node_chain_migration_test.dart`。
