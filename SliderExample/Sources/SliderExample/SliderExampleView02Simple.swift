import SwiftUI

/// SliderExampleView02Simple - 带标签的 Slider 示例
/// 演示如何为 Slider 添加标签，兼容 iOS 13+
@available(iOS 13.0, *)
public struct SliderExampleView02Simple: View {
  // MARK: - 状态属性

  /// 亮度值，范围 0-100
  @State private var brightness: Double = 50.0

  /// 字体大小，范围 12-36
  @State private var fontSize: Double = 16.0

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 30) {
        // MARK: - 标题
        Text("带标签的 Slider")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom, 20)

        // MARK: - 亮度控制 Slider（带完整标签）
        VStack(alignment: .leading, spacing: 15) {
          Text("屏幕亮度调节")
            .font(.headline)
            .foregroundColor(.primary)

          // 带主标签和最小/最大值标签的 Slider
          Slider(
            value: $brightness,
            in: 0...100
          ) {
            // 主标签
            Text("亮度")
              .font(.caption)
              .foregroundColor(.secondary)
          } minimumValueLabel: {
            // 最小值标签
            CrossPlatformIcon(systemName: "sun.min", fallbackText: "☀︎")
              .foregroundColor(.orange)
          } maximumValueLabel: {
            // 最大值标签
            CrossPlatformIcon(systemName: "sun.max.fill", fallbackText: "☀️")
              .foregroundColor(.orange)
          }

          // 当前值显示
          Text("当前亮度: \(Int(brightness))%")
            .font(.subheadline)
            .foregroundColor(.secondary)

          // 亮度效果演示
          Rectangle()
            .fill(Color.yellow)
            .frame(height: 20)
            .opacity(brightness / 100.0)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        // MARK: - 字体大小 Slider
        VStack(alignment: .leading, spacing: 15) {
          Text("字体大小调节")
            .font(.headline)
            .foregroundColor(.primary)

          Slider(
            value: $fontSize,
            in: 12...36
          ) {
            Text("字体大小")
              .font(.caption)
              .foregroundColor(.secondary)
          } minimumValueLabel: {
            Text("A")
              .font(.caption)
              .foregroundColor(.blue)
          } maximumValueLabel: {
            Text("A")
              .font(.title)
              .foregroundColor(.blue)
          }

          // 字体效果演示
          Text("示例文本 Sample Text")
            .font(.system(size: fontSize))
            .foregroundColor(.primary)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)

          Text("当前字体大小: \(Int(fontSize))pt")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        Spacer()
      }
      .padding()
      .modifier(CrossPlatformNavigationTitle(title: "带标签 Slider"))
    }
  }
}

// MARK: - 预览
#Preview {
  SliderExampleView02Simple()
}
