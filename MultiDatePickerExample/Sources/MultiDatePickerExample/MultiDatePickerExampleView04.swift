import SwiftUI

/// MultiDatePicker 高级用法和样式示例
/// 展示复杂的使用场景和自定义样式
public struct MultiDatePickerExampleView04: View {
  @State private var workDays: Set<DateComponents> = []
  @State private var holidays: Set<DateComponents> = []
  @State private var meetings: Set<DateComponents> = []
  @State private var selectedCategory = 0

  @Environment(\.calendar) var calendar

  public init() {}

  private let categories = ["工作日", "假期", "会议日"]
  private let categoryColors: [Color] = [.blue, .green, .orange]

  // 获取当前选中类别的日期集合绑定
  private var currentSelection: Binding<Set<DateComponents>> {
    switch selectedCategory {
    case 0: return $workDays
    case 1: return $holidays
    case 2: return $meetings
    default: return $workDays
    }
  }

  // 计算本月的日期范围
  private var currentMonthRange: Range<Date> {
    let now = Date()
    let startOfMonth = calendar.dateInterval(of: .month, for: now)?.start ?? now
    let endOfMonth =
      calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) ?? now
    return startOfMonth..<calendar.date(byAdding: .day, value: 1, to: endOfMonth)!
  }

  public var body: some View {
    VStack(spacing: 16) {
      Text("高级用法和样式")
        .font(.title2)
        .fontWeight(.semibold)

      // 类别选择器
      Picker("选择类别", selection: $selectedCategory) {
        ForEach(0..<categories.count, id: \.self) { index in
          Label(categories[index], systemImage: categoryIcon(for: index))
            .tag(index)
        }
      }
      .pickerStyle(.segmented)

      // 当前类别的 MultiDatePicker
      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Text("选择\(categories[selectedCategory])")
            .font(.headline)
            .foregroundColor(categoryColors[selectedCategory])

          Spacer()

          Text("本月范围")
            .font(.caption)
            .foregroundColor(.secondary)
        }

        MultiDatePicker(
          "选择\(categories[selectedCategory])",
          selection: currentSelection,
          in: currentMonthRange
        )
        .frame(maxHeight: 280)
        .background(categoryColors[selectedCategory].opacity(0.05))
        .cornerRadius(12)
      }

      // 统计信息卡片
      HStack(spacing: 12) {
        StatCard(
          title: "工作日",
          count: workDays.count,
          color: .blue,
          icon: "briefcase.fill"
        )

        StatCard(
          title: "假期",
          count: holidays.count,
          color: .green,
          icon: "sun.max.fill"
        )

        StatCard(
          title: "会议",
          count: meetings.count,
          color: .orange,
          icon: "person.3.fill"
        )
      }

      // 日期冲突检查
      if hasConflicts() {
        HStack {
          Image(systemName: "exclamationmark.triangle.fill")
            .foregroundColor(.red)
          Text("检测到日期冲突！")
            .font(.caption)
            .foregroundColor(.red)
          Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)
      }

      // 所有选中日期的综合视图
      if !allSelectedDates().isEmpty {
        VStack(alignment: .leading, spacing: 8) {
          Text("本月日程总览：")
            .font(.headline)

          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(allSelectedDatesWithCategories(), id: \.date) { item in
                VStack(spacing: 2) {
                  Text(item.date, style: .date)
                    .font(.caption2)
                    .fontWeight(.medium)

                  HStack(spacing: 2) {
                    ForEach(item.categories, id: \.self) { category in
                      Circle()
                        .fill(categoryColors[category])
                        .frame(width: 6, height: 6)
                    }
                  }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
              }
            }
            .padding(.horizontal)
          }
        }
      }

      // 操作按钮
      HStack(spacing: 12) {
        Button("清除当前类别") {
          currentSelection.wrappedValue.removeAll()
        }
        .buttonStyle(.bordered)
        .disabled(currentSelection.wrappedValue.isEmpty)

        Button("清除所有") {
          workDays.removeAll()
          holidays.removeAll()
          meetings.removeAll()
        }
        .buttonStyle(.borderedProminent)
        .disabled(allSelectedDates().isEmpty)
      }

      Spacer()
    }
    .padding()
    .navigationTitle("高级用法")
    .navigationBarTitleDisplayMode(.inline)
  }

  // 获取类别图标
  private func categoryIcon(for index: Int) -> String {
    switch index {
    case 0: return "briefcase.fill"
    case 1: return "sun.max.fill"
    case 2: return "person.3.fill"
    default: return "calendar"
    }
  }

  // 检查是否有日期冲突
  private func hasConflicts() -> Bool {
    let allDates = [workDays, holidays, meetings]
    for i in 0..<allDates.count {
      for j in (i + 1)..<allDates.count {
        if !allDates[i].intersection(allDates[j]).isEmpty {
          return true
        }
      }
    }
    return false
  }

  // 获取所有选中的日期
  private func allSelectedDates() -> Set<DateComponents> {
    return workDays.union(holidays).union(meetings)
  }

  // 获取所有选中日期及其类别信息
  private func allSelectedDatesWithCategories() -> [(date: Date, categories: [Int])] {
    var result: [(date: Date, categories: [Int])] = []
    let allDateSets = [workDays, holidays, meetings]

    for dateComponents in allSelectedDates() {
      if let date = calendar.date(from: dateComponents) {
        var categories: [Int] = []
        for (index, dateSet) in allDateSets.enumerated() {
          if dateSet.contains(dateComponents) {
            categories.append(index)
          }
        }
        result.append((date: date, categories: categories))
      }
    }

    return result.sorted { $0.date < $1.date }
  }
}

// 统计卡片组件
struct StatCard: View {
  let title: String
  let count: Int
  let color: Color
  let icon: String

  var body: some View {
    VStack(spacing: 4) {
      Image(systemName: icon)
        .foregroundColor(color)
        .font(.title3)

      Text("\(count)")
        .font(.title2)
        .fontWeight(.bold)
        .foregroundColor(color)

      Text(title)
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 12)
    .background(color.opacity(0.1))
    .cornerRadius(12)
  }
}

#Preview {
  NavigationView {
    MultiDatePickerExampleView04()
  }
}
