import SwiftUI

/// 简化的 DatePicker 示例
public struct DatePickerExampleSimple: View {

  @State private var selectedDate = Date()

  public var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text("DatePicker 基础示例")
          .font(.title)

        DatePicker(
          "选择日期",
          selection: $selectedDate,
          displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)

        Text("选中的日期:")
          .font(.headline)

        Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
          .font(.body)
          .foregroundColor(.blue)

        Spacer()
      }
      .padding()
      .navigationTitle("DatePicker 示例")
    }
  }

  public init() {}
}

#Preview {
  DatePickerExampleSimple()
}
