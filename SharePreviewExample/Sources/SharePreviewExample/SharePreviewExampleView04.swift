import SwiftUI

/// SharePreview 高级功能和实际应用示例
///
/// 本示例演示：
/// 1. 实际应用场景的完整实现
/// 2. 复杂数据结构的分享预览
/// 3. 动态预览内容的生成
/// 4. 性能优化和最佳实践
public struct SharePreviewExampleView04: View {

  // MARK: - 状态属性

  /// 文章列表
  @State private var articles: [Article] = [
    Article(
      title: "SwiftUI 入门指南",
      author: "张开发",
      content: "SwiftUI 是苹果推出的现代化 UI 框架，它采用声明式语法，让开发者能够更直观地构建用户界面...",
      category: .tutorial,
      publishDate: Date().addingTimeInterval(-86400 * 7),
      readTime: 15,
      tags: ["SwiftUI", "iOS", "教程"]
    ),
    Article(
      title: "iOS 17 新特性解析",
      author: "李技术",
      content: "iOS 17 带来了许多令人兴奋的新特性，包括交互式小组件、实时活动增强、新的隐私控制等...",
      category: .news,
      publishDate: Date().addingTimeInterval(-86400 * 3),
      readTime: 8,
      tags: ["iOS17", "新特性", "苹果"]
    ),
    Article(
      title: "App Store 优化技巧",
      author: "王产品",
      content: "如何提高你的应用在 App Store 中的可见性和下载量，包括关键词优化、截图设计、描述撰写等...",
      category: .business,
      publishDate: Date().addingTimeInterval(-86400 * 1),
      readTime: 12,
      tags: ["ASO", "营销", "App Store"]
    ),
  ]

  /// 用户资料
  @State private var userProfile = UserProfile(
    name: "iOS 开发者",
    bio: "专注于 iOS 开发和 SwiftUI 技术分享",
    followerCount: 1250,
    followingCount: 380,
    articleCount: 42
  )

  /// 项目信息
  @State private var projects: [Project] = [
    Project(
      name: "天气应用",
      description: "一个美观实用的天气预报应用",
      technology: "SwiftUI + WeatherKit",
      status: .completed,
      progress: 1.0
    ),
    Project(
      name: "任务管理器",
      description: "高效的个人任务管理工具",
      technology: "SwiftUI + Core Data",
      status: .inProgress,
      progress: 0.75
    ),
    Project(
      name: "音乐播放器",
      description: "支持多种格式的音乐播放器",
      technology: "SwiftUI + AVFoundation",
      status: .planning,
      progress: 0.2
    ),
  ]

