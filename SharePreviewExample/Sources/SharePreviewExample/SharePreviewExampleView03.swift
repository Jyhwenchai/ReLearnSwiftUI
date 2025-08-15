import SwiftUI

/// SharePreview 样式和修饰符示例
///
/// 本示例演示：
/// 1. SharePreview 的不同初始化方式
/// 2. 图标和图片的组合使用
/// 3. 动态预览内容的创建
/// 4. 预览样式的最佳实践
public struct SharePreviewExampleView03: View {

  // MARK: - 状态属性

  /// 当前选中的预览样式
  @State private var selectedStyle: PreviewStyle = .titleOnly

  /// 自定义标题
  @State private var customTitle = "我的分享内容"

  /// 自定义描述
  @State private var customDescription = "这是一个精彩的分享内容，包含了丰富的信息和有趣的细节。"

  /// 选中的图标
  @State private var selectedIcon = "star.fill"

  /// 选中的颜色
  @State private var selectedColor: Color = .blue

  /// 是否显示图标
  @State private var showIcon = true

  /// 是否显示图片
  @State private var showImage = true

  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 30) {

          // MARK: - 标题区域
          headerSection

          // MARK: - 样式选择器
          styleSelector

          // MARK: - 自定义控制面板
          customizationPanel

          // MARK: - 预览展示区域
          previewShowcase

          // MARK: - 高级样式示例
          advancedStylesSection

          Spacer(minLength: 50)
        }
        .padding()
      }
      .navigationTitle("样式和修饰符")
      .navigationBarTitleDisplayMode(.large)
    }
  }

  // MARK: - 视图组件

  /// 标题区域
  private var headerSection: some View {
    VStack(spacing: 16) {
      Image(systemName: "paintbrush.fill")
        .font(.system(size: 50))
        .foregroundColor(.purple)

      Text("SharePreview 样式定制")
        .font(.title2)
        .fontWeight(.bold)

      Text("学习如何自定义 SharePreview 的外观和行为")
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 样式选择器
  private var styleSelector: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("1. 预览样式选择")
        .font(.headline)
        .foregroundColor(.primary)

      Text("选择不同的 SharePreview 初始化方式")
        .font(.subheadline)
        .foregroundColor(.secondary)

      Picker("预览样式", selection: $selectedStyle) {
        ForEach(PreviewStyle.allCases, id: \.self) { style in
          Text(style.displayName).tag(style)
        }
      }
      .pickerStyle(SegmentedPickerStyle())

      // 样式说明
      Text(selectedStyle.description)
        .font(.caption)
        .foregroundColor(.secondary)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 自定义控制面板
  private var customizationPanel: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("2. 自定义控制面板")
        .font(.headline)
        .foregroundColor(.primary)

      // 标题输入
      VStack(alignment: .leading, spacing: 8) {
        Text("标题:")
          .font(.subheadline)
          .fontWeight(.medium)

        TextField("输入标题", text: $customTitle)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }

      // 描述输入
      VStack(alignment: .leading, spacing: 8) {
        Text("描述:")
          .font(.subheadline)
          .fontWeight(.medium)

        TextField("输入描述", text: $customDescription, axis: .vertical)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .lineLimit(3...5)
      }

      // 图标选择
      VStack(alignment: .leading, spacing: 8) {
        Text("图标:")
          .font(.subheadline)
          .fontWeight(.medium)

        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 12) {
            ForEach(iconOptions, id: \.self) { icon in
              Button(action: { selectedIcon = icon }) {
                Image(systemName: icon)
                  .font(.title2)
                  .foregroundColor(selectedIcon == icon ? .white : selectedColor)
                  .padding(12)
                  .background(selectedIcon == icon ? selectedColor : Color(.systemGray5))
                  .clipShape(Circle())
              }
            }
          }
          .padding(.horizontal)
        }
      }

      // 颜色选择
      VStack(alignment: .leading, spacing: 8) {
        Text("颜色:")
          .font(.subheadline)
          .fontWeight(.medium)

        HStack(spacing: 12) {
          ForEach(colorOptions, id: \.self) { color in
            Button(action: { selectedColor = color }) {
              Circle()
                .fill(color)
                .frame(width: 30, height: 30)
                .overlay(
                  Circle()
                    .stroke(selectedColor == color ? Color.primary : Color.clear, lineWidth: 3)
                )
            }
          }
        }
      }

      // 开关控制
      HStack {
        Toggle("显示图标", isOn: $showIcon)
        Spacer()
        Toggle("显示图片", isOn: $showImage)
      }
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 预览展示区域
  private var previewShowcase: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("3. 实时预览效果")
        .font(.headline)
        .foregroundColor(.primary)

      Text("根据上面的设置，实时查看 SharePreview 的效果")
        .font(.subheadline)
        .foregroundColor(.secondary)

      // 预览卡片
      VStack(spacing: 20) {
        // 预览内容展示
        previewCard

        // 分享按钮
        shareButton
      }
      .padding()
      .background(Color(.systemGray6))
      .cornerRadius(12)

      // 当前代码
      currentCodeExample
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 高级样式示例
  private var advancedStylesSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("4. 高级样式示例")
        .font(.headline)
        .foregroundColor(.primary)

      Text("探索更多 SharePreview 的高级用法和样式组合")
        .font(.subheadline)
        .foregroundColor(.secondary)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
        // 多媒体预览
        advancedPreviewCard(
          title: "多媒体内容",
          icon: "play.rectangle.fill",
          color: .red,
          content: "包含视频和音频的丰富媒体内容"
        )

        // 位置预览
        advancedPreviewCard(
          title: "位置信息",
          icon: "location.fill",
          color: .green,
          content: "分享地理位置和地图信息"
        )

        // 日程预览
        advancedPreviewCard(
          title: "日程安排",
          icon: "calendar",
          color: .orange,
          content: "分享会议和活动安排"
        )

        // 文件预览
        advancedPreviewCard(
          title: "文件分享",
          icon: "folder.fill",
          color: .blue,
          content: "分享文档和文件资源"
        )
      }

      // 代码示例
      codeExample(
        """
        // 组合使用图标和图片
        SharePreview(
            "标题",
            image: Image(systemName: "photo"),
            icon: Image(systemName: "star.fill")
        )

        // 动态内容预览
        SharePreview(
            Text("\\(dynamicTitle)"),
            image: Image(systemName: selectedIcon)
        )
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  // MARK: - 辅助视图

  /// 预览卡片
  private var previewCard: some View {
    HStack(spacing: 16) {
      // 图标/图片区域
      if showIcon || showImage {
        Image(systemName: selectedIcon)
          .font(.system(size: 40))
          .foregroundColor(selectedColor)
          .frame(width: 60, height: 60)
          .background(selectedColor.opacity(0.1))
          .clipShape(RoundedRectangle(cornerRadius: 12))
      }

      // 文本内容区域
      VStack(alignment: .leading, spacing: 4) {
        Text(customTitle)
          .font(.headline)
          .foregroundColor(.primary)

        Text(customDescription)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .lineLimit(3)
      }

      Spacer()
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 1)
  }

  /// 分享按钮
  private var shareButton: some View {
    Group {
      switch selectedStyle {
      case .titleOnly:
        ShareLink(
          item: "\(customTitle)\n\n\(customDescription)",
          preview: SharePreview(customTitle)
        ) {
          shareButtonContent
        }
      case .titleWithImage:
        ShareLink(
          item: "\(customTitle)\n\n\(customDescription)",
          preview: SharePreview(
            customTitle,
            image: Image(systemName: selectedIcon)
          )
        ) {
          shareButtonContent
        }
      case .titleWithIcon:
        ShareLink(
          item: "\(customTitle)\n\n\(customDescription)",
          preview: SharePreview(
            customTitle,
            icon: Image(systemName: selectedIcon)
          )
        ) {
          shareButtonContent
        }
      }
    }
  }

  /// 分享按钮内容
  private var shareButtonContent: some View {
    HStack {
      Image(systemName: "square.and.arrow.up")
      Text("分享内容")
    }
    .foregroundColor(.white)
    .padding()
    .background(selectedColor)
    .cornerRadius(8)
  }

  /// 当前代码示例
  private var currentCodeExample: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("当前代码:")
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundColor(.secondary)

      Text(generateCurrentCode())
        .font(.system(.caption, design: .monospaced))
        .padding(12)
        .background(Color(.systemGray5))
        .cornerRadius(8)
    }
  }

  /// 高级预览卡片
  private func advancedPreviewCard(title: String, icon: String, color: Color, content: String)
    -> some View
  {
    VStack(spacing: 12) {
      Image(systemName: icon)
        .font(.system(size: 30))
        .foregroundColor(color)

      Text(title)
        .font(.subheadline)
        .fontWeight(.semibold)

      Text(content)
        .font(.caption)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .lineLimit(3)

      ShareLink(
        item: content,
        preview: SharePreview(
          title,
          image: Image(systemName: icon)
        )
      ) {
        Text("分享")
          .font(.caption)
          .foregroundColor(.white)
          .padding(.horizontal, 16)
          .padding(.vertical, 6)
          .background(color)
          .cornerRadius(12)
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
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

  // MARK: - 辅助方法

  /// 生成当前代码
  private func generateCurrentCode() -> String {
    switch selectedStyle {
    case .titleOnly:
      return "SharePreview(\"\(customTitle)\")"
    case .titleWithImage:
      return """
        SharePreview(
            "\(customTitle)",
            image: Image(systemName: "\(selectedIcon)")
        )
        """
    case .titleWithIcon:
      return """
        SharePreview(
            "\(customTitle)",
            icon: Image(systemName: "\(selectedIcon)")
        )
        """
    }
  }

  // MARK: - 数据

  /// 图标选项
  private let iconOptions = [
    "star.fill", "heart.fill", "photo.fill", "music.note",
    "video.fill", "doc.fill", "folder.fill", "location.fill",
    "calendar", "clock.fill", "bell.fill", "gift.fill",
  ]

  /// 颜色选项
  private let colorOptions: [Color] = [
    .blue, .green, .red, .orange, .purple, .pink, .yellow, .indigo,
  ]
}

// MARK: - 枚举定义

/// 预览样式
enum PreviewStyle: CaseIterable {
  case titleOnly
  case titleWithImage
  case titleWithIcon

  var displayName: String {
    switch self {
    case .titleOnly: return "仅标题"
    case .titleWithImage: return "标题+图片"
    case .titleWithIcon: return "标题+图标"
    }
  }

  var description: String {
    switch self {
    case .titleOnly:
      return "最简单的预览形式，只包含标题文本"
    case .titleWithImage:
      return "包含标题和主要图片的预览，适合内容展示"
    case .titleWithIcon:
      return "包含标题和小图标的预览，适合类型标识"
    }
  }
}

// MARK: - 预览

#Preview {
  SharePreviewExampleView03()
}
