# EditButton 示例包

## 项目概述

本项目是一个完整的 SwiftUI EditButton 组件示例包，展示了 EditButton 在不同场景下的使用方法和最佳实践。

## 包含的示例

### 1. EditButtonExampleView01 - 基础 EditButton 使用

**功能描述：**

- 展示 EditButton 的基本创建和放置方法
- 演示如何读取和响应编辑模式状态
- 实现根据编辑模式显示不同内容的界面
- 包含用户信息编辑的实际应用场景

**主要特性：**

- 编辑模式状态实时显示
- 文本输入框与只读文本的动态切换
- 流畅的动画过渡效果
- 详细的中文注释说明

### 2. EditButtonExampleView02 - List 编辑功能

**功能描述：**

- 展示 EditButton 与 List 组件的经典组合
- 实现列表项的删除和移动功能
- 演示多选功能在编辑模式下的表现
- 包含添加新项目的完整流程

**主要特性：**

- 水果列表的增删改查操作
- 拖拽排序功能
- 多选和批量操作
- 编辑模式状态栏显示
- 添加新项目的弹窗界面

## 技术特色

### 1. 渐进式学习设计

- 从基础概念到高级应用的循序渐进
- 每个示例都有独立的学习价值
- 代码结构清晰，易于理解和修改

### 2. 详细的中文注释

- 每行关键代码都有详细的中文注释
- 解释 SwiftUI 概念和 EditButton 的工作原理
- 包含最佳实践和注意事项说明

### 3. 实际应用场景

- 用户信息编辑界面
- 列表管理功能
- 数据的增删改查操作
- 符合 iOS 设计规范的用户体验

### 4. 跨平台兼容性

- 专为 iOS 16.0+ 设计
- 支持 iPhone 和 iPad
- 遵循 SwiftUI 最佳实践

## 学习建议

### 推荐学习顺序：

1. **EditButtonExampleView01** - 掌握基础概念

   - 理解 EditButton 的基本用法
   - 学习编辑模式状态的读取和响应
   - 掌握动态界面切换的实现方法

2. **EditButtonExampleView02** - 学习实际应用

   - 了解 EditButton 与 List 的配合使用
   - 掌握列表编辑功能的实现
   - 学习复杂交互的处理方法

3. **阅读 EditButton.md 文档** - 深入理解
   - 全面了解 EditButton 的所有功能
   - 学习高级用法和最佳实践
   - 掌握常见问题的解决方案

## 代码结构

```
EditButtonExample/
├── Sources/
│   └── EditButtonExample/
│       ├── EditButton.swift              # 主入口文件
│       ├── EditButtonExampleView01.swift # 基础示例
│       └── EditButtonExampleView02.swift # List 编辑示例
├── EditButton.md                         # 详细技术文档
├── CLAUDE.md                             # 项目说明文档
└── Package.swift                         # Swift Package 配置
```

## 编译要求

- **iOS** 16.0+
- **Xcode** 14.0+
- **Swift** 5.7+

## 使用方法

### 1. 作为 Swift Package 导入

```swift
// 在 Package.swift 中添加依赖
dependencies: [
    .package(path: "../EditButtonExample")
]
```

### 2. 在代码中使用

```swift
import EditButtonExample

struct ContentView: View {
    var body: some View {
        EditButtonExample()
    }
}
```

### 3. 查看单个示例

```swift
import EditButtonExample

struct ContentView: View {
    var body: some View {
        EditButtonExampleView01()
        // 或
        EditButtonExampleView02()
    }
}
```

## 核心概念说明

### EditButton 的工作原理

- EditButton 是 SwiftUI 提供的特殊按钮组件
- 自动在 "Edit" 和 "Done" 之间切换标题
- 通过环境值 `editMode` 管理编辑状态
- 与 List 组件深度集成，支持删除和移动操作

### 编辑模式状态

- `inactive`: 非编辑模式，正常显示状态
- `active`: 编辑模式，允许修改操作
- `transient`: 过渡状态，通常很短暂

### 最佳实践

- 在 NavigationView 的 toolbar 中放置 EditButton
- 使用 @Environment(\.editMode) 读取编辑状态
- 为 ForEach 添加 onDelete 和 onMove 修饰符
- 提供清晰的视觉反馈表明编辑状态

## 扩展建议

基于这个示例包，你可以进一步探索：

1. **自定义编辑按钮样式**
2. **复杂的编辑状态管理**
3. **与 Core Data 的集成**
4. **批量操作功能**
5. **编辑权限控制**

## 注意事项

1. EditButton 主要为 iOS 设计，在 macOS 上不可用
2. 多选功能只在编辑模式下可用
3. 需要为 List 中的 ForEach 提供删除和移动处理函数
4. 编辑模式的切换会自动应用动画效果

## 总结

这个 EditButton 示例包提供了从基础到实际应用的完整学习路径。通过学习这些示例，开发者可以掌握 EditButton 的核心概念和实际应用技巧，为构建更好的 iOS 应用打下坚实基础。

每个示例都经过精心设计，不仅展示了功能实现，还包含了详细的注释和最佳实践建议。这使得本示例包不仅适合初学者学习，也适合有经验的开发者作为参考。
