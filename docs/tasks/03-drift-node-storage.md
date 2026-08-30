# Drift 节点与链路存储

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
