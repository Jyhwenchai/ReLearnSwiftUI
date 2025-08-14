# TextFieldExample - SwiftUI TextField 组件示例包

## 项目概述

TextFieldExample 是一个专门展示 SwiftUI TextField 组件各种用法的示例包。通过四个渐进式的示例视图，全面演示了从基础文本输入到高级自定义功能的完整实现。

## 示例结构

### TextFieldExampleView01 - 基础文本输入

**功能特点：**

- ✅ 基础 TextField 创建和使用
- ✅ 不同类型的文本输入（普通文本、用户名、邮箱、密码、数字）
- ✅ 键盘类型优化（emailAddress、numberPad 等）
- ✅ 输入行为控制（自动大写、自动纠错）
- ✅ SecureField 密码输入演示
- ✅ 多行文本输入（iOS 16+）

**学习要点：**

- TextField 的基本语法和参数
- @State 变量绑定机制
- 不同键盘类型的使用场景
- 输入验证的基础概念

### TextFieldExampleView02 - 样式和修饰符

**功能特点：**

- ✅ 内置 TextFieldStyle 演示（Plain、RoundedBorder）
- ✅ 自定义边框样式（实线、虚线、渐变）
- ✅ 图标装饰和搜索框样式
- ✅ 字体和颜色定制
- ✅ 背景效果（渐变、阴影、毛玻璃）

**学习要点：**

- TextFieldStyle 的选择和应用
- 使用 overlay 和 background 创建自定义样式
- HStack 组合图标和文本框
- 视觉设计的最佳实践

### TextFieldExampleView03 - 输入验证和格式化

**功能特点：**

- ✅ 实时邮箱格式验证
- ✅ 手机号自动格式化（XXX-XXXX-XXXX）
- ✅ 密码强度检测和可视化指示器
- ✅ 信用卡号格式化和类型检测
- ✅ 价格输入格式化（千分位分隔符）
- ✅ 用户名验证（多条件实时反馈）

**学习要点：**

- onChange 监听器的使用
- 正则表达式验证
- 字符串格式化技巧
- 用户友好的错误提示设计

### TextFieldExampleView04 - 高级功能和自定义

**功能特点：**

- ✅ 浮动标签动画效果
- ✅ 焦点状态的动画边框和阴影
- ✅ 标签输入系统（添加/删除标签）
- ✅ 智能搜索建议下拉列表
- ✅ 聊天输入框（多行支持、动态发送按钮）
- ✅ 代码输入框（等宽字体、编辑器样式）

**学习要点：**

- @FocusState 焦点管理
- 复杂动画效果实现
- 自定义交互组件设计
- 高级用户界面模式

## 技术特色

### 1. 渐进式学习设计

- 从简单到复杂的学习路径
- 每个示例都有详细的中文注释
- 实际应用场景模拟

### 2. 完整的功能覆盖

- 基础输入到高级定制
- 样式设计到交互行为
- 验证逻辑到用户体验

### 3. 现代 SwiftUI 特性

- iOS 16+ 多行文本输入
- @FocusState 焦点管理
- 动画和过渡效果
- 响应式设计

### 4. 实用的工具函数

- 邮箱格式验证
- 手机号格式化
- 密码强度检测
- 信用卡号处理
- 价格格式化

## 代码亮点

### 1. 智能验证系统

```swift
// 实时邮箱验证
.onChange(of: emailText) { _, newValue in
    isEmailValid = isValidEmail(newValue)
}

// 动态边框颜色反馈
.stroke(
    emailText.isEmpty ? Color.gray.opacity(0.3) :
    isEmailValid ? Color.green : Color.red,
    lineWidth: 1
)
```

### 2. 浮动标签动画

```swift
Text("邮箱地址")
    .font(isFloatingFocused || !floatingText.isEmpty ? .caption : .body)
    .foregroundColor(isFloatingFocused ? .blue : .secondary)
    .offset(y: isFloatingFocused || !floatingText.isEmpty ? -20 : 0)
    .animation(.easeInOut(duration: 0.2), value: isFloatingFocused)
```

### 3. 格式化输入处理

```swift
// 手机号格式化
private func formatPhoneNumber(_ input: String) -> String {
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

### 4. 搜索建议系统

```swift
// 智能过滤建议
private var filteredSuggestions: [String] {
    if searchText.isEmpty {
        return searchSuggestions
    }
    return searchSuggestions.filter {
        $0.localizedCaseInsensitiveContains(searchText)
    }
}
```

## 学习建议

### 初学者路径

1. **TextFieldExampleView01** - 掌握基础概念和语法
2. **阅读 TextField.md** - 深入理解组件原理
3. **TextFieldExampleView02** - 学习样式定制技巧
4. **实践练习** - 创建自己的输入表单

### 进阶开发者路径

1. **TextFieldExampleView03** - 学习验证和格式化
2. **TextFieldExampleView04** - 掌握高级交互技巧
3. **源码分析** - 理解实现细节
4. **扩展开发** - 基于示例创建自定义组件

## 实际应用场景

### 1. 用户注册/登录

- 用户名验证
- 邮箱格式检查
- 密码强度提示
- 实时错误反馈

### 2. 电商应用

- 商品搜索（智能建议）
- 价格输入（格式化）
- 地址信息录入
- 信用卡信息输入

### 3. 社交应用

- 聊天消息输入
- 标签系统
- 个人资料编辑
- 搜索功能

### 4. 企业应用

- 数据录入表单
- 配置参数设置
- 报表查询条件
- 用户权限管理

## 技术要求

- **最低版本**: iOS 15.0, macOS 12.0
- **推荐版本**: iOS 16.0+（支持多行文本输入）
- **Swift 版本**: Swift 6.0+
- **依赖**: 仅依赖 SwiftUI 框架

## 编译和测试

### iOS 平台测试

```bash
xcodebuild -scheme TextFieldExample -destination 'platform=iOS Simulator,name=iPhone 16' build
```

### macOS 平台测试

```bash
xcodebuild -scheme TextFieldExample -destination 'platform=macOS' build
```

## 扩展建议

### 1. 功能扩展

- 添加更多验证规则
- 支持自定义键盘
- 集成第三方输入法
- 添加语音输入支持

### 2. 样式扩展

- 更多主题样式
- 暗黑模式适配
- 动态字体支持
- 国际化界面

### 3. 性能优化

- 大数据输入优化
- 内存使用优化
- 动画性能提升
- 电池续航考虑

## 总结

TextFieldExample 提供了一个完整的 TextField 学习和参考资源，涵盖了从基础使用到高级定制的所有方面。通过学习这些示例，开发者可以：

- 掌握 TextField 的核心概念和用法
- 学会创建美观且实用的输入界面
- 理解输入验证和格式化的最佳实践
- 获得构建复杂交互组件的能力

这个示例包不仅适合初学者入门，也为有经验的开发者提供了实用的代码参考和设计灵感。
