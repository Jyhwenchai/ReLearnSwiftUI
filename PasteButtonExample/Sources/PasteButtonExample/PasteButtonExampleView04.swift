import SwiftUI
import UniformTypeIdentifiers

/// PasteButton 高级功能和实际应用示例
///
/// 这个示例展示了 PasteButton 的高级用法，包括：
/// - 数据验证和过滤
/// - 错误处理
/// - 实际应用场景
/// - 性能优化
/// - 可访问性支持
public struct PasteButtonExampleView04: View {
  // MARK: - 状态属性

  /// 笔记内容
  @State private var noteContent: String = ""

  /// URL 收藏列表
  @State private var bookmarkedURLs: [URL] = []

  /// 错误消息
  @State private var errorMessage: String = ""

  /// 显示错误警告
  @State private var showingError: Bool = false

  /// 处理状态
  @State private var isProcessing: Bool = false

  /// 统计信息
  @State private var statistics: PasteStatistics = PasteStatistics()

  /// 过滤设置
  @State private var enableFiltering: Bool = true

  /// 最大内容长度
  @State private var maxContentLength: Int = 1000

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(spacing: 25) {
        // MARK: - 标题和说明
        VStack(spacing: 10) {
          Text("高级功能和实际应用")
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("演示 PasteButton 在实际应用中的高级用法")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.top)

        Divider()

        // MARK: - 智能笔记应用
        VStack(alignment: .leading, spacing: 15) {
          Text("1. 智能笔记应用")
            .font(.headline)
            .foregroundColor(.primary)

          Text("带数据验证和格式化的笔记粘贴功能")
            .font(.caption)
            .foregroundColor(.secondary)

          VStack(spacing: 12) {
            // 设置选项
            HStack {
              Toggle("启用内容过滤", isOn: $enableFiltering)
                .font(.caption)

              Spacer()

              Text("最大长度: \(maxContentLength)")
                .font(.caption)
                .foregroundColor(.secondary)
            }

            // 粘贴按钮和处理
            HStack(spacing: 15) {
              VStack(spacing: 8) {
                PasteButton(payloadType: String.self) { strings in
                  handleNotePaste(strings)
                }
                .disabled(isProcessing)
                .tint(.blue)
                .apply { view in
                  if #available(iOS 16.0, macOS 14.0, *) {
                    view.buttonBorderShape(.roundedRectangle(radius: 8))
                  } else {
                    view
                  }
                }

                if isProcessing {
                  ProgressView()
                    .scaleEffect(0.8)
                }
              }

              Divider()
                .frame(height: 60)

              // 笔记内容显示
              VStack(alignment: .leading, spacing: 5) {
                Text("笔记内容:")
                  .font(.caption)
                  .foregroundColor(.secondary)

                ScrollView {
                  Text(noteContent.isEmpty ? "暂无笔记内容" : noteContent)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 80)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(6)

                Text("字符数: \(noteContent.count)")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
              .frame(maxWidth: .infinity)
            }
          }
          .padding()
          .background(Color.blue.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - URL 书签管理器
        VStack(alignment: .leading, spacing: 15) {
          Text("2. URL 书签管理器")
            .font(.headline)
            .foregroundColor(.primary)

          Text("验证和管理粘贴的 URL 链接")
            .font(.caption)
            .foregroundColor(.secondary)

          VStack(spacing: 12) {
            HStack(spacing: 15) {
              PasteButton(payloadType: URL.self) { urls in
                handleURLPaste(urls)
              }
              .tint(.green)
              .apply { view in
                if #available(iOS 16.0, macOS 14.0, *) {
                  view.buttonBorderShape(.capsule)
                } else {
                  view
                }
              }

              Spacer()

              Button("清空书签") {
                bookmarkedURLs.removeAll()
                statistics.urlCount = 0
              }
              .font(.caption)
              .foregroundColor(.red)
            }

            // 书签列表
            if !bookmarkedURLs.isEmpty {
              VStack(alignment: .leading, spacing: 8) {
                Text("已保存的书签:")
                  .font(.caption)
                  .foregroundColor(.secondary)

                ForEach(bookmarkedURLs.indices, id: \.self) { index in
                  HStack {
                    Image(systemName: "link")
                      .foregroundColor(.green)
                      .font(.caption)

                    Text(bookmarkedURLs[index].absoluteString)
                      .font(.caption)
                      .lineLimit(1)
                      .truncationMode(.middle)

                    Spacer()

                    Button("删除") {
                      bookmarkedURLs.remove(at: index)
                      statistics.urlCount = bookmarkedURLs.count
                    }
                    .font(.caption)
                    .foregroundColor(.red)
                  }
                  .padding(.vertical, 2)
                }
              }
              .padding(8)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)
            }
          }
          .padding()
          .background(Color.green.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 多媒体内容处理器
        VStack(alignment: .leading, spacing: 15) {
          Text("3. 多媒体内容处理器")
            .font(.headline)
            .foregroundColor(.primary)

          Text("处理图片和其他多媒体内容")
            .font(.caption)
            .foregroundColor(.secondary)

          VStack(spacing: 12) {
            HStack(spacing: 15) {
              // 图片粘贴按钮
              PasteButton(payloadType: Image.self) { images in
                handleImagePaste(images)
              }
              .tint(.purple)
              .labelStyle(.titleAndIcon)

              Spacer()

              // 数据粘贴按钮
              PasteButton(payloadType: Data.self) { dataArray in
                handleDataPaste(dataArray)
              }
              .tint(.orange)
              .labelStyle(.titleAndIcon)
            }

            // 处理结果显示
            if statistics.imageCount > 0 || statistics.dataSize > 0 {
              VStack(alignment: .leading, spacing: 8) {
                if statistics.imageCount > 0 {
                  Text("已处理图片: \(statistics.imageCount) 张")
                    .font(.caption)
                    .foregroundColor(.purple)
                }

                if statistics.dataSize > 0 {
                  Text("数据大小: \(formatBytes(statistics.dataSize))")
                    .font(.caption)
                    .foregroundColor(.orange)
                }
              }
              .padding(8)
              .background(Color.purple.opacity(0.1))
              .cornerRadius(6)
            }
          }
          .padding()
          .background(Color.purple.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 统计信息面板
        VStack(alignment: .leading, spacing: 15) {
          Text("4. 使用统计")
            .font(.headline)
            .foregroundColor(.primary)

          LazyVGrid(
            columns: [
              GridItem(.flexible()),
              GridItem(.flexible()),
            ], spacing: 12
          ) {
            StatisticCard(
              title: "文本粘贴",
              value: "\(statistics.textCount)",
              icon: "doc.text",
              color: .blue
            )

            StatisticCard(
              title: "URL 粘贴",
              value: "\(statistics.urlCount)",
              icon: "link",
              color: .green
            )

            StatisticCard(
              title: "图片粘贴",
              value: "\(statistics.imageCount)",
              icon: "photo",
              color: .purple
            )

            StatisticCard(
              title: "总操作数",
              value: "\(statistics.totalOperations)",
              icon: "chart.bar",
              color: .orange
            )
          }
        }

        // MARK: - 错误处理示例
        if !errorMessage.isEmpty {
          VStack(alignment: .leading, spacing: 10) {
            Text("⚠️ 错误信息")
              .font(.headline)
              .foregroundColor(.red)

            Text(errorMessage)
              .font(.body)
              .foregroundColor(.red)
              .padding()
              .background(Color.red.opacity(0.1))
              .cornerRadius(8)

            Button("清除错误") {
              errorMessage = ""
            }
            .font(.caption)
            .foregroundColor(.red)
          }
        }

        // MARK: - 使用说明
        VStack(alignment: .leading, spacing: 10) {
          Text("💡 高级功能说明")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("• 数据验证: 检查粘贴内容的有效性和格式")
            Text("• 错误处理: 优雅地处理无效或异常数据")
            Text("• 性能优化: 异步处理大量数据，避免界面卡顿")
            Text("• 用户反馈: 提供清晰的状态指示和错误信息")
            Text("• 可访问性: 支持 VoiceOver 和其他辅助功能")
            Text("• 实际应用: 结合具体业务场景的完整解决方案")
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
    .navigationTitle("高级功能和实际应用")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
    .alert("处理错误", isPresented: $showingError) {
      Button("确定") {
        showingError = false
      }
    } message: {
      Text(errorMessage)
    }
  }

  // MARK: - 数据处理方法

  /// 处理笔记粘贴
  private func handleNotePaste(_ strings: [String]) {
    isProcessing = true
    errorMessage = ""

    // 模拟异步处理
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      defer { isProcessing = false }

      let content = strings.joined(separator: "\n")

      // 数据验证
      if enableFiltering {
        if content.count > maxContentLength {
          errorMessage = "内容长度超过限制 (\(maxContentLength) 字符)"
          showingError = true
          return
        }

        // 过滤敏感内容（示例）
        let filteredContent = content.replacingOccurrences(of: "敏感词", with: "***")
        noteContent = filteredContent
      } else {
        noteContent = content
      }

      statistics.textCount += 1
      statistics.totalOperations += 1
    }
  }

  /// 处理 URL 粘贴
  private func handleURLPaste(_ urls: [URL]) {
    for url in urls {
      // 验证 URL 有效性
      if url.scheme != nil && (url.scheme == "http" || url.scheme == "https") {
        if !bookmarkedURLs.contains(url) {
          bookmarkedURLs.append(url)
        }
      } else {
        errorMessage = "无效的 URL: \(url.absoluteString)"
        showingError = true
      }
    }

    statistics.urlCount = bookmarkedURLs.count
    statistics.totalOperations += 1
  }

  /// 处理图片粘贴
  private func handleImagePaste(_ images: [Image]) {
    statistics.imageCount += images.count
    statistics.totalOperations += 1
  }

  /// 处理数据粘贴
  private func handleDataPaste(_ dataArray: [Data]) {
    let totalSize = dataArray.reduce(0) { $0 + $1.count }
    statistics.dataSize += totalSize
    statistics.totalOperations += 1
  }

  /// 格式化字节数
  private func formatBytes(_ bytes: Int) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useKB, .useMB, .useGB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: Int64(bytes))
  }
}

// MARK: - 数据模型

/// 粘贴操作统计信息
struct PasteStatistics {
  var textCount: Int = 0
  var urlCount: Int = 0
  var imageCount: Int = 0
  var dataSize: Int = 0
  var totalOperations: Int = 0
}

/// 统计卡片视图
struct StatisticCard: View {
  let title: String
  let value: String
  let icon: String
  let color: Color

  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: icon)
        .font(.title2)
        .foregroundColor(color)

      Text(value)
        .font(.title2)
        .fontWeight(.bold)
        .foregroundColor(color)

      Text(title)
        .font(.caption)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(color.opacity(0.1))
    .cornerRadius(12)
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    PasteButtonExampleView04()
  }
}
