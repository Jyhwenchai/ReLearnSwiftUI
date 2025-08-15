# ShareLink 组件完全指南

## 概述

ShareLink 是 SwiftUI 中用于分享内容的组件，它提供了系统标准的分享界面，支持分享各种类型的数据。ShareLink 让用户能够轻松地将应用中的内容分享到其他应用或服务中。

### 主要特性

- **系统集成**：使用系统原生的分享界面
- **多类型支持**：支持 URL、文本、图片、文件等多种内容类型
- **自定义预览**：可以自定义分享界面中的预览内容
- **预填充内容**：支持为邮件和消息应用预设主题和正文
- **跨平台兼容**：支持 iOS、macOS、watchOS 和 visionOS

### 系统要求

- iOS 16.0+
- macOS 13.0+
- watchOS 9.0+
- visionOS 1.0+

## 基础用法

### 最简单的分享

```swift
ShareLink(item: URL(string: "https://example.com")!)
```

这会创建一个使用系统默认样式的分享按钮。

### 带自定义标题的分享

```swift
ShareLink("分享链接", item: URL(string: "https://example.com")!)
```

### 分享文本内容

```swift
let text = "这是要分享的文本内容"
ShareLink("分享文本", item: text)
```

## 自定义标签

ShareLink 支持完全自定义的标签内容：

```swift
ShareLink(item: url) {
    Label("分享", systemImage: "square.and.arrow.up")
        .foregroundColor(.blue)
}
```

### 复杂的自定义标签

```swift
ShareLink(item: content) {
    VStack {
        Image(systemName: "paperplane.fill")
            .font(.title)
        Text("发送")
            .font(.caption)
    }
    .foregroundColor(.white)
    .padding()
    .background(Color.blue)
    .cornerRadius(10)
}
```

## 支持的内容类型

### 内置类型

ShareLink 原生支持以下类型：

- **URL**：网页链接，系统会自动获取预览
- **String**：纯文本内容
- **Data**：二进制数据（需要指定内容类型）
- **Image**：图片内容

### 自定义 Transferable 类型

要分享自定义类型，需要实现 `Transferable` 协议：

```swift
struct Photo: Transferable {
    let image: Image
    let caption: String

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(\.image)
    }
}
```

### 复杂的 Transferable 实现

```swift
struct Article: Transferable {
    let title: String
    let content: String
    let url: URL?

    static var transferRepresentation: some TransferRepresentation {
        Group {
            // 作为 URL 分享
            ProxyRepresentation { article in
                article.url ?? URL(string: "https://example.com")!
            }

            // 作为文本分享
            DataRepresentation(contentType: .plainText) { article in
                let text = "\(article.title)\n\n\(article.content)"
                return text.data(using: .utf8) ?? Data()
            }

            // 作为 HTML 分享
            DataRepresentation(contentType: .html) { article in
                let html = "<h1>\(article.title)</h1><p>\(article.content)</p>"
                return html.data(using: .utf8) ?? Data()
            }
        }
    }
}
```

## 分享预览

### 基础预览

```swift
ShareLink(
    item: photo,
    preview: SharePreview(
        "照片标题",
        image: photo.image
    )
)
```

### 带图标的预览

```swift
ShareLink(
    item: document,
    preview: SharePreview(
        document.title,
        icon: Image(systemName: "doc.text")
    )
)
```

## 预填充主题和消息

ShareLink 支持为邮件和消息应用预填充内容：

```swift
ShareLink(
    item: article,
    subject: Text("推荐阅读：\(article.title)"),
    message: Text("我发现了一篇很棒的文章，推荐给你！"),
    preview: SharePreview(article.title, icon: Image(systemName: "doc"))
)
```

### 参数说明

- **subject**：邮件主题，仅在支持的应用中生效
- **message**：预填充的消息内容
- **preview**：分享界面中显示的预览

## 批量分享

ShareLink 支持一次分享多个项目：

```swift
let urls = [
    URL(string: "https://example1.com")!,
    URL(string: "https://example2.com")!,
    URL(string: "https://example3.com")!
]

ShareLink("分享多个链接", items: urls)
```

### 批量分享自定义类型

```swift
let articles = [article1, article2, article3]

ShareLink(
    "分享文章合集",
    items: articles,
    subject: Text("推荐文章合集"),
    message: Text("这里有几篇不错的文章，分享给你参考！")
)
```

