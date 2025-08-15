# PasteButton 组件详解

## 概述

`PasteButton` 是 SwiftUI 在 iOS 16.0+ 和 macOS 13.0+ 中引入的系统按钮，专门用于从系统剪贴板读取内容并将其传递给应用程序进行处理。它提供了一种标准化的方式来实现粘贴功能，具有系统一致的外观和行为。

## 基本语法

```swift
PasteButton(payloadType: DataType.self) { items in
    // 处理粘贴的数据
}
```

## 平台支持

- **iOS**: 16.0+
- **iPadOS**: 16.0+
- **macOS**: 13.0+（某些初始化方法需要 13.0+）
- **Mac Catalyst**: 16.0+
- **visionOS**: 1.0+

## 核心特性

### 1. 自动验证

- 按钮会自动检测剪贴板内容的有效性
- 只有当剪贴板包含指定类型的数据时，按钮才会启用
- 在 iOS 上会根据剪贴板变化自动更新状态

### 2. 类型安全

- 支持强类型的数据处理
- 通过 `Transferable` 协议支持自定义数据类型
- 编译时类型检查确保数据处理的安全性

### 3. 系统集成

- 提供系统标准的外观和交互行为
- 自动适配当前环境的主题和样式
- 支持可访问性功能

## 初始化方法

### 1. 基础初始化

```swift
init<T>(payloadType: T.Type, onPaste: @escaping ([T]) -> Void) where T : Transferable
```

**参数说明：**

- `payloadType`: 指定接受的数据类型
- `onPaste`: 处理粘贴数据的闭包，接收一个数组参数

**示例：**

```swift
PasteButton(payloadType: String.self) { strings in
    // strings 是 [String] 类型
    if let firstString = strings.first {
        pastedText = firstString
    }
}
```

### 2. 高级初始化（部分版本支持）

```swift
init(supportedTypes: [UTType], payloadAction: @escaping ([NSItemProvider]) -> Void)
```

**参数说明：**

- `supportedTypes`: 支持的统一类型标识符数组
- `payloadAction`: 处理数据提供者的闭包

## 支持的数据类型

### 1. 内置类型

#### String（字符串）

```swift
PasteButton(payloadType: String.self) { strings in
    // 处理文本内容
    let text = strings.joined(separator: "\n")
}
```

#### URL（链接）

```swift
PasteButton(payloadType: URL.self) { urls in
    // 处理 URL 链接
    for url in urls {
        print("URL: \(url.absoluteString)")
    }
}
```

#### Image（图片）

```swift
PasteButton(payloadType: Image.self) { images in
    // 处理图片内容
    if let firstImage = images.first {
        displayedImage = firstImage
    }
}
```

#### Data（二进制数据）

```swift
PasteButton(payloadType: Data.self) { dataArray in
    // 处理二进制数据
    let totalBytes = dataArray.reduce(0) { $0 + $1.count }
    print("Total bytes: \(totalBytes)")
}
```

### 2. 自定义类型

要支持自定义类型，需要实现 `Transferable` 协议：

```swift
struct CustomData: Transferable {
    let content: String
    let timestamp: Date

    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
    }
}

// 使用自定义类型
PasteButton(payloadType: CustomData.self) { customDataArray in
    // 处理自定义数据
}
```

## 样式自定义

### 1. 颜色主题

```swift
PasteButton(payloadType: String.self) { strings in
    // 处理逻辑
}
.tint(.blue)  // 设置主题颜色
```

### 2. 边框样式

```swift
// 圆角矩形（iOS 16.0+, macOS 14.0+）
.buttonBorderShape(.roundedRectangle(radius: 12))

// 胶囊形（iOS 16.0+, macOS 14.0+）
.buttonBorderShape(.capsule)

// 圆形（iOS 17.0+, macOS 14.0+）
.buttonBorderShape(.circle)
```

### 3. 标签样式

```swift
// 只显示图标
.labelStyle(.iconOnly)

// 只显示文字
.labelStyle(.titleOnly)

// 显示图标和文字
.labelStyle(.titleAndIcon)
```

### 4. 控件尺寸

```swift
// 小尺寸
.controlSize(.small)

// 常规尺寸
.controlSize(.regular)

// 大尺寸
.controlSize(.large)
```

## 实际应用场景

### 1. 文本编辑器

```swift
struct TextEditor: View {
    @State private var content: String = ""

    var body: some View {
        VStack {
            TextEditor(text: $content)

            HStack {
                PasteButton(payloadType: String.self) { strings in
                    content += strings.joined(separator: "\n")
                }
                .tint(.blue)

                Spacer()
            }
        }
    }
}
```

### 2. URL 收藏夹

```swift
struct BookmarkManager: View {
    @State private var bookmarks: [URL] = []

    var body: some View {
        VStack {
            List(bookmarks, id: \.self) { url in
                Text(url.absoluteString)
            }

            PasteButton(payloadType: URL.self) { urls in
                for url in urls {
                    if !bookmarks.contains(url) {
                        bookmarks.append(url)
                    }
                }
            }
            .tint(.green)
        }
    }
}
```

### 3. 图片查看器

```swift
struct ImageViewer: View {
    @State private var displayedImage: Image?

    var body: some View {
        VStack {
            if let image = displayedImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("暂无图片")
                    .foregroundColor(.secondary)
            }

            PasteButton(payloadType: Image.self) { images in
                displayedImage = images.first
            }
            .tint(.purple)
        }
    }
}
```

## 数据验证和错误处理

### 1. 基础验证

