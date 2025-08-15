import SwiftUI

/// SliderExampleView03Simple - 步进 Slider 示例
/// 演示如何使用 step 参数创建离散值选择的 Slider，兼容 iOS 13+
@available(iOS 13.0, *)
public struct SliderExampleView03Simple: View {
  // MARK: - 状态属性

  /// 评分值，步进为 0.5
  @State private var rating: Double = 3.0

  /// 数量值，步进为 1
  @State private var quantity: Double = 5.0

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 30) {
        // MARK: - 标题
        Text("步进 Slider 示例")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom, 20)

        // MARK: - 评分 Slider（步进 0.5）
        VStack(alignment: .leading, spacing: 15) {
          Text("产品评分")
            .font(.headline)
            .foregroundColor(.primary)

          Slider(
            value: $rating,
            in: 1.0...5.0,
            step: 0.5  // 每次步进 0.5
          ) {
            Text("评分")
              .font(.caption)
          } minimumValueLabel: {
            Text("1")
              .font(.caption)
              .foregroundColor(.red)
          } maximumValueLabel: {
            Text("5")
              .font(.caption)
              .foregroundColor(.green)
          }

          // 星级显示
          HStack {
            CrossPlatformStarRating(rating: rating)

            Spacer()

            Text("\(rating, specifier: "%.1f") 星")
              .font(.subheadline)
              .foregroundColor(.secondary)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        // MARK: - 数量 Slider（步进 1）
        VStack(alignment: .leading, spacing: 15) {
          Text("商品数量")
            .font(.headline)
            .foregroundColor(.primary)

          Slider(
            value: $quantity,
            in: 1...20,
            step: 1  // 每次步进 1
          ) {
            Text("数量")
              .font(.caption)
          } minimumValueLabel: {
            Text("1")
              .font(.caption)
          } maximumValueLabel: {
            Text("20")
              .font(.caption)
          }

          HStack {
            Text("选择数量: \(Int(quantity)) 件")
              .font(.subheadline)
              .foregroundColor(.secondary)

            Spacer()

            // 数量可视化
            HStack(spacing: 2) {
              ForEach(1...min(Int(quantity), 10), id: \.self) { _ in
                Circle()
                  .fill(Color.blue)
                  .frame(width: 8, height: 8)
              }
              if quantity > 10 {
                Text("+\(Int(quantity) - 10)")
                  .font(.caption)
                  .foregroundColor(.blue)
              }
            }
          }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        Spacer()
      }
      .padding()
      .modifier(CrossPlatformNavigationTitle(title: "步进 Slider"))
    }
  }
}

// MARK: - 预览
#Preview {
  SliderExampleView03Simple()
}
