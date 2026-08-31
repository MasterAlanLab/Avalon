# 节点库 UI

## 进度补充（2026-08-30）

除移动端全屏布局外的实现边界与验收标准均已落地：列表、筛选、表单/Raw 编辑、绑定、复制、
重命名、资产、导出与统一导入预览（`lib/widgets/node_import_preview.dart`）齐备，
loading / error / 空状态已分开并有本地化文案。

密钥遮罩已复核成立：列表项只渲染 `type / 来源 / stale / 本地覆盖` 标签，导入预览只渲染
`#index · TYPE · name` 与 issue 文案，导出预览走 `includeSecrets: false`，表单密码字段使用
`obscureText`；Raw 编辑器按设计显示原文。

**仍缺**：「移动端使用全屏页」这条实现边界。节点与链编辑一律走 `globalState.showCommonDialog` +
`CommonDialog`，而 `lib/widgets/dialog.dart` 是固定 `maxWidth: 300`、
`maxHeight: min(height - 40, 500)` 的 `AlertDialog`，不随尺寸切换全屏页。
详见 [复核记录](verify-2026-08-30.md)。

## 目标

在 Profiles 页面提供完整的全局节点库管理体验。

## 输入

- 节点查询、导入预览、编辑、绑定和导出服务。
- ARB 本地化源文件。

## 输出

- Profiles 页“节点”分栏。
- 节点列表、类型/来源/状态过滤器。
- 导入预览、常用协议表单、Raw 编辑器和绑定操作。

## 依赖

Task 01、04、08、09。

## 实现边界

- 手动新增默认只保存到全局库。
- 来源节点显示来源、stale 和 override 状态。
- 表单与 Raw 编辑共享同一 draft，并提供清除覆盖。
- 移动端使用全屏页，桌面使用适配宽度的对话框/侧栏。

## 验收标准

- 桌面与 Android 可添加、批量导入、编辑、复制、重命名、绑定、删除和导出。
- 密钥字段在列表与普通预览中遮罩。
- loading、空状态、错误与成功反馈均有本地化文案。

## 测试

采用服务层核心测试和手工 UI 验收，不新增 widget 测试文件。
