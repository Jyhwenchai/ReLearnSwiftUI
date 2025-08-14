import SwiftUI

/// LabelExampleView04 - 自定义 Label 样式和高级功能
///
/// 这个示例展示了 Label 的高级用法和自定义样式：
/// - 创建自定义 LabelStyle
/// - 复杂的布局和组合
/// - 性能优化技巧
/// - 实际项目中的应用场景
public struct LabelExampleView04: View {
  @State private var downloadProgress: Double = 0.0
  @State private var isDownloading = false
  @State private var notificationCount = 5

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("自定义样式和高级功能")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom)

        // MARK: - 1. 自定义 LabelStyle
        GroupBox("1. 自定义 LabelStyle") {
          VStack(alignment: .leading, spacing: 12) {
            Text("使用自定义样式的 Label：")
              .font(.headline)

            // 垂直布局样式
            Label("垂直布局", systemImage: "arrow.up.and.down")
              .labelStyle(VerticalLabelStyle())

            // 反向布局样式
            Label("反向布局", systemImage: "arrow.left.and.right")
              .labelStyle(ReverseLabelStyle())

            // 带背景的样式
            Label("背景样式", systemImage: "paintbrush.fill")
              .labelStyle(BackgroundLabelStyle())

            // 圆形图标样式
            Label("圆形图标", systemImage: "star.fill")
              .labelStyle(CircularIconLabelStyle())

            Text("💡 自定义 LabelStyle 可以创建统一的设计语言")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 2. 动态内容 Label
        GroupBox("2. 动态内容 Label") {
          VStack(alignment: .leading, spacing: 12) {
            // 带数字徽章的 Label
            Label {
              HStack {
                Text("消息")
                if notificationCount > 0 {
                  Text("\(notificationCount)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red)
                    .clipShape(Capsule())
                }
              }
            } icon: {
              Image(systemName: "envelope")
                .foregroundColor(.blue)
            }

            // 控制按钮
            HStack {
              Button("增加消息") {
                withAnimation(.easeInOut) {
                  notificationCount += 1
                }
              }

              Button("清除消息") {
                withAnimation(.easeInOut) {
                  notificationCount = 0
                }
              }
            }
            .buttonStyle(.bordered)

            // 进度指示器 Label
            Label {
              VStack(alignment: .leading, spacing: 4) {
                HStack {
                  Text("下载进度")
                  Spacer()
                  Text("\(Int(downloadProgress * 100))%")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }

                ProgressView(value: downloadProgress)
                  .progressViewStyle(LinearProgressViewStyle())
              }
            } icon: {
              Image(systemName: isDownloading ? "arrow.down.circle.fill" : "arrow.down.circle")
                .foregroundColor(isDownloading ? .blue : .gray)
            }

            // 下载控制按钮
            Button(isDownloading ? "停止下载" : "开始下载") {
              if isDownloading {
                isDownloading = false
                downloadProgress = 0.0
              } else {
                startDownload()
              }
            }
            .buttonStyle(.bordered)

            Text("💡 Label 可以包含动态内容，实时反映应用状态")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 3. 复杂布局组合
        GroupBox("3. 复杂布局组合") {
          VStack(alignment: .leading, spacing: 12) {
            Text("文件列表示例：")
              .font(.headline)

            // 文件项目
            FileItemLabel(
              name: "重要文档.pdf",
              size: "2.5 MB",
              modifiedDate: "今天 14:30",
              icon: "doc.fill",
              iconColor: .red
            )

            FileItemLabel(
              name: "项目图片.jpg",
              size: "1.8 MB",
              modifiedDate: "昨天 09:15",
              icon: "photo.fill",
              iconColor: .blue
            )

            FileItemLabel(
              name: "数据表格.xlsx",
              size: "856 KB",
              modifiedDate: "2天前",
              icon: "tablecells.fill",
              iconColor: .green
            )

            Text("💡 通过组合多个元素可以创建复杂的信息展示界面")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 4. 性能优化示例
        GroupBox("4. 性能优化示例") {
          VStack(alignment: .leading, spacing: 12) {
            Text("大量 Label 的性能优化：")
              .font(.headline)

            // 使用 LazyVStack 优化大量 Label 的渲染
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack(spacing: 8) {
                ForEach(0..<50, id: \.self) { index in
                  Label("项目 \(index + 1)", systemImage: "folder")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
                }
              }
              .padding(.horizontal)
            }
            .frame(height: 40)

            Text("💡 使用 LazyVStack/LazyHStack 可以优化大量视图的性能")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 5. 实际应用：设置界面
        GroupBox("5. 实际应用：设置界面") {
          VStack(alignment: .leading, spacing: 8) {
            Text("设置选项列表：")
              .font(.headline)

            SettingItemLabel(
              title: "通知设置",
              subtitle: "管理推送通知和提醒",
              icon: "bell.fill",
              iconColor: .orange,
              hasChevron: true
            )

            SettingItemLabel(
              title: "隐私设置",
              subtitle: "控制数据共享和权限",
              icon: "lock.fill",
              iconColor: .blue,
              hasChevron: true
            )

            SettingItemLabel(
              title: "存储空间",
              subtitle: "已使用 15.2 GB，共 64 GB",
              icon: "internaldrive.fill",
              iconColor: .purple,
              hasChevron: true
            )

            SettingItemLabel(
              title: "关于",
              subtitle: "版本信息和法律条款",
              icon: "info.circle.fill",
              iconColor: .gray,
              hasChevron: true
            )

            Text("💡 Label 是构建设置界面的理想选择")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 6. 最佳实践总结
        GroupBox("6. 最佳实践总结") {
          VStack(alignment: .leading, spacing: 8) {
            Text("Label 使用最佳实践：")
              .font(.headline)

            VStack(alignment: .leading, spacing: 4) {
              Text("✅ 使用语义化的图标和文本")
              Text("✅ 保持图标和文本的视觉平衡")
              Text("✅ 为可访问性添加适当的标签")
              Text("✅ 在大量 Label 时考虑性能优化")
              Text("✅ 使用一致的样式和间距")
              Text("❌ 避免过度复杂的自定义样式")
              Text("❌ 不要在 Label 中放置过多信息")
            }
            .font(.caption)
            .foregroundColor(.secondary)

            Text("💡 遵循这些最佳实践可以创建更好的用户体验")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding()
    }
    .navigationTitle("自定义样式")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 辅助方法
  private func startDownload() {
    isDownloading = true
    downloadProgress = 0.0

    Task {
      while isDownloading && downloadProgress < 1.0 {
        try? await Task.sleep(nanoseconds: 100_000_000)  // 0.1 seconds
        await MainActor.run {
          if isDownloading && downloadProgress < 1.0 {
            downloadProgress += 0.02
          } else {
            isDownloading = false
          }
        }
      }
    }
  }
}

// MARK: - 自定义 LabelStyle

/// 垂直布局的 Label 样式
struct VerticalLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    VStack(spacing: 4) {
      configuration.icon
        .font(.title2)
      configuration.title
        .font(.caption)
    }
    .padding(8)
  }
}

/// 反向布局的 Label 样式（文本在左，图标在右）
struct ReverseLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.title
      Spacer()
      configuration.icon
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
  }
}

/// 带背景的 Label 样式
struct BackgroundLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.icon
        .foregroundColor(.white)
      configuration.title
        .foregroundColor(.white)
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
    .background(Color.blue)
    .cornerRadius(8)
  }
}

/// 圆形图标的 Label 样式
struct CircularIconLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.icon
        .foregroundColor(.white)
        .frame(width: 24, height: 24)
        .background(Color.blue)
        .clipShape(Circle())
      configuration.title
    }
    .padding(.horizontal, 8)
    .padding(.vertical, 4)
  }
}

// MARK: - 自定义组件

/// 文件项目 Label
struct FileItemLabel: View {
  let name: String
  let size: String
  let modifiedDate: String
  let icon: String
  let iconColor: Color

  var body: some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(iconColor)
        .frame(width: 20)

      VStack(alignment: .leading, spacing: 2) {
        Text(name)
          .font(.body)
          .lineLimit(1)

        HStack {
          Text(size)
          Text("•")
          Text(modifiedDate)
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }

      Spacer()

      Image(systemName: "chevron.right")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding(.vertical, 4)
  }
}

/// 设置项目 Label
struct SettingItemLabel: View {
  let title: String
  let subtitle: String
  let icon: String
  let iconColor: Color
  let hasChevron: Bool

  var body: some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(iconColor)
        .frame(width: 20)

      VStack(alignment: .leading, spacing: 2) {
        Text(title)
          .font(.body)

        Text(subtitle)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }

      Spacer()

      if hasChevron {
        Image(systemName: "chevron.right")
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
    .padding(.vertical, 8)
    .contentShape(Rectangle())
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    LabelExampleView04()
  }
}
