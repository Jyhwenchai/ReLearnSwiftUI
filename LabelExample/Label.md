# SwiftUI Label 组件完整指南

## 概述

`Label` 是 SwiftUI 中用于显示图标和文本组合的组件，在 iOS 14.0+ 和 macOS 11.0+ 中引入。它提供了一种简洁的方式来创建包含图标和文本的界面元素，广泛应用于导航栏、工具栏、列表项、按钮等场景。

## 基本语法

### 最简单的用法

```swift
Label("设置", systemImage: "gear")
```

### 使用自定义视图

```swift
Label {
    Text("自定义文本")
} icon: {
    Image(systemName: "star.fill")
        .foregroundColor(.yellow)
}
```

## 核心特性

### 1. 双参数构造器

Label 最常用的构造器接受两个参数：

- `title`: 显示的文本内容（String 或 Text）
- `systemImage`: SF Symbols 图标名称

```swift
Label("文档", systemImage: "doc")
Label("收藏", systemImage: "heart.fill")
Label("分享", systemImage: "square.and.arrow.up")
```

### 2. 闭包构造器

使用闭包可以完全自定义图标和文本内容：

```swift
Label {
    VStack(alignment: .leading) {
        Text("主标题")
            .font(.headline)
        Text("副标题")
            .font(.caption)
            .foregroundColor(.secondary)
    }
} icon: {
    ZStack {
        Circle()
            .fill(Color.blue)
            .frame(width: 24, height: 24)
        Text("A")
            .foregroundColor(.white)
            .font(.caption)
    }
}
```

## Label 样式 (LabelStyle)

SwiftUI 提供了几种内置的 Label 样式：

### 内置样式

```swift
// 默认样式（显示图标和文本）
Label("默认", systemImage: "star")
    .labelStyle(.automatic)

// 只显示图标
Label("只显示图标", systemImage: "heart")
    .labelStyle(.iconOnly)

// 只显示文本
Label("只显示文本", systemImage: "text")
    .labelStyle(.titleOnly)

// 显示图标和文本（与 automatic 相同）
Label("图标和文本", systemImage: "doc")
    .labelStyle(.titleAndIcon)
```

### 自定义样式

创建自定义 LabelStyle：

```swift
struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 4) {
            configuration.icon
                .font(.title2)
            configuration.title
                .font(.caption)
        }
        .padding(8)
    }
}

// 使用自定义样式
Label("垂直布局", systemImage: "arrow.up.and.down")
    .labelStyle(VerticalLabelStyle())
```

## 常用修饰符

### 1. 字体和颜色

```swift
// 设置整体字体大小（影响图标和文本）
Label("大标签", systemImage: "star")
    .font(.title)

// 设置颜色
Label("彩色标签", systemImage: "heart.fill")
    .foregroundColor(.red)

// 分别设置图标和文本颜色
Label {
    Text("绿色文本")
        .foregroundColor(.green)
} icon: {
    Image(systemName: "leaf.fill")
        .foregroundColor(.orange)
}
```

### 2. 背景和边框

```swift
// 添加背景
Label("背景标签", systemImage: "paintbrush")
    .padding()
    .background(Color.blue.opacity(0.1))
    .cornerRadius(8)

// 添加边框
Label("边框标签", systemImage: "rectangle")
    .padding()
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.blue, lineWidth: 2)
    )

// 添加阴影
Label("阴影标签", systemImage: "cloud")
    .padding()
    .background(Color.white)
    .cornerRadius(8)
    .shadow(radius: 4)
```

### 3. 填充和间距

```swift
// 不同的填充设置
Label("小填充", systemImage: "minus")
    .padding(4)

Label("中等填充", systemImage: "equal")
    .padding(8)

Label("大填充", systemImage: "plus")
    .padding(16)

// 不对称填充
Label("不对称", systemImage: "arrow.up.and.down")
    .padding(.horizontal, 20)
    .padding(.vertical, 6)
```

## 高级用法

### 1. 动态内容

