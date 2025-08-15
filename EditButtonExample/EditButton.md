# EditButton 组件详解

## 概述

`EditButton` 是 SwiftUI 中的一个特殊按钮组件，专门用于切换编辑模式状态。它会自动在 "Edit" 和 "Done" 之间切换标题，并管理环境中的 `editMode` 值。这个组件主要用于 iOS 平台，在需要编辑功能的界面中提供标准化的用户体验。

## 基本语法

```swift
EditButton()
```

## 平台支持

- **iOS** 13.0+
- **iPadOS** 13.0+
- **Mac Catalyst** 13.0+
- **visionOS** 1.0+

**注意：** EditButton 在 macOS 上不可用。

## 核心概念

### 1. 编辑模式 (EditMode)

EditButton 与 SwiftUI 的编辑模式系统紧密集成：

```swift
enum EditMode {
    case inactive  // 非编辑模式
    case active    // 编辑模式
    case transient // 过渡状态
}
```

### 2. 环境值 (Environment Value)

EditButton 通过环境值 `editMode` 来管理编辑状态：

```swift
@Environment(\.editMode) private var editMode
```

## 基本用法

### 1. 简单的 EditButton

```swift
struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Text("项目 1")
                Text("项目 2")
                Text("项目 3")
            }
            .navigationTitle("列表")
            .toolbar {
                EditButton()
            }
        }
    }
}
```

### 2. 与 List 结合使用

```swift
struct EditableListView: View {
    @State private var items = ["苹果", "香蕉", "橙子"]

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationTitle("水果")
            .toolbar {
                EditButton()
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func moveItems(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}
```

### 3. 读取编辑模式状态

```swift
struct EditModeAwareView: View {
    @Environment(\.editMode) private var editMode
    @State private var text = "Hello, World!"

    var body: some View {
        VStack {
            if editMode?.wrappedValue.isEditing == true {
                TextField("编辑文本", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(text)
            }
        }
        .navigationTitle("编辑示例")
        .toolbar {
            EditButton()
        }
    }
}
```

## 高级用法

### 1. 自定义编辑按钮

虽然不能直接自定义 EditButton 的外观，但可以创建自己的编辑按钮：

```swift
struct CustomEditButton: View {
    @Environment(\.editMode) private var editMode

    var body: some View {
        Button(action: {
            withAnimation {
                if editMode?.wrappedValue.isEditing == true {
                    editMode?.wrappedValue = .inactive
                } else {
                    editMode?.wrappedValue = .active
                }
            }
        }) {
            Text(editMode?.wrappedValue.isEditing == true ? "完成" : "编辑")
        }
    }
}
```

### 2. 条件性显示 EditButton

```swift
struct ConditionalEditView: View {
    @State private var items = ["项目1", "项目2"]
    @State private var canEdit = true

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: canEdit ? deleteItems : nil)
            }
            .navigationTitle("条件编辑")
            .toolbar {
                if canEdit {
                    EditButton()
                }
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
```

### 3. 编辑模式生命周期管理

```swift
struct EditLifecycleView: View {
    @Environment(\.editMode) private var editMode
    @State private var backupData: [String] = []
    @State private var currentData = ["数据1", "数据2", "数据3"]

    var body: some View {
        NavigationView {
            List {
                ForEach(currentData, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("生命周期管理")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if editMode?.wrappedValue.isEditing == true {
                        Button("取消") {
                            cancelEditing()
                        }

                        Button("保存") {
                            saveChanges()
                        }
                    } else {
                        Button("编辑") {
                            startEditing()
                        }
                    }
                }
            }
        }
    }

    func startEditing() {
        backupData = currentData
        withAnimation {
            editMode?.wrappedValue = .active
        }
    }

    func cancelEditing() {
        currentData = backupData
        withAnimation {
            editMode?.wrappedValue = .inactive
        }
    }

    func saveChanges() {
        // 保存逻辑
        withAnimation {
            editMode?.wrappedValue = .inactive
        }
    }

    func deleteItems(at offsets: IndexSet) {
        currentData.remove(atOffsets: offsets)
    }
}
```

## EditMode 详解

### 1. EditMode 状态

