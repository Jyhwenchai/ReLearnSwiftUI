# RenameButton 组件详解

## 概述

RenameButton 是 SwiftUI 中的一个特殊用途按钮，专门用于触发标准的重命名操作。它是 iOS 16.0+ 引入的新组件，为应用提供了统一的重命名交互体验。

## 基本语法

```swift
RenameButton()
```

RenameButton 是一个无参数的简单组件，它的行为完全依赖于环境中的 renameAction。

## 核心概念

### 1. 环境依赖

RenameButton 从环境中获取重命名操作，如果没有定义 renameAction，按钮会自动被禁用。

```swift
// 错误示例 - 按钮会被禁用
RenameButton()

// 正确示例 - 提供 renameAction
SomeView()
    .renameAction {
        // 重命名逻辑
    }
```

### 2. renameAction 修饰符

renameAction 是配合 RenameButton 使用的关键修饰符：

```swift
func renameAction(_ action: @escaping () -> Void) -> some View
```

**参数说明：**

- `action`: 重命名时执行的闭包

**使用示例：**

```swift
TextField("名称", text: $itemName)
    .renameAction {
        // 开始重命名操作
        isEditing = true
    }
```

## 使用场景

### 1. 上下文菜单中使用

```swift
Text("文件名")
    .contextMenu {
        RenameButton()
        // 其他菜单项
    }
    .renameAction {
        startRenaming()
    }
```

### 2. 导航标题菜单中使用

```swift
NavigationView {
    ContentView()
        .navigationTitle("标题")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    RenameButton()
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .renameAction {
            // 重命名标题逻辑
        }
}
```

### 3. 列表项重命名

```swift
List {
    ForEach(items) { item in
        Text(item.name)
            .contextMenu {
                RenameButton()
            }
            .renameAction {
                startRenaming(item)
            }
    }
}
```

## 状态管理模式

### 1. 基础状态管理

```swift
struct RenameableItem: View {
    @State private var name: String
    @State private var isEditing = false
    @FocusState private var isFocused: Bool

    var body: some View {
        if isEditing {
            TextField("名称", text: $name)
                .focused($isFocused)
                .onSubmit {
                    completeRename()
                }
        } else {
            Text(name)
                .contextMenu {
                    RenameButton()
                }
                .renameAction {
                    startRename()
                }
        }
    }

    private func startRename() {
        isEditing = true
        isFocused = true
    }

    private func completeRename() {
        isEditing = false
        isFocused = false
    }
}
```

### 2. 高级状态管理

```swift
class RenameManager: ObservableObject {
    @Published var editingItem: Item?
    @Published var editingText = ""

    func startRename(_ item: Item) {
        editingItem = item
        editingText = item.name
    }

    func completeRename() {
        guard let item = editingItem else { return }
        item.name = editingText
        editingItem = nil
        editingText = ""
    }

    func cancelRename() {
        editingItem = nil
        editingText = ""
    }
}
```

## 焦点管理

### 1. @FocusState 使用

```swift
struct FocusExample: View {
    @State private var text = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField("输入", text: $text)
            .focused($isFocused)
            .renameAction {
                // 延迟聚焦确保界面更新完成
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isFocused = true
                }
            }
    }
}
```

### 2. 键盘事件处理

```swift
.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
    if isEditing {
        completeRename()
    }
}
```

## 输入验证

### 1. 基础验证

```swift
private func validateAndSave() {
    let trimmed = newName.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else {
        showError("名称不能为空")
        return
    }

    guard trimmed != originalName else {
        cancelRename()
        return
    }

    saveName(trimmed)
}
```

### 2. 高级验证

```swift
private func validateName(_ name: String) -> ValidationResult {
    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)

    if trimmed.isEmpty {
        return .failure("名称不能为空")
    }

    if trimmed.count > 50 {
        return .failure("名称过长")
    }

    if existingNames.contains(trimmed) {
        return .failure("名称已存在")
    }

    let invalidChars = CharacterSet(charactersIn: "/\\:*?\"<>|")
    if trimmed.rangeOfCharacter(from: invalidChars) != nil {
        return .failure("名称包含无效字符")
    }

    return .success(trimmed)
}
```

