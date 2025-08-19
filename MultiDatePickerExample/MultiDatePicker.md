# MultiDatePicker 组件详解

## 概述

`MultiDatePicker` 是 SwiftUI 中用于选择多个日期的控件，以日历视图的形式呈现，允许用户同时选择多个日期。它是 iOS 16.0+ 引入的新组件，为需要多日期选择功能的应用提供了原生支持。

## 基本语法

```swift
MultiDatePicker(
    "标签文本",
    selection: $selectedDates
)
```

## 核心特性

### 1. 多日期选择

- 使用 `Set<DateComponents>` 存储选中的日期
- 支持点击选择/取消选择日期
- 自动处理日期的添加和移除

### 2. 日期范围限制

- 支持通过 `in:` 参数限制可选择的日期范围
- 可以设置最小日期、最大日期或特定范围

### 3. 环境值定制

- 支持自定义 `locale`（语言/地区）
- 支持自定义 `calendar`（日历系统）
- 支持自定义 `timeZone`（时区）

## 初始化方法

### 基础初始化

```swift
// 基础用法
MultiDatePicker("选择日期", selection: $selectedDates)

// 使用标签闭包
MultiDatePicker(selection: $selectedDates) {
    Label("选择日期", systemImage: "calendar")
}
```

### 带日期范围限制

```swift
// 限制日期范围
MultiDatePicker(
    "选择日期",
    selection: $selectedDates,
    in: startDate..<endDate
)

// 只允许未来日期
MultiDatePicker(
    "选择未来日期",
    selection: $selectedDates,
    in: Date()...
)

// 只允许过去日期
MultiDatePicker(
    "选择过去日期",
    selection: $selectedDates,
    in: ...Date()
)
```

## 数据类型

### DateComponents

`MultiDatePicker` 使用 `Set<DateComponents>` 来存储选中的日期：

```swift
@State private var selectedDates: Set<DateComponents> = []

// 转换为 Date 类型
let dates = selectedDates.compactMap { dateComponents in
    Calendar.current.date(from: dateComponents)
}
```

### 日期范围类型

支持多种日期范围类型：

- `Range<Date>`: `startDate..<endDate`
- `ClosedRange<Date>`: `startDate...endDate`
- `PartialRangeFrom<Date>`: `startDate...`
- `PartialRangeThrough<Date>`: `...endDate`

## 环境值定制

### Locale（语言/地区）

```swift
MultiDatePicker("选择日期", selection: $selectedDates)
    .environment(\.locale, Locale(identifier: "zh-Hans"))
```

### Calendar（日历系统）

```swift
MultiDatePicker("选择日期", selection: $selectedDates)
    .environment(\.calendar, Calendar(identifier: .chinese))
```

### TimeZone（时区）

```swift
MultiDatePicker("选择日期", selection: $selectedDates)
    .environment(\.timeZone, TimeZone(identifier: "Asia/Shanghai")!)
```

### 组合使用

```swift
MultiDatePicker("选择日期", selection: $selectedDates)
    .environment(\.locale, Locale(identifier: "zh-Hans"))
    .environment(\.calendar, Calendar(identifier: .gregorian))
    .environment(\.timeZone, TimeZone(identifier: "Asia/Shanghai")!)
```

## 常用修饰符

### 布局相关

```swift
MultiDatePicker("选择日期", selection: $selectedDates)
    .frame(maxHeight: 400)  // 限制高度
    .padding()              // 添加内边距
    .background(Color.gray.opacity(0.1))  // 背景色
    .cornerRadius(12)       // 圆角
```

### 样式定制

```swift
MultiDatePicker("选择日期", selection: $selectedDates)
    .accentColor(.blue)     // 强调色
    .foregroundColor(.primary)  // 前景色
```

## 实际应用场景

### 1. 工作日程安排

```swift
@State private var workDays: Set<DateComponents> = []
@State private var holidays: Set<DateComponents> = []

var body: some View {
    VStack {
        MultiDatePicker("选择工作日", selection: $workDays)
        MultiDatePicker("选择假期", selection: $holidays)
    }
}
```

### 2. 事件日期选择

```swift
@State private var eventDates: Set<DateComponents> = []

var body: some View {
    MultiDatePicker(
        "选择活动日期",
        selection: $eventDates,
        in: Date()...Calendar.current.date(byAdding: .month, value: 6, to: Date())!
    )
}
```

