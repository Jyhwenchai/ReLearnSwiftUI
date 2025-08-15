import SwiftUI
import UniformTypeIdentifiers

/// PasteButton 支持的数据类型示例
///
/// 这个示例展示了 PasteButton 支持的各种数据类型，包括：
/// - 文本类型 (String)
/// - 图片类型 (Image)
/// - URL 类型 (URL)
/// - 数据类型 (Data)
/// - 自定义 Transferable 类型
public struct PasteButtonExampleView02: View {
  // MARK: - 状态属性

  /// 粘贴的文本内容
  @State private var pastedText: String = ""

  /// 粘贴的 URL 内容
  @State private var pastedURL: String = ""

  /// 粘贴的图片
  @State private var pastedImage: Image? = nil

  /// 粘贴的数据信息
  @State private var pastedDataInfo: String = ""

  /// 自定义数据
  @State private var customData: String = ""

  /// 操作状态消息
  @State private var statusMessage: String = "准备接收粘贴内容"

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(spacing: 25) {
        // MARK: - 标题和说明
        VStack(spacing: 10) {
          Text("支持的数据类型")
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("演示 PasteButton 支持的各种数据类型")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.top)

        // MARK: - 状态消息
        Text(statusMessage)
          .font(.caption)
          .foregroundColor(.blue)
          .padding(.horizontal)

        Divider()

        // MARK: - 文本类型粘贴
        VStack(alignment: .leading, spacing: 15) {
          Text("1. 文本类型 (String)")
            .font(.headline)
            .foregroundColor(.primary)

          HStack(spacing: 15) {
            PasteButton(payloadType: String.self) { strings in
              // 处理粘贴的字符串数组
              pastedText = strings.joined(separator: "\n")
              statusMessage = "成功粘贴 \(strings.count) 个文本项"
            }

            Divider()
              .frame(height: 40)

            VStack(alignment: .leading, spacing: 5) {
              Text("粘贴的文本:")
                .font(.caption)
                .foregroundColor(.secondary)

              ScrollView {
                Text(pastedText.isEmpty ? "暂无内容" : pastedText)
                  .font(.body)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .frame(height: 60)
              .padding(8)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(6)
            }
            .frame(maxWidth: .infinity)
          }
          .padding()
          .background(Color.blue.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - URL 类型粘贴
        VStack(alignment: .leading, spacing: 15) {
          Text("2. URL 类型")
            .font(.headline)
            .foregroundColor(.primary)

          HStack(spacing: 15) {
            PasteButton(payloadType: URL.self) { urls in
              // 处理粘贴的 URL 数组
              pastedURL = urls.map { $0.absoluteString }.joined(separator: "\n")
              statusMessage = "成功粘贴 \(urls.count) 个 URL"
            }

            Divider()
              .frame(height: 40)

            VStack(alignment: .leading, spacing: 5) {
              Text("粘贴的 URL:")
                .font(.caption)
                .foregroundColor(.secondary)

              ScrollView {
                Text(pastedURL.isEmpty ? "暂无内容" : pastedURL)
                  .font(.body)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .frame(height: 60)
              .padding(8)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)
            }
            .frame(maxWidth: .infinity)
          }
          .padding()
          .background(Color.green.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 图片类型粘贴
        VStack(alignment: .leading, spacing: 15) {
          Text("3. 图片类型 (Image)")
            .font(.headline)
            .foregroundColor(.primary)

          HStack(spacing: 15) {
            PasteButton(payloadType: Image.self) { images in
              // 处理粘贴的图片数组
              if let firstImage = images.first {
                pastedImage = firstImage
                statusMessage = "成功粘贴 \(images.count) 张图片"
              }
            }

            Divider()
              .frame(height: 80)

            VStack(alignment: .leading, spacing: 5) {
              Text("粘贴的图片:")
                .font(.caption)
                .foregroundColor(.secondary)

              if let image = pastedImage {
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 80, height: 60)
                  .background(Color.purple.opacity(0.1))
                  .cornerRadius(6)
              } else {
                Rectangle()
                  .fill(Color.purple.opacity(0.1))
                  .frame(width: 80, height: 60)
                  .cornerRadius(6)
                  .overlay(
                    Text("暂无图片")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  )
              }
            }
            .frame(maxWidth: .infinity)
          }
          .padding()
          .background(Color.purple.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 数据类型粘贴
        VStack(alignment: .leading, spacing: 15) {
          Text("4. 数据类型 (Data)")
            .font(.headline)
            .foregroundColor(.primary)

          HStack(spacing: 15) {
            PasteButton(payloadType: Data.self) { dataArray in
              // 处理粘贴的数据数组
              let totalBytes = dataArray.reduce(0) { $0 + $1.count }
              pastedDataInfo = "数据项数: \(dataArray.count)\n总字节数: \(totalBytes)"
              statusMessage = "成功粘贴 \(dataArray.count) 个数据项"
            }

            Divider()
              .frame(height: 40)

            VStack(alignment: .leading, spacing: 5) {
              Text("数据信息:")
                .font(.caption)
                .foregroundColor(.secondary)

              Text(pastedDataInfo.isEmpty ? "暂无数据" : pastedDataInfo)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(6)
            }
            .frame(maxWidth: .infinity)
          }
          .padding()
          .background(Color.orange.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 多类型支持示例
        VStack(alignment: .leading, spacing: 15) {
          Text("5. 多类型支持")
            .font(.headline)
            .foregroundColor(.primary)

          Text("使用 supportedTypes 参数支持多种数据类型")
            .font(.caption)
            .foregroundColor(.secondary)

          HStack(spacing: 15) {
            // 注意：这个 API 在某些版本中可能不可用
            // 这里展示概念性的用法
            PasteButton(payloadType: String.self) { strings in
              customData = "多类型数据: \(strings.joined(separator: ", "))"
              statusMessage = "处理了多类型数据"
            }

            Divider()
              .frame(height: 40)

            VStack(alignment: .leading, spacing: 5) {
              Text("处理结果:")
                .font(.caption)
                .foregroundColor(.secondary)

              Text(customData.isEmpty ? "暂无数据" : customData)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color.pink.opacity(0.1))
                .cornerRadius(6)
            }
            .frame(maxWidth: .infinity)
          }
          .padding()
          .background(Color.pink.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 使用说明
        VStack(alignment: .leading, spacing: 10) {
          Text("💡 数据类型说明")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("• String: 支持纯文本、富文本等文本内容")
            Text("• URL: 支持网址、文件路径等链接内容")
            Text("• Image: 支持图片文件（PNG、JPEG 等）")
            Text("• Data: 支持任意二进制数据")
            Text("• 自定义类型: 需要实现 Transferable 协议")
            Text("• 按钮会根据剪贴板内容自动启用/禁用")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.yellow.opacity(0.05))
        .cornerRadius(12)

        Spacer()
      }
      .padding()
    }
    .navigationTitle("支持的数据类型")
    #if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    PasteButtonExampleView02()
  }
}
