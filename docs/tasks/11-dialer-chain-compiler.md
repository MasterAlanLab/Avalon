# dialer-proxy 链路编译器

## 目标

把全局链路编译为 Mihomo 生成节点和可选策略组，供单 Core 直接加载。

## 输入

- 有序 hop 列表。
- 节点与策略组解析器。
- Profile 已占用名称和 branch limit。

## 输出

- 生成的 `proxies`、`proxy-groups`。
- 路径矩阵、名称映射、warning/error。

## 依赖

Task 02、10。

## 实现边界

- 每条路径均克隆节点，不改动持久化配置，也不创建第二个 Core。
- 后 hop 的 `dialer-proxy` 指向前 hop 的生成名称；用户看到的前置/主/后置方向与生成顺序一致。
- 策略组递归展开，组合数在生成前计算。
- 循环、缺失引用、stale 引用和超限为 error。
- UDP、Reality、ShadowTLS 中继兼容性为 warning。
- 本地端点只生成 SOCKS/HTTP/HTTPS Mihomo proxy 配置；其监听进程由外部组件负责。

## 验收标准

- `[PRE, MAIN, POST]` 的最终选择是 POST 生成节点或链 selector，配置中可见完整 `dialer-proxy` 链。
- 组 hop 的笛卡尔分支稳定排序。
- 生成名称与 Profile 原名称不冲突。
- 单 hop、远端多 hop 和包含本地端点的链路都只产生一个可加载的最终配置。

## 测试

集中在 `test/nodes/chain_compiler_test.dart`。