### 3. 预订系统

```swift
@State private var availableDates: Set<DateComponents> = []

var body: some View {
    MultiDatePicker(
        "选择可预订日期",
        selection: $availableDates,
        in: Date()...Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    )
}
```

## 数据处理

### 日期格式化

```swift
func formatSelectedDates() -> [String] {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium

    return selectedDates.compactMap { dateComponents in
        Calendar.current.date(from: dateComponents)
    }.sorted().map { date in
        formatter.string(from: date)
    }
}
```

### 日期筛选

```swift
// 获取本月选中的日期
func datesInCurrentMonth() -> Set<DateComponents> {
    let calendar = Calendar.current
    let now = Date()

    return selectedDates.filter { dateComponents in
        guard let date = calendar.date(from: dateComponents) else { return false }
        return calendar.isDate(date, equalTo: now, toGranularity: .month)
    }
}
```

### 日期统计

```swift
// 计算选中日期的统计信息
func dateStatistics() -> (weekdays: Int, weekends: Int) {
    let calendar = Calendar.current
    var weekdays = 0
    var weekends = 0

    for dateComponents in selectedDates {
        guard let date = calendar.date(from: dateComponents) else { continue }
        let weekday = calendar.component(.weekday, from: date)

        if weekday == 1 || weekday == 7 { // 周日或周六
            weekends += 1
        } else {
            weekdays += 1
        }
    }

    return (weekdays, weekends)
}
```

## 性能优化

### 1. 限制选择数量

```swift
@State private var selectedDates: Set<DateComponents> = []
private let maxSelectionCount = 10

var body: some View {
    MultiDatePicker("选择日期", selection: $selectedDates)
        .onChange(of: selectedDates) { newDates in
            if newDates.count > maxSelectionCount {
                // 保留最新的选择
                selectedDates = Set(Array(newDates).suffix(maxSelectionCount))
            }
        }
}
```

### 2. 延迟处理

```swift
@State private var selectedDates: Set<DateComponents> = []
@State private var processedDates: [Date] = []

var body: some View {
    MultiDatePicker("选择日期", selection: $selectedDates)
        .onChange(of: selectedDates) { _ in
            // 使用延迟处理避免频繁更新
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                processSelectedDates()
            }
        }
}

private func processSelectedDates() {
    processedDates = selectedDates.compactMap { dateComponents in
        Calendar.current.date(from: dateComponents)
    }.sorted()
}
```

## 平台兼容性

- **iOS** 16.0+
- **iPadOS** 16.0+
- **Mac Catalyst** 16.0+
- **visionOS** 1.0+

注意：`MultiDatePicker` 不支持 macOS、watchOS 和 tvOS。

## 最佳实践

### 1. 用户体验

- 提供清晰的标签说明选择目的
- 显示选中日期的数量和列表
- 提供清除选择的功能
- 在日期范围有限制时给出明确提示

### 2. 数据管理

- 使用合适的数据结构存储选中日期
- 及时清理不需要的日期数据
- 考虑数据持久化需求

### 3. 性能考虑

- 避免在选择变化时进行重量级操作
- 合理限制可选择的日期数量
- 使用延迟处理机制

### 4. 国际化

- 根据用户地区设置合适的 locale
- 考虑不同日历系统的支持
- 注意时区处理

## 常见问题

### Q: 如何限制最大选择数量？

A: 使用 `onChange` 修饰符监听选择变化，当超过限制时移除多余的选择。

### Q: 如何实现单选模式？

A: 监听选择变化，确保集合中只保留最新选择的日期。

### Q: 如何处理不同时区的日期？

A: 使用 `environment(\.timeZone, _)` 设置合适的时区，并在数据处理时考虑时区转换。

### Q: 如何自定义日期显示格式？

A: 通过设置环境值中的 `locale` 和 `calendar` 来影响显示格式。

### Q: 如何实现日期预设？

A: 在视图初始化时设置 `selectedDates` 的初始值。

## 相关组件

- **DatePicker**: 单日期选择器
- **Calendar**: 日历相关功能
- **DateFormatter**: 日期格式化
- **Locale**: 本地化设置
- **TimeZone**: 时区处理
