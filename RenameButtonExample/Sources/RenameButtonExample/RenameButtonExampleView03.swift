import SwiftUI

/// RenameButton 自定义样式和高级功能示例
/// 演示 RenameButton 的样式定制和高级使用场景
public struct RenameButtonExampleView03: View {
  // MARK: - 状态属性

  /// 项目数据模型
  struct ProjectItem: Identifiable {
    let id = UUID()
    var name: String
    var type: ProjectType
    var isStarred: Bool
    var lastModified: Date
    var tags: [String]
  }

  /// 项目类型枚举
  enum ProjectType: String, CaseIterable {
    case document = "文档"
    case presentation = "演示文稿"
    case spreadsheet = "电子表格"
    case image = "图片"
    case video = "视频"

    var icon: String {
      switch self {
      case .document: return "doc.text"
      case .presentation: return "rectangle.on.rectangle"
      case .spreadsheet: return "tablecells"
      case .image: return "photo"
      case .video: return "video"
      }
    }

    var color: Color {
      switch self {
      case .document: return .blue
      case .presentation: return .orange
      case .spreadsheet: return .green
      case .image: return .purple
      case .video: return .red
      }
    }
  }

  /// 项目列表
  @State private var projects: [ProjectItem] = [
    ProjectItem(
      name: "年度报告", type: .document, isStarred: true,
      lastModified: Date().addingTimeInterval(-3600), tags: ["重要", "工作"]),
    ProjectItem(
      name: "产品介绍", type: .presentation, isStarred: false,
      lastModified: Date().addingTimeInterval(-7200), tags: ["产品", "营销"]),
    ProjectItem(
      name: "销售数据", type: .spreadsheet, isStarred: true,
      lastModified: Date().addingTimeInterval(-1800), tags: ["数据", "分析"]),
    ProjectItem(
      name: "团队合影", type: .image, isStarred: false, lastModified: Date().addingTimeInterval(-5400),
      tags: ["团队", "照片"]),
    ProjectItem(
      name: "培训视频", type: .video, isStarred: false, lastModified: Date().addingTimeInterval(-9000),
      tags: ["培训", "教育"]),
  ]

  /// 当前编辑的项目索引
  @State private var editingIndex: Int?

  /// 编辑中的名称
  @State private var editingName: String = ""

  /// 焦点状态
  @FocusState private var isNameFieldFocused: Bool

  /// 搜索文本
  @State private var searchText: String = ""

  /// 选中的项目类型过滤
  @State private var selectedTypeFilter: ProjectType?

  /// 显示重命名历史
  @State private var showRenameHistory = false

  /// 重命名历史记录
  @State private var renameHistory: [RenameRecord] = []

