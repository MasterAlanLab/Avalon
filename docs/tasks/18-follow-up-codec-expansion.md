# 后续专用协议扩展

## 目标

在 Raw 全覆盖基础上逐步增加长尾协议的专用表单和分享格式。

## 输入

- Mihomo 新版本协议目录。
- 用户提供的真实格式样本和 Raw-only 节点记录。
- 既有 codec registry。

## 输出

- Hysteria、SSR、Snell、Mieru、Sudoku、ShadowQUIC、WireGuard、Tailscale、SSH、MASQUE、TrustTunnel、ZeroTier、OpenVPN 等 codec/form backlog。
- 每个新增协议的字段映射、URI 方言和兼容性样例。

## 依赖

Task 00、05、06、07、08。

## 实现边界

- 每个扩展以 registry 插件形式加入。
- Raw 记录保持原样，新增表单只覆盖已知字段。
- 协议目录按锁定的 Mihomo commit 更新。

## 验收标准

- 新 codec 不影响已有输入分流。
- Raw-only 记录打开新表单后未知字段保持。
- 新 URI 可通过同一表驱动测试文件加入样例。

## 测试

继续扩充 `test/nodes/node_codec_test.dart`，保持单文件。
