import SwiftUI

/// SharePreview 不同内容类型示例
///
/// 本示例演示：
/// 1. 不同数据类型的分享预览
/// 2. 自定义 Transferable 类型的分享
/// 3. 多项目分享的预览处理
/// 4. 复杂内容的预览优化
public struct SharePreviewExampleView02: View {

  // MARK: - 状态属性

  /// 照片数据
  @State private var photos: [PhotoItem] = [
    PhotoItem(name: "风景照片", description: "美丽的山景", imageName: "mountain.2"),
    PhotoItem(name: "城市夜景", description: "繁华的都市夜晚", imageName: "building.2"),
    PhotoItem(name: "海滩日落", description: "宁静的海边日落", imageName: "sun.max"),
  ]

  /// 文档数据
  @State private var documents: [DocumentItem] = [
    DocumentItem(title: "项目报告", content: "这是一份重要的项目报告...", type: .pdf),
    DocumentItem(title: "会议纪要", content: "今日会议的主要内容...", type: .text),
    DocumentItem(title: "设计稿", content: "UI 设计的最新版本...", type: .image),
  ]

  /// 联系人信息
  @State private var contact = ContactInfo(
    name: "张三",
    email: "zhangsan@example.com",
    phone: "+86 138 0013 8000"
  )

  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 30) {

          // MARK: - 标题区域
          headerSection

          // MARK: - 照片分享
          photoShareSection

          // MARK: - 文档分享
          documentShareSection

          // MARK: - 联系人分享
          contactShareSection

          // MARK: - 多项目分享
          multiItemShareSection

          Spacer(minLength: 50)
        }
        .padding()
      }
      .navigationTitle("不同内容类型")
      .navigationBarTitleDisplayMode(.large)
    }
  }

  // MARK: - 视图组件

  /// 标题区域
  private var headerSection: some View {
    VStack(spacing: 16) {
      Image(systemName: "doc.richtext")
        .font(.system(size: 50))
        .foregroundColor(.green)

      Text("不同内容类型的分享预览")
        .font(.title2)
        .fontWeight(.bold)

      Text("学习如何为不同类型的内容创建合适的分享预览")
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 照片分享区域
  private var photoShareSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("1. 照片内容分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("为图片内容创建丰富的预览信息，包含标题和预览图。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
        ForEach(photos) { photo in
          photoCard(photo)
        }
      }

      // 代码示例
      codeExample(
        """
        struct PhotoItem: Transferable {
            static var transferRepresentation: some TransferRepresentation {
                ProxyRepresentation(exporting: \\.description)
            }
            
            let name: String
            let description: String
            let imageName: String
        }

        ShareLink(
            item: photo,
            preview: SharePreview(
                photo.name,
                image: Image(systemName: photo.imageName)
            )
        )
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 文档分享区域
  private var documentShareSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("2. 文档内容分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("为不同类型的文档提供相应的图标和预览信息。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      VStack(spacing: 12) {
        ForEach(documents) { document in
          documentRow(document)
        }
      }

      // 代码示例
      codeExample(
        """
        ShareLink(
            item: document,
            preview: SharePreview(
                document.title,
                image: Image(systemName: document.type.iconName)
            )
        ) {
            // 自定义文档行视图
        }
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 联系人分享区域
  private var contactShareSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("3. 联系人信息分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("分享联系人信息时提供个人头像和基本信息预览。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      HStack(spacing: 16) {
        // 联系人头像
        Image(systemName: "person.circle.fill")
          .font(.system(size: 60))
          .foregroundColor(.blue)

        VStack(alignment: .leading, spacing: 4) {
          Text(contact.name)
            .font(.title3)
            .fontWeight(.semibold)

          Text(contact.email)
            .font(.subheadline)
            .foregroundColor(.secondary)

          Text(contact.phone)
            .font(.subheadline)
            .foregroundColor(.secondary)
        }

        Spacer()

        ShareLink(
          item: contact,
          preview: SharePreview(
            contact.name,
            image: Image(systemName: "person.circle.fill")
          )
        ) {
          Image(systemName: "square.and.arrow.up")
            .font(.title2)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
        }
      }
      .padding()
      .background(Color(.systemGray6))
      .cornerRadius(12)

      // 代码示例
      codeExample(
        """
        struct ContactInfo: Transferable {
            static var transferRepresentation: some TransferRepresentation {
                ProxyRepresentation { contact in
                    "联系人: \\(contact.name)\\n邮箱: \\(contact.email)\\n电话: \\(contact.phone)"
                }
            }
        }
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 多项目分享区域
  private var multiItemShareSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("4. 多项目分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("同时分享多个项目时，为每个项目提供独立的预览。")
        .font(.subheadline)
        .foregroundColor(.secondary)

      // 选中的照片数量
      Text("已选择 \(photos.count) 张照片")
        .font(.subheadline)
        .foregroundColor(.blue)

      // 多项目分享按钮
      ShareLink(items: photos) { photo in
        SharePreview(
          photo.name,
          image: Image(systemName: photo.imageName)
        )
      } label: {
        HStack {
          Image(systemName: "photo.on.rectangle.angled")
          Text("分享所有照片")
          Text("(\(photos.count))")
            .foregroundColor(.secondary)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.green)
        .cornerRadius(8)
      }

      // 代码示例
      codeExample(
        """
        ShareLink(items: photos) { photo in
            SharePreview(
                photo.name,
                image: Image(systemName: photo.imageName)
            )
        } label: {
            Text("分享所有照片")
        }
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  // MARK: - 辅助视图

  /// 照片卡片
  private func photoCard(_ photo: PhotoItem) -> some View {
    VStack(spacing: 12) {
      Image(systemName: photo.imageName)
        .font(.system(size: 40))
        .foregroundColor(.blue)

      Text(photo.name)
        .font(.subheadline)
        .fontWeight(.medium)

      Text(photo.description)
        .font(.caption)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)

      ShareLink(
        item: photo,
        preview: SharePreview(
          photo.name,
          image: Image(systemName: photo.imageName)
        )
      ) {
        Image(systemName: "square.and.arrow.up")
          .font(.caption)
          .foregroundColor(.white)
          .padding(8)
          .background(Color.blue)
          .clipShape(Circle())
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 文档行视图
  private func documentRow(_ document: DocumentItem) -> some View {
    HStack(spacing: 16) {
      Image(systemName: document.type.iconName)
        .font(.title2)
        .foregroundColor(document.type.color)
        .frame(width: 30)

      VStack(alignment: .leading, spacing: 4) {
        Text(document.title)
          .font(.subheadline)
          .fontWeight(.medium)

        Text(document.content)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(2)
      }

      Spacer()

      ShareLink(
        item: document,
        preview: SharePreview(
          document.title,
          image: Image(systemName: document.type.iconName)
        )
      ) {
        Image(systemName: "square.and.arrow.up")
          .font(.subheadline)
          .foregroundColor(.blue)
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(8)
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

// MARK: - 数据模型

/// 照片项目
struct PhotoItem: Identifiable, Transferable {
  let id = UUID()
  let name: String
  let description: String
  let imageName: String

  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation(exporting: \.description)
  }
}

/// 文档项目
struct DocumentItem: Identifiable, Transferable {
  let id = UUID()
  let title: String
  let content: String
  let type: DocumentType

  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation(exporting: { document in
      "\(document.title)\n\n\(document.content)"
    })
  }
}

/// 文档类型
enum DocumentType {
  case pdf, text, image

  var iconName: String {
    switch self {
    case .pdf: return "doc.fill"
    case .text: return "doc.text.fill"
    case .image: return "photo.fill"
    }
  }

  var color: Color {
    switch self {
    case .pdf: return .red
    case .text: return .blue
    case .image: return .green
    }
  }
}

/// 联系人信息
struct ContactInfo: Transferable {
  let name: String
  let email: String
  let phone: String

  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation(exporting: { contact in
      "联系人: \(contact.name)\n邮箱: \(contact.email)\n电话: \(contact.phone)"
    })
  }
}

// MARK: - 预览

#Preview {
  SharePreviewExampleView02()
}
