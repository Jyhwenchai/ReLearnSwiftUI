import SwiftUI

/// RenameButton 与导航标题结合使用示例
/// 演示在导航标题菜单中使用 RenameButton 的方法
public struct RenameButtonExampleView02: View {
  // MARK: - 状态属性

  /// 文档数据模型
  struct Document: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var lastModified: Date
    var wordCount: Int
  }

  /// 当前文档
  @State private var currentDocument = Document(
    title: "我的文档",
    content:
      "这是一个示例文档的内容。您可以在这里编写任何内容，并且可以通过导航栏的重命名功能来修改文档标题。\n\n这个示例展示了如何在导航标题菜单中使用 RenameButton，这是一个非常实用的功能，特别适用于文档编辑、笔记应用等场景。",
    lastModified: Date(),
    wordCount: 85
  )

  /// 文档标题的绑定状态（用于导航标题）
  @State private var documentTitle: String = "我的文档"

  /// 文档内容编辑状态
  @State private var isEditingContent = false

  /// 显示文档信息
  @State private var showDocumentInfo = false

  /// 显示保存成功提示
  @State private var showSaveSuccess = false

  /// 文档历史记录
  @State private var documentHistory: [String] = []

  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        VStack(spacing: 20) {
          // MARK: - 文档信息卡片
          DocumentInfoCard(document: currentDocument)

          // MARK: - 文档内容编辑区域
          VStack(alignment: .leading, spacing: 12) {
            HStack {
              Text("文档内容")
                .font(.headline)

              Spacer()

              Button(isEditingContent ? "完成" : "编辑") {
                isEditingContent.toggle()
                if !isEditingContent {
                  saveDocument()
                }
              }
              .buttonStyle(.bordered)
            }

            if isEditingContent {
              TextEditor(text: $currentDocument.content)
                .frame(minHeight: 200)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onChange(of: currentDocument.content) { _, newValue in
                  updateWordCount()
                }
            } else {
              Text(currentDocument.content)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
          }

          // MARK: - 操作说明
          InstructionCard()

          Spacer(minLength: 50)
        }
        .padding()
      }
      // 导航标题
      .navigationTitle(documentTitle)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            // 导航标题菜单中的 RenameButton
            RenameButton()

            Divider()

            Button("文档信息", systemImage: "info.circle") {
              showDocumentInfo = true
            }

            Button("导出", systemImage: "square.and.arrow.up") {
              exportDocument()
            }

            Button("复制标题", systemImage: "doc.on.doc") {
              copyTitle()
            }
          } label: {
            Image(systemName: "ellipsis.circle")
          }
        } as ToolbarContent
      }
      .renameAction {
        // 模拟重命名操作，在实际应用中这里会触发文本编辑
        let alert = UIAlertController(title: "重命名文档", message: "请输入新的文档标题", preferredStyle: .alert)
        alert.addTextField { textField in
          textField.text = documentTitle
          textField.placeholder = "文档标题"
        }

        let confirmAction = UIAlertAction(title: "确认", style: .default) { _ in
          if let newTitle = alert.textFields?.first?.text, !newTitle.isEmpty {
            documentTitle = newTitle
            updateDocumentTitle(newTitle)
          }
        }

        let cancelAction = UIAlertAction(title: "取消", style: .cancel)

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first
        {
          window.rootViewController?.present(alert, animated: true)
        }
      }
      .navigationBarTitleDisplayMode(.large)
    }
    // 监听标题变化
    .onChange(of: documentTitle) { oldValue, newValue in
      if oldValue != newValue && !newValue.isEmpty {
        updateDocumentTitle(newValue)
      }
    }
    // 文档信息弹窗
    .sheet(isPresented: $showDocumentInfo) {
      DocumentInfoSheet(document: currentDocument, history: documentHistory)
    }
    // 保存成功提示
    .alert("保存成功", isPresented: $showSaveSuccess) {
      Button("确定") {}
    } message: {
      Text("文档已保存")
    }
    .onAppear {
      // 初始化标题
      documentTitle = currentDocument.title
    }
  }

  // MARK: - 辅助方法

  /// 更新文档标题
  private func updateDocumentTitle(_ newTitle: String) {
    let trimmedTitle = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedTitle.isEmpty {
      // 保存历史记录
      if currentDocument.title != trimmedTitle {
        documentHistory.append("标题从 '\(currentDocument.title)' 更改为 '\(trimmedTitle)'")
      }

      currentDocument.title = trimmedTitle
      currentDocument.lastModified = Date()
    }
  }

  /// 更新字数统计
  private func updateWordCount() {
    currentDocument.wordCount = currentDocument.content.count
    currentDocument.lastModified = Date()
  }

  /// 保存文档
  private func saveDocument() {
    currentDocument.lastModified = Date()
    updateWordCount()
    showSaveSuccess = true

    // 添加保存记录
    documentHistory.append("文档已保存 - \(formatDate(currentDocument.lastModified))")
  }

  /// 导出文档
  private func exportDocument() {
    // 模拟导出功能
    print("导出文档: \(currentDocument.title)")
    documentHistory.append("文档已导出 - \(formatDate(Date()))")
  }

  /// 复制标题
  private func copyTitle() {
    UIPasteboard.general.string = currentDocument.title
    documentHistory.append("标题已复制到剪贴板")
  }

  /// 格式化日期
  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.string(from: date)
  }
}

