# TextField 组件详解

## 概述

TextField 是 SwiftUI 中用于文本输入的核心组件，它提供了一个可编辑的文本输入界面。TextField 支持单行和多行文本输入，具有丰富的样式定制选项和强大的验证功能。

## 基本语法

```swift
TextField(titleKey: LocalizedStringKey, text: Binding<String>)
TextField(_ title: String, text: Binding<String>)
```

### 参数说明

- `titleKey/title`: 占位符文本，当输入框为空时显示
- `text`: 绑定到 @State 变量的文本内容

## 基础用法

### 1. 简单文本输入

```swift
@State private var text = ""

TextField("请输入文本", text: $text)
    .textFieldStyle(.roundedBorder)
```

### 2. 不同输入类型

```swift
// 邮箱输入
TextField("邮箱", text: $email)
    .keyboardType(.emailAddress)
    .autocapitalization(.none)

// 密码输入
SecureField("密码", text: $password)

// 数字输入
TextField("数字", text: $number)
    .keyboardType(.numberPad)
```

## TextFieldStyle 样式

### 内置样式

#### 1. Plain Style (默认)

```swift
TextField("文本", text: $text)
    .textFieldStyle(.plain)
```

- 最简洁的样式
- 无边框装饰
- 需要自定义背景

#### 2. Rounded Border Style

```swift
TextField("文本", text: $text)
    .textFieldStyle(.roundedBorder)
```

- 圆角边框样式
- 最常用的样式
- 自带背景和边框

### 自定义样式

```swift
TextField("自定义样式", text: $text)
    .textFieldStyle(.plain)
    .padding(.horizontal, 12)
    .padding(.vertical, 10)
    .background(Color(.systemGray6))
    .cornerRadius(8)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.blue, lineWidth: 2)
    )
```

## 键盘类型

### 常用键盘类型

```swift
.keyboardType(.default)        // 默认键盘
.keyboardType(.emailAddress)   // 邮箱键盘
.keyboardType(.numberPad)      // 数字键盘
.keyboardType(.phonePad)       // 电话键盘
.keyboardType(.decimalPad)     // 小数键盘
.keyboardType(.URL)            // URL 键盘
.keyboardType(.webSearch)      // 网页搜索键盘
```

### 键盘行为控制

```swift
TextField("文本", text: $text)
    .autocapitalization(.none)      // 禁用自动大写
    .disableAutocorrection(true)    // 禁用自动纠错
    .textInputAutocapitalization(.never)  // iOS 15+ 新API
```

## 输入验证和格式化

### 1. 实时验证

```swift
@State private var email = ""
@State private var isValid = false

TextField("邮箱", text: $email)
    .onChange(of: email) { _, newValue in
        isValid = isValidEmail(newValue)
    }
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(isValid ? Color.green : Color.red, lineWidth: 1)
    )

func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
}
```

### 2. 输入格式化

```swift
TextField("手机号", text: $phone)
    .onChange(of: phone) { _, newValue in
        phone = formatPhoneNumber(newValue)
    }

func formatPhoneNumber(_ input: String) -> String {
    let digits = input.filter { $0.isNumber }
    let maxLength = 11
    let truncated = String(digits.prefix(maxLength))

    var formatted = ""
    for (index, char) in truncated.enumerated() {
        if index == 3 || index == 7 {
            formatted += "-"
        }
        formatted += String(char)
    }
    return formatted
}
```

## 焦点管理

### 使用 @FocusState

```swift
@State private var text = ""
@FocusState private var isFocused: Bool

TextField("文本", text: $text)
    .focused($isFocused)
    .onSubmit {
        // 提交时的处理
        isFocused = false
    }

// 程序控制焦点
Button("获得焦点") {
    isFocused = true
}
```

### 多个输入框的焦点管理

```swift
enum Field: Hashable {
    case username, password
}

@FocusState private var focusedField: Field?

VStack {
    TextField("用户名", text: $username)
        .focused($focusedField, equals: .username)

    SecureField("密码", text: $password)
        .focused($focusedField, equals: .password)
}
.onSubmit {
    switch focusedField {
    case .username:
        focusedField = .password
    case .password:
        // 提交表单
        break
    case .none:
        break
    }
}
```

