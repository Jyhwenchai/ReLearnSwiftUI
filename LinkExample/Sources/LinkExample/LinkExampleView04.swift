import SwiftUI

/// LinkExampleView04 - 高级功能和实际应用
///
/// 本示例演示了 Link 组件的高级用法：
/// - 动态链接生成
/// - 链接状态管理
/// - 复杂的用户界面集成
/// - 实际应用场景
public struct LinkExampleView04: View {
  public init() {}

  // 状态管理
  @State private var searchText = ""
  @State private var selectedCategory = "技术"
  @State private var bookmarks: [BookmarkItem] = sampleBookmarks
  @State private var showingAddBookmark = false
  @State private var newBookmarkTitle = ""
  @State private var newBookmarkURL = ""

  let categories = ["技术", "新闻", "娱乐", "教育", "购物"]

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          // MARK: - 动态搜索链接
          GroupBox("动态搜索链接") {
            VStack(alignment: .leading, spacing: 15) {
              Text("输入搜索关键词：")
                .font(.headline)

              TextField("搜索内容", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())

              if !searchText.isEmpty {
                VStack(spacing: 10) {
                  // Google 搜索
                  DynamicSearchLink(
                    title: "在 Google 中搜索",
                    icon: "magnifyingglass",
                    baseURL: "https://www.google.com/search?q=",
                    query: searchText
                  )

                  // GitHub 搜索
                  DynamicSearchLink(
                    title: "在 GitHub 中搜索",
                    icon: "chevron.left.forwardslash.chevron.right",
                    baseURL: "https://github.com/search?q=",
                    query: searchText
                  )

                  // Stack Overflow 搜索
                  DynamicSearchLink(
                    title: "在 Stack Overflow 中搜索",
                    icon: "questionmark.circle",
                    baseURL: "https://stackoverflow.com/search?q=",
                    query: searchText
                  )
                }
              } else {
                Text("输入关键词后将显示搜索链接")
                  .font(.caption)
                  .foregroundColor(.secondary)
                  .padding()
              }
            }
            .padding()
          }

          // MARK: - 分类链接导航
          GroupBox("分类链接导航") {
            VStack(alignment: .leading, spacing: 15) {
              Text("选择分类：")
                .font(.headline)

              Picker("分类", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                  Text(category).tag(category)
                }
              }
              .pickerStyle(SegmentedPickerStyle())

              // 根据分类显示相关链接
              CategoryLinksView(category: selectedCategory)
            }
            .padding()
          }

          // MARK: - 书签管理系统
          GroupBox("书签管理系统") {
            VStack(alignment: .leading, spacing: 15) {
              HStack {
                Text("我的书签")
                  .font(.headline)

                Spacer()

                Button("添加书签") {
                  showingAddBookmark = true
                }
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(6)
              }

              if bookmarks.isEmpty {
                Text("暂无书签")
                  .font(.caption)
                  .foregroundColor(.secondary)
                  .padding()
              } else {
                ForEach(bookmarks) { bookmark in
                  BookmarkRowView(bookmark: bookmark) {
                    // 删除书签
                    if let index = bookmarks.firstIndex(where: { $0.id == bookmark.id }) {
                      bookmarks.remove(at: index)
                    }
                  }
                }
              }
            }
            .padding()
          }

          // MARK: - 社交媒体分享
          GroupBox("社交媒体分享") {
            VStack(alignment: .leading, spacing: 15) {
              Text("分享当前页面：")
                .font(.headline)

              let shareURL = "https://example.com/current-page"
              let shareTitle = "查看这个精彩内容"

              LazyVGrid(
                columns: [
                  GridItem(.flexible()),
                  GridItem(.flexible()),
                ], spacing: 10
              ) {
                // Twitter 分享
                SocialShareLink(
                  platform: "Twitter",
                  icon: "at",
                  color: .blue,
                  url:
                    "https://twitter.com/intent/tweet?text=\(shareTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&url=\(shareURL)"
                )

                // Facebook 分享
                SocialShareLink(
                  platform: "Facebook",
                  icon: "f.circle",
                  color: .blue,
                  url: "https://www.facebook.com/sharer/sharer.php?u=\(shareURL)"
                )

                // LinkedIn 分享
                SocialShareLink(
                  platform: "LinkedIn",
                  icon: "person.crop.rectangle",
                  color: .blue,
                  url: "https://www.linkedin.com/sharing/share-offsite/?url=\(shareURL)"
                )

                // 邮件分享
                SocialShareLink(
                  platform: "邮件",
                  icon: "envelope",
                  color: .green,
                  url:
                    "mailto:?subject=\(shareTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(shareURL)"
                )
              }
            }
            .padding()
          }

          // MARK: - 实用工具链接
          GroupBox("实用工具链接") {
            VStack(alignment: .leading, spacing: 15) {
              Text("常用工具：")
                .font(.headline)

              LazyVGrid(
                columns: [
                  GridItem(.flexible()),
                  GridItem(.flexible()),
                ], spacing: 10
              ) {
                ToolLinkCard(
                  title: "颜色选择器",
                  description: "在线颜色工具",
                  icon: "paintpalette",
                  url: "https://colorhunt.co"
                )

                ToolLinkCard(
                  title: "JSON 格式化",
                  description: "JSON 在线工具",
                  icon: "doc.text",
                  url: "https://jsonformatter.org"
                )

                ToolLinkCard(
                  title: "正则表达式",
                  description: "正则测试工具",
                  icon: "textformat.abc",
                  url: "https://regex101.com"
                )

                ToolLinkCard(
                  title: "Base64 编码",
                  description: "编码解码工具",
                  icon: "lock.shield",
                  url: "https://www.base64encode.org"
                )
              }
            }
            .padding()
          }

          // MARK: - 链接统计和分析
          GroupBox("链接使用统计") {
            VStack(alignment: .leading, spacing: 15) {
              Text("链接点击统计：")
                .font(.headline)

              VStack(spacing: 8) {
                StatisticRow(title: "今日点击", count: 23)
                StatisticRow(title: "本周点击", count: 156)
                StatisticRow(title: "本月点击", count: 678)
                StatisticRow(title: "总点击数", count: 2341)
              }

              Text("注意：这是模拟数据，实际应用中需要实现点击追踪")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding()
          }
        }
        .padding()
      }
      .navigationTitle("Link 高级应用")
      #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
      #endif
    }
    .sheet(isPresented: $showingAddBookmark) {
      AddBookmarkView(
        title: $newBookmarkTitle,
        url: $newBookmarkURL,
        onSave: {
          if !newBookmarkTitle.isEmpty && !newBookmarkURL.isEmpty {
            let newBookmark = BookmarkItem(
              title: newBookmarkTitle,
              url: newBookmarkURL,
              category: selectedCategory
            )
            bookmarks.append(newBookmark)
            newBookmarkTitle = ""
            newBookmarkURL = ""
            showingAddBookmark = false
          }
        },
        onCancel: {
          showingAddBookmark = false
        }
      )
    }
  }
}

