import SwiftUI
import UniformTypeIdentifiers

/// ShareLink 示例 4：高级功能和实际应用
///
/// 本示例展示 ShareLink 的高级功能：
/// - 预填充主题和消息
/// - 复杂的 Transferable 实现
/// - 实际应用场景模拟
/// - 错误处理和用户体验优化
@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
public struct ShareLinkExampleView04: View {

  // MARK: - 复杂数据模型

  /// 文章模型
  struct Article: Transferable {
    let title: String
    let author: String
    let content: String
    let publishDate: Date
    let tags: [String]
    let url: URL?

    static var transferRepresentation: some TransferRepresentation {
      // 作为文本分享
      DataRepresentation(contentType: .plainText) { article in
        let text = """
          📖 \(article.title)
          ✍️ 作者：\(article.author)
          📅 发布：\(article.publishDate.formatted(date: .abbreviated, time: .omitted))
          🏷️ 标签：\(article.tags.joined(separator: ", "))

          \(article.content)
          """
        return text.data(using: .utf8) ?? Data()
      } importing: { data in
        let content = String(data: data, encoding: .utf8) ?? ""
        return Article(
          title: "导入的文章",
          author: "未知作者",
          content: content,
          publishDate: Date(),
          tags: [],
          url: nil
        )
      }
    }
  }

  /// 产品信息模型
  struct Product: Transferable {
    let name: String
    let price: Double
    let description: String
    let imageURL: URL?
    let category: String

    static var transferRepresentation: some TransferRepresentation {
      DataRepresentation(contentType: .plainText) { product in
        let text = """
          🛍️ \(product.name)
          💰 价格：¥\(String(format: "%.2f", product.price))
          📂 分类：\(product.category)

          📝 描述：
          \(product.description)
          """
        return text.data(using: .utf8) ?? Data()
      } importing: { data in
        let content = String(data: data, encoding: .utf8) ?? ""
        return Product(
          name: "导入的产品",
          price: 0.0,
          description: content,
          imageURL: nil,
          category: "未分类"
        )
      }
    }
  }

  // MARK: - 状态属性

  /// 示例文章
  private let sampleArticle = Article(
    title: "SwiftUI ShareLink 完全指南",
    author: "iOS 开发者",
    content: "ShareLink 是 SwiftUI 中一个强大的分享组件。",
    publishDate: Date(),
    tags: ["SwiftUI", "iOS", "分享", "教程"],
    url: URL(string: "https://developer.apple.com/documentation/swiftui/sharelink")
  )

  /// 示例产品
  private let sampleProduct = Product(
    name: "SwiftUI 开发教程",
    price: 99.99,
    description: "全面学习 SwiftUI 开发的完整教程。",
    imageURL: URL(string: "https://example.com/product-image.jpg"),
    category: "教育"
  )

  /// 用户反馈状态
  @State private var showingShareSuccess = false
  @State private var shareCount = 0

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {

        // MARK: - 预填充主题和消息

        VStack(alignment: .leading, spacing: 15) {
          Text("预填充主题和消息")
            .font(.headline)
            .foregroundColor(.primary)

          Text("为邮件和消息应用预填充主题和内容")
            .font(.subheadline)
            .foregroundColor(.secondary)

          ShareLink(
            item: sampleArticle,
            subject: Text("推荐阅读：\(sampleArticle.title)"),
            message: Text("我发现了一篇很棒的文章，推荐给你阅读！"),
            preview: SharePreview(
              sampleArticle.title,
              icon: Image(systemName: "doc.text")
            )
          ) {
            VStack(alignment: .leading, spacing: 8) {
              HStack {
                Image(systemName: "doc.text.fill")
                  .foregroundColor(.blue)

                Text(sampleArticle.title)
                  .font(.subheadline)
                  .fontWeight(.medium)
                  .lineLimit(2)

                Spacer()
              }

              Text("作者：\(sampleArticle.author)")
                .font(.caption)
                .foregroundColor(.secondary)

              HStack {
                ForEach(sampleArticle.tags.prefix(3), id: \.self) { tag in
                  Text(tag)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(4)
                }

                Spacer()

                Label("分享文章", systemImage: "square.and.arrow.up")
                  .font(.caption)
                  .foregroundColor(.blue)
              }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
          }
        }

        // MARK: - 产品分享场景

        VStack(alignment: .leading, spacing: 15) {
          Text("电商产品分享")
            .font(.headline)
            .foregroundColor(.primary)

          Text("模拟电商应用中的产品分享功能")
            .font(.subheadline)
            .foregroundColor(.secondary)

          ShareLink(
            item: sampleProduct,
            subject: Text("看看这个好产品：\(sampleProduct.name)"),
            message: Text("我在应用中发现了这个产品，觉得你可能会感兴趣！"),
            preview: SharePreview(
              sampleProduct.name,
              icon: Image(systemName: "bag")
            )
          ) {
            HStack(spacing: 15) {
              // 产品图片占位符
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(
                  Image(systemName: "bag.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
                )

              VStack(alignment: .leading, spacing: 4) {
                Text(sampleProduct.name)
                  .font(.subheadline)
                  .fontWeight(.medium)
                  .lineLimit(2)

                Text("¥\(String(format: "%.2f", sampleProduct.price))")
                  .font(.headline)
                  .foregroundColor(.red)

                Text(sampleProduct.category)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              VStack {
                Image(systemName: "square.and.arrow.up.circle.fill")
                  .font(.title2)
                  .foregroundColor(.green)

                Text("分享")
                  .font(.caption)
                  .foregroundColor(.green)
              }
            }
            .padding()
            .background(Color(.systemBackground))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
            )
          }
        }

        // MARK: - 用户体验优化

        VStack(alignment: .leading, spacing: 15) {
          Text("用户体验优化")
            .font(.headline)
            .foregroundColor(.primary)

          Text("提供分享反馈和统计信息")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(spacing: 15) {
            HStack {
              VStack(alignment: .leading) {
                Text("分享统计")
                  .font(.subheadline)
                  .fontWeight(.medium)

                Text("已分享 \(shareCount) 次")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              Button(action: {
                shareCount += 1
                showingShareSuccess = true

                // 自动隐藏成功提示
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                  showingShareSuccess = false
                }
              }) {
                Label("模拟分享", systemImage: "square.and.arrow.up")
              }
              .buttonStyle(.borderedProminent)
            }

            if showingShareSuccess {
              HStack {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(.green)

                Text("分享成功！")
                  .font(.subheadline)
                  .foregroundColor(.green)

                Spacer()
              }
              .padding()
              .background(Color.green.opacity(0.1))
              .cornerRadius(8)
              .transition(.opacity)
            }
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        Spacer(minLength: 20)
      }
      .padding()
    }
    .navigationTitle("高级功能和实际应用")
    .navigationBarTitleDisplayMode(.inline)
    .animation(.easeInOut, value: showingShareSuccess)
  }
}

// MARK: - 预览

@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
#Preview {
  NavigationView {
    ShareLinkExampleView04()
  }
}
