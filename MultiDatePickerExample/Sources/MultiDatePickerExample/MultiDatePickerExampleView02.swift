import SwiftUI

/// MultiDatePicker 日期范围限制示例
/// 展示如何限制可选择的日期范围
public struct MultiDatePickerExampleView02: View {
  @State private var selectedDates: Set<DateComponents> = []

  // 获取环境中的日历和时区
  @Environment(\.calendar) var calendar
  @Environment(\.timeZone) var timeZone

  public init() {}

  // 计算日期范围：从今天开始的未来30天
  private var dateRange: Range<Date> {
    let today = Date()
    let futureDate = calendar.date(byAdding: .day, value: 30, to: today) ?? today
    return today..<futureDate
  }

  // 计算过去30天到今天的范围
  private var pastDateRange: Range<Date> {
    let today = Date()
    let pastDate = calendar.date(byAdding: .day, value: -30, to: today) ?? today
    return pastDate..<today
  }

  // 计算特定月份的日期范围
  private var specificMonthRange: Range<Date> {
    let startDate =
      calendar.date(
        from: DateComponents(
          timeZone: timeZone,
          year: 2024,
          month: 12,
          day: 1
        )) ?? Date()

    let endDate =
      calendar.date(
        from: DateComponents(
          timeZone: timeZone,
          year: 2024,
          month: 12,
          day: 31
        )) ?? Date()

    return startDate..<endDate
  }

  @State private var selectedRangeType = 0

  public var body: some View {
    VStack(spacing: 20) {
      Text("日期范围限制")
        .font(.title2)
        .fontWeight(.semibold)

      // 范围类型选择器
      Picker("选择日期范围类型", selection: $selectedRangeType) {
        Text("未来30天").tag(0)
        Text("过去30天").tag(1)
        Text("2024年12月").tag(2)
      }
      .pickerStyle(.segmented)

      // 根据选择的类型显示不同的日期范围限制
      Group {
        switch selectedRangeType {
        case 0:
          // 限制在未来30天内
          MultiDatePicker(
            "选择未来30天内的日期",
            selection: $selectedDates,
            in: dateRange
          )
        case 1:
          // 限制在过去30天内
          MultiDatePicker(
            "选择过去30天内的日期",
            selection: $selectedDates,
            in: pastDateRange
          )
        case 2:
          // 限制在2024年12月
          MultiDatePicker(
            "选择2024年12月的日期",
            selection: $selectedDates,
            in: specificMonthRange
          )
        default:
          EmptyView()
        }
      }
      .frame(maxHeight: 350)
      .onChange(of: selectedRangeType) { _ in
        // 切换范围类型时清除之前的选择
        selectedDates.removeAll()
      }

      // 显示当前范围信息
      VStack(alignment: .leading, spacing: 4) {
        Text("当前可选范围：")
          .font(.caption)
          .foregroundColor(.secondary)

        let currentRange =
          selectedRangeType == 0
          ? dateRange : selectedRangeType == 1 ? pastDateRange : specificMonthRange

        Text("\(currentRange.lowerBound, style: .date) - \(currentRange.upperBound, style: .date)")
          .font(.caption)
          .foregroundColor(.blue)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      // 显示选中的日期
      if !selectedDates.isEmpty {
        VStack(alignment: .leading, spacing: 8) {
          Text("已选择 \(selectedDates.count) 个日期：")
            .font(.headline)

          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(
                Array(
                  selectedDates.compactMap { dateComponents in
                    calendar.date(from: dateComponents)
                  }.sorted()), id: \.self
              ) { date in
                Text(date, style: .date)
                  .font(.caption)
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .background(Color.green.opacity(0.2))
                  .cornerRadius(6)
              }
            }
            .padding(.horizontal)
          }
        }
      }

      Button("清除选择") {
        selectedDates.removeAll()
      }
      .buttonStyle(.bordered)
      .disabled(selectedDates.isEmpty)

      Spacer()
    }
    .padding()
    .navigationTitle("日期范围限制")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NavigationView {
    MultiDatePickerExampleView02()
  }
}
