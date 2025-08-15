import SwiftUI

/// ShareLink 示例 1：基础分享功能
///
/// 本示例展示 ShareLink 的基本用法：
/// - 分享 URL 链接
/// - 分享纯文本内容
/// - 使用系统默认样式
/// - 自定义分享按钮标题
@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
public struct ShareLinkExampleView01: View {

  // MARK: - 状态属性

  /// 要分享的 URL
  private let sampleURL = URL(
    string: "https://developer.apple.com/documentation/swiftui/sharelink")!

  /// 要分享的文本内容
  private let sampleText = "学习 SwiftUI ShareLink 组件的使用方法和最佳实践"

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {

        // MARK: - 基础 URL 分享

        VStack(alignment: .leading, spacing: 15) {
          Text("基础 URL 分享")
            .font(.headline)
            .foregroundColor(.primary)

          Text("最简单的 ShareLink 用法，分享一个 URL 链接")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(alignment: .leading, spacing: 10) {
            // 使用系统默认样式的分享链接
            ShareLink(item: sampleURL)

            Text("• 使用系统默认的分享图标和样式")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("• 点击后会显示系统分享界面")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 自定义标题的 URL 分享

        VStack(alignment: .leading, spacing: 15) {
          Text("自定义标题分享")
            .font(.headline)
            .foregroundColor(.primary)

          Text("为分享链接添加自定义标题文本")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(alignment: .leading, spacing: 10) {
            // 带自定义标题的分享链接
            ShareLink("分享 SwiftUI 文档", item: sampleURL)

            Text("• 显示自定义的标题文本")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("• 保持系统标准的分享图标")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 文本内容分享

        VStack(alignment: .leading, spacing: 15) {
          Text("文本内容分享")
            .font(.headline)
            .foregroundColor(.primary)

          Text("分享纯文本内容，适用于分享想法、引用等")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(alignment: .leading, spacing: 10) {
            // 分享文本内容
            ShareLink("分享学习笔记", item: sampleText)

            Text("• 分享的文本：\"\(sampleText)\"")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("• 系统会根据内容类型显示合适的分享选项")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 使用说明

        VStack(alignment: .leading, spacing: 15) {
          Text("使用说明")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
              Text("1.")
                .foregroundColor(.blue)
                .fontWeight(.medium)
              Text("ShareLink 会自动检测内容类型并显示相应的分享选项")
            }

            HStack(alignment: .top, spacing: 8) {
              Text("2.")
                .foregroundColor(.blue)
                .fontWeight(.medium)
              Text("URL 分享时系统会自动获取网页标题和图标作为预览")
            }

            HStack(alignment: .top, spacing: 8) {
              Text("3.")
                .foregroundColor(.blue)
                .fontWeight(.medium)
              Text("文本分享适用于 Messages、Mail、Notes 等应用")
            }

            HStack(alignment: .top, spacing: 8) {
              Text("4.")
                .foregroundColor(.blue)
                .fontWeight(.medium)
              Text("ShareLink 需要 iOS 16.0+ 或 macOS 13.0+ 系统支持")
            }
          }
          .font(.subheadline)
          .foregroundColor(.secondary)
          .padding()
          .background(Color.blue.opacity(0.1))
          .cornerRadius(10)
        }

        Spacer(minLength: 20)
      }
      .padding()
    }
    .navigationTitle("基础分享功能")
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - 预览

@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
#Preview {
  NavigationView {
    ShareLinkExampleView01()
  }
}