```swift
struct DynamicLabel: View {
    @State private var count = 0

    var body: some View {
        Label {
            HStack {
                Text("消息")
                if count > 0 {
                    Text("\(count)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.red)
                        .clipShape(Capsule())
                }
            }
        } icon: {
            Image(systemName: "envelope")
        }
    }
}
```

### 2. 交互状态

```swift
struct InteractiveLabel: View {
    @State private var isSelected = false

    var body: some View {
        Button(action: {
            withAnimation {
                isSelected.toggle()
            }
        }) {
            Label(isSelected ? "已选中" : "未选中",
                  systemImage: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .white : .primary)
                .padding()
                .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
```

### 3. 动画效果

```swift
struct AnimatedLabel: View {
    @State private var isAnimating = false

    var body: some View {
        Label("脉冲动画", systemImage: "heart.fill")
            .foregroundColor(.red)
            .scaleEffect(isAnimating ? 1.2 : 1.0)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
    }
}
```

## 实际应用场景

### 1. 导航菜单

```swift
struct NavigationMenu: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("个人资料", systemImage: "person.circle")
            Label("设置", systemImage: "gear")
            Label("帮助", systemImage: "questionmark.circle")
            Label("退出", systemImage: "arrow.right.square")
        }
        .padding()
    }
}
```

### 2. 状态指示器

```swift
struct StatusIndicator: View {
    let isOnline: Bool

    var body: some View {
        Label {
            Text(isOnline ? "在线" : "离线")
                .foregroundColor(isOnline ? .green : .red)
        } icon: {
            Circle()
                .fill(isOnline ? Color.green : Color.red)
                .frame(width: 8, height: 8)
        }
    }
}
```

### 3. 文件列表

```swift
struct FileItem: View {
    let fileName: String
    let fileSize: String
    let fileType: String

    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text(fileName)
                    .font(.body)
                Text(fileSize)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: iconForFileType(fileType))
                .foregroundColor(colorForFileType(fileType))
        }
    }

    private func iconForFileType(_ type: String) -> String {
        switch type {
        case "pdf": return "doc.fill"
        case "jpg", "png": return "photo.fill"
        case "xlsx": return "tablecells.fill"
        default: return "doc"
        }
    }

    private func colorForFileType(_ type: String) -> Color {
        switch type {
        case "pdf": return .red
        case "jpg", "png": return .blue
        case "xlsx": return .green
        default: return .gray
        }
    }
}
```

### 4. 通知标签

```swift
struct NotificationLabel: View {
    enum NotificationType {
        case success, warning, error, info
    }

    let type: NotificationType
    let message: String

    var body: some View {
        Label(message, systemImage: iconName)
            .foregroundColor(textColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(backgroundColor)
            .cornerRadius(6)
    }

    private var iconName: String {
        switch type {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "xmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }

    private var textColor: Color {
        switch type {
        case .success: return .green
        case .warning: return .orange
        case .error: return .red
        case .info: return .blue
        }
    }

    private var backgroundColor: Color {
        textColor.opacity(0.1)
    }
}
```

## 可访问性支持

Label 天然支持可访问性，但可以进一步增强：

```swift
Label("重要通知", systemImage: "exclamationmark.triangle.fill")
    .accessibilityLabel("重要通知：需要您的注意")
    .accessibilityHint("点击查看详细信息")
    .accessibilityAddTraits(.isButton)
```

### 可访问性最佳实践

1. **提供描述性标签**：使用 `accessibilityLabel` 提供清晰的描述
2. **添加操作提示**：使用 `accessibilityHint` 说明可能的操作
3. **设置正确的特征**：使用 `accessibilityAddTraits` 标识元素类型
4. **避免冗余信息**：不要重复图标和文本已经传达的信息

## 性能优化

### 1. 大量 Label 的优化

```swift
// 使用 LazyVStack 优化大量 Label 的渲染
LazyVStack {
    ForEach(items, id: \.id) { item in
        Label(item.title, systemImage: item.icon)
    }
}
```

### 2. 图标缓存

```swift
// 对于自定义图标，考虑使用缓存
struct CachedIconLabel: View {
    let title: String
    let iconName: String

    var body: some View {
        Label {
            Text(title)
        } icon: {
            // 使用缓存的图标视图
            CachedIconView(name: iconName)
        }
    }
}
```

