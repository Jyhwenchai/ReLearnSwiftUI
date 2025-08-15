import SwiftUI

/// ShareLink 示例 3：样式和修饰符
///
/// 本示例展示 ShareLink 的样式定制：
/// - 自定义标签和图标
/// - 不同的视觉样式
/// - 按钮样式变化
/// - 颜色和字体定制
@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
public struct ShareLinkExampleView03: View {

  // MARK: - 状态属性

  /// 示例内容
  private let sampleURL = URL(
    string: "https://developer.apple.com/documentation/swiftui/sharelink")!
  private let sampleText = "探索 SwiftUI ShareLink 组件的强大功能和灵活的样式定制选项"

  /// 控制不同样式的显示状态
  @State private var showCompactStyle = true
  @State private var showColoredStyle = true
  @State private var showCustomIcon = true

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {

        // MARK: - 自定义标签样式

        VStack(alignment: .leading, spacing: 15) {
          Text("自定义标签样式")
            .font(.headline)
            .foregroundColor(.primary)

          Text("使用自定义视图作为 ShareLink 的标签")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(spacing: 15) {
            // 使用 Label 的标准样式
            ShareLink(item: sampleURL) {
              Label("分享链接", systemImage: "link")
                .font(.subheadline)
                .foregroundColor(.blue)
            }

            // 使用自定义图标
            ShareLink(item: sampleURL) {
              Label("分享到社交媒体", systemImage: "person.2.fill")
                .font(.subheadline)
                .foregroundColor(.purple)
            }

            // 纯文本样式
            ShareLink(item: sampleURL) {
              Text("点击分享")
                .font(.headline)
                .foregroundColor(.green)
                .underline()
            }

            // 图标加文本的水平布局
            ShareLink(item: sampleURL) {
              HStack {
                Image(systemName: "square.and.arrow.up.circle.fill")
                  .font(.title2)
                  .foregroundColor(.orange)

                Text("立即分享")
                  .font(.subheadline)
                  .fontWeight(.medium)
              }
            }
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 按钮样式变化

        VStack(alignment: .leading, spacing: 15) {
          Text("按钮样式变化")
            .font(.headline)
            .foregroundColor(.primary)

          Text("应用不同的按钮样式修饰符")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(spacing: 15) {
            // 填充样式按钮
            ShareLink("填充样式", item: sampleURL)
              .buttonStyle(.borderedProminent)
              .controlSize(.large)

            // 边框样式按钮
            ShareLink("边框样式", item: sampleURL)
              .buttonStyle(.bordered)
              .controlSize(.regular)

            // 紧凑样式按钮
            ShareLink("紧凑样式", item: sampleURL)
              .buttonStyle(.borderless)
              .controlSize(.small)

            // 自定义颜色的按钮
            ShareLink("自定义颜色", item: sampleURL)
              .buttonStyle(.borderedProminent)
              .tint(.red)
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 复杂自定义样式

        VStack(alignment: .leading, spacing: 15) {
          Text("复杂自定义样式")
            .font(.headline)
            .foregroundColor(.primary)

          Text("创建具有丰富视觉效果的分享按钮")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(spacing: 15) {
            // 卡片样式的分享按钮
            ShareLink(item: sampleText) {
              VStack(spacing: 8) {
                Image(systemName: "quote.bubble.fill")
                  .font(.title)
                  .foregroundColor(.white)

                Text("分享想法")
                  .font(.subheadline)
                  .fontWeight(.medium)
                  .foregroundColor(.white)
              }
              .frame(maxWidth: .infinity)
              .padding()
              .background(
                LinearGradient(
                  colors: [.blue, .purple],
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                )
              )
              .cornerRadius(15)
            }

            // 带阴影效果的按钮
            ShareLink(item: sampleURL) {
              HStack {
                Image(systemName: "paperplane.fill")
                  .font(.title2)

                Text("发送链接")
                  .font(.headline)
                  .fontWeight(.semibold)
              }
              .foregroundColor(.white)
              .padding(.horizontal, 20)
              .padding(.vertical, 12)
              .background(Color.green)
              .cornerRadius(25)
              .shadow(color: .green.opacity(0.3), radius: 5, x: 0, y: 3)
            }

            // 圆形图标按钮
            ShareLink(item: sampleURL) {
              Image(systemName: "square.and.arrow.up")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.orange)
                .clipShape(Circle())
                .shadow(radius: 3)
            }
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 响应式样式

        VStack(alignment: .leading, spacing: 15) {
          Text("响应式样式")
            .font(.headline)
            .foregroundColor(.primary)

          Text("根据设备和环境调整样式")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(spacing: 15) {
            // 根据设备类型调整样式
            ShareLink(item: sampleURL) {
              #if os(iOS)
                Label("iPhone 分享", systemImage: "iphone")
                  .font(.subheadline)
                  .foregroundColor(.blue)
              #elseif os(macOS)
                Label("Mac 分享", systemImage: "desktopcomputer")
                  .font(.subheadline)
                  .foregroundColor(.blue)
              #elseif os(watchOS)
                Label("Watch 分享", systemImage: "applewatch")
                  .font(.caption)
                  .foregroundColor(.blue)
              #else
                Label("通用分享", systemImage: "square.and.arrow.up")
                  .font(.subheadline)
                  .foregroundColor(.blue)
              #endif
            }

            // 动态字体大小支持
            ShareLink(item: sampleURL) {
              Text("支持动态字体")
                .font(.body)
                .foregroundColor(.primary)
            }
            .accessibilityLabel("分享链接，支持动态字体大小")

            // 暗黑模式适配
            ShareLink(item: sampleURL) {
              HStack {
                Image(systemName: "moon.fill")
                Text("暗黑模式适配")
              }
              .foregroundColor(.primary)
              .padding()
              .background(Color(.systemBackground))
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color(.systemGray4), lineWidth: 1)
              )
            }
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 样式最佳实践

        VStack(alignment: .leading, spacing: 15) {
          Text("样式最佳实践")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            StyleTipRow(
              icon: "eye",
              title: "视觉一致性",
              description: "保持与应用整体设计风格的一致性"
            )

            StyleTipRow(
              icon: "hand.tap",
              title: "触摸友好",
              description: "确保按钮有足够的触摸区域（至少 44pt）"
            )

            StyleTipRow(
              icon: "accessibility",
              title: "无障碍访问",
              description: "提供清晰的标签和适当的对比度"
            )

            StyleTipRow(
              icon: "iphone.and.arrow.forward",
              title: "跨平台适配",
              description: "考虑不同平台的设计规范差异"
            )

            StyleTipRow(
              icon: "paintbrush",
              title: "适度定制",
              description: "避免过度定制，保持系统原生体验"
            )
          }
          .padding()
          .background(Color.blue.opacity(0.1))
          .cornerRadius(10)
        }

        Spacer(minLength: 20)
      }
      .padding()
    }
    .navigationTitle("样式和修饰符")
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - 辅助视图

/// 样式提示行视图
@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
private struct StyleTipRow: View {
  let icon: String
  let title: String
  let description: String

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      Image(systemName: icon)
        .font(.system(size: 16))
        .foregroundColor(.blue)
        .frame(width: 20)

      VStack(alignment: .leading, spacing: 2) {
        Text(title)
          .font(.subheadline)
          .fontWeight(.medium)

        Text(description)
          .font(.caption)
          .foregroundColor(.secondary)
      }

      Spacer()
    }
  }
}

// MARK: - 预览

@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
#Preview {
  NavigationView {
    ShareLinkExampleView03()
  }
}
