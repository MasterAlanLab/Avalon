# 有效配置组装

## 目标

以单一管线把 Profile、节点、链路、脚本、自定义组、规则和应用补丁生成单 Core 可加载的最终 YAML。

## 输入

- Profile 原始 Map。
- 节点/链绑定和 Provider 快照。
- 脚本结果、自定义组/规则、端口/TUN/DNS 补丁。

## 输出

- `EffectiveConfigRequest`、`EffectiveConfigArtifact`。
- 稳定名称分配器、配置 digest、诊断和 revision。
- Core 完整 YAML 校验入口。

## 依赖

Task 02、03、08、09。

## 实现边界

- 顺序：源配置 → 脚本 → 来源 overlay → 手动绑定 → Provider 物化 → 链路 → 自定义组/规则 → 应用补丁。
- 源配置对象保持不变，组装在深拷贝上完成。
- 链路生成代理和 `dialer-proxy` 在同一 artifact 中完成；不创建第二个 Core 或独立运行目录。
- 单节点直连、单 hop 链和多 hop 链共用同一个 Core 校验、写入和启动入口。
- 最终 YAML 校验成功后才进入原子写入流程。

## 验收标准

- 同一输入产生相同 YAML 和 digest。
- 节点重名使用确定后缀，所有组引用同步替换。
- 配置预览与实际运行使用同一个 artifact。
- 多 hop 生成配置中，后 hop 的 `dialer-proxy` 始终指向前 hop 的生成名称。

## 测试

在既有 `test/common/task_test.dart` 增加最小组装断言。
