import SwiftUI

/// 动态菜单内容示例
///
/// 展示如何创建动态变化的菜单内容：
/// - 基于状态的条件菜单项
/// - 动态生成的菜单项
/// - 响应数据变化的菜单
public struct CommandMenuExampleView05: View {
  @State private var isLoggedIn: Bool = false
  @State private var userName: String = ""
  @State private var openDocuments: [String] = []
  @State private var bookmarks: [String] = ["首页", "文档", "设置"]
  @State private var recentSearches: [String] = []

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      Text("动态菜单内容")
        .font(.largeTitle)
        .padding()

      VStack(alignment: .leading, spacing: 10) {
        HStack {
          Text("登录状态:")
          Text(isLoggedIn ? "已登录 (\(userName))" : "未登录")
            .foregroundColor(isLoggedIn ? .green : .red)
        }

        Text("打开的文档: \(openDocuments.count) 个")
        Text("书签数量: \(bookmarks.count) 个")
        Text("最近搜索: \(recentSearches.count) 个")
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(10)

      VStack(spacing: 10) {
        Button(isLoggedIn ? "退出登录" : "模拟登录") {
          if isLoggedIn {
            isLoggedIn = false
            userName = ""
            openDocuments.removeAll()
          } else {
            isLoggedIn = true
            userName = "用户\(Int.random(in: 1...999))"
            openDocuments = ["文档1.txt", "项目2.md"]
          }
        }
        .buttonStyle(DefaultButtonStyle())

        Button("添加文档") {
          let newDoc = "文档\(openDocuments.count + 1).txt"
          openDocuments.append(newDoc)
        }
        .disabled(!isLoggedIn)

        Button("添加书签") {
          let newBookmark = "书签\(bookmarks.count + 1)"
          bookmarks.append(newBookmark)
        }

        Button("模拟搜索") {
          let searches = ["SwiftUI", "CommandMenu", "动态菜单", "iOS开发", "macOS应用"]
          if let randomSearch = searches.randomElement() {
            recentSearches.insert(randomSearch, at: 0)
            if recentSearches.count > 5 {
              recentSearches.removeLast()
            }
          }
        }
      }

      VStack(alignment: .leading, spacing: 8) {
        Text("动态菜单特点:")
          .font(.headline)

        Text("• 菜单项根据应用状态动态显示/隐藏")
        Text("• 菜单内容可以基于数据动态生成")
        Text("• 支持条件逻辑控制菜单项")
        Text("• 可以响应用户操作实时更新")
      }
      .font(.caption)
      .foregroundColor(.secondary)

      Spacer()
    }
    .padding()
    .navigationTitle("动态菜单")

  }
}

