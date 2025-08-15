# Picker 组件详解

## 概述

Picker 是 SwiftUI 中用于从一组互斥值中进行选择的控件。它提供了多种样式和配置选项，适用于各种用户界面场景。

## 基本语法

```swift
Picker("标签", selection: $selectedValue) {
    Text("选项1").tag(value1)
    Text("选项2").tag(value2)
    Text("选项3").tag(value3)
}
```

## 核心概念

### 1. 选择绑定 (Selection Binding)

- 使用 `@State` 或 `@Binding` 属性包装器
- 选择值必须与 tag 值类型匹配
- 支持任何遵循 `Hashable` 协议的类型

### 2. 标签 (Label)

- 可以是字符串或自定义视图
- 描述选择器的用途
- 支持多行标签和副标题

### 3. 选项内容 (Content)

- 使用 `tag()` 修饰符设置选择值
- 支持复杂的视图结构
- 可以包含图标、文本和其他视图元素

## 初始化方法

### 1. 字符串标签初始化

```swift
Picker("选择口味", selection: $selectedFlavor) {
    Text("巧克力").tag(Flavor.chocolate)
    Text("香草").tag(Flavor.vanilla)
}
```

### 2. 自定义标签初始化

```swift
Picker(selection: $selectedValue) {
    // 选项内容
} label: {
    HStack {
        Image(systemName: "heart.fill")
        VStack(alignment: .leading) {
            Text("主标题")
            Text("副标题").font(.caption)
        }
    }
}
```

### 3. 图像标签初始化

```swift
// 系统图标
Picker("选择", systemImage: "gear", selection: $selectedValue) {
    // 选项内容
}

// 自定义图像
Picker("选择", image: Image("custom-icon"), selection: $selectedValue) {
    // 选项内容
}
```

## Picker 样式

### 1. 自动样式 (.automatic)

```swift
.pickerStyle(.automatic)
```

- **特点**: 系统根据上下文自动选择最合适的样式
- **适用场景**: 大多数情况下的默认选择
- **平台差异**: 在不同平台上表现不同

### 2. 分段控件样式 (.segmented)

```swift
.pickerStyle(.segmented)
```

- **特点**: 所有选项同时可见，类似于分段控件
- **适用场景**: 2-5 个选项，需要快速切换
- **优点**: 直观、快速选择
- **缺点**: 占用较多空间

### 3. 菜单样式 (.menu)

```swift
.pickerStyle(.menu)
```

- **特点**: 点击后显示下拉菜单
- **适用场景**: 选项较多，需要节省空间
- **优点**: 节省界面空间
- **缺点**: 需要额外点击操作

### 4. 滚轮样式 (.wheel)

```swift
.pickerStyle(.wheel)
```

- **特点**: 经典的滚轮选择器
- **适用场景**: 数值选择、大量选项
- **优点**: 适合连续数值选择
- **缺点**: 占用较多垂直空间

## 与 ForEach 结合使用

### 1. 基础用法

```swift
Picker("选择国家", selection: $selectedCountry) {
    ForEach(countries) { country in
        Text(country.name).tag(country)
    }
}
```

### 2. 自定义 ID

```swift
Picker("选择数字", selection: $selectedNumber) {
    ForEach(1...10, id: \.self) { number in
        Text("\(number)").tag(number)
    }
}
```

### 3. 复杂视图结构

```swift
Picker("选择产品", selection: $selectedProduct) {
    ForEach(products) { product in
        VStack(alignment: .leading) {
            Text(product.name)
            Text("¥\(product.price)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .tag(product)
    }
}
```

## 高级用法

### 1. 级联选择

```swift
// 第一级选择影响第二���选项
Picker("国家", selection: $selectedCountry) {
    ForEach(countries) { country in
        Text(country.name).tag(country)
    }
}

Picker("城市", selection: $selectedCity) {
    ForEach(filteredCities) { city in
        Text(city.name).tag(city)
    }
}
.onChange(of: selectedCountry) { _, newCountry in
    // 更新城市选择
    selectedCity = filteredCities.first ?? defaultCity
}
```

### 2. 条件选择

```swift
if isAdvancedUser {
    Picker("高级选项", selection: $advancedOption) {
        ForEach(advancedOptions) { option in
            Text(option.name).tag(option)
        }
    }
}
```

### 3. 动态选项

```swift
@State private var availableOptions: [Option] = []

Picker("动态选项", selection: $selectedOption) {
    ForEach(availableOptions) { option in
        Text(option.name).tag(option)
    }
}
.onAppear {
    loadOptions()
}
```

## 相关 ViewModifier

### 1. pickerStyle(\_:)

设置 Picker 的显示样式

```swift
.pickerStyle(.segmented)
.pickerStyle(.menu)
.pickerStyle(.wheel)
.pickerStyle(.automatic)
```

