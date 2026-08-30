# 节点与链路导出

## 目标

提供常用 URI、批量 Base64、Clash YAML、JSON 与 ZIP 导出。

## 输入

- 选中的节点、链路、资产和 `includeSecrets` 选项。

## 输出

- `NodeExportService`。
- 单节点 URI、换行 URI、标准 Base64。
- Clash `proxies`/`proxy-groups` 片段、JSON 和带 manifest 的 ZIP。
- 每个节点的导出诊断。

## 依赖

Task 01、02、08、11。

## 实现边界

- 专用 codec 节点生成 URI。
- Raw-only 节点进入 Clash、JSON 和 ZIP。
- ZIP 资产路径使用相对引用并包含 SHA-256。
- 名称、IPv6、用户名和密码使用标准 URI 编码。

## 验收标准

- URI 批次可由输入 dispatcher 再次导入。
- Clash/JSON 保留所有 Raw 字段。
- 每个未生成 URI 的节点都有明确诊断，其他格式继续产出。

## 测试

导出往返并入 `test/nodes/node_codec_test.dart`。
