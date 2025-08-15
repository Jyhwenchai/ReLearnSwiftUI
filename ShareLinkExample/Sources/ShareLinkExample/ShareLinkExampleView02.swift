import SwiftUI
import UniformTypeIdentifiers

/// ShareLink 示例 2：分享不同类型的内容
///
/// 本示例展示如何分享各种类型的内容：
/// - 图片内容分享
/// - 自定义 Transferable 类型
/// - 多个项目同时分享
/// - 文件内容分享
@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
public struct ShareLinkExampleView02: View {

  // MARK: - 自定义 Transferable 类型

  /// 自定义照片类型，符合 Transferable 协议
  struct Photo: Transferable {
    let image: Image
    let caption: String
    let metadata: String

    static var transferRepresentation: some TransferRepresentation {
      // 使用 ProxyRepresentation 将自定义类型转换为系统类型
      ProxyRepresentation(exporting: \.image)
    }
  }

  /// 自定义文档类型
  struct Document: Transferable {
    let title: String
    let content: String
    let createdDate: Date

    static var transferRepresentation: some TransferRepresentation {
      // 使用 DataRepresentation 提供数据表示
      DataRepresentation(contentType: .plainText) { document in
        let fullContent = """
          标题: \(document.title)
          创建时间: \(document.createdDate.formatted())

          内容:
          \(document.content)
          """
        return fullContent.data(using: .utf8) ?? Data()
      } importing: { data in
        // 简单的导入实现，实际应用中可以解析数据
        let content = String(data: data, encoding: .utf8) ?? ""
        return Document(title: "导入的文档", content: content, createdDate: Date())
      }
    }
  }

  // MARK: - 状态属性

  /// 示例照片
  private let samplePhoto = Photo(
    image: Image(systemName: "photo.fill"),
    caption: "美丽的风景照片",
    metadata: "拍摄于 2024 年春天"
  )

  /// 示例文档
  private let sampleDocument = Document(
    title: "SwiftUI 学习笔记",
    content: "ShareLink 是一个强大的分享组件，支持多种内容类型的分享。",
    createdDate: Date()
  )

  /// 多个 URL 项目
  private let multipleURLs = [
    URL(string: "https://developer.apple.com/documentation/swiftui/sharelink")!,
    URL(string: "https://developer.apple.com/documentation/swiftui/transferable")!,
    URL(string: "https://developer.apple.com/documentation/swiftui/sharepreview")!,
  ]

  /// 示例图片数据
  @State private var imageData: Data?

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {

        // MARK: - 图片分享

        VStack(alignment: .leading, spacing: 15) {
          Text("图片内容分享")
            .font(.headline)
            .foregroundColor(.primary)

          Text("分享图片内容，系统会显示支持图片的应用")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(alignment: .leading, spacing: 10) {
            HStack {
              // 显示示例图片
              Image(systemName: "photo.fill")
                .font(.system(size: 40))
                .foregroundColor(.blue)

              VStack(alignment: .leading) {
                Text("风景照片")
                  .font(.subheadline)
                  .fontWeight(.medium)

                Text("点击分享按钮分享图片")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              // 分享图片
              ShareLink(
                item: samplePhoto,
                preview: SharePreview(
                  samplePhoto.caption,
                  image: samplePhoto.image
                )
              ) {
                Label("分享图片", systemImage: "square.and.arrow.up")
                  .font(.caption)
              }
            }

            Text("• 使用 SharePreview 提供预览信息")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("• 自定义类型需要实现 Transferable 协议")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 文档分享

        VStack(alignment: .leading, spacing: 15) {
          Text("文档内容分享")
            .font(.headline)
            .foregroundColor(.primary)

          Text("分享自定义文档类型，转换为文本格式")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(alignment: .leading, spacing: 10) {
            HStack {
              Image(systemName: "doc.text.fill")
                .font(.system(size: 40))
                .foregroundColor(.green)

              VStack(alignment: .leading) {
                Text(sampleDocument.title)
                  .font(.subheadline)
                  .fontWeight(.medium)

                Text(
                  "创建于 \(sampleDocument.createdDate.formatted(date: .abbreviated, time: .omitted))"
                )
                .font(.caption)
                .foregroundColor(.secondary)
              }

              Spacer()

              // 分享文档
              ShareLink(
                item: sampleDocument,
                preview: SharePreview(
                  sampleDocument.title,
                  icon: Image(systemName: "doc.text")
                )
              ) {
                Label("分享文档", systemImage: "square.and.arrow.up")
                  .font(.caption)
              }
            }

            Text("• 使用 DataRepresentation 转换为文本数据")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("• 包含标题、时间和内容的完整信息")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 多项目分享

        VStack(alignment: .leading, spacing: 15) {
          Text("多项目同时分享")
            .font(.headline)
            .foregroundColor(.primary)

          Text("一次分享多个相关的 URL 链接")
            .font(.subheadline)
            .foregroundColor(.secondary)

          VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
              ForEach(Array(multipleURLs.enumerated()), id: \.offset) { index, url in
                HStack {
                  Text("\(index + 1).")
                    .foregroundColor(.blue)
                    .fontWeight(.medium)

                  Text(url.lastPathComponent)
                    .font(.caption)
                    .foregroundColor(.secondary)

                  Spacer()
                }
              }
            }

            HStack {
              Spacer()

              // 分享多个 URL
              ShareLink(
                "分享相关文档",
                items: multipleURLs
              )
            }

            Text("• 同时分享 \(multipleURLs.count) 个相关文档链接")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("• 接收应用会收到所有链接")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }

        // MARK: - 内容类型说明

        VStack(alignment: .leading, spacing: 15) {
          Text("支持的内容类型")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            ContentTypeRow(
              icon: "link",
              title: "URL",
              description: "网页链接，自动获取预览"
            )

            ContentTypeRow(
              icon: "textformat",
              title: "String",
              description: "纯文本内容"
            )

            ContentTypeRow(
              icon: "photo",
              title: "Image",
              description: "图片内容，支持多种格式"
            )

            ContentTypeRow(
              icon: "doc",
              title: "Data",
              description: "二进制数据，需指定类型"
            )

            ContentTypeRow(
              icon: "gear",
              title: "Custom",
              description: "自定义类型，实现 Transferable"
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
    .navigationTitle("分享不同类型内容")
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - 辅助视图

/// 内容类型行视图
@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
private struct ContentTypeRow: View {
  let icon: String
  let title: String
  let description: String

  var body: some View {
    HStack(spacing: 12) {
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
    ShareLinkExampleView02()
  }
}
