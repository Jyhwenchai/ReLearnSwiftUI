import SwiftUI

/// 范围限制示例
/// 展示 Stepper 的范围限制功能和边界处理
public struct StepperExampleView03: View {
  // 温度值（摄氏度）
  @State private var temperature = 20.0

  // 音量值（0-100）
  @State private var volume = 50

  // 评分值（1-5星）
  @State private var rating = 3

  // 进度值（0-100，步长10）
  @State private var progress = 50

  public init() {}

  public var body: some View {
    VStack(spacing: 25) {
      // 标题
      Text("范围限制示例")
        .font(.largeTitle)
        .fontWeight(.bold)

      ScrollView {
        VStack(spacing: 25) {
          // 温度控制器
          rangeSection(
            title: "温度控制",
            description: "范围: 0°C - 40°C，步长: 0.5°C",
            icon: "thermometer",
            color: .red
          ) {
            Stepper(
              value: $temperature,
              in: 0...40,
              step: 0.5,
              format: .number.precision(.fractionLength(1))
            ) {
              HStack {
                Image(systemName: temperatureIcon)
                  .foregroundColor(temperatureColor)
                Text("\(temperature, specifier: "%.1f")°C")
                  .fontWeight(.medium)
              }
            }

            // 温度指示器
            temperatureIndicator
          }

          // 音量控制器
          rangeSection(
            title: "音量控制",
            description: "范围: 0 - 100，步长: 5",
            icon: "speaker.wave.3",
            color: .blue
          ) {
            Stepper(
              value: $volume,
              in: 0...100,
              step: 5
            ) {
              HStack {
                Image(systemName: volumeIcon)
                  .foregroundColor(.blue)
                Text("音量: \(volume)%")
                  .fontWeight(.medium)
              }
            }

            // 音量进度条
            volumeProgressBar
          }

          // 评分控制器
          rangeSection(
            title: "评分控制",
            description: "范围: 1 - 5 星，步长: 1",
            icon: "star.fill",
            color: .yellow
          ) {
            Stepper(
              value: $rating,
              in: 1...5,
              step: 1
            ) {
              HStack {
                Image(systemName: "star.fill")
                  .foregroundColor(.yellow)
                Text("评分: \(rating) 星")
                  .fontWeight(.medium)
              }
            }

            // 星级显示
            starRating
          }

          // 进度控制器
          rangeSection(
            title: "进度控制",
            description: "范围: 0 - 100，步长: 10",
            icon: "chart.bar.fill",
            color: .green
          ) {
            Stepper(
              value: $progress,
              in: 0...100,
              step: 10
            ) {
              HStack {
                Image(systemName: "chart.bar.fill")
                  .foregroundColor(.green)
                Text("进度: \(progress)%")
                  .fontWeight(.medium)
              }
            }

            // 进度条
            progressBar
          }

          // 边界提示
          boundaryInfo
        }
      }
    }
    .padding()
    .navigationTitle("范围限制")
    #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  /// 创建范围区域的辅助函数
  @ViewBuilder
  private func rangeSection<Content: View>(
    title: String,
    description: String,
    icon: String,
    color: Color,
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Image(systemName: icon)
          .foregroundColor(color)
        Text(title)
          .font(.headline)
          .fontWeight(.semibold)
      }

      Text(description)
        .font(.caption)
        .foregroundColor(.secondary)

      content()
    }
    .padding()
    .background(color.opacity(0.05))
    .cornerRadius(12)
  }

  /// 温度图标
  private var temperatureIcon: String {
    switch temperature {
    case 0..<10: return "thermometer.snowflake"
    case 10..<25: return "thermometer"
    default: return "thermometer.sun"
    }
  }

  /// 温度颜色
  private var temperatureColor: Color {
    switch temperature {
    case 0..<10: return .blue
    case 10..<25: return .orange
    default: return .red
    }
  }

  /// 温度指示器
  private var temperatureIndicator: some View {
    HStack {
      Text("冷")
        .font(.caption)
        .foregroundColor(.blue)

      Rectangle()
        .fill(
          LinearGradient(
            colors: [.blue, .orange, .red],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .frame(height: 8)
        .cornerRadius(4)
        .overlay(
          Circle()
            .fill(Color.white)
            .frame(width: 12, height: 12)
            .shadow(radius: 2)
            .offset(x: CGFloat((temperature / 40.0) * 200 - 100))
        )

      Text("热")
        .font(.caption)
        .foregroundColor(.red)
    }
    .frame(width: 200)
  }

  /// 音量图标
  private var volumeIcon: String {
    switch volume {
    case 0: return "speaker.slash"
    case 1..<30: return "speaker.wave.1"
    case 30..<70: return "speaker.wave.2"
    default: return "speaker.wave.3"
    }
  }

  /// 音量进度条
  private var volumeProgressBar: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(Color.gray.opacity(0.3))
          .frame(height: 8)
          .cornerRadius(4)

        Rectangle()
          .fill(Color.blue)
          .frame(width: geometry.size.width * CGFloat(volume) / 100, height: 8)
          .cornerRadius(4)
      }
    }
    .frame(height: 8)
  }

  /// 星级评分显示
  private var starRating: some View {
    HStack(spacing: 4) {
      ForEach(1...5, id: \.self) { index in
        Image(systemName: index <= rating ? "star.fill" : "star")
          .foregroundColor(index <= rating ? .yellow : .gray)
          .font(.title2)
      }
    }
  }

  /// 进度条
  private var progressBar: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(Color.gray.opacity(0.3))
          .frame(height: 12)
          .cornerRadius(6)

        Rectangle()
          .fill(Color.green)
          .frame(width: geometry.size.width * CGFloat(progress) / 100, height: 12)
          .cornerRadius(6)

        Text("\(progress)%")
          .font(.caption2)
          .fontWeight(.bold)
          .foregroundColor(.white)
          .position(x: geometry.size.width * CGFloat(progress) / 100 / 2, y: 6)
      }
    }
    .frame(height: 12)
  }

  /// 边界信息
  private var boundaryInfo: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("边界处理说明:")
        .font(.headline)
        .fontWeight(.semibold)

      Text("• 当达到最小值时，减少按钮自动禁用")
      Text("• 当达到最大值时，增加按钮自动禁用")
      Text("• 步长确保值始终在有效范围内")
      Text("• 不同的步长适用于不同的使用场景")
    }
    .font(.body)
    .foregroundColor(.secondary)
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(8)
  }
}

#Preview {
  NavigationView {
    StepperExampleView03()
  }
}
