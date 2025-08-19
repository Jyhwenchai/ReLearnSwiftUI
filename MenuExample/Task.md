# Menu 组件示例任务

## 任务概述

为 SwiftUI Menu 组件创建完整的示例包，包含基础用法、高级功能和相关修饰符的演示。

## 任务目标

1. 创建多个 Menu 示例视图，展示不同的使用场景
2. 演示 Menu 的基础功能和高级特性
3. 展示相关的 ViewModifier 和样式设置
4. 提供详细的中文注释和文档

## 示例规划

### MenuExampleView01 - 基础 Menu

- 基本的 Menu 创建和使用
- 简单的按钮菜单项
- 文本标签和图标标签

### MenuExampleView02 - 嵌套菜单和子菜单

- 创建嵌套的子菜单
- 多层级菜单结构
- 菜单项的组织和分类

### MenuExampleView03 - 带主要操作的菜单

- 使用 primaryAction 参数
- 主要操作和次要菜单的结合
- 长按和点击的不同行为

### MenuExampleView04 - 菜单样式和修饰符

- menuStyle 修饰符的使用
- menuOrder 修饰符
- menuIndicator 修饰符
- menuActionDismissBehavior 修饰符

### MenuExampleView05 - 上下文菜单

- contextMenu 修饰符的使用
- 长按触发的上下文菜单
- 带预览的上下文菜单

### MenuExampleView06 - 高级菜单功能

- 菜单项的动态生成
- 条件菜单项
- 菜单项的状态管理

## 相关修饰符

- `.menuStyle(_:)` - 设置菜单样式
- `.menuOrder(_:)` - 设置菜单项顺序
- `.menuIndicator(_:)` - 控制菜单指示器显示
- `.menuActionDismissBehavior(_:)` - 控制菜单关闭行为
- `.contextMenu(menuItems:)` - 添加上下文菜单
- `.contextMenu(menuItems:preview:)` - 带预览的上下文菜单

## 平台支持

- iOS 14.0+
- iPadOS 14.0+
- macOS 11.0+
- tvOS 17.0+
- visionOS 1.0+

## 完成标准

- 所有示例都能在 iOS 和 macOS 平台正常编译和运行
- 代码包含详细的中文注释
- 文档完整，包含使用说明和最佳实践
