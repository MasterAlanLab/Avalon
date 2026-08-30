# VLESS 与 VMess 编解码

## 目标

实现 VLESS、VMess URI 到 Mihomo Map 的双向转换。

## 输入

- VLESS URI。
- VMess Base64 JSON 与兼容 URI。
- Mihomo VLESS/VMess 字段定义。

## 输出

- `VlessCodec`、`VmessCodec`。
- Reality、TLS、SNI、fingerprint、ALPN、flow、transport 映射。
- 规范化反向 URI。

## 依赖

Task 01、04。

## 实现边界

- 支持 IPv4、域名、方括号 IPv6 和百分号编码。
- `security=reality` 映射到 TLS、`reality-opts` 和 client fingerprint。
- TCP `headerType=none` 作为导入元数据保留。
- transport 支持 tcp、ws、http、h2、grpc、xhttp。

## 验收标准

- Reality VLESS 使用占位值可正确生成 Mihomo Map。
- VMess Base64 JSON 可解析并再次导出。
- 未识别 query 字段保留在 import metadata。

## 测试

只在 `test/nodes/node_codec_test.dart` 增加表驱动样例。
