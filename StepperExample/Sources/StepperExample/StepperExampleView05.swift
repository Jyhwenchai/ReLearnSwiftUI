import SwiftUI

/// 样式定制示例
/// 展示 Stepper 的各种样式定制和视觉效果
public struct StepperExampleView05: View {
  @State private var value1 = 5
  @State private var value2 = 10.0
  @State private var value3 = 3
  @State private var value4 = 50
  @State private var value5 = 2

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      // 标题
      Text("样式定制示例")
        .font(.largeTitle)
        .fontWeight(.bold)

      ScrollView {
        VStack(spacing: 25) {
          // 经典样式
          classicStyleSection

          // 现代卡片样式
          modernCardStyleSection

          // 渐变背景样式
          gradientStyleSection

          // 圆角边框样式
          borderedStyleSection

          // 紧凑样式
          compactStyleSection

          // 自定义按钮样式
          customButtonStyleSection
        }
      }
    }
    .padding()
    .navigationTitle("样式定制")
    #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  /// 经典样式
  private var classicStyleSection: some View {
    styleSection(
      title: "经典样式",
      description: "传统的 Stepper 外观"
    ) {
      Stepper(
        value: $value1,
        in: 1...10,
        step: 1
      ) {
        HStack {
          Image(systemName: "star.fill")
            .foregroundColor(.yellow)
          Text("经典步进器: \(value1)")
            .font(.body)
            .fontWeight(.medium)
        }
      }
      .padding()
      .background(Color.white)
      .cornerRadius(8)
      .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
    }
  }

  /// 现代卡片样式
  private var modernCardStyleSection: some View {
    styleSection(
      title: "现代卡片样式",
      description: "带阴影和圆角的现代设计"
    ) {
      Stepper(
        value: $value2,
        in: 0...20,
        step: 0.5,
        format: .number.precision(.fractionLength(1))
      ) {
        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Image(systemName: "gauge.high")
              .foregroundColor(.blue)
              .font(.title2)
            Text("现代步进器")
              .font(.headline)
              .fontWeight(.semibold)
            Spacer()
          }

          Text("当前值: \(value2, specifier: "%.1f")")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.blue)

          Text("这是一个现代风格的步进器示例")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      .padding(20)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Color.white)
          .shadow(color: .blue.opacity(0.1), radius: 8, x: 0, y: 4)
      )
    }
  }

  /// 渐变背景样式
  private var gradientStyleSection: some View {
    styleSection(
      title: "渐变背景样式",
      description: "使用渐变色彩的视觉效果"
    ) {
      Stepper(
        value: $value3,
        in: 1...5,
        step: 1
      ) {
        HStack {
          Image(systemName: "flame.fill")
            .foregroundColor(.white)
            .font(.title2)

          VStack(alignment: .leading, spacing: 4) {
            Text("渐变步进器")
              .font(.headline)
              .fontWeight(.bold)
              .foregroundColor(.white)

            Text("级别 \(value3)")
              .font(.subheadline)
              .foregroundColor(.white.opacity(0.8))
          }

          Spacer()
        }
      }
      .padding(20)
      .background(
        LinearGradient(
          colors: [.orange, .red, .pink],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      )
      .cornerRadius(16)
      .shadow(color: .red.opacity(0.3), radius: 8, x: 0, y: 4)
    }
  }

  /// 圆角边框样式
  private var borderedStyleSection: some View {
    styleSection(
      title: "圆角边框样式",
      description: "带有彩色边框的设计"
    ) {
      Stepper(
        value: $value4,
        in: 0...100,
        step: 10
      ) {
        HStack {
          ZStack {
            Circle()
              .fill(Color.green.opacity(0.2))
              .frame(width: 40, height: 40)

            Image(systemName: "percent")
              .foregroundColor(.green)
              .font(.title3)
              .fontWeight(.bold)
          }

          VStack(alignment: .leading, spacing: 2) {
            Text("进度控制")
              .font(.headline)
              .fontWeight(.semibold)
              .foregroundColor(.green)

            Text("\(value4)% 完成")
              .font(.subheadline)
              .foregroundColor(.secondary)
          }

          Spacer()
        }
      }
      .padding(16)
      .background(Color.clear)
      .overlay(
        RoundedRectangle(cornerRadius: 12)
          .stroke(
            LinearGradient(
              colors: [.green, .mint],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: 2
          )
      )
      .background(Color.green.opacity(0.05))
      .cornerRadius(12)
    }
  }

  /// 紧凑样式
  private var compactStyleSection: some View {
    styleSection(
      title: "紧凑样式",
      description: "节省空间的紧凑设计"
    ) {
      VStack(spacing: 12) {
        // 水平紧凑布局
        HStack(spacing: 15) {
          compactStepper(
            value: $value5,
            range: 1...5,
            title: "评分",
            icon: "star.fill",
            color: .yellow
          )

          compactStepper(
            value: $value1,
            range: 1...10,
            title: "数量",
            icon: "number.circle.fill",
            color: .blue
          )
        }

        // 内联样式
        HStack {
          Text("快速调整:")
            .font(.headline)
            .fontWeight(.semibold)

          Spacer()

          Stepper(
            value: $value4,
            in: 0...100,
            step: 5
          ) {
            Text("\(value4)")
              .font(.title2)
              .fontWeight(.bold)
              .foregroundColor(.purple)
              .frame(minWidth: 40)
          }
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)
      }
    }
  }

  /// 自定义按钮样式
  private var customButtonStyleSection: some View {
    styleSection(
      title: "自定义按钮样式",
      description: "完全自定义的按钮外观"
    ) {
      VStack(spacing: 15) {
        // 大号按钮样式
        customButtonStepper(
          value: $value2,
          range: 0...20,
          step: 1,
          title: "音量控制",
          icon: "speaker.wave.2.fill",
          color: .indigo
        )

        // 圆形按钮样式
        circularButtonStepper(
          value: $value3,
          range: 1...10,
          title: "亮度",
          icon: "sun.max.fill",
          color: .orange
        )
      }
    }
  }

  /// 创建样式区域的辅助函数
  @ViewBuilder
  private func styleSection<Content: View>(
    title: String,
    description: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.headline)
          .fontWeight(.semibold)

        Text(description)
          .font(.caption)
          .foregroundColor(.secondary)
      }

      content()
    }
  }

  /// 紧凑步进器
  @ViewBuilder
  private func compactStepper(
    value: Binding<Int>,
    range: ClosedRange<Int>,
    title: String,
    icon: String,
    color: Color
  ) -> some View {
    VStack(spacing: 8) {
      HStack {
        Image(systemName: icon)
          .foregroundColor(color)
        Text(title)
          .font(.caption)
          .fontWeight(.medium)
      }

      Stepper(
        value: value,
        in: range,
        step: 1
      ) {
        Text("\(value.wrappedValue)")
          .font(.title2)
          .fontWeight(.bold)
          .foregroundColor(color)
          .frame(minWidth: 30)
      }
    }
    .padding()
    .background(color.opacity(0.1))
    .cornerRadius(12)
  }

  /// 自定义按钮步进器
  @ViewBuilder
  private func customButtonStepper(
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double,
    title: String,
    icon: String,
    color: Color
  ) -> some View {
    VStack(spacing: 12) {
      HStack {
        Image(systemName: icon)
          .foregroundColor(color)
          .font(.title2)
        Text(title)
          .font(.headline)
          .fontWeight(.semibold)
        Spacer()
        Text("\(Int(value.wrappedValue))")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(color)
      }

      HStack(spacing: 20) {
        // 自定义减少按钮
        Button(action: {
          if value.wrappedValue > range.lowerBound {
            value.wrappedValue -= step
          }
        }) {
          Image(systemName: "minus.circle.fill")
            .font(.title)
            .foregroundColor(value.wrappedValue > range.lowerBound ? color : .gray)
        }
        .disabled(value.wrappedValue <= range.lowerBound)

        Spacer()

        // 进度指示器
        ProgressView(value: value.wrappedValue, total: range.upperBound)
          .progressViewStyle(LinearProgressViewStyle(tint: color))
          .frame(height: 8)

        Spacer()

        // 自定义增加按钮
        Button(action: {
          if value.wrappedValue < range.upperBound {
            value.wrappedValue += step
          }
        }) {
          Image(systemName: "plus.circle.fill")
            .font(.title)
            .foregroundColor(value.wrappedValue < range.upperBound ? color : .gray)
        }
        .disabled(value.wrappedValue >= range.upperBound)
      }
    }
    .padding()
    .background(color.opacity(0.05))
    .cornerRadius(16)
  }

  /// 圆形按钮步进器
  @ViewBuilder
  private func circularButtonStepper(
    value: Binding<Int>,
    range: ClosedRange<Int>,
    title: String,
    icon: String,
    color: Color
  ) -> some View {
    HStack(spacing: 20) {
      // 减少按钮
      Button(action: {
        if value.wrappedValue > range.lowerBound {
          value.wrappedValue -= 1
        }
      }) {
        ZStack {
          Circle()
            .fill(value.wrappedValue > range.lowerBound ? color : Color.gray)
            .frame(width: 50, height: 50)

          Image(systemName: "minus")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
        }
      }
      .disabled(value.wrappedValue <= range.lowerBound)

      // 中央显示区域
      VStack(spacing: 4) {
        Image(systemName: icon)
          .font(.title)
          .foregroundColor(color)

        Text(title)
          .font(.caption)
          .fontWeight(.medium)

        Text("\(value.wrappedValue)")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(color)
      }
      .frame(minWidth: 80)

      // 增加按钮
      Button(action: {
        if value.wrappedValue < range.upperBound {
          value.wrappedValue += 1
        }
      }) {
        ZStack {
          Circle()
            .fill(value.wrappedValue < range.upperBound ? color : Color.gray)
            .frame(width: 50, height: 50)

          Image(systemName: "plus")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
        }
      }
      .disabled(value.wrappedValue >= range.upperBound)
    }
    .padding()
    .background(color.opacity(0.05))
    .cornerRadius(20)
  }
}

#Preview {
  NavigationView {
    StepperExampleView05()
  }
}
