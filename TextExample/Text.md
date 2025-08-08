# SwiftUI Text 组件详解

## 概述

`Text` 是 SwiftUI 中最基础也是最重要的视图组件之一，用于显示一行或多行只读文本。它提供了丰富的样式选项和格式化功能，可以满足各种文本显示需求。

## 基本语法

```swift
Text("Hello, SwiftUI!")
```

## 初始化方式

### 1. 基础文本初始化

```swift
// 最简单的文本
Text("Hello, World!")

// 字面量文本（不进行本地化）
Text(verbatim: "这是字面量文本")

// 本地化文本
Text("localized.key")
```

### 2. 日期和时间初始化

```swift
// 日期显示
Text(Date(), style: .date)
Text(Date(), style: .time) 
Text(Date(), style: .relative)
Text(Date(), style: .offset)

// 自定义日期格式
Text(Date(), format: Date.FormatStyle()
    .year(.defaultDigits)
    .month(.abbreviated)
    .day(.defaultDigits))
```

### 3. 数字格式化初始化

```swift
// 基础数字
Text(123.456, format: .number)

// 货币格式
Text(123.45, format: .currency(code: "USD"))
Text(123.45, format: .currency(code: "CNY"))

// 百分比格式
Text(0.75, format: .percent)
```

### 4. 计时器初始化

```swift
// 倒计时
Text(timerInterval: Date.now...endDate,
     countsDown: true,
     showsHours: true)

// 正计时
Text(timerInterval: startDate...Date.distantFuture,
     countsDown: false,
     showsHours: false)
```

### 5. AttributedString 和 Formatter

```swift
// AttributedString
Text(attributedString)

// 使用 Formatter
Text(date, formatter: dateFormatter)
Text(number, formatter: numberFormatter)
```

## 字体设置

### 系统预定义字体

```swift
Text("文本").font(.largeTitle)    // 最大标题
Text("文本").font(.title)         // 标题
Text("文本").font(.title2)        // 标题2
Text("文本").font(.title3)        // 标题3
Text("文本").font(.headline)      // 标题行
Text("文本").font(.subheadline)   // 副标题
Text("文本").font(.body)          // 正文（默认）
Text("文本").font(.callout)       // 标注
Text("文本").font(.footnote)      // 脚注
Text("文本").font(.caption)       // 说明
Text("文本").font(.caption2)      // 说明2
```

### 自定义字体

```swift
// 自定义大小和权重
Text("文本").font(.system(size: 24, weight: .bold))

// 字体设计风格
Text("文本").font(.system(size: 16, design: .default))     // 默认
Text("文本").font(.system(size: 16, design: .monospaced))  // 等宽
Text("文本").font(.system(size: 16, design: .rounded))     // 圆角
Text("文本").font(.system(size: 16, design: .serif))       // 衬线

// 字体权重
Text("文本").fontWeight(.ultraLight)  // 超轻
Text("文本").fontWeight(.thin)        // 细
Text("文本").fontWeight(.light)       // 轻
Text("文本").fontWeight(.regular)     // 常规
Text("文本").fontWeight(.medium)      // 中等
Text("文本").fontWeight(.semibold)    // 半粗
Text("文本").fontWeight(.bold)        // 粗体
Text("文本").fontWeight(.heavy)       // 重
Text("文本").fontWeight(.black)       // 最粗

// 字体宽度
Text("文本").fontWidth(.compressed)   // 压缩
Text("文本").fontWidth(.condensed)    // 紧缩
Text("文本").fontWidth(.standard)     // 标准
Text("文本").fontWidth(.expanded)     // 扩展
```

## 文本颜色

```swift
// 系统颜色
Text("文本").foregroundColor(.primary)    // 主色
Text("文本").foregroundColor(.secondary)  // 次要色
Text("文本").foregroundColor(.blue)       // 蓝色
Text("文本").foregroundColor(.red)        // 红色

// 自定义颜色
Text("文本").foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.6))
Text("文本").foregroundStyle(.red)        // 使用 foregroundStyle（iOS 15+）
```

## 文本修饰

### 基础修饰

```swift
// 粗体和斜体
Text("粗体").bold()
Text("斜体").italic()
Text("粗斜体").bold().italic()

// 使用布尔值控制
Text("条件粗体").bold(true)
Text("条件斜体").italic(false)
```

### 下划线和删除线

```swift
// 基础下划线
Text("下划线").underline()
Text("自定义下划线").underline(true, color: .red)

// 不同线条样式
Text("实线下划线").underline(true, pattern: .solid, color: .blue)
Text("虚线下划线").underline(true, pattern: .dash, color: .green)
Text("点线下划线").underline(true, pattern: .dot, color: .orange)

// 删除线
Text("删除线").strikethrough()
Text("自定义删除线").strikethrough(true, color: .red)
Text("虚线删除线").strikethrough(true, pattern: .dash, color: .blue)
```

### 等宽字体

```swift
// 等宽字体
Text("等宽文本").monospaced()
Text("条件等宽").monospaced(true)

// 等宽数字（其他字符保持比例）
Text("Price: $123.45").monospacedDigit()
```

## 字符间距调整

```swift
// 字符间距（tracking）- 增加尾随空白
Text("增加间距").tracking(2.0)
Text("减少间距").tracking(-1.0)

// 字距调整（kerning）- 调整字符偏移
Text("字距调整").kerning(3.0)

// 基线偏移
Text("上标").baselineOffset(8)
Text("下标").baselineOffset(-4)
```