### 2. tag(\_:)

为选项设置关联值

```swift
Text("选项").tag(associatedValue)
```

### 3. horizontalRadioGroupLayout()

设置水平单选按钮布局（macOS）

```swift
.horizontalRadioGroupLayout()
```

### 4. defaultWheelPickerItemHeight(\_:)

设置滚轮选择器项目的默认高度

```swift
.defaultWheelPickerItemHeight(44)
```

### 5. paletteSelectionEffect(\_:)

设置调色板选择效果

```swift
.paletteSelectionEffect(.symbolVariants)
```

## 数据类型要求

### 1. Hashable 协议

选择值类型必须遵循 `Hashable` 协议：

```swift
enum Flavor: String, CaseIterable, Hashable {
    case chocolate, vanilla, strawberry
}
```

### 2. Identifiable 协议

与 ForEach 结合使用时，数据类型应遵循 `Identifiable` 协议：

```swift
struct Country: Identifiable {
    let id = UUID()
    let name: String
    let code: String
}
```

### 3. 自定义 Equatable

对于复杂类型，可能需要自定义相等性比较：

```swift
struct Product: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let price: Double

    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
```

## 最佳实践

### 1. 选择合适的样式

- **2-5 个选项**: 使用 `.segmented` 样式
- **多个选项**: 使用 `.menu` 样式
- **数值选择**: 使用 `.wheel` 样式
- **不确定**: 使用 `.automatic` 样式

### 2. 提供清晰的标签

```swift
// 好的做法
Picker("选择配送方式", selection: $deliveryMethod) { ... }

// 避免模糊的标签
Picker("选择", selection: $someValue) { ... }
```

### 3. 使用有意义的 tag 值

```swift
// 好的做法
Text("快速配送").tag(DeliveryMethod.express)

// 避免使用索引作为 tag
Text("快速配送").tag(1)
```

### 4. 处理选择变化

```swift
.onChange(of: selectedValue) { oldValue, newValue in
    // 处理选择变化
    handleSelectionChange(from: oldValue, to: newValue)
}
```

### 5. 提供默认值

```swift
@State private var selectedFlavor: Flavor = .chocolate // 提供默认值
```

## 常见问题

### 1. 选择不更新

**问题**: Picker 选择后状态不更新
**解决**: 确保使用正确的绑定和 tag 值类型匹配

```swift
// 错误：类型不匹配
@State private var selected: String = ""
Text("选项").tag(1) // Int 类型

// 正确：类型匹配
@State private var selected: Int = 0
Text("选项").tag(1) // Int 类型
```

### 2. ForEach 中的 tag 问题

**问题**: 使用 ForEach 时选择不正确
**解决**: 确保数据类型遵循 Identifiable 或使用正确的 id

```swift
// 如果类型不遵循 Identifiable
ForEach(items, id: \.self) { item in
    Text(item.name).tag(item)
}
```

### 3. 级联选择同步问题

**问题**: 级联选择时子选择器不更新
**解决**: 使用 onChange 监听父选择器变化

```swift
.onChange(of: parentSelection) { _, newValue in
    childSelection = getDefaultChild(for: newValue)
}
```

## 平台差异

### iOS/iPadOS

- 在 List 中显示为导航行
- 支持所有样式
- 自动样式通常显示为导航行

### macOS

- 支持单选按钮样式
- 可以使用 horizontalRadioGroupLayout()
- 菜单样式显示为下拉菜单

### watchOS

- 样式选择有限
- 通常使用全屏选择界面
- 滚轮样式适配表冠操作

### tvOS

- 适配遥控器操作
- 焦点导航支持
- 样式自动适配电视界面

## 可访问性

### 1. 语音标签

```swift
.accessibilityLabel("选择冰淇淋口味")
```

### 2. 语音提示

```swift
.accessibilityHint("双击选择不同的口味")
```

### 3. 语音值

```swift
.accessibilityValue(selectedFlavor.displayName)
```

## 性能优化

### 1. 避免频繁重建

```swift
// 将选项数据声明为静态或缓存
static let flavors = Flavor.allCases
```

### 2. 使用 LazyVStack（大量选项时）

```swift
Picker("选择", selection: $selected) {
    LazyVStack {
        ForEach(largeDataSet) { item in
            Text(item.name).tag(item)
        }
    }
}
```

### 3. 条件渲染

```swift
// 只在需要时渲染复杂选项
if showAdvancedOptions {
    ForEach(advancedOptions) { option in
        ComplexOptionView(option: option).tag(option)
    }
}
```

Picker 是 SwiftUI 中功能强大且灵活的选择控件，通过合理使用其各种特性和样式，可以创建出优秀的用户选择体验。
