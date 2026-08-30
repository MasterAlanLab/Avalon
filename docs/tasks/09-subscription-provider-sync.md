# 订阅与 Provider 节点同步

## 目标

把 Profile 内联节点和 Provider 快照映射到全局节点库，同时保持来源更新和本地覆盖。

## 输入

- Profile ID 与原始配置。
- Provider 名称、缓存文件和 payload。
- 现有来源节点与 overlay。

## 输出

- `NodeSourceSyncService`。
- 创建、更新、unchanged、stale 和 conflict 报告。
- 来源节点到 Profile 的自动绑定。

## 依赖

Task 03、04、08。

## 实现边界

- 优先按 `profile/provider + source key` 匹配，再按同来源指纹匹配。
- 新来源值只更新 snapshot，overlay 继续合成 effective Map。
- 本轮未出现的来源节点标记 stale；重新出现时恢复 active。
- 手动节点保持独立来源。

## 验收标准

- 订阅顺序改变不会生成重复节点。
- 本地重命名和字段覆盖在更新后保持。
- stale 节点仍可查看；参与已启用链路时产生配置 error。

## 测试

核心同步与 overlay 行为集中放入数据库迁移测试文件。
