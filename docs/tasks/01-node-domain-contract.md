# 节点领域契约

## 目标

定义稳定、可持久化且能保留 Mihomo 未知字段的节点领域模型。

## 输入

- Task 00 协议目录。
- Mihomo 单个 `proxies` Map。
- 手动节点、Profile 内联节点和 Provider 快照三类来源。

## 输出

- `ProxyNodeRecord`、`NodeSourceRef`、`NodeOverlay`、`ProfileNodeBinding`。
- `NodeImportRequest`、`NodeImportPreview`、`NodeImportResult`、`NodeIssue`。
- `NodeExportRequest`、`NodeExportResult`。
- 稳定 ID、名称分配、SHA-256 指纹和去重规则。

## 依赖

Task 00。

## 实现边界

- 完整 `Map<String, dynamic>` 是节点配置权威值，表单只修改已知字段路径。
- 来源节点保存 source snapshot；overlay 使用递归 `set` 和字段路径 `remove`。
- Map 递归合并，List 整体替换。
- 指纹忽略名称、来源元数据和运行时生成的 `dialer-proxy`。

## 验收标准

- 未知字段经过表单编辑后仍存在。
- 清除覆盖能恢复当前来源快照。
- 同指纹导入可更新原记录或显式创建副本。
- DB 和链路只以节点 ID 建立引用。

## 测试

在 `test/nodes/node_codec_test.dart` 覆盖指纹稳定性和未知字段保留。