  /// 重命名记录模型
  struct RenameRecord: Identifiable {
    let id = UUID()
    let oldName: String
    let newName: String
    let timestamp: Date
    let projectType: ProjectType
  }

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        // MARK: - 搜索和过滤栏
        VStack(spacing: 12) {
          // 搜索栏
          HStack {
            Image(systemName: "magnifyingglass")
              .foregroundColor(.secondary)

            TextField("搜索项目...", text: $searchText)
              .textFieldStyle(PlainTextFieldStyle())
          }
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .background(Color(.systemGray6))
          .cornerRadius(10)

          // 类型过滤器
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              FilterChip(
                title: "全部",
                isSelected: selectedTypeFilter == nil
              ) {
                selectedTypeFilter = nil
              }

              ForEach(ProjectType.allCases, id: \.self) { type in
                FilterChip(
                  title: type.rawValue,
                  isSelected: selectedTypeFilter == type,
                  color: type.color
                ) {
                  selectedTypeFilter = selectedTypeFilter == type ? nil : type
                }
              }
            }
            .padding(.horizontal)
          }
        }
        .padding()
        .background(Color(.systemBackground))

        // MARK: - 项目列表
        List {
          ForEach(filteredProjects.indices, id: \.self) { index in
            let originalIndex = projects.firstIndex { $0.id == filteredProjects[index].id }!

            ProjectRowView(
              project: filteredProjects[index],
              isEditing: editingIndex == originalIndex,
              editingName: $editingName,
              isFocused: $isNameFieldFocused,
              onStarToggle: {
                projects[originalIndex].isStarred.toggle()
              }
            )
            .contextMenu {
              // 自定义样式的 RenameButton
              RenameButton()

              Divider()

              Button(
                projects[originalIndex].isStarred ? "取消收藏" : "收藏",
                systemImage: projects[originalIndex].isStarred ? "star.slash" : "star"
              ) {
                projects[originalIndex].isStarred.toggle()
              }

              Button("复制", systemImage: "doc.on.doc") {
                copyProject(at: originalIndex)
              }

              Button("分享", systemImage: "square.and.arrow.up") {
                shareProject(at: originalIndex)
              }

              Divider()

              Button("删除", systemImage: "trash", role: .destructive) {
                deleteProject(at: originalIndex)
              }
            }
            .renameAction {
              startRenaming(at: originalIndex)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
              Button("删除", role: .destructive) {
                deleteProject(at: originalIndex)
              }

              Button("重命名") {
                startRenaming(at: originalIndex)
              }
              .tint(.blue)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
              Button(projects[originalIndex].isStarred ? "取消收藏" : "收藏") {
                projects[originalIndex].isStarred.toggle()
              }
              .tint(projects[originalIndex].isStarred ? .gray : .yellow)
            }
          }
        }
        .listStyle(PlainListStyle())
      }
      .navigationTitle("项目管理")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            Button("重命名历史", systemImage: "clock") {
              showRenameHistory = true
            }

            Button("添加项目", systemImage: "plus") {
              addNewProject()
            }

            Divider()

            Button("导出列表", systemImage: "square.and.arrow.up") {
              exportProjectList()
            }
          } label: {
            Image(systemName: "ellipsis.circle")
          }
        }
      }
    }
    // 重命名历史页面
    .sheet(isPresented: $showRenameHistory) {
      RenameHistoryView(history: renameHistory)
    }
    // 监听编辑完成
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
    { _ in
      if editingIndex != nil {
        completeRenaming()
      }
    }
  }

  // MARK: - 计算属性

  /// 过滤后的项目列表
  private var filteredProjects: [ProjectItem] {
    var filtered = projects

    // 按类型过滤
    if let selectedType = selectedTypeFilter {
      filtered = filtered.filter { $0.type == selectedType }
    }

    // 按搜索文本过滤
    if !searchText.isEmpty {
      filtered = filtered.filter { project in
        project.name.localizedCaseInsensitiveContains(searchText)
          || project.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
      }
    }

    // 按收藏和修改时间排序
    return filtered.sorted { first, second in
      if first.isStarred != second.isStarred {
        return first.isStarred
      }
      return first.lastModified > second.lastModified
    }
  }

  // MARK: - 辅助方法

  /// 开始重命名
  private func startRenaming(at index: Int) {
    editingIndex = index
    editingName = projects[index].name

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isNameFieldFocused = true
    }
  }

  /// 完成重命名
  private func completeRenaming() {
    guard let index = editingIndex else { return }

    let trimmedName = editingName.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedName.isEmpty && trimmedName != projects[index].name {
      // 记录重命名历史
      let record = RenameRecord(
        oldName: projects[index].name,
        newName: trimmedName,
        timestamp: Date(),
        projectType: projects[index].type
      )
      renameHistory.insert(record, at: 0)

      // 更新项目名称
      projects[index].name = trimmedName
      projects[index].lastModified = Date()
    }

    // 重置编辑状态
    editingIndex = nil
    editingName = ""
    isNameFieldFocused = false
  }

  /// 复制项目
  private func copyProject(at index: Int) {
    let original = projects[index]
    let copy = ProjectItem(
      name: "\(original.name) 副本",
      type: original.type,
      isStarred: false,
      lastModified: Date(),
      tags: original.tags
    )
    projects.insert(copy, at: index + 1)
  }

  /// 分享项目
  private func shareProject(at index: Int) {
    let project = projects[index]
    print("分享项目: \(project.name)")
  }

  /// 删除项目
  private func deleteProject(at index: Int) {
    projects.remove(at: index)
  }

  /// 添加新项目
  private func addNewProject() {
    let newProject = ProjectItem(
      name: "新项目",
      type: .document,
      isStarred: false,
      lastModified: Date(),
      tags: ["新建"]
    )
    projects.insert(newProject, at: 0)
  }

  /// 导出项目列表
  private func exportProjectList() {
    print("导出项目列表")
  }
}

