# TextEditor 组件详解

## 概述

TextEditor 是 SwiftUI 中用于多行文本编辑的组件，它提供了一个可滚动的文本编辑区域，适用于需要用户输入大量文本的场景。与 TextField 不同，TextEditor 专门设计用于多行文本输入，支持换行、滚动和丰富的文本编辑功能。

## 基本语法

```swift
TextEditor(text: $textBinding)
```

### 参数说明

- `text`: `Binding<String>` - 绑定的文本内容，支持双向数据绑定

## 基础用法

### 1. 简单的多行文本编辑

```swift
struct BasicTextEditorExample: View {
    @State private var text = ""

    var body: some View {
        TextEditor(text: $text)
            .frame(height: 200)
            .padding()
            .border(Color.gray, width: 1)
    }
}
```

### 2. 带占位符的文本编辑器

由于 TextEditor 没有内置的占位符功能，需要自定义实现：

```swift
struct PlaceholderTextEditor: View {
    @State private var text = ""

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(height: 150)
                .padding(8)

            if text.isEmpty {
                Text("请输入文本...")
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
                    .allowsHitTesting(false)
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
```

### 3. 限制字符数的文本编辑器

```swift
struct LimitedTextEditor: View {
    @State private var text = ""
    private let maxLength = 200

    var body: some View {
        VStack {
            TextEditor(text: Binding(
                get: { text },
                set: { newValue in
                    if newValue.count <= maxLength {
                        text = newValue
                    }
                }
            ))
            .frame(height: 100)

            HStack {
                Spacer()
                Text("\(text.count)/\(maxLength)")
                    .font(.caption)
                    .foregroundColor(text.count > maxLength * 8 / 10 ? .orange : .secondary)
            }
        }
    }
}
```

## 常用修饰符

### 1. 字体和文本样式

```swift
TextEditor(text: $text)
    .font(.title3)                    // 设置字体大小
    .foregroundColor(.blue)           // 设置文字颜色
    .multilineTextAlignment(.center)  // 设置文本对齐方式
    .lineSpacing(4)                   // 设置行间距
```

### 2. 背景和边框

```swift
TextEditor(text: $text)
    .padding(16)
    .background(Color(.systemGray6))  // 设置背景色
    .cornerRadius(12)                 // 设置圆角
    .overlay(
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.blue, lineWidth: 2)  // 添加边框
    )
```

### 3. 尺寸控制

```swift
TextEditor(text: $text)
    .frame(width: 300, height: 200)   // 固定尺寸
    .frame(minHeight: 100, maxHeight: 300)  // 最小和最大高度
```

### 4. 滚动行为

```swift
TextEditor(text: $text)
    .scrollContentBackground(.hidden)  // 隐藏默认背景
    .scrollDisabled(false)             // 控制滚动行为
```

### 5. 交互控制

```swift
TextEditor(text: $text)
    .disabled(isReadOnly)              // 禁用编辑
    .textSelection(.enabled)           // 启用文本选择
    .autocorrectionDisabled(true)      // 禁用自动更正
```

## 高级功能

### 1. 自动保存功能

```swift
struct AutoSaveTextEditor: View {
    @State private var text = ""
    @State private var saveTimer: Timer?

    var body: some View {
        TextEditor(text: $text)
            .onChange(of: text) { _, newValue in
                // 重置保存计时器
                saveTimer?.invalidate()
                saveTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                    saveText(newValue)
                }
            }
    }

    private func saveText(_ content: String) {
        // 保存逻辑
        print("自动保存: \(content)")
    }
}
```

### 2. 文本统计功能

```swift
struct TextStatisticsEditor: View {
    @State private var text = ""

    private var wordCount: Int {
        text.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .count
    }

    private var characterCount: Int {
        text.count
    }

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .frame(height: 200)

            HStack {
                Text("字符数: \(characterCount)")
                Spacer()
                Text("单词数: \(wordCount)")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
}
```

### 3. 搜索和高亮功能

```swift
struct SearchableTextEditor: View {
    @State private var text = ""
    @State private var searchText = ""

    var body: some View {
        VStack {
            // 搜索框
            TextField("搜索...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // 文本编辑器
            TextEditor(text: $text)
                .frame(height: 200)
                .overlay(
                    searchHighlightOverlay,
                    alignment: .topLeading
                )
        }
    }

    private var searchHighlightOverlay: some View {
        // 搜索高亮实现
        Text(highlightedText)
            .allowsHitTesting(false)
            .opacity(searchText.isEmpty ? 0 : 0.3)
    }

    private var highlightedText: AttributedString {
        // 高亮文本实现
        var attributedString = AttributedString(text)
        // 添加高亮逻辑
        return attributedString
    }
}
```

