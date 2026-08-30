# Shadowsocks、Trojan 与 SOCKS 编解码

## 目标

实现 SS、Trojan、HTTP、SOCKS4/4a/SOCKS5 常用分享格式的双向转换。

## 输入

- SIP002 与传统 Shadowsocks URI。
- Trojan URI。
- HTTP/HTTPS proxy URI（显式端口、认证或 `proxy` 参数）。
- SOCKS/SOCKS4/SOCKS4a/SOCKS5 URI。

## 输出

- `ShadowsocksCodec`、`TrojanCodec`、`HttpCodec`、`SocksCodec`。
- 插件、用户名、密码、TLS、SNI 和 transport 字段映射。

## 依赖

Task 01、04。

## 实现边界

- SS 同时接受整体 Base64 和 userinfo Base64。
- Trojan 使用标准 query 处理 TLS 与 transport。
- HTTP 与 HTTPS outbound 通过同一 codec 双向转换；普通无端口 URL 仍保留订阅分支。
- SOCKS4/4a/5 的无认证与用户名密码认证使用同一 codec。

## 验收标准

- 三类 URI 均支持 IPv6 和 Unicode 名称。
- SS 插件参数经过导入导出后保持。
- 密码中的保留字符正确编码。

## 测试

只在 `test/nodes/node_codec_test.dart` 增加表驱动样例。