## 用户体验优化

### 1. 动画效果

```swift
withAnimation(.easeInOut(duration: 0.3)) {
    isEditing.toggle()
}
```

### 2. 错误处理

```swift
@State private var errorMessage: String?
@State private var showError = false

// 显示错误
private func showError(_ message: String) {
    errorMessage = message
    showError = true
}

// 在视图中显示
.alert("错误", isPresented: $showError) {
    Button("确定") { }
} message: {
    Text(errorMessage ?? "")
}
```

### 3. 成功反馈

```swift
@State private var showSuccess = false

private func showSuccessMessage() {
    showSuccess = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        showSuccess = false
    }
}

// 成功提示
.overlay(
    Text("重命名成功")
        .padding()
        .background(Color.green)
        .foregroundColor(.white)
        .cornerRadius(8)
        .opacity(showSuccess ? 1 : 0)
        .animation(.easeInOut, value: showSuccess)
)
```

## 可访问性支持

### 1. 基础可访问性

```swift
RenameButton()
    .accessibilityLabel("重命名")
    .accessibilityHint("双击开始重命名")
```

### 2. 动态可访问性

```swift
TextField("名称", text: $name)
    .accessibilityLabel(isEditing ? "编辑名称" : "名称")
    .accessibilityValue(name)
    .accessibilityHint(isEditing ? "输入新名称后按回车确认" : "双击编辑名称")
```

## 平台差异

### iOS 特有功能

- 上下文菜单集成
- 导航栏标题重命名
- 键盘事件处理
- UIAlertController 集成

### 跨平台注意事项

```swift
#if os(iOS)
// iOS 特有代码
.contextMenu {
    RenameButton()
}
#else
// 其他平台替代方案
Button("重命名") {
    startRename()
}
#endif
```

## 性能优化

### 1. 状态更新优化

```swift
// 避免频繁更新
private func updateName(_ newName: String) {
    // 防抖处理
    NSObject.cancelPreviousPerformRequests(withTarget: self)
    perform(#selector(actualUpdate), with: newName, afterDelay: 0.5)
}
```

### 2. 内存管理

```swift
// 及时清理状态
deinit {
    NotificationCenter.default.removeObserver(self)
}
```

## 常见问题

### 1. 按钮被禁用

**问题**: RenameButton 显示为灰色不可点击
**解决**: 确保提供了 renameAction

```swift
// 错误
RenameButton()

// 正确
SomeView()
    .renameAction { /* 处理逻辑 */ }
```

### 2. 焦点管理问题

**问题**: TextField 无法获得焦点
**解决**: 使用延迟聚焦

```swift
.renameAction {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        isFocused = true
    }
}
```

### 3. 键盘事件冲突

**问题**: 键盘隐藏时意外触发操作
**解决**: 添加状态检查

```swift
.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
    if isEditing && !editingText.isEmpty {
        completeRename()
    }
}
```

## 最佳实践

### 1. 设计原则

- 保持操作的一致性
- 提供清晰的视觉反馈
- 支持键盘和触摸操作
- 处理边界情况

### 2. 代码组织

- 分离状态管理逻辑
- 使用可复用的组件
- 添加详细的注释
- 进行充分的测试

### 3. 用户体验

- 提供即时反馈
- 支持撤销操作
- 处理网络错误
- 优化加载状态

## 示例应用场景

### 1. 文件管理器

- 文件和文件夹重命名
- 批量重命名操作
- 重命名历史记录

### 2. 笔记应用

- 笔记标题编辑
- 分类名称修改
- 标签管理

### 3. 项目管理

- 项目名称修改
- 任务重命名
- 里程碑编辑

### 4. 媒体库

- 播放列表重命名
- 相册标题编辑
- 标签分类管理

RenameButton 虽然是一个简单的组件，但在实际应用中需要考虑状态管理、用户体验、错误处理等多个方面。通过合理的设计和实现，可以为用户提供流畅、直观的重命名体验。
