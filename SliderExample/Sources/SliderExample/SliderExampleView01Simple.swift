import SwiftUI

/// SliderExampleView01Simple - 简化的基础 Slider 示例
/// 演示 Slider 的基本用法，兼容 iOS 13+
@available(iOS 13.0, *)
public struct SliderExampleView01Simple: View {
  // MARK: - 状态属性

  /// 温度值，使用 @State 进行状态管理
  @State private var temperature: Double = 20.0

  /// 音量值，演示不同的数值范围
  @State private var volume: Double = 0.5

  /// 进度值，演示百分比显示
  @State private var progress: Double = 0.3

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 30) {
        // MARK: - 标题
        Text("基础 Slider 示例")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom, 20)

        // MARK: - 温度控制 Slider
        VStack(alignment: .leading, spacing: 10) {
          Text("温度控制")
            .font(.headline)
            .foregroundColor(.primary)

          // 基础 Slider，范围从 0 到 40 度
          Slider(value: $temperature, in: 0...40)
            .accentColor(.orange)  // 设置滑块颜色为橙色

          // 显示当前温度值
          Text("当前温度: \(temperature, specifier: "%.1f")°C")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        // MARK: - 音量控制 Slider
        VStack(alignment: .leading, spacing: 10) {
          Text("音量控制")
            .font(.headline)
            .foregroundColor(.primary)

          // 音量 Slider，范围从 0.0 到 1.0
          Slider(value: $volume, in: 0.0...1.0)
            .accentColor(.blue)

          // 显示当前音量百分比
          Text("音量: \(Int(volume * 100))%")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        // MARK: - 进度控制 Slider
        VStack(alignment: .leading, spacing: 10) {
          Text("进度设置")
            .font(.headline)
            .foregroundColor(.primary)

          // 进度 Slider，范围从 0.0 到 1.0
          Slider(value: $progress, in: 0.0...1.0)
            .accentColor(.green)

          // 显示当前进度
          HStack {
            Text("进度: \(Int(progress * 100))%")
              .font(.subheadline)
              .foregroundColor(.secondary)

            Spacer()

            // 简单的进度条可视化
            RoundedRectangle(cornerRadius: 2)
              .fill(Color.green)
              .frame(width: CGFloat(progress * 100), height: 4)
              .frame(width: 100, alignment: .leading)
              .background(Color.gray.opacity(0.3))
              .cornerRadius(2)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        Spacer()
      }
      .padding()
      .modifier(CrossPlatformNavigationTitle(title: "基础 Slider"))
    }
  }
}

// MARK: - 预览
#Preview {
  SliderExampleView01Simple()
}