### 4. 键盘工具栏

```swift
struct ToolbarTextEditor: View {
    @State private var text = ""

    var body: some View {
        TextEditor(text: $text)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Button("粗体") {
                            insertFormatting("**", "**")
                        }

                        Button("斜体") {
                            insertFormatting("*", "*")
                        }

                        Spacer()

                        Button("完成") {
                            hideKeyboard()
                        }
                    }
                }
            }
    }

    private func insertFormatting(_ prefix: String, _ suffix: String) {
        text += prefix + "文本" + suffix
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
```

## 样式自定义

### 1. 主题样式

```swift
struct ThemedTextEditor: View {
    @State private var text = ""

    var body: some View {
        TextEditor(text: $text)
            .font(.body)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.accentColor.opacity(0.1))
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
            )
            .tint(.accentColor)
    }
}
```

### 2. 渐变背景样式

```swift
struct GradientTextEditor: View {
    @State private var text = ""

    var body: some View {
        TextEditor(text: $text)
            .padding(20)
            .background(
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .cornerRadius(16)
    }
}
```

### 3. 代码编辑器样式

```swift
struct CodeTextEditor: View {
    @State private var code = ""

    var body: some View {
        TextEditor(text: $code)
            .font(.system(.body, design: .monospaced))
            .padding(16)
            .background(Color.black.opacity(0.05))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}
```

## 实际应用场景

### 1. 笔记应用

```swift
struct NoteEditor: View {
    @State private var title = ""
    @State private var content = ""
    @State private var lastModified = Date()

    var body: some View {
        VStack(spacing: 16) {
            // 标题输入
            TextField("笔记标题", text: $title)
                .font(.title2)
                .fontWeight(.semibold)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

            // 内容编辑
            TextEditor(text: $content)
                .font(.body)
                .padding(16)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onChange(of: content) { _, _ in
                    lastModified = Date()
                }

            // 信息栏
            HStack {
                Text("最后修改: \(lastModified, style: .relative)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Text("\(content.count) 字符")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
```

### 2. 评论系统

```swift
struct CommentEditor: View {
    @State private var comment = ""
    @State private var rating = 5

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 评分
            HStack {
                Text("评分:")
                ForEach(1...5, id: \.self) { star in
                    Button(action: { rating = star }) {
                        Image(systemName: star <= rating ? "star.fill" : "star")
                            .foregroundColor(star <= rating ? .yellow : .gray)
                    }
                }
            }

            // 评论输入
            TextEditor(text: $comment)
                .frame(height: 100)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            // 字符限制
            HStack {
                Text("\(comment.count)/500")
                    .font(.caption)
                    .foregroundColor(comment.count > 450 ? .red : .secondary)

                Spacer()

                Button("提交评论") {
                    submitComment()
                }
                .disabled(comment.isEmpty || comment.count > 500)
            }
        }
        .padding()
    }

    private func submitComment() {
        // 提交评论逻辑
    }
}
```

### 3. 邮件编写

```swift
struct EmailComposer: View {
    @State private var to = ""
    @State private var subject = ""
    @State private var body = ""

    var body: some View {
        VStack(spacing: 16) {
            // 收件人
            HStack {
                Text("收件人:")
                    .frame(width: 60, alignment: .leading)
                TextField("邮箱地址", text: $to)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // 主题
            HStack {
                Text("主题:")
                    .frame(width: 60, alignment: .leading)
                TextField("邮件主题", text: $subject)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // 正文
            VStack(alignment: .leading) {
                Text("正文:")
                TextEditor(text: $body)
                    .frame(minHeight: 200)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }

            // 发送按钮
            HStack {
                Button("保存草稿") {
                    saveDraft()
                }
                .buttonStyle(.bordered)

                Spacer()

                Button("发送") {
                    sendEmail()
                }
                .buttonStyle(.borderedProminent)
                .disabled(to.isEmpty || subject.isEmpty || body.isEmpty)
            }
        }
        .padding()
    }

    private func saveDraft() {
        // 保存草稿逻辑
    }

    private func sendEmail() {
        // 发送邮件逻辑
    }
}
```

## 性能优化

### 1. 大文本处理

```swift
struct OptimizedTextEditor: View {
    @State private var text = ""

    var body: some View {
        TextEditor(text: $text)
            .onChange(of: text) { _, newValue in
                // 限制文本长度以避免性能问题
                if newValue.count > 10000 {
                    text = String(newValue.prefix(10000))
                }
            }
    }
}
```

