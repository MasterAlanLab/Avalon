# 输入分流与规范化

## 进度补充（2026-08-30）

所有入口（节点库、粘贴、文件、二维码、App Link）已共用同一个导入预览
（`lib/widgets/node_import_preview.dart`）：逐项勾选、更新已有 / 创建副本的去重策略、
是否绑定当前 Profile。Windows 上应用已运行时的链接改由 runner 转发给原实例。
详见 [修复记录](fixes-2026-08-30.md) R9 与“输入入口统一预览”。

## 目标

建立粘贴、文件、二维码、剪贴板和 App Link 共用的节点输入管线。

## 输入

- 单条或多行文本。
- 标准 Base64、URL-safe Base64。
- YAML、JSON、完整 Clash 配置或单节点 Map。
- 二维码原始值和 App Link URI。

## 输出

- `NodeInputDispatcher`。
- 格式识别结果、节点 drafts、订阅地址和逐项 issues。
- 预览、去重决策和事务提交接口。

## 依赖

Task 00、01。

## 实现边界

- `vless`、`vmess`、`ss`、`trojan`、`hysteria2`、`hy2`、`tuic`、`anytls`、`socks`、`socks4`、`socks4a`、`socks5`、HTTP/HTTPS 代理 URI 进入 codec registry。
- 无端口、无认证且无 proxy 参数的 `http`、`https` 进入订阅地址分支。
- 带显式端口、认证信息或 `proxy`/TLS 参数的 `http`、`https` 进入 HTTP outbound codec。
- YAML/JSON 中的 `proxies` 逐项转为 draft。
- 单项错误不影响其他有效 draft 的预览，最终提交只写入用户选中的有效项。

## 验收标准

- 相同内容从粘贴、二维码和文件进入后得到相同规范化节点。
- 非 URL 二维码原始文本可进入 dispatcher。
- 每个输入行的错误包含索引、代码和可展示消息。

## 测试

集中在 `test/nodes/node_codec_test.dart`。