// MARK: - 项目行视图
struct ProjectRowView: View {
  let project: RenameButtonExampleView03.ProjectItem
  let isEditing: Bool
  @Binding var editingName: String
  @FocusState.Binding var isFocused: Bool
  let onStarToggle: () -> Void

  var body: some View {
    HStack(spacing: 12) {
      // 项目类型图标
      Image(systemName: project.type.icon)
        .font(.title2)
        .foregroundColor(project.type.color)
        .frame(width: 30)

      VStack(alignment: .leading, spacing: 4) {
        // 项目名称
        if isEditing {
          TextField("项目名称", text: $editingName)
            .focused($isFocused)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
              isFocused = false
            }
        } else {
          HStack {
            Text(project.name)
              .font(.body)
              .fontWeight(.medium)

            if project.isStarred {
              Image(systemName: "star.fill")
                .font(.caption)
                .foregroundColor(.yellow)
            }
          }
        }

        // 项目信息
        HStack {
          Text(project.type.rawValue)
            .font(.caption)
            .foregroundColor(.secondary)

          Text("•")
            .font(.caption)
            .foregroundColor(.secondary)

          Text(formatDate(project.lastModified))
            .font(.caption)
            .foregroundColor(.secondary)
        }

        // 标签
        if !project.tags.isEmpty {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
              ForEach(project.tags, id: \.self) { tag in
                Text(tag)
                  .font(.caption2)
                  .padding(.horizontal, 6)
                  .padding(.vertical, 2)
                  .background(project.type.color.opacity(0.2))
                  .foregroundColor(project.type.color)
                  .cornerRadius(4)
              }
            }
          }
        }
      }

      Spacer()

      // 收藏按钮
      Button(action: onStarToggle) {
        Image(systemName: project.isStarred ? "star.fill" : "star")
          .foregroundColor(project.isStarred ? .yellow : .gray)
      }
      .buttonStyle(PlainButtonStyle())
    }
    .padding(.vertical, 4)
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.localizedString(for: date, relativeTo: Date())
  }
}

// MARK: - 过滤器芯片
struct FilterChip: View {
  let title: String
  let isSelected: Bool
  let color: Color
  let action: () -> Void

  init(title: String, isSelected: Bool, color: Color = .blue, action: @escaping () -> Void) {
    self.title = title
    self.isSelected = isSelected
    self.color = color
    self.action = action
  }

  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.caption)
        .fontWeight(.medium)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isSelected ? color : Color(.systemGray5))
        .foregroundColor(isSelected ? .white : .primary)
        .cornerRadius(16)
    }
    .buttonStyle(PlainButtonStyle())
  }
}

// MARK: - 重命名历史视图
struct RenameHistoryView: View {
  let history: [RenameButtonExampleView03.RenameRecord]
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationView {
      List {
        if history.isEmpty {
          ContentUnavailableView(
            "暂无重命名记录",
            systemImage: "clock",
            description: Text("当您重命名项目时，历史记录将显示在这里")
          )
        } else {
          ForEach(history) { record in
            VStack(alignment: .leading, spacing: 4) {
              HStack {
                Image(systemName: record.projectType.icon)
                  .foregroundColor(record.projectType.color)

                Text(record.projectType.rawValue)
                  .font(.caption)
                  .foregroundColor(.secondary)

                Spacer()

                Text(formatDate(record.timestamp))
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              HStack {
                Text(record.oldName)
                  .strikethrough()
                  .foregroundColor(.secondary)

                Image(systemName: "arrow.right")
                  .font(.caption)
                  .foregroundColor(.secondary)

                Text(record.newName)
                  .fontWeight(.medium)
              }
              .font(.body)
            }
            .padding(.vertical, 2)
          }
        }
      }
      .navigationTitle("重命名历史")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("完成") {
            dismiss()
          }
        } as ToolbarContent
      }
    }
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.string(from: date)
  }
}

// MARK: - 预览
#Preview {
  RenameButtonExampleView03()
}
