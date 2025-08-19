# SwiftUI Menu 组件详解

## 概述

`Menu` 是 SwiftUI 中用于展示操作菜单的控件。它提供了一个可点击的标签，当用户与之交互时会显示一个包含多个操作选项的菜单。Menu 支持嵌套菜单、主要操作、自定义样式等高级功能。

## 基本语法

```swift
Menu("菜单标题") {
    Button("选项1", action: action1)
    Button("选项2", action: action2)
    Button("选项3", action: action3)
}
```

## 主要特性

### 1. 基础菜单创建

```swift
// 文本标签菜单
Menu("文件操作") {
    Button("新建", action: newFile)
    Button("打开", action: openFile)
    Button("保存", action: saveFile)
}

// 自定义标签菜单
Menu {
    Button("复制", action: copy)
    Button("粘贴", action: paste)
} label: {
    Label("编辑", systemImage: "pencil.circle")
}
```

### 2. 嵌套菜单

```swift
Menu("高级操作") {
    Button("基本操作", action: basicAction)

    // 嵌套子菜单
    Menu("导出选项") {
        Button("导出为 PDF", action: exportPDF)
        Button("导出为 Word", action: exportWord)
        Button("导出为 Excel", action: exportExcel)
    }

    Menu("导入选项") {
        Button("从本地导入", action: importLocal)
        Button("从云端导入", action: importCloud)
    }
}
```

### 3. 带主要操作的菜单

```swift
Menu {
    Button("添加到阅读列表", action: addToReadingList)
    Button("为所有标签页添加书签", action: bookmarkAll)
    Button("显示所有书签", action: showBookmarks)
} label: {
    Label("书签", systemImage: "bookmark")
} primaryAction: {
    // 主要操作：直接添加书签
    addBookmark()
}
```

## 初始化方法

### 1. 基础初始化

```swift
// 使用字符串标题
init(_ title: LocalizedStringKey, content: () -> Content)
init<S>(_ title: S, content: () -> Content) where S : StringProtocol

// 使用自定义标签
init(content: () -> Content, label: () -> Label)
```

### 2. 带主要操作的初始化

```swift
init(_ title: LocalizedStringKey,
     content: () -> Content,
     primaryAction: @escaping () -> Void)

init(content: () -> Content,
     label: () -> Label,
     primaryAction: @escaping () -> Void)
```

### 3. 带图片的初始化

```swift
init(_ titleKey: LocalizedStringKey,
     image: ImageResource,
     content: () -> Content)
```

## 相关修饰符

### 1. 菜单样式 - menuStyle

```swift
Menu("样式菜单") {
    Button("选项1", action: action1)
    Button("选项2", action: action2)
}
.menuStyle(.automatic)  // 自动样式（默认）
```

**可用样式:**

- `.automatic` - 自动样式，系统根据上下文选择合适的样式

### 2. 菜单顺序 - menuOrder

```swift
Menu("顺序菜单") {
    Button("第一项", action: action1)
    Button("第二项", action: action2)
    Button("第三项", action: action3)
}
.menuOrder(.fixed)      // 固定顺序
.menuOrder(.automatic)  // 自动顺序（默认）
```

**可用选项:**

- `.automatic` - 系统自动决定菜单项顺序
- `.fixed` - 保持代码中定义的顺序

### 3. 菜单指示器 - menuIndicator

```swift
Menu("指示器菜单") {
    Button("选项1", action: action1)
    Button("选项2", action: action2)
}
.menuIndicator(.visible)  // 显示指示器
.menuIndicator(.hidden)   // 隐藏指示器
.menuIndicator(.automatic) // 自动（默认）
```

**可用选项:**

- `.automatic` - 系统自动决定是否显示指示器
- `.visible` - 始终显示菜单指示器
- `.hidden` - 始终隐藏菜单指示器

### 4. 菜单关闭行为 - menuActionDismissBehavior

```swift
Menu("关闭行为菜单") {
    Button("普通操作", action: normalAction)

    Toggle("切换选项", isOn: $toggleState)
        .menuActionDismissBehavior(.disabled)  // 不关闭菜单

    Button("关闭菜单的操作", action: closeAction)
        .menuActionDismissBehavior(.automatic) // 关闭菜单
}
.menuActionDismissBehavior(.automatic)
```

**可用选项:**

- `.automatic` - 执行操作后自动关闭菜单（默认）
- `.disabled` - 执行操作后不关闭菜单

## 上下文菜单

### 1. 基础上下文菜单

```swift
Text("长按显示菜单")
    .contextMenu {
        Button("复制", action: copy)
        Button("分享", action: share)
        Button("删除", action: delete)
    }
```

### 2. 带预览的上下文菜单

```swift
Image("photo")
    .contextMenu(menuItems: {
        Button("保存", action: save)
        Button("分享", action: share)
        Button("删除", action: delete)
    }, preview: {
        // 预览内容
        VStack {
            Image("photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text("照片预览")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    })
```

