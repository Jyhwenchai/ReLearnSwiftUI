# CommandMenu 详细文档

## 概述

CommandMenu 是 SwiftUI 中用于创建顶级命令菜单的容器。它允许开发者在应用中添加自定义的菜单栏菜单（macOS）或键盘快捷键（iOS/iPadOS）。

## 基本语法

```swift
CommandMenu("菜单标题") {
    // 菜单内容
    Button("菜单项") {
        // 操作
    }
}
```

## 平台差异

### macOS

- 在菜单栏中显示为实际的菜单
- 插入在 View 和 Window 菜单之间
- 支持完整的菜单层次结构

### iOS/iPadOS/tvOS

- 不显示可视菜单
- 为带有键盘快捷键的菜单项创建键盘命令
- 在外接键盘上可以使用快捷键

### visionOS

- 支持空间计算环境中的菜单交互
- 可以通过手势和语音控制

## 核心组件

### 1. CommandMenu

创建独立的顶级菜单。

```swift
CommandMenu("文件") {
    Button("新建") {
        // 新建操作
    }
    .keyboardShortcut("n", modifiers: .command)

    Button("打开") {
        // 打开操作
    }
    .keyboardShortcut("o", modifiers: .command)
}
```

### 2. CommandGroup

扩展现有的系统菜单。

```swift
// 在现有菜单组后添加
CommandGroup(after: .saveItem) {
    Button("导出") {
        // 导出操作
    }
}

// 替换现有菜单组
CommandGroup(replacing: .newItem) {
    Button("新建项目") {
        // 自定义新建操作
    }
}

// 在现有菜单组前添加
CommandGroup(before: .help) {
    Button("用户手册") {
        // 帮助操作
    }
}
```

## 标准命令组位置

CommandGroup 可以使用以下标准位置：

### 应用级别

- `.appInfo` - 应用信息（关于、偏好设置）
- `.appSettings` - 应用设置
- `.appVisibility` - 应用可见性（隐藏、退出）

### 文件操作

- `.newItem` - 新建项目
- `.openItem` - 打开项目
- `.saveItem` - 保存项目
- `.importExport` - 导入导出
- `.printItem` - 打印

### 编辑操作

- `.undoRedo` - 撤销重做
- `.pasteboard` - 剪贴板操作（剪切、复制、粘贴）
- `.textEditing` - 文本编辑
- `.textFormatting` - 文本格式化

### 视图操作

- `.toolbar` - 工具栏
- `.sidebar` - 侧边栏
- `.windowSize` - 窗口大小
- `.windowArrangement` - 窗口排列

### 帮助

- `.help` - 帮助菜单

## 菜单项类型

### 1. 基本按钮

```swift
Button("菜单项") {
    // 操作代码
}
.keyboardShortcut("k", modifiers: .command)
```

### 2. 子菜单

```swift
Menu("子菜单") {
    Button("子项目 1") { }
    Button("子项目 2") { }

    Divider() // 分隔符

    Button("子项目 3") { }
}
```

### 3. 分隔符

```swift
Divider()
```

### 4. 禁用项目

```swift
Button("禁用项目") {
    // 操作
}
.disabled(true)
```

### 5. 条件菜单项

```swift
if someCondition {
    Button("条件项目") {
        // 操作
    }
}
```

## 键盘快捷键

### 修饰键

- `.command` - Cmd 键（macOS）/ Ctrl 键（其他平台）
- `.option` - Option 键（macOS）/ Alt 键（其他平台）
- `.control` - Control 键
- `.shift` - Shift 键

### 组合修饰键

```swift
.keyboardShortcut("s", modifiers: [.command, .shift])
```

### 特殊键

```swift
.keyboardShortcut(.return) // 回车键
.keyboardShortcut(.escape) // ESC 键
.keyboardShortcut(.delete) // 删除键
.keyboardShortcut(.tab)    // Tab 键
```

## 动态菜单内容

### 基于状态的菜单

```swift
CommandMenu("动态菜单") {
    if isLoggedIn {
        Button("用户资料") { }
        Button("退出登录") { }
    } else {
        Button("登录") { }
        Button("注册") { }
    }
}
```

### 动态生成菜单项

```swift
CommandMenu("文档") {
    ForEach(openDocuments, id: \.self) { document in
        Button(document.name) {
            // 打开文档
        }
    }
}
```

## 最佳实践

### 1. 菜单结构设计

- 保持菜单层次清晰，避免过深的嵌套
- 使用分隔符分组相关功能
- 按照用户习惯组织菜单项

### 2. 键盘快捷键

- 使用标准的快捷键约定
- 避免与系统快捷键冲突
- 为常用功能提供快捷键

### 3. 菜单项命名

- 使用清晰、简洁的名称
- 保持命名一致性
- 使用动词描述操作

### 4. 状态管理

- 正确处理菜单项的启用/禁用状态
- 及时更新动态菜单内容
- 使用适当的状态管理模式

## 常见问题

### Q: CommandMenu 在 iOS 上不显示菜单？

A: 这是正常的。在 iOS 上，CommandMenu 只为带有键盘快捷键的项目创建键盘命令，不显示可视菜单。

### Q: 如何在现有系统菜单中添加项目？

A: 使用 CommandGroup 的 `after`、`before` 或 `replacing` 参数来扩展现有菜单。

### Q: 键盘快捷键不工作？

A: 确保：

1. 快捷键没有与系统快捷键冲突
2. 菜单项没有被禁用
3. 在正确的 Scene 级别定义了 commands

### Q: 如何创建复杂的嵌套菜单？

A: 使用 Menu 组件创建子菜单，可以无限嵌套。

## 注意事项

1. **Scene 级别定义**: CommandMenu 必须在 Scene 级别使用 `.commands` 修饰符定义
2. **平台兼容性**: 考虑不同平台的行为差异
3. **性能考虑**: 避免在菜单中执行耗时操作
4. **可访问性**: 确保菜单项有适当的可访问性标签
5. **本地化**: 为多语言应用提供本地化的菜单文本

## 相关组件

- `Commands` - 命令协议
- `CommandsBuilder` - 命令构建器
- `CommandGroupPlacement` - 命令组位置
- `Menu` - 普通菜单组件
- `Button` - 按钮组件

## 示例应用场景

1. **文本编辑器**: 文件、编辑、格式、工具菜单
2. **图片编辑器**: 图像、滤镜、工具、视图菜单
3. **项目管理**: 项目、任务、团队、报告菜单
4. **开发工具**: 代码、构建、调试、版本控制菜单

CommandMenu 是构建专业 macOS 应用的重要工具，同时也为 iOS 应用提供了键盘快捷键支持，是提升用户体验的关键组件。