/// 演示动态菜单内容的 App
struct DynamicMenuExampleApp05: App {
  @State private var isLoggedIn = false
  @State private var userName = ""
  @State private var openDocuments: [String] = []
  @State private var bookmarks = ["首页", "文档", "设置"]
  @State private var recentSearches: [String] = []
  @State private var currentTheme = "浅色"
  @State private var isFullScreen = false

  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView05()
    }
    .commands {
      // 1. 用户菜单 - 根据登录状态动态变化
      CommandMenu("用户") {
        if isLoggedIn {
          // 已登录状态的菜单项
          Text("欢迎, \(userName)")
            .foregroundColor(.secondary)

          Divider()

          Button("个人资料") {
            print("打开个人资料")
          }
          .keyboardShortcut("p", modifiers: .command)

          Button("账户设置") {
            print("打开账户设置")
          }

          Button("同步数据") {
            print("同步用户数据")
          }
          .keyboardShortcut("s", modifiers: [.command, .shift])

          Divider()

          Button("退出登录") {
            isLoggedIn = false
            userName = ""
            openDocuments.removeAll()
            print("用户已退出登录")
          }
          .keyboardShortcut("q", modifiers: [.command, .shift])
        } else {
          // 未登录状态的菜单项
          Button("登录") {
            isLoggedIn = true
            userName = "用户\(Int.random(in: 1...999))"
            openDocuments = ["欢迎文档.txt"]
            print("用户已登录: \(userName)")
          }
          .keyboardShortcut("l", modifiers: .command)

          Button("注册") {
            print("打开注册页面")
          }

          Button("忘记密码") {
            print("打开密码重置页面")
          }

          Divider()

          Button("离线模式") {
            print("启用离线模式")
          }
        }
      }

      // 2. 文档菜单 - 基于打开的文档动态生成
      CommandMenu("文档") {
        Button("新建文档") {
          let newDoc = "文档\(openDocuments.count + 1).txt"
          openDocuments.append(newDoc)
          print("创建新文档: \(newDoc)")
        }
        .keyboardShortcut("n", modifiers: .command)

        if !openDocuments.isEmpty {
          Divider()

          // 动态生成打开文档的菜单项
          ForEach(openDocuments.indices, id: \.self) { index in
            let document = openDocuments[index]

            Menu(document) {
              Button("切换到此文档") {
                print("切换到文档: \(document)")
              }

              Button("保存文档") {
                print("保存文档: \(document)")
              }
              .keyboardShortcut("s", modifiers: .command)

              Button("另存为...") {
                print("另存为: \(document)")
              }
              .keyboardShortcut("s", modifiers: [.command, .shift])

              Divider()

              Button("关闭文档") {
                openDocuments.remove(at: index)
                print("关闭文档: \(document)")
              }
              .keyboardShortcut("w", modifiers: .command)
            }
          }

          Divider()

          Button("关闭所有文档") {
            let count = openDocuments.count
            openDocuments.removeAll()
            print("关闭了 \(count) 个文档")
          }
          .keyboardShortcut("w", modifiers: [.command, .option])
          .disabled(openDocuments.isEmpty)

          Button("保存所有文档") {
            print("保存所有 \(openDocuments.count) 个文档")
          }
          .keyboardShortcut("s", modifiers: [.command, .option])
        } else {
          Divider()

          Text("没有打开的文档")
            .foregroundColor(.secondary)
        }
      }

      // 3. 书签菜单 - 动态书签列表
      CommandMenu("书签") {
        Button("添加书签") {
          let newBookmark = "书签\(bookmarks.count + 1)"
          bookmarks.append(newBookmark)
          print("添加书签: \(newBookmark)")
        }
        .keyboardShortcut("d", modifiers: .command)

        Button("管理书签") {
          print("打开书签管理器")
        }
        .keyboardShortcut("b", modifiers: [.command, .option])

        if !bookmarks.isEmpty {
          Divider()

          // 动态生成书签菜单项
          ForEach(bookmarks.indices, id: \.self) { index in
            let bookmark = bookmarks[index]

            Button(bookmark) {
              print("打开书签: \(bookmark)")
            }
            .keyboardShortcut(KeyEquivalent(Character("\(index + 1)")), modifiers: .command)
          }

          if bookmarks.count > 3 {
            Divider()

            Button("清理书签") {
              bookmarks = Array(bookmarks.prefix(3))
              print("清理多余书签")
            }
          }
        }
      }

      // 4. 搜索菜单 - 基于搜索历史动态变化
      CommandMenu("搜索") {
        Button("新搜索") {
          print("开始新搜索")
        }
        .keyboardShortcut("f", modifiers: .command)

        Button("高级搜索") {
          print("打开高级搜索")
        }
        .keyboardShortcut("f", modifiers: [.command, .shift])

        if !recentSearches.isEmpty {
          Divider()

          Text("最近搜索:")
            .foregroundColor(.secondary)

          // 动态生成最近搜索项
          ForEach(recentSearches.prefix(5), id: \.self) { search in
            Button("搜索: \(search)") {
              print("重新搜索: \(search)")
            }
          }

          Divider()

          Button("清除搜索历史") {
            recentSearches.removeAll()
            print("清除搜索历史")
          }
        } else {
          Divider()

          Text("没有搜索历史")
            .foregroundColor(.secondary)
        }
      }

      // 5. 视图菜单 - 根据当前状态动态调整
      CommandMenu("视图") {
        // 主题切换 - 显示当前主题状态
        Menu("主题 (当前: \(currentTheme))") {
          Button("浅色主题") {
            currentTheme = "浅色"
            print("切换到浅色主题")
          }
          .disabled(currentTheme == "浅色")

          Button("深色主题") {
            currentTheme = "深色"
            print("切换到深色主题")
          }
          .disabled(currentTheme == "深色")

          Button("自动主题") {
            currentTheme = "自动"
            print("切换到自动主题")
          }
          .disabled(currentTheme == "自动")
        }

        Divider()

        // 全屏模式切换
        Button(isFullScreen ? "退出全屏" : "进入全屏") {
          isFullScreen.toggle()
          print(isFullScreen ? "进入全屏模式" : "退出全屏模式")
        }
        .keyboardShortcut("f", modifiers: [.command, .control])

        // 根据登录状态显示不同的视图选项
        if isLoggedIn {
          Button("同步视图设置") {
            print("同步用户的视图设置")
          }

          Button("个性化布局") {
            print("应用个性化布局")
          }
        } else {
          Button("默认布局") {
            print("应用默认布局")
          }

          Text("登录后可使用更多视图选项")
            .foregroundColor(.secondary)
        }

        Divider()

        // 根据打开文档数量显示不同选项
        if openDocuments.count > 1 {
          Button("平铺所有文档") {
            print("平铺显示所有 \(openDocuments.count) 个文档")
          }

          Button("标签页视图") {
            print("切换到标签页视图")
          }
        } else if openDocuments.count == 1 {
          Button("专注模式") {
            print("启用专注模式")
          }
        } else {
          Button("欢迎页面") {
            print("显示欢迎页面")
          }
        }
      }
    }
  }
}

#Preview {
  CommandMenuExampleView05()
}
