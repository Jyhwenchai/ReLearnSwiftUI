import SwiftUI

/// MenuExampleView06 - 高级菜单功能示例
/// 展示动态菜单、条件菜单项、状态管理等高级功能
public struct MenuExampleView06: View {
  @State private var selectedAction = "未选择任何操作"
  @State private var isLoggedIn = false
  @State private var userRole: UserRole = .guest
  @State private var selectedItems: Set<Int> = []
  @State private var recentFiles = ["文档1.pdf", "报告2.docx", "表格3.xlsx"]
  @State private var favoriteActions = ["复制", "粘贴", "保存"]
  @State private var showAdvancedOptions = false

  // 模拟数据
  private let allItems = Array(1...10)

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("高级菜单功能")
          .font(.largeTitle)
          .fontWeight(.bold)

        Text("当前状态: \(selectedAction)")
          .foregroundColor(.secondary)
          .padding()
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)

        VStack(spacing: 25) {
          // 示例1: 动态菜单内容
          Group {
            Text("动态菜单内容")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              HStack {
                Text("最近文件数量: \(recentFiles.count)")
                Spacer()
                Button("添加文件") {
                  recentFiles.append("新文件\(recentFiles.count + 1).txt")
                }
                .buttonStyle(.bordered)
              }

              Menu("最近文件") {
                if recentFiles.isEmpty {
                  Text("没有最近文件")
                    .foregroundColor(.secondary)
                } else {
                  ForEach(recentFiles, id: \.self) { file in
                    Button(action: { selectAction("打开 \(file)") }) {
                      Label(file, systemImage: "doc")
                    }
                  }

                  Divider()

                  Button("清除历史", role: .destructive) {
                    recentFiles.removeAll()
                    selectAction("清除最近文件历史")
                  }
                }
              }
              .buttonStyle(.borderedProminent)
            }
          }

          Divider()

          // 示例2: 条件菜单项
          Group {
            Text("条件菜单项")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              HStack {
                Toggle("已登录", isOn: $isLoggedIn)
                Spacer()
                Picker("用户角色", selection: $userRole) {
                  Text("访客").tag(UserRole.guest)
                  Text("用户").tag(UserRole.user)
                  Text("管理员").tag(UserRole.admin)
                }
                .pickerStyle(.menu)
              }

              Menu("用户菜单") {
                if isLoggedIn {
                  Button(action: { selectAction("查看个人资料") }) {
                    Label("个人资料", systemImage: "person.circle")
                  }

                  Button(action: { selectAction("设置") }) {
                    Label("设置", systemImage: "gearshape")
                  }

                  // 根据用户角色显示不同选项
                  if userRole == .admin {
                    Divider()

                    Menu("管理员功能") {
                      Button("用户管理", action: { selectAction("用户管理") })
                      Button("系统设置", action: { selectAction("系统设置") })
                      Button("日志查看", action: { selectAction("日志查看") })
                    }
                  } else if userRole == .user {
                    Button(action: { selectAction("我的文档") }) {
                      Label("我的文档", systemImage: "folder")
                    }
                  }

                  Divider()

                  Button("退出登录", role: .destructive) {
                    isLoggedIn = false
                    selectAction("退出登录")
                  }
                } else {
                  Button(action: {
                    isLoggedIn = true
                    selectAction("登录")
                  }) {
                    Label("登录", systemImage: "person.badge.key")
                  }

                  Button(action: { selectAction("注册") }) {
                    Label("注册", systemImage: "person.badge.plus")
                  }
                }
              }
              .buttonStyle(.bordered)
            }
          }

          Divider()

          // 示例3: 多选菜单
          Group {
            Text("多选菜单")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              Text("已选择: \(selectedItems.count) 项")
                .foregroundColor(.secondary)

              LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 10) {
                ForEach(allItems, id: \.self) { item in
                  Button("\(item)") {
                    if selectedItems.contains(item) {
                      selectedItems.remove(item)
                    } else {
                      selectedItems.insert(item)
                    }
                  }
                  .buttonStyle(.bordered)
                  .background(selectedItems.contains(item) ? Color.blue.opacity(0.2) : Color.clear)
                  .cornerRadius(8)
                }
              }

              Menu("批量操作") {
                if selectedItems.isEmpty {
                  Text("请先选择项目")
                    .foregroundColor(.secondary)
                } else {
                  Button(action: {
                    selectAction("复制 \(selectedItems.count) 个项目")
                  }) {
                    Label("复制选中项", systemImage: "doc.on.doc")
                  }

                  Button(action: {
                    selectAction("移动 \(selectedItems.count) 个项目")
                  }) {
                    Label("移动选中项", systemImage: "folder")
                  }

                  Button(action: {
                    selectAction("导出 \(selectedItems.count) 个项目")
                  }) {
                    Label("导出选中项", systemImage: "square.and.arrow.up")
                  }

                  Divider()

                  Button(
                    "全选",
                    action: {
                      selectedItems = Set(allItems)
                      selectAction("全选")
                    })

                  Button(
                    "取消选择",
                    action: {
                      selectedItems.removeAll()
                      selectAction("取消选择")
                    })

                  Divider()

                  Button("删除选中项", role: .destructive) {
                    selectAction("删除 \(selectedItems.count) 个项目")
                    selectedItems.removeAll()
                  }
                }
              }
              .buttonStyle(.borderedProminent)
              .disabled(selectedItems.isEmpty)
            }
          }

          Divider()

          // 示例4: 自定义菜单项
          Group {
            Text("自定义菜单项")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            Menu("自定义菜单") {
              // 带副标题的菜单项
              Button(action: { selectAction("新建文档") }) {
                VStack(alignment: .leading, spacing: 2) {
                  Text("新建文档")
                    .fontWeight(.medium)
                  Text("创建一个新的文档文件")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
              }

              Button(action: { selectAction("打开文件夹") }) {
                VStack(alignment: .leading, spacing: 2) {
                  Text("打开文件夹")
                    .fontWeight(.medium)
                  Text("浏览本地文件夹")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
              }

              Divider()

              // 带状态指示的菜单项
              Button(action: {
                showAdvancedOptions.toggle()
                selectAction("切换高级选项")
              }) {
                HStack {
                  Text("高级选项")
                  Spacer()
                  Image(systemName: showAdvancedOptions ? "checkmark" : "")
                    .foregroundColor(.blue)
                }
              }

              // 带快捷键提示的菜单项
              Button(action: { selectAction("保存文档") }) {
                HStack {
                  Label("保存", systemImage: "square.and.arrow.down")
                  Spacer()
                  Text("⌘S")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
              }

              Button(action: { selectAction("查找") }) {
                HStack {
                  Label("查找", systemImage: "magnifyingglass")
                  Spacer()
                  Text("⌘F")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
              }
            }
            .buttonStyle(.bordered)
          }

          Divider()

          // 示例5: 收藏夹菜单
          Group {
            Text("收藏夹菜单")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              HStack {
                Text("收藏的操作:")
                Spacer()
                Button("重置") {
                  favoriteActions = ["复制", "粘贴", "保存"]
                }
                .buttonStyle(.bordered)
              }

              Menu("收藏夹") {
                ForEach(favoriteActions, id: \.self) { action in
                  Button(action: { selectAction("执行收藏操作: \(action)") }) {
                    HStack {
                      Label(action, systemImage: iconForAction(action))
                      Spacer()
                      Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    }
                  }
                }

                if !favoriteActions.isEmpty {
                  Divider()
                }

                Menu("添加到收藏夹") {
                  let availableActions = ["剪切", "删除", "重命名", "移动", "压缩"]
                  ForEach(availableActions, id: \.self) { action in
                    if !favoriteActions.contains(action) {
                      Button("添加 \(action)") {
                        favoriteActions.append(action)
                        selectAction("添加 \(action) 到收藏夹")
                      }
                    }
                  }
                }

                if !favoriteActions.isEmpty {
                  Menu("从收藏夹移除") {
                    ForEach(favoriteActions, id: \.self) { action in
                      Button("移除 \(action)") {
                        favoriteActions.removeAll { $0 == action }
                        selectAction("从收藏夹移除 \(action)")
                      }
                    }
                  }
                }
              }
              .buttonStyle(.borderedProminent)
            }
          }
        }

        // 说明文本
        VStack(alignment: .leading, spacing: 8) {
          Text("高级功能说明:")
            .fontWeight(.semibold)
          Text("• 动态生成菜单内容")
          Text("• 根据状态条件显示不同菜单项")
          Text("• 支持多选和批量操作")
          Text("• 自定义菜单项样式和内容")
          Text("• 收藏夹和个性化菜单")
        }
        .font(.caption)
        .foregroundColor(.secondary)
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(8)
      }
      .padding()
    }
    .navigationTitle("高级功能")
    #if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 辅助方法

  /// 选择操作
  private func selectAction(_ action: String) {
    selectedAction = action
  }

  /// 获取操作对应的图标
  private func iconForAction(_ action: String) -> String {
    switch action {
    case "复制": return "doc.on.doc"
    case "粘贴": return "doc.on.clipboard"
    case "保存": return "square.and.arrow.down"
    case "剪切": return "scissors"
    case "删除": return "trash"
    case "重命名": return "pencil"
    case "移动": return "folder"
    case "压缩": return "archivebox"
    default: return "star"
    }
  }
}

// MARK: - 数据模型

/// 用户角色枚举
enum UserRole: CaseIterable {
  case guest, user, admin

  var displayName: String {
    switch self {
    case .guest: return "访客"
    case .user: return "用户"
    case .admin: return "管理员"
    }
  }
}

#Preview {
  NavigationView {
    MenuExampleView06()
  }
}