  /// 选中的分享类型
  @State private var selectedShareType: ShareType = .article

  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 30) {

          // MARK: - 标题区域
          headerSection

          // MARK: - 分享类型选择器
          shareTypeSelector

          // MARK: - 内容展示区域
          contentSection

          // MARK: - 批量分享功能
          batchShareSection

          // MARK: - 最佳实践指南
          bestPracticesSection

          Spacer(minLength: 50)
        }
        .padding()
      }
      .navigationTitle("高级功能应用")
      .navigationBarTitleDisplayMode(.large)
    }
  }

  // MARK: - 视图组件

  /// 标题区域
  private var headerSection: some View {
    VStack(spacing: 16) {
      Image(systemName: "sparkles")
        .font(.system(size: 50))
        .foregroundColor(.orange)

      Text("SharePreview 高级应用")
        .font(.title2)
        .fontWeight(.bold)

      Text("探索 SharePreview 在实际项目中的高级用法和最佳实践")
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 分享类型选择器
  private var shareTypeSelector: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("1. 实际应用场景")
        .font(.headline)
        .foregroundColor(.primary)

      Text("选择不同的内容类型，查看相应的分享预览实现")
        .font(.subheadline)
        .foregroundColor(.secondary)

      Picker("分享类型", selection: $selectedShareType) {
        ForEach(ShareType.allCases, id: \.self) { type in
          Text(type.displayName).tag(type)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 内容展示区域
  private var contentSection: some View {
    Group {
      switch selectedShareType {
      case .article:
        articleSection
      case .profile:
        profileSection
      case .project:
        projectSection
      }
    }
  }

  /// 文章分享区域
  private var articleSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("文章内容分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("为博客文章、新闻等内容创建丰富的分享预览")
        .font(.subheadline)
        .foregroundColor(.secondary)

      LazyVStack(spacing: 16) {
        ForEach(articles) { article in
          articleCard(article)
        }
      }

      // 代码示例
      codeExample(
        """
        struct Article: Transferable {
            static var transferRepresentation: some TransferRepresentation {
                ProxyRepresentation(exporting: { article in
                    "\\(article.title)\\n\\n作者: \\(article.author)\\n\\n\\(article.content)"
                })
            }
        }

        ShareLink(
            item: article,
            preview: SharePreview(
                article.title,
                image: Image(systemName: article.category.iconName)
            )
        )
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 用户资料分享区域
  private var profileSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("用户资料分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("分享用户个人资料和成就信息")
        .font(.subheadline)
        .foregroundColor(.secondary)

      profileCard(userProfile)

      // 代码示例
      codeExample(
        """
        ShareLink(
            item: userProfile,
            preview: SharePreview(
                userProfile.name,
                image: Image(systemName: "person.circle.fill")
            )
        ) {
            // 自定义分享按钮
        }
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 项目分享区域
  private var projectSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("项目信息分享")
        .font(.headline)
        .foregroundColor(.primary)

      Text("分享开发项目的详细信息和进度")
        .font(.subheadline)
        .foregroundColor(.secondary)

      LazyVStack(spacing: 16) {
        ForEach(projects) { project in
          projectCard(project)
        }
      }

      // 代码示例
      codeExample(
        """
        ShareLink(
            item: project,
            preview: SharePreview(
                project.name,
                image: Image(systemName: project.status.iconName)
            )
        )
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 批量分享功能
  private var batchShareSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("2. 批量分享功能")
        .font(.headline)
        .foregroundColor(.primary)

      Text("同时分享多个相关内容，为每个项目提供独立预览")
        .font(.subheadline)
        .foregroundColor(.secondary)

      VStack(spacing: 16) {
        // 分享所有文章
        ShareLink(items: articles) { article in
          SharePreview(
            article.title,
            image: Image(systemName: article.category.iconName)
          )
        } label: {
          batchShareButton(
            title: "分享所有文章",
            subtitle: "\(articles.count) 篇文章",
            icon: "doc.text.fill",
            color: .blue
          )
        }

        // 分享所有项目
        ShareLink(items: projects) { project in
          SharePreview(
            project.name,
            image: Image(systemName: project.status.iconName)
          )
        } label: {
          batchShareButton(
            title: "分享所有项目",
            subtitle: "\(projects.count) 个项目",
            icon: "folder.fill",
            color: .green
          )
        }
      }

      // 代码示例
      codeExample(
        """
        ShareLink(items: articles) { article in
            SharePreview(
                article.title,
                image: Image(systemName: article.category.iconName)
            )
        } label: {
            Text("分享所有文章")
        }
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  /// 最佳实践指南
  private var bestPracticesSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("3. 最佳实践指南")
        .font(.headline)
        .foregroundColor(.primary)

      Text("SharePreview 使用的最佳实践和性能优化建议")
        .font(.subheadline)
        .foregroundColor(.secondary)

      VStack(alignment: .leading, spacing: 12) {
        practiceItem(
          icon: "checkmark.circle.fill",
          title: "选择合适的预览内容",
          description: "标题应简洁明了，图片应具有代表性"
        )

        practiceItem(
          icon: "speedometer",
          title: "优化预览性能",
          description: "避免在预览中使用过大的图片或复杂的视图"
        )

        practiceItem(
          icon: "eye.fill",
          title: "考虑用户体验",
          description: "预览内容应该能够准确反映分享的实际内容"
        )

        practiceItem(
          icon: "globe",
          title: "跨平台兼容性",
          description: "确保预览在不同平台和应用中都能正常显示"
        )
      }

      // 性能优化代码示例
      codeExample(
        """
        // ✅ 推荐：使用轻量级的预览
        SharePreview(
            article.title,
            image: Image(systemName: "doc.text")
        )

        // ❌ 避免：使用复杂的自定义视图
        SharePreview(
            article.title,
            image: ComplexCustomView()
        )
        """)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  // MARK: - 辅助视图

  /// 文章卡片
  private func articleCard(_ article: Article) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Image(systemName: article.category.iconName)
          .font(.title2)
          .foregroundColor(article.category.color)

        VStack(alignment: .leading, spacing: 4) {
          Text(article.title)
            .font(.headline)
            .lineLimit(2)

          Text("作者: \(article.author)")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }

        Spacer()

        ShareLink(
          item: article,
          preview: SharePreview(
            article.title,
            image: Image(systemName: article.category.iconName)
          )
        ) {
          Image(systemName: "square.and.arrow.up")
            .font(.title3)
            .foregroundColor(.blue)
        }
      }

      Text(article.content)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .lineLimit(3)

      HStack {
        Label("\(article.readTime) 分钟", systemImage: "clock")
          .font(.caption)
          .foregroundColor(.secondary)

        Spacer()

        Text(article.publishDate, style: .date)
          .font(.caption)
          .foregroundColor(.secondary)
      }

      // 标签
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(article.tags, id: \.self) { tag in
            Text(tag)
              .font(.caption)
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .background(article.category.color.opacity(0.2))
              .foregroundColor(article.category.color)
              .cornerRadius(8)
          }
        }
        .padding(.horizontal, 1)
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 用户资料卡片
  private func profileCard(_ profile: UserProfile) -> some View {
    VStack(spacing: 16) {
      HStack(spacing: 16) {
        Image(systemName: "person.circle.fill")
          .font(.system(size: 60))
          .foregroundColor(.blue)

        VStack(alignment: .leading, spacing: 4) {
          Text(profile.name)
            .font(.title2)
            .fontWeight(.bold)

          Text(profile.bio)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(2)
        }

        Spacer()

        ShareLink(
          item: profile,
          preview: SharePreview(
            profile.name,
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

      HStack(spacing: 30) {
        statItem(title: "关注者", value: "\(profile.followerCount)")
        statItem(title: "关注中", value: "\(profile.followingCount)")
        statItem(title: "文章", value: "\(profile.articleCount)")
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 项目卡片
  private func projectCard(_ project: Project) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Image(systemName: project.status.iconName)
          .font(.title2)
          .foregroundColor(project.status.color)

        VStack(alignment: .leading, spacing: 4) {
          Text(project.name)
            .font(.headline)

          Text(project.technology)
            .font(.subheadline)
            .foregroundColor(.secondary)
        }

        Spacer()

        ShareLink(
          item: project,
          preview: SharePreview(
            project.name,
            image: Image(systemName: project.status.iconName)
          )
        ) {
          Image(systemName: "square.and.arrow.up")
            .font(.title3)
            .foregroundColor(.blue)
        }
      }

      Text(project.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .lineLimit(2)

      // 进度条
      VStack(alignment: .leading, spacing: 4) {
        HStack {
          Text("进度")
            .font(.caption)
            .foregroundColor(.secondary)

          Spacer()

          Text("\(Int(project.progress * 100))%")
            .font(.caption)
            .fontWeight(.medium)
        }

        ProgressView(value: project.progress)
          .tint(project.status.color)
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  /// 批量分享按钮
  private func batchShareButton(title: String, subtitle: String, icon: String, color: Color)
    -> some View
  {
    HStack(spacing: 16) {
      Image(systemName: icon)
        .font(.title2)
        .foregroundColor(color)
        .frame(width: 40)

      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.headline)
          .foregroundColor(.primary)

        Text(subtitle)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }

      Spacer()

      Image(systemName: "square.and.arrow.up")
        .font(.title3)
        .foregroundColor(.white)
    }
    .padding()
    .background(color.opacity(0.1))
    .cornerRadius(12)
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(color.opacity(0.3), lineWidth: 1)
    )
  }

  /// 统计项目
  private func statItem(title: String, value: String) -> some View {
    VStack(spacing: 4) {
      Text(value)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundColor(.primary)

      Text(title)
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }

  /// 最佳实践项目
  private func practiceItem(icon: String, title: String, description: String) -> some View {
    HStack(alignment: .top, spacing: 12) {
      Image(systemName: icon)
        .font(.title3)
        .foregroundColor(.green)
        .frame(width: 20)

      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.subheadline)
          .fontWeight(.medium)

        Text(description)
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
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

/// 文章模型
struct Article: Identifiable, Transferable {
  let id = UUID()
  let title: String
  let author: String
  let content: String
  let category: ArticleCategory
  let publishDate: Date
  let readTime: Int
  let tags: [String]

  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation(exporting: { article in
      "\(article.title)\n\n作者: \(article.author)\n\n\(article.content)"
    })
  }
}

/// 文章分类
enum ArticleCategory {
  case tutorial, news, business

  var iconName: String {
    switch self {
    case .tutorial: return "book.fill"
    case .news: return "newspaper.fill"
    case .business: return "chart.line.uptrend.xyaxis"
    }
  }

  var color: Color {
    switch self {
    case .tutorial: return .blue
    case .news: return .red
    case .business: return .green
    }
  }
}

/// 用户资料模型
struct UserProfile: Transferable {
  let name: String
  let bio: String
  let followerCount: Int
  let followingCount: Int
  let articleCount: Int

  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation(exporting: { profile in
      "\(profile.name)\n\n\(profile.bio)\n\n关注者: \(profile.followerCount) | 文章: \(profile.articleCount)"
    })
  }
}

/// 项目模型
struct Project: Identifiable, Transferable {
  let id = UUID()
  let name: String
  let description: String
  let technology: String
  let status: ProjectStatus
  let progress: Double

  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation(exporting: { project in
      "\(project.name)\n\n\(project.description)\n\n技术栈: \(project.technology)\n状态: \(project.status.displayName)"
    })
  }
}

/// 项目状态
enum ProjectStatus {
  case planning, inProgress, completed

  var displayName: String {
    switch self {
    case .planning: return "规划中"
    case .inProgress: return "进行中"
    case .completed: return "已完成"
    }
  }

  var iconName: String {
    switch self {
    case .planning: return "lightbulb.fill"
    case .inProgress: return "gear.badge"
    case .completed: return "checkmark.circle.fill"
    }
  }

  var color: Color {
    switch self {
    case .planning: return .orange
    case .inProgress: return .blue
    case .completed: return .green
    }
  }
}

/// 分享类型
enum ShareType: CaseIterable {
  case article, profile, project

  var displayName: String {
    switch self {
    case .article: return "文章"
    case .profile: return "资料"
    case .project: return "项目"
    }
  }
}

// MARK: - 预览

#Preview {
  SharePreviewExampleView04()
}
