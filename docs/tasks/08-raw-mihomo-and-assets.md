# Raw Mihomo 节点与资产

## 目标

为全部 Mihomo proxy type 提供 Raw YAML/JSON 路径，并管理节点依赖文件。

## 输入

- 单节点 Map、`proxies` List、完整 Clash YAML/JSON。
- 证书、私钥、CA、WireGuard、OpenVPN 等本地文件。

## 输出

- `RawMihomoCodec`。
- 深层 YamlMap/YamlList 到 Dart Map/List 的转换。
- `NodeAssetManager`、资产记录、SHA-256 校验和运行路径解析。

## 依赖

Task 01、04。

## 实现边界

- Raw 节点要求 `name` 与 `type`，其余字段交给 Mihomo 校验。
- 文件复制到 `nodes/<nodeId>/assets/`，配置保存便携相对引用。
- 运行时只在有效配置副本中展开绝对路径。

## 验收标准

- 任意当前 Mihomo proxy type 可保存为节点记录。
- Raw 编辑后未知嵌套字段保持。
- 资产替换、删除、备份和恢复均同步更新引用。

## 测试

Raw 解析放在 `test/nodes/node_codec_test.dart`；资产复制使用手工验收。