// MARK: - 文档信息卡片
struct DocumentInfoCard: View {
  let document: RenameButtonExampleView02.Document

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("文档信息")
        .font(.headline)

      VStack(spacing: 8) {
        InfoRow(label: "标题", value: document.title)
        InfoRow(label: "字数", value: "\(document.wordCount) 字符")
        InfoRow(label: "最后修改", value: formatDate(document.lastModified))
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(12)
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.string(from: date)
  }
}

// MARK: - 信息行
struct InfoRow: View {
  let label: String
  let value: String

  var body: some View {
    HStack {
      Text(label)
        .foregroundColor(.secondary)
        .frame(width: 80, alignment: .leading)

      Text(value)
        .fontWeight(.medium)

      Spacer()
    }
    .font(.body)
  }
}

// MARK: - 操作说明卡片
struct InstructionCard: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("使用说明")
        .font(.headline)

      VStack(alignment: .leading, spacing: 6) {
        InstructionItem(
          icon: "ellipsis.circle",
          text: "点击导航栏右上角的菜单按钮"
        )

        InstructionItem(
          icon: "pencil",
          text: "选择 '重命名' 来修改文档标题"
        )

        InstructionItem(
          icon: "keyboard",
          text: "输入新标题后按回车键确认"
        )

        InstructionItem(
          icon: "info.circle",
          text: "查看文档信息了解更多详情"
        )
      }
    }
    .padding()
    .background(Color(.systemBlue).opacity(0.1))
    .cornerRadius(12)
  }
}

// MARK: - 说明项目
struct InstructionItem: View {
  let icon: String
  let text: String

  var body: some View {
    HStack(spacing: 8) {
      Image(systemName: icon)
        .foregroundColor(.blue)
        .frame(width: 20)

      Text(text)
        .font(.caption)
        .foregroundColor(.primary)
    }
  }
}

// MARK: - 文档信息详情页
struct DocumentInfoSheet: View {
  let document: RenameButtonExampleView02.Document
  let history: [String]
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationView {
      List {
        Section("文档详情") {
          InfoRow(label: "标题", value: document.title)
          InfoRow(label: "字符数", value: "\(document.wordCount)")
          InfoRow(label: "创建时间", value: formatDate(document.lastModified))
          InfoRow(label: "文档ID", value: document.id.uuidString.prefix(8).uppercased())
        }

        if !history.isEmpty {
          Section("操作历史") {
            ForEach(history.reversed(), id: \.self) { record in
              Text(record)
                .font(.caption)
            }
          }
        }
      }
      .navigationTitle("文档信息")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("完成") {
            dismiss()
          }
        }
      }
    }
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .medium
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.string(from: date)
  }
}

// MARK: - 预览
#Preview {
  RenameButtonExampleView02()
}
