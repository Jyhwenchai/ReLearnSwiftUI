import SwiftUI

/// SharePreview 基础示例
///
/// 本示例演示：
/// 1. SharePreview 的基本创建方法
/// 2. 与 ShareLink 的基本集成
/// 3. 不同初始化方式的使用
/// 4. 基础预览效果展示
public struct SharePreviewExampleView01: View {

  // MARK: - 状态属性

  /// 要分享的文本内容
  @State private var shareText = "Hello, SwiftUI!"

  /// 要分享的 URL
  @State private var shareURL = URL(string: "https://developer.apple.com/swiftui/")!

  /// 自定义分享消息
  @State private var customMessage = "Check out this amazing SwiftUI resource!"

  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 30) {

          // MARK: - 标题区域
          headerSection

          // MARK: - 基础文本分享
          basicTextShareSection

          // MARK: - URL 分享
          urlShareSection

          // MARK: - 仅标题预览
          titleOnlyPreviewSection

          // MARK: - 带图片的预览
          imagePreviewSection

          Spacer(minLength: 50)
        }
        .padding()
      }
      .navigationTitle("SharePreview 基础")
      .navigationBarTitleDisplayMode(.large)
    }
  }

  // MARK: - 视图组件

  /// 标题区域
  private var headerSection: some View {
    VStack(spacing: 16) {
      Image(systemName: "square.and.arrow.up")
        .font(.system(size: 50))
        .foregroundColor(.blue)

      Text("SharePreview 基础示例")
        .font(.title2)
        .fontWeight(.bold)

      Text("学习 SharePreview 的基本创建和使用方法")
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 基础文本分享区域
  private var basicTextShareSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("1. 基础文本分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("最简单的 SharePreview 使用方式，只包含标题信息。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      // 可编辑的分享文本
      TextField("输入要分享的文本", text: $shareText)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      // 基础分享按钮
      ShareLink(
        item: shareText,
        preview: SharePreview("分享文本")
      ) {
        HStack {
          Image(systemName: "square.and.arrow.up")
          Text("分享文本")
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(8)
      }

      // 代码示例
      codeExample(
        """
        ShareLink(
            item: shareText,
            preview: SharePreview("分享文本")
        ) {
            // 自定义按钮样式
        }
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// URL 分享区域
  private var urlShareSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("2. URL 分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("分享 URL 链接，系统会自动获取网页元数据，或使用自定义预览。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      // URL 输入框
      TextField(
        "输入 URL",
        text: Binding(
          get: { shareURL.absoluteString },
          set: { shareURL = URL(string: $0) ?? shareURL }
        )
      )
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .keyboardType(.URL)
      .autocapitalization(.none)

      HStack(spacing: 16) {
        // 系统自动预览
        ShareLink(item: shareURL) {
          VStack {
            Image(systemName: "link")
            Text("系统预览")
              .font(.caption)
          }
          .foregroundColor(.white)
          .padding()
          .background(Color.green)
          .cornerRadius(8)
        }

        // 自定义预览
        ShareLink(
          item: shareURL,
          preview: SharePreview(
            "SwiftUI 官方文档",
            image: Image(systemName: "swift")
          )
        ) {
          VStack {
            Image(systemName: "square.and.arrow.up")
            Text("自定义预览")
              .font(.caption)
          }
          .foregroundColor(.white)
          .padding()
          .background(Color.orange)
          .cornerRadius(8)
        }
      }

      // 代码示例
      codeExample(
        """
        // 系统自动预览
        ShareLink(item: url)

        // 自定义预览
        ShareLink(
            item: url,
            preview: SharePreview(
                "SwiftUI 官方文档",
                image: Image(systemName: "swift")
            )
        )
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 仅标题预览区域
  private var titleOnlyPreviewSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("3. 仅标题预览")
        .font(.headline)
        .foregroundColor(.primary)

      Text("使用 SharePreview 的最简单形式，只提供标题信息。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      // 自定义消息输入
      TextField("输入自定义消息", text: $customMessage)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      ShareLink(
        item: customMessage,
        preview: SharePreview(Text(customMessage))
      ) {
        HStack {
          Image(systemName: "text.bubble")
          Text("分享消息")
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.purple)
        .cornerRadius(8)
      }

      // 代码示例
      codeExample(
        """
        SharePreview(Text("标题文本"))

        // 或者使用字符串字面量
        SharePreview("标题文本")
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 带图片的预览区域
  private var imagePreviewSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("4. 带图片的预览")
        .font(.headline)
        .foregroundColor(.primary)

      Text("为分享预览添加图片，提供更丰富的视觉效果。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      HStack(spacing: 16) {
        // SF Symbol 图片预览
        ShareLink(
          item: "SwiftUI 是苹果的现代 UI 框架",
          preview: SharePreview(
            "SwiftUI 框架",
            image: Image(systemName: "swift")
          )
        ) {
          VStack {
            Image(systemName: "swift")
              .font(.title)
            Text("Swift 图标")
              .font(.caption)
          }
          .foregroundColor(.white)
          .padding()
          .background(Color.red)
          .cornerRadius(8)
        }

        // 系统图标预览
        ShareLink(
          item: "探索 iOS 开发的精彩世界",
          preview: SharePreview(
            "iOS 开发",
            image: Image(systemName: "iphone")
          )
        ) {
          VStack {
            Image(systemName: "iphone")
              .font(.title)
            Text("iPhone 图标")
              .font(.caption)
          }
          .foregroundColor(.white)
          .padding()
          .background(Color.indigo)
          .cornerRadius(8)
        }
      }

      // 代码示例
      codeExample(
        """
        SharePreview(
            "标题文本",
            image: Image(systemName: "swift")
        )
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 代码示例组件
  private func codeExample(_ code: String) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("代码示例:")
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundColor(.secondary)

      Text(code)
        .font(.system(.caption, design: .monospaced))
        .padding(12)
        .background(Color(.systemGray5))
        .cornerRadius(8)
    }
  }
}

// MARK: - 预览

#Preview {
  SharePreviewExampleView01()
}