## 样式定制

### 按钮样式

```swift
ShareLink("分享", item: content)
    .buttonStyle(.borderedProminent)
    .controlSize(.large)
    .tint(.blue)
```

### 可用的按钮样式

- `.automatic`：自动样式
- `.borderless`：无边框样式
- `.bordered`：有边框样式
- `.borderedProminent`：突出的有边框样式
- `.plain`：纯文本样式

### 控制大小

- `.mini`：最小尺寸
- `.small`：小尺寸
- `.regular`：常规尺寸（默认）
- `.large`：大尺寸

## 跨平台适配

### 平台特定样式

```swift
ShareLink(item: content) {
    #if os(iOS)
    Label("iPhone 分享", systemImage: "iphone")
    #elseif os(macOS)
    Label("Mac 分享", systemImage: "desktopcomputer")
    #elseif os(watchOS)
    Label("Watch 分享", systemImage: "applewatch")
    #else
    Label("分享", systemImage: "square.and.arrow.up")
    #endif
}
```

### 响应式设计

```swift
ShareLink(item: content) {
    Text("分享")
        .font(.body) // 支持动态字体
        .foregroundColor(.primary) // 适配暗黑模式
}
.accessibilityLabel("分享内容")
```

## 实际应用场景

### 1. 社交媒体分享

```swift
struct SocialShareView: View {
    let post: Post

    var body: some View {
        ShareLink(
            item: post,
            subject: Text("看看这个有趣的内容"),
            message: Text("我在应用中发现了这个，觉得你可能会感兴趣！")
        ) {
            HStack {
                Image(systemName: "person.2.fill")
                Text("分享到社交媒体")
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(25)
        }
    }
}
```

### 2. 文档分享

```swift
struct DocumentShareView: View {
    let document: Document

    var body: some View {
        ShareLink(
            item: document,
            preview: SharePreview(
                document.title,
                icon: Image(systemName: "doc.text")
            )
        ) {
            Label("分享文档", systemImage: "square.and.arrow.up")
        }
    }
}
```

### 3. 产品推荐

```swift
struct ProductShareView: View {
    let product: Product

    var body: some View {
        ShareLink(
            item: product,
            subject: Text("推荐产品：\(product.name)"),
            message: Text("我发现了这个不错的产品，分享给你看看！")
        ) {
            VStack {
                AsyncImage(url: product.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 100, height: 100)
                .cornerRadius(10)

                Text(product.name)
                    .font(.caption)
                    .lineLimit(2)

                Text("¥\(product.price, specifier: "%.2f")")
                    .font(.caption)
                    .foregroundColor(.red)

                Label("分享", systemImage: "square.and.arrow.up")
                    .font(.caption2)
            }
        }
    }
}
```

## 性能优化

### 1. 延迟加载内容

对于需要网络请求或复杂计算的内容，使用异步加载：

```swift
struct AsyncShareContent: Transferable {
    let contentProvider: () async -> String

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .plainText) { content in
            let text = await content.contentProvider()
            return text.data(using: .utf8) ?? Data()
        }
    }
}
```

### 2. 缓存预览内容

```swift
class SharePreviewCache: ObservableObject {
    private var cache: [String: SharePreview] = [:]

    func preview(for item: ShareableItem) -> SharePreview {
        if let cached = cache[item.id] {
            return cached
        }

        let preview = SharePreview(item.title, icon: item.icon)
        cache[item.id] = preview
        return preview
    }
}
```

## 错误处理

### 处理分享失败

```swift
struct SafeShareLink: View {
    let item: ShareableItem
    @State private var showingError = false

    var body: some View {
        ShareLink(item: item) {
            Label("分享", systemImage: "square.and.arrow.up")
        }
        .alert("分享失败", isPresented: $showingError) {
            Button("确定") { }
        } message: {
            Text("无法分享此内容，请稍后重试。")
        }
    }
}
```

### 验证内容有效性

```swift
extension ShareableItem {
    var isValidForSharing: Bool {
        // 验证内容是否适合分享
        return !title.isEmpty && content != nil
    }
}
```

## 无障碍访问

### 提供清晰的标签

```swift
ShareLink(item: content) {
    Image(systemName: "square.and.arrow.up")
}
.accessibilityLabel("分享内容")
.accessibilityHint("打开分享界面以分享当前内容")
```

### 支持动态字体