// MARK: - 辅助视图组件

/// 动态搜索链接组件
struct DynamicSearchLink: View {
  let title: String
  let icon: String
  let baseURL: String
  let query: String

  var body: some View {
    if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let url = URL(string: baseURL + encodedQuery)
    {
      Link(destination: url) {
        HStack {
          Image(systemName: icon)
            .foregroundColor(.blue)
            .frame(width: 20)

          Text(title)
            .foregroundColor(.primary)

          Spacer()

          Text("「\(query)」")
            .font(.caption)
            .foregroundColor(.secondary)

          Image(systemName: "arrow.up.right.square")
            .foregroundColor(.blue)
            .font(.caption)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
      }
    }
  }
}

/// 分类链接视图
struct CategoryLinksView: View {
  let category: String

  var body: some View {
    VStack(spacing: 10) {
      switch category {
      case "技术":
        CategoryLink(
          title: "GitHub", url: "https://github.com",
          icon: "chevron.left.forwardslash.chevron.right")
        CategoryLink(
          title: "Stack Overflow", url: "https://stackoverflow.com", icon: "questionmark.circle")
        CategoryLink(
          title: "Apple Developer", url: "https://developer.apple.com", icon: "apple.logo")

      case "新闻":
        CategoryLink(title: "Apple 新闻", url: "https://www.apple.com/newsroom/", icon: "newspaper")
        CategoryLink(title: "TechCrunch", url: "https://techcrunch.com", icon: "globe")
        CategoryLink(title: "The Verge", url: "https://www.theverge.com", icon: "tv")

      case "娱乐":
        CategoryLink(title: "YouTube", url: "https://www.youtube.com", icon: "play.rectangle")
        CategoryLink(title: "Netflix", url: "https://www.netflix.com", icon: "tv.circle")
        CategoryLink(title: "Spotify", url: "https://www.spotify.com", icon: "music.note")

      case "教育":
        CategoryLink(title: "Coursera", url: "https://www.coursera.org", icon: "graduationcap")
        CategoryLink(title: "Khan Academy", url: "https://www.khanacademy.org", icon: "book")
        CategoryLink(title: "edX", url: "https://www.edx.org", icon: "studentdesk")

      case "购物":
        CategoryLink(title: "Amazon", url: "https://www.amazon.com", icon: "cart")
        CategoryLink(title: "eBay", url: "https://www.ebay.com", icon: "bag")
        CategoryLink(title: "Apple Store", url: "https://www.apple.com/store", icon: "bag.fill")

      default:
        Text("选择一个分类查看相关链接")
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
  }
}

/// 分类链接项
struct CategoryLink: View {
  let title: String
  let url: String
  let icon: String

  var body: some View {
    if let linkURL = URL(string: url) {
      Link(destination: linkURL) {
        HStack {
          Image(systemName: icon)
            .foregroundColor(.blue)
            .frame(width: 20)

          Text(title)
            .foregroundColor(.primary)

          Spacer()

          Image(systemName: "arrow.up.right.square")
            .foregroundColor(.blue)
            .font(.caption)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
      }
    }
  }
}

/// 书签行视图
struct BookmarkRowView: View {
  let bookmark: BookmarkItem
  let onDelete: () -> Void

  var body: some View {
    HStack {
      if let url = URL(string: bookmark.url) {
        Link(destination: url) {
          HStack {
            Image(systemName: "bookmark.fill")
              .foregroundColor(.orange)

            VStack(alignment: .leading) {
              Text(bookmark.title)
                .foregroundColor(.primary)
                .lineLimit(1)

              Text(bookmark.url)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
            }

            Spacer()

            Text(bookmark.category)
              .font(.caption)
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .background(Color.blue.opacity(0.2))
              .cornerRadius(4)

            Image(systemName: "arrow.up.right.square")
              .foregroundColor(.blue)
              .font(.caption)
          }
        }
      }

      Button(action: onDelete) {
        Image(systemName: "trash")
          .foregroundColor(.red)
      }
      .buttonStyle(BorderlessButtonStyle())
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }
}

/// 社交分享链接
struct SocialShareLink: View {
  let platform: String
  let icon: String
  let color: Color
  let url: String

  var body: some View {
    if let shareURL = URL(string: url) {
      Link(destination: shareURL) {
        VStack {
          Image(systemName: icon)
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(color)
            .clipShape(Circle())

          Text(platform)
            .font(.caption)
            .foregroundColor(.primary)
        }
      }
    }
  }
}

/// 工具链接卡片
struct ToolLinkCard: View {
  let title: String
  let description: String
  let icon: String
  let url: String

  var body: some View {
    if let toolURL = URL(string: url) {
      Link(destination: toolURL) {
        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Image(systemName: icon)
              .foregroundColor(.blue)

            Spacer()

            Image(systemName: "arrow.up.right")
              .font(.caption)
              .foregroundColor(.secondary)
          }

          Text(title)
            .font(.headline)
            .foregroundColor(.primary)

          Text(description)
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
      }
    }
  }
}

/// 统计行视图
struct StatisticRow: View {
  let title: String
  let count: Int

  var body: some View {
    HStack {
      Text(title)
        .foregroundColor(.secondary)

      Spacer()

      Text("\(count)")
        .font(.headline)
        .foregroundColor(.primary)
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
    .background(Color.gray.opacity(0.1))
    .cornerRadius(6)
  }
}

/// 添加书签视图
struct AddBookmarkView: View {
  @Binding var title: String
  @Binding var url: String
  let onSave: () -> Void
  let onCancel: () -> Void

  var body: some View {
    NavigationView {
      Form {
        VStack(alignment: .leading, spacing: 8) {
          Text("书签信息")
            .font(.headline)

          TextField("标题", text: $title)
            .textFieldStyle(RoundedBorderTextFieldStyle())

          TextField("URL", text: $url)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            #if os(iOS)
              .keyboardType(.URL)
              .autocapitalization(.none)
            #endif
        }
        .padding()
      }
      .navigationTitle("添加书签")
      #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
      #endif
      #if os(iOS)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("取消", action: onCancel)
          }

          ToolbarItem(placement: .navigationBarTrailing) {
            Button("保存", action: onSave)
              .disabled(title.isEmpty || url.isEmpty)
          }
        })
      #elseif os(macOS)
        .toolbar(content: {
          ToolbarItem(placement: .cancellationAction) {
            Button("取消", action: onCancel)
          }

          ToolbarItem(placement: .confirmationAction) {
            Button("保存", action: onSave)
              .disabled(title.isEmpty || url.isEmpty)
          }
        })
      #endif
    }
  }
}

// MARK: - 数据模型

/// 书签数据模型
struct BookmarkItem: Identifiable {
  let id = UUID()
  let title: String
  let url: String
  let category: String
}

/// 示例书签数据
let sampleBookmarks: [BookmarkItem] = [
  BookmarkItem(title: "Apple 官网", url: "https://www.apple.com", category: "技术"),
  BookmarkItem(
    title: "SwiftUI 文档", url: "https://developer.apple.com/documentation/swiftui", category: "技术"),
  BookmarkItem(title: "GitHub", url: "https://github.com", category: "技术"),
]

// MARK: - 预览
#Preview {
  LinkExampleView04()
}