```swift
PasteButton(payloadType: String.self) { strings in
    guard !strings.isEmpty else {
        print("没有接收到数据")
        return
    }

    let content = strings.joined(separator: "\n")

    // 验证内容长度
    guard content.count <= 1000 else {
        showError("内容长度超过限制")
        return
    }

    // 处理有效内容
    processContent(content)
}
```

### 2. 异步处理

```swift
PasteButton(payloadType: Data.self) { dataArray in
    Task {
        do {
            for data in dataArray {
                try await processData(data)
            }
        } catch {
            await MainActor.run {
                showError("数据处理失败: \(error.localizedDescription)")
            }
        }
    }
}
```

### 3. 内容过滤

```swift
PasteButton(payloadType: String.self) { strings in
    let filteredStrings = strings.compactMap { string in
        // 过滤空字符串和过长的内容
        guard !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              string.count <= 500 else {
            return nil
        }

        // 过滤敏感内容
        return string.replacingOccurrences(of: "敏感词", with: "***")
    }

    guard !filteredStrings.isEmpty else {
        showError("没有有效的内容")
        return
    }

    processFilteredContent(filteredStrings)
}
```

## 跨平台兼容性

### 1. 平台特定功能

```swift
PasteButton(payloadType: String.self) { strings in
    processStrings(strings)
}
#if os(iOS)
.navigationBarTitleDisplayMode(.inline)
#endif
```

### 2. 版本兼容性

```swift
if #available(iOS 16.0, macOS 14.0, *) {
    PasteButton(payloadType: String.self) { strings in
        processStrings(strings)
    }
    .buttonBorderShape(.roundedRectangle(radius: 12))
} else {
    PasteButton(payloadType: String.self) { strings in
        processStrings(strings)
    }
}
```

## 性能优化

### 1. 避免重复处理

```swift
struct OptimizedPasteButton: View {
    @State private var lastProcessedContent: String = ""

    var body: some View {
        PasteButton(payloadType: String.self) { strings in
            let content = strings.joined(separator: "\n")

            // 避免重复处理相同内容
            guard content != lastProcessedContent else { return }

            lastProcessedContent = content
            processContent(content)
        }
    }
}
```

### 2. 大数据处理

```swift
PasteButton(payloadType: Data.self) { dataArray in
    // 在后台队列处理大数据
    DispatchQueue.global(qos: .userInitiated).async {
        let processedData = dataArray.map { processLargeData($0) }

        DispatchQueue.main.async {
            updateUI(with: processedData)
        }
    }
}
```

## 可访问性支持

### 1. 自定义标签

```swift
PasteButton(payloadType: String.self) { strings in
    processStrings(strings)
}
.accessibilityLabel("粘贴文本内容")
.accessibilityHint("从剪贴板粘贴文本到当前位置")
```

### 2. 状态反馈

```swift
struct AccessiblePasteButton: View {
    @State private var isProcessing = false

    var body: some View {
        PasteButton(payloadType: String.self) { strings in
            isProcessing = true
            processStrings(strings)
            isProcessing = false
        }
        .accessibilityValue(isProcessing ? "正在处理" : "就绪")
    }
}
```

## 常见问题和解决方案

### 1. 按钮不启用

**问题**: PasteButton 始终处于禁用状态

**解决方案**:

- 确保剪贴板包含指定类型的数据
- 检查数据类型是否正确实现了 `Transferable` 协议
- 在模拟器中测试时，确保已复制相应类型的内容

### 2. 数据接收为空

**问题**: 闭包被调用但接收到的数组为空

**解决方案**:

```swift
PasteButton(payloadType: String.self) { strings in
    guard !strings.isEmpty else {
        print("警告: 接收到空数据数组")
        return
    }
    // 正常处理
}
```

### 3. 跨平台样式问题

**问题**: 某些样式在不同平台表现不一致

**解决方案**:

```swift
PasteButton(payloadType: String.self) { strings in
    processStrings(strings)
}
.apply { view in
    if #available(iOS 16.0, macOS 14.0, *) {
        view.buttonBorderShape(.capsule)
    } else {
        view
    }
}
```

### 4. 内存泄漏

**问题**: 处理大量数据时出现内存问题

**解决方案**:

```swift
PasteButton(payloadType: Data.self) { dataArray in
    // 使用 autoreleasepool 管理内存
    autoreleasepool {
        for data in dataArray {
            processData(data)
        }
    }
}
```

## 最佳实践

### 1. 用户体验

- 提供清晰的视觉反馈
- 处理失败时给出有意义的错误信息
- 支持撤销操作（如果适用）

### 2. 数据安全

- 验证粘贴的数据格式和内容
- 过滤潜在的恶意内容
- 限制数据大小和数量

### 3. 性能考虑

- 异步处理大量数据
- 避免在主线程进行耗时操作
- 合理使用内存管理

### 4. 可访问性

- 提供适当的可访问性标签
- 支持键盘导航
- 考虑视觉障碍用户的需求

## 相关组件

- `EditButton`: 用于切换编辑模式的系统按钮
- `RenameButton`: 用于重命名操作的系统按钮
- `ShareLink`: 用于分享内容的系统组件
- `Transferable`: 定义可传输数据的协议

## 总结

`PasteButton` 是一个功能强大且易于使用的 SwiftUI 组件，它简化了剪贴板数据的处理流程。通过合理使用其各种特性和最佳实践，可以为用户提供流畅、安全的粘贴体验。在实际开发中，应该根据具体需求选择合适的数据类型和处理方式，同时注意跨平台兼容性和性能优化。