## 多行文本输入 (iOS 16+)

### 基础多行输入

```swift
@State private var multilineText = ""

TextField("多行文本", text: $multilineText, axis: .vertical)
    .lineLimit(3...6)  // 限制行数范围
    .textFieldStyle(.roundedBorder)
```

### 高级多行配置

```swift
TextField("详细描述", text: $description, axis: .vertical)
    .lineLimit(2, reservesSpace: true)  // 保留空间
    .textFieldStyle(.plain)
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(8)
```

## 常用修饰符

### 文本样式

```swift
TextField("文本", text: $text)
    .font(.title2)                    // 字体大小
    .fontWeight(.semibold)            // 字体粗细
    .foregroundColor(.blue)           // 文字颜色
    .multilineTextAlignment(.center)  // 文本对齐
```

### 输入限制

```swift
TextField("限制输入", text: $text)
    .onChange(of: text) { _, newValue in
        // 限制字符数
        if newValue.count > 50 {
            text = String(newValue.prefix(50))
        }

        // 过滤特殊字符
        text = newValue.filter { $0.isLetter || $0.isNumber }
    }
```

### 提交处理

```swift
TextField("搜索", text: $searchText)
    .onSubmit {
        performSearch()
    }
    .submitLabel(.search)  // 自定义提交按钮标签
```

## 高级功能

### 1. 浮动标签效果

```swift
@State private var text = ""
@FocusState private var isFocused: Bool

ZStack(alignment: .leading) {
    Text("标签文本")
        .font(isFocused || !text.isEmpty ? .caption : .body)
        .foregroundColor(isFocused ? .blue : .secondary)
        .offset(y: isFocused || !text.isEmpty ? -20 : 0)
        .animation(.easeInOut(duration: 0.2), value: isFocused)

    TextField("", text: $text)
        .focused($isFocused)
        .padding(.top, isFocused || !text.isEmpty ? 8 : 0)
}
```

### 2. 搜索建议

```swift
@State private var searchText = ""
@State private var suggestions = ["Apple", "SwiftUI", "iOS"]
@State private var showSuggestions = false

VStack {
    TextField("搜索", text: $searchText)
        .onChange(of: searchText) { _, _ in
            showSuggestions = !searchText.isEmpty
        }

    if showSuggestions {
        List(filteredSuggestions, id: \.self) { suggestion in
            Button(suggestion) {
                searchText = suggestion
                showSuggestions = false
            }
        }
        .frame(maxHeight: 200)
    }
}
```

### 3. 标签输入系统

```swift
@State private var tagText = ""
@State private var tags: [String] = []

VStack {
    // 显示已有标签
    ScrollView(.horizontal) {
        HStack {
            ForEach(tags, id: \.self) { tag in
                HStack {
                    Text(tag)
                    Button("×") { removeTag(tag) }
                }
                .padding(.horizontal, 8)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(12)
            }
        }
    }

    // 添加新标签
    TextField("添加标签", text: $tagText)
        .onSubmit { addTag() }
}
```

## 样式定制

### 1. 图标装饰

```swift
HStack {
    Image(systemName: "person.fill")
        .foregroundColor(.gray)

    TextField("用户名", text: $username)
        .textFieldStyle(.plain)
}
.padding()
.background(Color(.systemGray6))
.cornerRadius(8)
```

### 2. 清除按钮

```swift
HStack {
    TextField("搜索", text: $searchText)
        .textFieldStyle(.plain)

    if !searchText.isEmpty {
        Button(action: { searchText = "" }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        }
    }
}
```

### 3. 动画边框

```swift
TextField("动画边框", text: $text)
    .focused($isFocused)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(
                LinearGradient(
                    colors: isFocused ? [.blue, .purple] : [.clear],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 2
            )
            .animation(.easeInOut, value: isFocused)
    )
```

## 可访问性支持