## 常见问题和解决方案

### 1. 图标和文本不对齐

**问题**：自定义图标与文本基线不对齐

**解决方案**：

```swift
Label {
    Text("对齐文本")
} icon: {
    Image(systemName: "star")
        .frame(width: 16, height: 16) // 固定图标大小
        .alignmentGuide(.firstTextBaseline) { d in
            d[.bottom] - 2 // 微调对齐
        }
}
```

### 2. 长文本处理

**问题**：文本过长导致布局问题

**解决方案**：

```swift
Label("这是一个很长的标签文本，可能会导致布局问题", systemImage: "text.alignleft")
    .lineLimit(2) // 限制行数
    .truncationMode(.tail) // 截断模式
```

### 3. 图标颜色继承问题

**问题**：图标颜色不随主题变化

**解决方案**：

```swift
Label("主题适配", systemImage: "paintpalette")
    .foregroundColor(.primary) // 使用语义颜色
```

### 4. 自定义样式不生效

**问题**：LabelStyle 没有按预期工作

**解决方案**：

```swift
// 确保正确实现 LabelStyle 协议
struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 必须使用 configuration.icon 和 configuration.title
        HStack {
            configuration.icon
            configuration.title
        }
    }
}
```

## 注意事项

### 1. 平台兼容性

- Label 需要 iOS 14.0+ / macOS 11.0+
- 某些 SF Symbols 在不同系统版本中可能不可用
- 考虑为旧版本提供降级方案

### 2. 图标选择

- 优先使用 SF Symbols 系统图标
- 确保图标语义与文本内容匹配
- 注意图标在不同尺寸下的清晰度

### 3. 文本长度

- 考虑不同语言的文本长度差异
- 为长文本提供适当的截断策略
- 测试在小屏幕设备上的显示效果

### 4. 颜色对比度

- 确保图标和文本有足够的对比度
- 考虑深色模式下的显示效果
- 遵循无障碍设计指南

## 最佳实践

### 1. 设计一致性

- 在应用中保持 Label 样式的一致性
- 使用统一的图标风格和颜色方案
- 建立设计系统和样式指南

### 2. 语义化使用

- 选择有意义的图标和文本组合
- 避免纯装饰性的图标
- 确保图标增强而不是干扰文本理解

### 3. 响应式设计

- 考虑不同屏幕尺寸的显示效果
- 使用动态字体大小支持
- 测试横屏和竖屏模式

### 4. 性能考虑

- 避免在 Label 中使用复杂的动画
- 对大量 Label 使用懒加载
- 优化自定义图标的渲染性能

## 相关组件

### 与其他组件的关系

1. **Button**: Label 常用作 Button 的内容
2. **NavigationLink**: 在导航中使用 Label 作为标题
3. **List**: 列表项中经常使用 Label
4. **Toolbar**: 工具栏按钮通常使用 Label
5. **TabView**: 标签页标题可以使用 Label

### 组合使用示例

```swift
// 在 Button 中使用 Label
Button(action: {}) {
    Label("保存", systemImage: "square.and.arrow.down")
}

// 在 NavigationLink 中使用 Label
NavigationLink(destination: SettingsView()) {
    Label("设置", systemImage: "gear")
}

// 在 List 中使用 Label
List {
    Label("文档", systemImage: "doc")
    Label("图片", systemImage: "photo")
    Label("视频", systemImage: "video")
}
```

## 总结

Label 是 SwiftUI 中一个简单但功能强大的组件，它提供了创建图标文本组合的标准化方式。通过合理使用 Label 的各种特性和样式，可以创建出既美观又实用的用户界面。

关键要点：

- 使用合适的图标和文本组合
- 保持设计的一致性和可访问性
- 根据需要选择合适的样式和修饰符
- 考虑性能和平台兼容性
- 遵循最佳实践和设计指南

通过掌握这些概念和技巧，你可以充分发挥 Label 组件的潜力，创建出优秀的 SwiftUI 应用界面。