### 2. 延迟更新

```swift
struct DebouncedTextEditor: View {
    @State private var text = ""
    @State private var debouncedText = ""
    @State private var debounceTimer: Timer?

    var body: some View {
        TextEditor(text: $text)
            .onChange(of: text) { _, newValue in
                debounceTimer?.invalidate()
                debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    debouncedText = newValue
                    // 执行需要延迟的操作
                    performExpensiveOperation(debouncedText)
                }
            }
    }

    private func performExpensiveOperation(_ text: String) {
        // 执行耗时操作，如网络请求或复杂计算
    }
}
```

## 可访问性支持

### 1. 基础可访问性

```swift
TextEditor(text: $text)
    .accessibilityLabel("文本编辑器")
    .accessibilityHint("输入多行文本内容")
    .accessibilityValue(text.isEmpty ? "空" : text)
```

### 2. 动态类型支持

```swift
TextEditor(text: $text)
    .font(.body)
    .dynamicTypeSize(.large...(.accessibility5))  // 支持动态字体大小
```

## 常见问题和解决方案

### 1. 占位符实现

**问题**: TextEditor 没有内置占位符功能

**解决方案**:

```swift
ZStack(alignment: .topLeading) {
    TextEditor(text: $text)

    if text.isEmpty {
        Text("占位符文本")
            .foregroundColor(.secondary)
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .allowsHitTesting(false)
    }
}
```

### 2. 键盘遮挡问题

**问题**: 键盘弹出时可能遮挡 TextEditor

**解决方案**:

```swift
ScrollViewReader { proxy in
    ScrollView {
        TextEditor(text: $text)
            .id("textEditor")
    }
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
        withAnimation {
            proxy.scrollTo("textEditor", anchor: .bottom)
        }
    }
}
```

### 3. 文本选择和光标控制

**问题**: 需要程序化控制文本选择和光标位置

**解决方案**:

```swift
// 使用 UIViewRepresentable 包装 UITextView 以获得更多控制
struct AdvancedTextEditor: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        let parent: AdvancedTextEditor

        init(_ parent: AdvancedTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
```

### 4. 自定义输入限制

**问题**: 需要限制特定字符或格式的输入

**解决方案**:

```swift
TextEditor(text: Binding(
    get: { text },
    set: { newValue in
        // 过滤不允许的字符
        let filtered = newValue.filter { char in
            char.isLetter || char.isNumber || char.isWhitespace
        }
        text = filtered
    }
))
```

## 最佳实践

### 1. 状态管理

- 使用 `@State` 管理本地文本状态
- 使用 `@Binding` 在父子视图间传递文本
- 考虑使用 `@StateObject` 或 `@ObservableObject` 管理复杂的文本编辑状态

### 2. 性能考虑

- 对于大文本，考虑使用分页或虚拟化
- 使用防抖动技术减少频繁的状态更新
- 避免在 `onChange` 中执行耗时操作

### 3. 用户体验

- 提供清晰的占位符文本
- 显示字符数或其他有用的统计信息
- 实现自动保存功能
- 提供撤销重做功能

### 4. 样式一致性

- 保持与应用整体设计风格一致
- 使用系统颜色和字体以支持暗黑模式
- 考虑动态类型和可访问性需求

### 5. 错误处理

- 验证用户输入
- 提供清晰的错误提示
- 实现输入限制和格式化

## 与其他组件的关系

### TextEditor vs TextField

| 特性     | TextEditor | TextField  |
| -------- | ---------- | ---------- |
| 行数     | 多行       | 单行       |
| 滚动     | 支持       | 不支持     |
| 占位符   | 需自定义   | 内置支持   |
| 适用场景 | 长文本编辑 | 短文本输入 |

### TextEditor vs Text

| 特性   | TextEditor | Text   |
| ------ | ---------- | ------ |
| 编辑性 | 可编辑     | 只读   |
| 交互性 | 支持输入   | 仅显示 |
| 性能   | 较重       | 轻量   |

## 总结

TextEditor 是 SwiftUI 中功能强大的多行文本编辑组件，适用于各种需要用户输入大量文本的场景。通过合理使用修饰符和自定义功能，可以创建出功能丰富、用户体验良好的文本编辑界面。

关键要点：

- 使用 `@State` 或 `@Binding` 管理文本状态
- 自定义实现占位符功能
- 合理使用修饰符进行样式定制
- 考虑性能和可访问性
- 根据具体应用场景选择合适的功能实现

通过本文档的学习和实践，你应该能够熟练使用 TextEditor 组件，并根据项目需求创建出专业的文本编辑界面。
