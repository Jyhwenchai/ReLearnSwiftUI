import SwiftUI

/// MultiDatePicker 基础示例
/// 展示最基本的多日期选择器用法
public struct MultiDatePickerExampleView01: View {
  // 使用 Set<DateComponents> 存储选中的日期
  // DateComponents 包含日期的各个组成部分（年、月、日等）
  @State private var selectedDates: Set<DateComponents> = []

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      Text("基础多日期选择器")
        .font(.title2)
        .fontWeight(.semibold)

      // 基础的 MultiDatePicker
      // 第一个参数是标签文本，第二个参数是绑定的选中日期集合
      MultiDatePicker(
        "选择多个日期",
        selection: $selectedDates
      )
      .frame(maxHeight: 400)  // 限制高度以适应布局

      // 显示选中的日期数量
      Text("已选择 \(selectedDates.count) 个日期")
        .foregroundColor(.secondary)

      // 显示选中的日期列表
      if !selectedDates.isEmpty {
        VStack(alignment: .leading, spacing: 8) {
          Text("选中的日期：")
            .font(.headline)

          // 将 DateComponents 转换为 Date 并格式化显示
          ForEach(
            Array(
              selectedDates.compactMap { dateComponents in
                Calendar.current.date(from: dateComponents)
              }.sorted()), id: \.self
          ) { date in
            Text(date, style: .date)
              .padding(.horizontal, 12)
              .padding(.vertical, 4)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(8)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }

      // 清除选择按钮
      Button("清除所有选择") {
        selectedDates.removeAll()
      }
      .buttonStyle(.bordered)
      .disabled(selectedDates.isEmpty)

      Spacer()
    }
    .padding()
    .navigationTitle("基础示例")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NavigationView {
    MultiDatePickerExampleView01()
  }
}