```swift
// 检查是否在编辑模式
if editMode?.wrappedValue.isEditing == true {
    // 编辑模式逻辑
}

// 检查具体状态
switch editMode?.wrappedValue {
case .active:
    // 编辑模式激活
case .inactive:
    // 编辑模式未激活
case .transient:
    // 过渡状态
case .none:
    // 编辑模式不可用
}
```

### 2. 手动控制编辑模式

```swift
// 激活编辑模式
editMode?.wrappedValue = .active

// 退出编辑模式
editMode?.wrappedValue = .inactive

// 带动画的状态切换
withAnimation {
    editMode?.wrappedValue = editMode?.wrappedValue.isEditing == true ? .inactive : .active
}
```

## 与其他组件的集成

### 1. 与 ForEach 结合

```swift
List {
    ForEach(items, id: \.self) { item in
        Text(item)
    }
    .onDelete(perform: deleteItems)  // 删除功能
    .onMove(perform: moveItems)      // 移动功能
}
```

### 2. 与 TextField 结合

```swift
VStack {
    ForEach($items, id: \.self) { $item in
        if editMode?.wrappedValue.isEditing == true {
            TextField("编辑项目", text: $item)
        } else {
            Text(item)
        }
    }
}
```

### 3. 与选择功能结合

```swift
List(selection: $selectedItems) {
    ForEach(items, id: \.self) { item in
        Text(item)
    }
}
// 注意：多选功能只在编辑模式下可用
```

## 最佳实践

### 1. 用户体验

- **一致性**：在整个应用中保持编辑模式的一致行为
- **反馈**：提供清晰的视觉反馈表明当前处于编辑模式
- **取消机制**：允许用户取消编辑操作

### 2. 性能优化

```swift
// 使用 @State 而不是 @ObservedObject 来管理简单的编辑状态
@State private var isEditing = false

// 避免在编辑模式切换时进行昂贵的操作
.onChange(of: editMode?.wrappedValue) { newValue in
    // 轻量级操作
}
```

### 3. 错误处理

```swift
func deleteItems(at offsets: IndexSet) {
    guard !offsets.isEmpty else { return }

    withAnimation {
        items.remove(atOffsets: offsets)
    }
}
```

### 4. 可访问性

```swift
EditButton()
    .accessibilityLabel("编辑列表")
    .accessibilityHint("点击进入编辑模式以删除或重新排列项目")
```

## 常见问题

### 1. EditButton 不显示？

确保 EditButton 放置在支持工具栏的容器中：

```swift
NavigationView {
    // 内容
    .toolbar {
        EditButton()
    }
}
```

### 2. 编辑模式状态不更新？

确保正确使用环境值：

```swift
@Environment(\.editMode) private var editMode
```

### 3. 删除/移动功能不工作？

确保为 ForEach 添加了相应的修饰符：

```swift
ForEach(items, id: \.self) { item in
    Text(item)
}
.onDelete(perform: deleteItems)
.onMove(perform: moveItems)
```

### 4. macOS 兼容性问题？

EditButton 在 macOS 上不可用，需要创建自定义解决方案：

```swift
#if os(iOS)
EditButton()
#else
Button("编辑") {
    // 自定义编辑逻辑
}
#endif
```

## 注意事项

1. **平台限制**：EditButton 主要为 iOS 设计，在 macOS 上不可用
2. **环境依赖**：EditButton 依赖于 SwiftUI 的环境系统
3. **自动管理**：EditButton 会自动管理按钮标题和编辑状态
4. **动画支持**：状态切换时会自动应用动画效果
5. **多选限制**：List 的多选功能只在编辑模式下可用

## 相关组件

- **List**：主要与 EditButton 配合使用的组件
- **ForEach**：提供删除和移动功能的组件
- **NavigationView**：提供工具栏支持
- **Toolbar**：EditButton 的容器

## 总结

EditButton 是 SwiftUI 中一个简单但强大的组件，它提供了标准化的编辑模式切换功能。通过与 List、ForEach 等组件的配合，可以轻松实现复杂的编辑界面。理解编辑模式的工作原理和最佳实践，能够帮助开发者创建更好的用户体验。

虽然 EditButton 的 API 相对简单，但它背后的编辑模式系统为 SwiftUI 应用提供了强大的编辑功能支持。合理使用这个组件，可以让应用的编辑功能更加直观和易用。
