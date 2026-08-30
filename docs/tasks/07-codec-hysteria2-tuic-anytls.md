# Hysteria2、TUIC 与 AnyTLS 编解码

## 目标

实现三类现代协议的 URI、表单和 Mihomo Map 转换。

## 输入

- `hysteria2://`、`hy2://`、`tuic://`、`anytls://` URI。
- Mihomo 对应协议字段。

## 输出

- `Hysteria2Codec`、`TuicCodec`、`AnyTlsCodec`。
- password、uuid、SNI、ALPN、obfs、端口跳跃、TLS 参数映射。

## 依赖

Task 01、04。

## 实现边界

- Hysteria2 两个 scheme 归一化为 `hysteria2` 类型。
- query 中的数值与布尔值按字段表转换，其余值保留。
- 导出使用稳定 query 排序。

## 验收标准

- 三种协议的最小 URI 与完整 URI 均产生可校验 Map。
- 别名 `hy2` 能再次以规范 scheme 导出。
- TLS 和 obfs 参数经过往返保持。

## 测试

只在 `test/nodes/node_codec_test.dart` 增加表驱动样例。