### 3. 选择性上下文菜单

```swift
List(selection: $selectedItems) {
    ForEach(items) { item in
        Text(item.name)
    }
}
.contextMenu(forSelectionType: Item.ID.self) { selectedIDs in
    if selectedIDs.isEmpty {
        Button("全选", action: selectAll)
    } else {
        Button("复制选中项", action: { copyItems(selectedIDs) })
        Button("删除选中项", action: { deleteItems(selectedIDs) })
    }
}
```

## 菜单内容组织

### 1. 使用分隔符

```swift
Menu("组织菜单") {
    Button("操作1", action: action1)
    Button("操作2", action: action2)

    Divider()  // 分隔符

    Button("设置", action: settings)
    Button("帮助", action: help)
}
```

### 2. 菜单项角色

```swift
Menu("角色菜单") {
    Button("普通操作", action: normalAction)

    Button("删除", role: .destructive, action: deleteAction)  // 破坏性操作
    Button("取消", role: .cancel, action: cancelAction)       // 取消操作
}
```

### 3. 动态菜单内容

```swift
Menu("动态菜单") {
    ForEach(dynamicItems) { item in
        Button(item.title, action: { selectItem(item) })
    }

    if showAdvancedOptions {
        Divider()
        Button("高级选项", action: advancedAction)
    }
}
```

## 环境值

### 1. 菜单相关环境值

```swift
// 设置菜单顺序
.environment(\.menuOrder, .fixed)

// 设置菜单指示器可见性
.environment(\.menuIndicatorVisibility, .hidden)
```

### 2. 在环境中使用

```swift
@Environment(\.menuOrder) var menuOrder
@Environment(\.menuIndicatorVisibility) var menuIndicatorVisibility
```

## 平台差异

### iOS/iPadOS

- 点击显示菜单
- 支持长按手势
- 菜单以弹出窗口形式显示

### macOS

- 点击箭头图标显示菜单
- 支持右键点击
- 菜单以下拉形式显示

### tvOS

- 使用遥控器选择
- 菜单项较大，适合电视界面

### visionOS

- 支持手势和眼动追踪
- 3D 空间中的菜单显示

## 最佳实践

### 1. 菜单项数量

- 避免菜单项过多（建议不超过 7-9 项）
- 使用子菜单组织相关功能
- 考虑使用分隔符分组

### 2. 菜单标签设计

- 使用清晰、简洁的标签文本
- 适当使用图标增强可识别性
- 保持标签样式一致

### 3. 交互设计

- 为常用操作提供主要操作
- 合理使用上下文菜单
- 考虑不同平台的交互习惯

### 4. 性能优化

- 避免在菜单中执行耗时操作
- 使用延迟加载动态内容
- 合理使用状态管理

## 常见问题

### Q: 如何创建多级嵌套菜单？

A: 在菜单内容中使用 `Menu` 组件创建子菜单：

```swift
Menu("主菜单") {
    Menu("子菜单1") {
        Button("选项1", action: action1)
        Button("选项2", action: action2)
    }
    Menu("子菜单2") {
        Button("选项A", action: actionA)
        Button("选项B", action: actionB)
    }
}
```

### Q: 如何在菜单项中显示状态？

A: 使用自定义视图或图标来显示状态：

```swift
Menu("状态菜单") {
    Button(action: toggleOption) {
        HStack {
            Text("选项")
            Spacer()
            if isOptionEnabled {
                Image(systemName: "checkmark")
            }
        }
    }
}
```

### Q: 如何禁用菜单项？

A: 使用 `.disabled()` 修饰符：

```swift
Menu("菜单") {
    Button("可用选项", action: availableAction)
    Button("禁用选项", action: disabledAction)
        .disabled(true)
}
```

### Q: 如何自定义菜单样式？

A: 创建自定义 `MenuStyle`：

```swift
struct CustomMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 自定义菜单外观
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

// 使用自定义样式
Menu("自定义菜单") {
    // 菜单内容
}
.menuStyle(CustomMenuStyle())
```

## 注意事项

1. **平台兼容性**: Menu 在 iOS 14.0+、macOS 11.0+ 等平台可用
2. **性能考虑**: 避免在菜单中放置过多复杂视图
3. **可访问性**: 确保菜单项有适当的标签和提示
4. **用户体验**: 保持菜单结构简单清晰，避免过深的嵌套
5. **状态管理**: 合理管理菜单相关的状态变化

## 相关组件

- `Button` - 菜单项的主要组件
- `Label` - 创建带图标的菜单标签
- `Divider` - 菜单项分隔符
- `Toggle` - 菜单中的开关控件
- `Picker` - 选择器，可用作菜单样式
- `ContextMenu` - 上下文菜单的专用组件

Menu 组件为 SwiftUI 应用提供了强大而灵活的菜单功能，通过合理使用其各种特性，可以创建出用户友好的交互界面。
