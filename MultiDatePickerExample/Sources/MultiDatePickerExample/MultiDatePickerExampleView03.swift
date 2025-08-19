import SwiftUI

/// MultiDatePicker 环境值定制示例
/// 展示如何通过环境值定制 locale、calendar 和 timeZone
public struct MultiDatePickerExampleView03: View {
  @State private var selectedDates: Set<DateComponents> = []
  @State private var selectedLocale = 0
  @State private var selectedCalendar = 0
  @State private var selectedTimeZone = 0

  public init() {}

  // 预定义的 locale 选项
  private let locales = [
    ("简体中文", Locale(identifier: "zh-Hans")),
    ("English", Locale(identifier: "en")),
    ("日本語", Locale(identifier: "ja")),
    ("Français", Locale(identifier: "fr")),
    ("Deutsch", Locale(identifier: "de")),
  ]

  // 预定义的 calendar 选项
  private let calendars = [
    ("公历", Calendar(identifier: .gregorian)),
    ("中国农历", Calendar(identifier: .chinese)),
    ("日本历", Calendar(identifier: .japanese)),
    ("伊斯兰历", Calendar(identifier: .islamicCivil)),
    ("希伯来历", Calendar(identifier: .hebrew)),
  ]

  // 预定义的 timeZone 选项
  private let timeZones = [
    ("北京时间", TimeZone(identifier: "Asia/Shanghai")!),
    ("UTC", TimeZone(identifier: "UTC")!),
    ("纽约时间", TimeZone(identifier: "America/New_York")!),
    ("东京时间", TimeZone(identifier: "Asia/Tokyo")!),
    ("伦敦时间", TimeZone(identifier: "Europe/London")!),
  ]

  public var body: some View {
    VStack(spacing: 16) {
      Text("环境值定制")
        .font(.title2)
        .fontWeight(.semibold)

      // 环境设置选择器
      VStack(spacing: 12) {
        // Locale 选择器
        VStack(alignment: .leading, spacing: 4) {
          Text("语言/地区 (Locale)")
            .font(.caption)
            .foregroundColor(.secondary)

          Picker("Locale", selection: $selectedLocale) {
            ForEach(0..<locales.count, id: \.self) { index in
              Text(locales[index].0).tag(index)
            }
          }
          .pickerStyle(.menu)
        }

        // Calendar 选择器
        VStack(alignment: .leading, spacing: 4) {
          Text("日历系统 (Calendar)")
            .font(.caption)
            .foregroundColor(.secondary)

          Picker("Calendar", selection: $selectedCalendar) {
            ForEach(0..<calendars.count, id: \.self) { index in
              Text(calendars[index].0).tag(index)
            }
          }
          .pickerStyle(.menu)
        }

        // TimeZone 选择器
        VStack(alignment: .leading, spacing: 4) {
          Text("时区 (TimeZone)")
            .font(.caption)
            .foregroundColor(.secondary)

          Picker("TimeZone", selection: $selectedTimeZone) {
            ForEach(0..<timeZones.count, id: \.self) { index in
              Text(timeZones[index].0).tag(index)
            }
          }
          .pickerStyle(.menu)
        }
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(12)

      // 应用环境值的 MultiDatePicker
      MultiDatePicker(
        "选择日期",
        selection: $selectedDates
      )
      .environment(\.locale, locales[selectedLocale].1)
      .environment(\.calendar, calendars[selectedCalendar].1)
      .environment(\.timeZone, timeZones[selectedTimeZone].1)
      .frame(maxHeight: 300)
      .onChange(of: selectedLocale) { _ in selectedDates.removeAll() }
      .onChange(of: selectedCalendar) { _ in selectedDates.removeAll() }
      .onChange(of: selectedTimeZone) { _ in selectedDates.removeAll() }

      // 显示当前环境设置
      VStack(alignment: .leading, spacing: 4) {
        Text("当前环境设置：")
          .font(.caption)
          .fontWeight(.semibold)

        Text("• 语言: \(locales[selectedLocale].0)")
          .font(.caption2)
        Text("• 日历: \(calendars[selectedCalendar].0)")
          .font(.caption2)
        Text("• 时区: \(timeZones[selectedTimeZone].0)")
          .font(.caption2)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding()
      .background(Color.blue.opacity(0.1))
      .cornerRadius(8)

      // 显示选中的日期（使用当前环境设置格式化）
      if !selectedDates.isEmpty {
        VStack(alignment: .leading, spacing: 8) {
          Text("选中的日期 (\(selectedDates.count) 个)：")
            .font(.headline)

          ForEach(
            Array(
              selectedDates.compactMap { dateComponents in
                calendars[selectedCalendar].1.date(from: dateComponents)
              }.sorted()), id: \.self
          ) { date in
            // 使用当前选择的环境值格式化日期
            Text(formatDate(date))
              .font(.caption)
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .background(Color.orange.opacity(0.2))
              .cornerRadius(6)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }

      Button("清除选择") {
        selectedDates.removeAll()
      }
      .buttonStyle(.bordered)
      .disabled(selectedDates.isEmpty)

      Spacer()
    }
    .padding()
    .navigationTitle("环境值定制")
    .navigationBarTitleDisplayMode(.inline)
  }

  // 使用当前环境设置格式化日期
  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = locales[selectedLocale].1
    formatter.calendar = calendars[selectedCalendar].1
    formatter.timeZone = timeZones[selectedTimeZone].1
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
}

#Preview {
  NavigationView {
    MultiDatePickerExampleView03()
  }
}