## 多行文本处理

### 文本对齐

```swift
Text("多行文本内容...")
    .multilineTextAlignment(.leading)    // 左对齐
    .multilineTextAlignment(.center)     // 居中
    .multilineTextAlignment(.trailing)   // 右对齐
```

### 行数限制

```swift
Text("长文本...")
    .lineLimit(1)           // 限制1行
    .lineLimit(3)           // 限制3行
    .lineLimit(2...4)       // 2-4行范围
    .lineLimit(2, reservesSpace: true)  // 预留空间
```

### 截断模式

```swift
Text("长文本...")
    .lineLimit(1)
    .truncationMode(.tail)    // 尾部截断（默认）
    .truncationMode(.head)    // 头部截断
    .truncationMode(.middle)  // 中间截断
```

### 行间距

```swift
Text("多行文本...")
    .lineSpacing(5)     // 增加行间距
    .lineSpacing(-2)    // 减少行间距
```

### 自适应显示

```swift
Text("长文本...")
    .minimumScaleFactor(0.5)    // 最小缩放到50%
    .allowsTightening(true)     // 允许字符紧缩
```

## 高级功能

### 文本选择

```swift
Text("可选择的文本")
    .textSelection(.enabled)    // 启用选择
    .textSelection(.disabled)   // 禁用选择
```

### 动态类型

```swift
// 设置特定动态类型大小
Text("动态文本")
    .dynamicTypeSize(.large)

// 限制动态类型范围
Text("受限动态文本")
    .dynamicTypeSize(.large ... .xxxLarge)
```

### 文本缩放

```swift
Text("缩放文本")
    .textScale(.secondary, isEnabled: true)
```

### 大小写变换

```swift
Text("大小写文本")
    .textCase(.uppercase)    // 大写
    .textCase(.lowercase)    // 小写
```

### 文本合并

```swift
// 使用 + 操作符合并不同样式的文本
let combinedText = Text("普通文本 ")
    + Text("粗体文本").bold().foregroundColor(.blue)
    + Text(" 斜体文本").italic().foregroundColor(.green)
```

### AttributedString 支持

```swift
// Markdown 支持
Text("支持 **粗体** 和 *斜体* 以及 `代码`")

// 自定义 AttributedString
var attributedString = AttributedString("自定义样式文本")
attributedString.font = .boldSystemFont(ofSize: 16)
attributedString.foregroundColor = .blue
Text(attributedString)
```

## 最佳实践

### 1. 性能优化

- 对于静态文本，使用简单的初始化方式
- 避免在循环中创建复杂的 AttributedString
- 合理使用文本缓存

### 2. 可访问性

```swift
Text("重要文本")
    .accessibilityLabel("这是重要的文本内容")
    .accessibilityHint("双击以获取更多信息")
```

### 3. 本地化

```swift
// 在 Localizable.strings 中定义本地化字符串
Text("welcome.message")

// 带参数的本地化
Text("Hello, \(userName)!")
```

### 4. 响应式设计

```swift
Text("响应式文本")
    .font(.title)
    .minimumScaleFactor(0.7)
    .lineLimit(2)
    .multilineTextAlignment(.center)
```

## 常见问题与解决方案

### 1. 文本被截断

**问题**：长文本在小屏幕上被截断

**解决方案**：
```swift
Text("很长的文本内容...")
    .minimumScaleFactor(0.5)  // 允许缩放
    .lineLimit(nil)           // 移除行数限制
    .allowsTightening(true)   // 允许字符紧缩
```

### 2. 等宽字体不生效

**问题**：数字对齐问题

**解决方案**：
```swift
Text("Price: $123.45")
    .monospacedDigit()  // 只对数字使用等宽
```

### 3. 动态类型不响应

**问题**：文本不跟随系统字体大小设置

**解决方案**：
```swift
Text("动态文本")
    .font(.body)  // 使用系统预定义字体
    // 避免使用固定大小：.font(.system(size: 16))
```

### 4. 多行文本对齐问题

**问题**：多行文本对齐不一致

**解决方案**：
```swift
Text("多行文本内容...")
    .multilineTextAlignment(.leading)  // 明确设置对齐方式
    .frame(maxWidth: .infinity, alignment: .leading)  // 容器对齐
```

### 5. 富文本样式冲突

**问题**：AttributedString 样式被 SwiftUI 修饰符覆盖

**解决方案**：
```swift
// AttributedString 的样式优先级更高
// 避免同时使用 AttributedString 样式和 SwiftUI 修饰符
Text(attributedString)  // 只使用 AttributedString 样式
```

## 相关组件

- `Label`：结合图标和文本的标签组件
- `TextField`：可编辑文本输入框
- `TextEditor`：多行文本编辑器
- `SecureField`：密码输入框

## 版本兼容性

- `Text` 基础功能：iOS 13.0+
- `textSelection`：iOS 15.0+
- `textScale`：iOS 17.0+
- `AttributedString` 支持：iOS 15.0+
- 新的 Format API：iOS 15.0+

## 总结

SwiftUI 的 `Text` 组件功能强大且灵活，通过合理使用各种修饰符和初始化方式，可以创建出美观且功能丰富的文本界面。记住始终考虑可访问性和本地化需求，确保应用能为所有用户提供良好的体验。