### 基础可访问性

```swift
TextField("邮箱", text: $email)
    .accessibilityLabel("邮箱地址输入框")
    .accessibilityHint("请输入您的邮箱地址")
    .accessibilityValue(email.isEmpty ? "空" : email)
```

### 高级可访问性

```swift
TextField("密码", text: $password)
    .accessibilityLabel("密码输入")
    .accessibilityAddTraits(.isSecureTextField)
    .accessibilityRemoveTraits(.isButton)
```

## 性能优化

### 1. 避免频繁更新

```swift
@State private var text = ""
@State private var debouncedText = ""

TextField("搜索", text: $text)
    .onChange(of: text) { _, newValue in
        // 使用防抖动避免频繁搜索
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if text == newValue {
                debouncedText = newValue
                performSearch(debouncedText)
            }
        }
    }
```

### 2. 大量数据处理

```swift
TextField("大数据输入", text: $largeText)
    .onChange(of: largeText) { _, newValue in
        // 异步处理大量数据
        Task {
            await processLargeData(newValue)
        }
    }
```

## 常见问题和解决方案

### 1. 键盘遮挡问题

```swift
ScrollViewReader { proxy in
    ScrollView {
        VStack {
            // 其他内容

            TextField("输入", text: $text)
                .id("textfield")
                .focused($isFocused)
        }
    }
    .onChange(of: isFocused) { _, focused in
        if focused {
            withAnimation {
                proxy.scrollTo("textfield", anchor: .center)
            }
        }
    }
}
```

### 2. 输入验证延迟

```swift
@State private var text = ""
@State private var validationMessage = ""

TextField("输入", text: $text)
    .onChange(of: text) { _, newValue in
        // 延迟验证避免频繁提示
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if text == newValue {
                validateInput(newValue)
            }
        }
    }
```

### 3. 多语言支持

```swift
TextField(LocalizedStringKey("input_placeholder"), text: $text)
    .environment(\.locale, Locale(identifier: "zh-CN"))
```

## 最佳实践

### 1. 用户体验

- 选择合适的键盘类型
- 提供清晰的占位符文本
- 实时验证并给出友好提示
- 支持键盘快捷键操作

### 2. 性能考虑

- 避免在 onChange 中执行耗时操作
- 使用防抖动技术减少不必要的更新
- 合理使用 @FocusState 管理焦点

### 3. 可访问性

- 提供有意义的可访问性标签
- 支持 VoiceOver 等辅助功能
- 确保足够的颜色对比度

### 4. 安全性

- 敏感信息使用 SecureField
- 验证用户输入防止注入攻击
- 适当限制输入长度和字符类型

## 相关组件

### 1. SecureField

用于密码等敏感信息输入：

```swift
SecureField("密码", text: $password)
```

### 2. TextEditor

用于多行文本编辑：

```swift
TextEditor(text: $longText)
    .frame(minHeight: 100)
```

### 3. Form

表单容器，优化输入体验：

```swift
Form {
    TextField("姓名", text: $name)
    TextField("邮箱", text: $email)
}
```

## 使用场景

### 1. 登录表单

- 用户名/邮箱输入
- 密码输入
- 验证码输入

### 2. 搜索功能

- 搜索关键词输入
- 实时搜索建议
- 搜索历史

### 3. 数据录入

- 个人信息填写
- 地址信息输入
- 数值数据录入

### 4. 聊天应用

- 消息输入
- 多行文本支持
- 表情符号输入

### 5. 设置界面

- 配置参数输入
- 服务器地址设置
- 个性化选项

## 总结

TextField 是 SwiftUI 中功能强大且灵活的文本输入组件。通过合理使用其各种修饰符和配置选项，可以创建出既美观又实用的用户界面。在实际开发中，需要根据具体的使用场景选择合适的样式和功能，同时注意性能优化和用户体验的平衡。

掌握 TextField 的各种用法对于构建高质量的 SwiftUI 应用至关重要，它不仅能够满足基本的文本输入需求，还能通过自定义实现复杂的交互效果。
