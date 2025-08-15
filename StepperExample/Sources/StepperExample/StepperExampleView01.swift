import SwiftUI

/// 基础 Stepper 示例
/// 展示 Stepper 的基本用法，使用 onIncrement 和 onDecrement 闭包
public struct StepperExampleView01: View {
  // 状态变量，用于存储当前值
  @State private var value = 0

  // 颜色数组，用于演示步进器的视觉效果
  let colors: [Color] = [.orange, .red, .gray, .blue, .green, .purple, .pink]

  public init() {}

  /// 增加步骤的函数
  /// 当值达到颜色数组的最大索引时，重置为 0（循环）
  func incrementStep() {
    value += 1
    if value >= colors.count {
      value = 0
    }
  }

  /// 减少步骤的函数
  /// 当值小于 0 时，设置为颜色数组的最后一个索引（循环）
  func decrementStep() {
    value -= 1
    if value < 0 {
      value = colors.count - 1
    }
  }

  public var body: some View {
    VStack(spacing: 30) {
      // 标题
      Text("基础 Stepper 示例")
        .font(.largeTitle)
        .fontWeight(.bold)

      // 当前状态显示
      VStack(spacing: 10) {
        Text("当前值: \(value)")
          .font(.title2)
          .fontWeight(.semibold)

        Text("颜色: \(colors[value].description)")
          .font(.body)
          .foregroundColor(.secondary)
      }
      .padding()
      .background(colors[value].opacity(0.3))
      .cornerRadius(12)

      // 基础 Stepper - 使用自定义增减逻辑
      Stepper {
        HStack {
          Image(systemName: "paintpalette.fill")
            .foregroundColor(colors[value])
          Text("调整颜色索引")
            .fontWeight(.medium)
        }
      } onIncrement: {
        // 点击增加按钮时执行
        incrementStep()
      } onDecrement: {
        // 点击减少按钮时执行
        decrementStep()
      }
      .padding()
      .background(colors[value].opacity(0.1))
      .cornerRadius(8)

      // 说明文本
      VStack(alignment: .leading, spacing: 8) {
        Text("功能说明:")
          .font(.headline)
          .fontWeight(.semibold)

        Text("• 使用 onIncrement 和 onDecrement 闭包")
        Text("• 实现自定义的循环逻辑")
        Text("• 当达到边界时自动循环到另一端")
        Text("• 背景颜色随当前值变化")
      }
      .font(.body)
      .foregroundColor(.secondary)
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(8)

      Spacer()
    }
    .padding()
    .navigationTitle("基础示例")
    #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

#Preview {
  NavigationView {
    StepperExampleView01()
  }
}