```swift
ShareLink("分享", item: content)
    .font(.body) // 自动适应用户的字体大小设置
```

### 确保足够的触摸区域

```swift
ShareLink(item: content) {
    Image(systemName: "square.and.arrow.up")
        .font(.title2)
        .frame(minWidth: 44, minHeight: 44) // 确保最小触摸区域
}
```

## 最佳实践

### 1. 选择合适的内容类型

- **URL**：适用于网页、文章链接
- **文本**：适用于引用、想法、简短内容
- **图片**：适用于照片、截图、图表
- **自定义类型**：适用于复杂的应用特定内容

### 2. 提供有意义的预览

```swift
// 好的做法
ShareLink(
    item: article,
    preview: SharePreview(
        article.title,
        icon: Image(systemName: "doc.text")
    )
)

// 避免的做法
ShareLink(item: article) // 没有预览信息
```

### 3. 使用适当的主题和消息

```swift
// 个性化的主题和消息
ShareLink(
    item: recipe,
    subject: Text("美味食谱：\(recipe.name)"),
    message: Text("我刚试了这个食谱，味道很棒！你也试试看吧。")
)
```

### 4. 保持视觉一致性

```swift
// 与应用设计风格保持一致
ShareLink(item: content) {
    Label("分享", systemImage: "square.and.arrow.up")
        .foregroundColor(.accentColor) // 使用应用的主题色
        .font(.body)
}
```

### 5. 考虑用户体验

```swift
struct UserFriendlyShareLink: View {
    let item: ShareableItem
    @State private var isSharing = false

    var body: some View {
        ShareLink(item: item) {
            HStack {
                if isSharing {
                    ProgressView()
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "square.and.arrow.up")
                }

                Text("分享")
            }
        }
        .disabled(isSharing)
        .onTapGesture {
            isSharing = true
            // 分享完成后重置状态
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isSharing = false
            }
        }
    }
}
```

## 常见问题

### Q: ShareLink 在某些应用中不显示？

A: 这通常是因为内容类型不被目标应用支持。尝试为你的 Transferable 类型添加 `FileRepresentation`：

```swift
static var transferRepresentation: some TransferRepresentation {
    Group {
        DataRepresentation(contentType: .plainText) { ... }
        FileRepresentation(contentType: .plainText) { item in
            // 创建临时文件
            let tempURL = FileManager.default.temporaryDirectory
                .appendingPathComponent("shared_content.txt")
            try item.content.write(to: tempURL, atomically: true, encoding: .utf8)
            return SentTransferredFile(tempURL)
        }
    }
}
```

### Q: 如何自定义分享界面的外观？

A: ShareLink 使用系统原生的分享界面，无法直接自定义其外观。但你可以：

1. 自定义 ShareLink 按钮的外观
2. 提供丰富的预览内容
3. 使用 subject 和 message 参数预填充内容

### Q: ShareLink 支持哪些分享目标？

A: ShareLink 显示的分享选项取决于：

1. 设备上安装的应用
2. 分享内容的类型
3. 各个应用声明支持的内容类型

常见的分享目标包括：Messages、Mail、AirDrop、社交媒体应用等。

### Q: 如何处理大文件的分享？

A: 对于大文件，建议使用 `FileRepresentation` 并实现异步处理：

```swift
static var transferRepresentation: some TransferRepresentation {
    FileRepresentation(contentType: .data) { item in
        // 异步处理大文件
        return try await item.generateFile()
    }
}
```

### Q: ShareLink 在 watchOS 上的表现如何？

A: 在 watchOS 上，ShareLink 的功能相对有限，主要支持：

- AirDrop 到附近的设备
- 发送到配对的 iPhone
- 部分支持 Messages 和 Mail

建议为 watchOS 提供简化的分享选项。

## 总结

ShareLink 是 SwiftUI 中一个强大而灵活的分享组件，它提供了：

1. **简单易用**：最少一行代码即可实现分享功能
2. **高度可定制**：支持自定义标签、预览和预填充内容
3. **类型安全**：通过 Transferable 协议确保类型安全
4. **系统集成**：使用原生分享界面，用户体验一致
5. **跨平台支持**：在多个 Apple 平台上工作

通过合理使用 ShareLink，你可以为用户提供流畅、直观的内容分享体验，增强应用的社交功能和用户参与度。

记住始终考虑用户体验、性能优化和无障碍访问，让分享功能真正为用户创造价值。
