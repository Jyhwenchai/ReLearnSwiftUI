import SwiftUI

/// 数值绑定示例
/// 展示 Stepper 与数值绑定的使用，包括步长设置和格式化
public struct StepperExampleView02: View {
  // 整数值绑定
  @State private var intValue = 10

  // 浮点数值绑定
  @State private var doubleValue = 5.0

  // 自定义步长
  @State private var customStepValue = 0

  // 编辑状态
  @State private var isEditing = false

  public init() {}

  public var body: some View {
    VStack(spacing: 25) {
      // 标题
      Text("数值绑定示例")
        .font(.largeTitle)
        .fontWeight(.bold)

      ScrollView {
        VStack(spacing: 20) {
          // 基础整数 Stepper
          stepperSection(
            title: "整数步进器",
            description: "默认步长为 1"
          ) {
            Stepper(
              value: $intValue,
              step: 1
            ) {
              HStack {
                Image(systemName: "number.circle.fill")
                  .foregroundColor(.blue)
                Text("整数值: \(intValue)")
                  .fontWeight(.medium)
              }
            }
          }

          // 浮点数 Stepper 带格式化
          stepperSection(
            title: "浮点数步进器",
            description: "步长为 0.5，显示一位小数"
          ) {
            Stepper(
              value: $doubleValue,
              step: 0.5
            ) {
              HStack {
                Image(systemName: "point.3.connected.trianglepath.dotted")
                  .foregroundColor(.green)
                Text("浮点值: \(doubleValue, specifier: "%.1f")")
                  .fontWeight(.medium)
              }
            }
          }

          // 自定义步长 Stepper
          stepperSection(
            title: "自定义步长",
            description: "步长为 5"
          ) {
            Stepper(
              value: $customStepValue,
              step: 5
            ) {
              HStack {
                Image(systemName: "plus.forwardslash.minus")
                  .foregroundColor(.orange)
                Text("步长5: \(customStepValue)")
                  .fontWeight(.medium)
              }
            }
          }

          // 带编辑状态回调的 Stepper
          stepperSection(
            title: "编辑状态监听",
            description: "监听编辑开始和结束"
          ) {
            VStack(alignment: .leading, spacing: 8) {
              Stepper(
                value: $intValue,
                step: 2,
                onEditingChanged: { editing in
                  isEditing = editing
                }
              ) {
                HStack {
                  Image(systemName: isEditing ? "pencil.circle.fill" : "checkmark.circle.fill")
                    .foregroundColor(isEditing ? .orange : .green)
                  Text("值: \(intValue)")
                    .fontWeight(.medium)
                }
              }

              Text("编辑状态: \(isEditing ? "正在编辑" : "未编辑")")
                .font(.caption)
                .foregroundColor(isEditing ? .orange : .green)
            }
          }

          // 数值显示卡片
          VStack(spacing: 12) {
            Text("当前所有数值")
              .font(.headline)
              .fontWeight(.semibold)

            HStack(spacing: 15) {
              valueCard("整数", "\(intValue)", .blue)
              valueCard("浮点", String(format: "%.1f", doubleValue), .green)
              valueCard("步长5", "\(customStepValue)", .orange)
            }
          }
          .padding()
          .background(Color.gray.opacity(0.1))
          .cornerRadius(12)
        }
      }
    }
    .padding()
    .navigationTitle("数值绑定")
    #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  /// 创建步进器区域的辅助函数
  @ViewBuilder
  private func stepperSection<Content: View>(
    title: String,
    description: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.headline)
        .fontWeight(.semibold)

      Text(description)
        .font(.caption)
        .foregroundColor(.secondary)

      content()
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
    }
  }

  /// 创建数值卡片的辅助函数
  @ViewBuilder
  private func valueCard(_ title: String, _ value: String, _ color: Color) -> some View {
    VStack(spacing: 4) {
      Text(title)
        .font(.caption)
        .foregroundColor(.secondary)
      Text(value)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundColor(color)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
    .background(color.opacity(0.1))
    .cornerRadius(8)
  }
}

#Preview {
  NavigationView {
    StepperExampleView02()
  }
}
