# Toggle 组件示例任务

## 任务概述

为 SwiftUI Toggle 组件创建完整的示例包，包含基础用法、高级用法和所有相关的 ViewModifier 演示。

## 任务目标

1. 创建多个 Toggle 示例视图，展示不同的使用场景
2. 演示所有可用的 ToggleStyle 样式
3. 展示 Toggle 的各种初始化方法
4. 提供详细的中文注释和文档
5. 确保在 iOS 和 macOS 平台都能正常编译运行

## 示例规划

### ToggleExampleView01.swift - 基础用法

- 基本的 Toggle 创建和使用
- 文本标签的 Toggle
- 绑定状态变量的使用

### ToggleExampleView02.swift - 不同的初始化方法

- 使用系统图标的 Toggle
- 使用自定义图片的 Toggle
- 使用复杂标签的 Toggle（标题+副标题）

### ToggleExampleView03.swift - Toggle 样式

- 演示所有内置的 ToggleStyle
- automatic、switch、button、checkbox 样式
- 自定义 ToggleStyle

### ToggleExampleView04.swift - 高级用法和实际场景

- 设置页面中的 Toggle 组合
- 表单中的 Toggle 使用
- 动画效果和状态变化
- 禁用状态和条件控制

### ToggleExampleView05.swift - 集合和批量操作

- 多个 Toggle 的批量控制
- 全选/取消全选功能
- Toggle 集合的状态管理

## 技术要点

- 使用 @State 和 @Binding 进行状态管理
- 演示不同平台的样式差异
- 包含无障碍支持
- 性能优化和最佳实践

## 完成标准

- 所有示例都有详细的中文注释
- 代码结构清晰，易于理解
- 在 iOS 和 macOS 平台编译无错误
- 文档完整，包含使用说明和最佳实践
