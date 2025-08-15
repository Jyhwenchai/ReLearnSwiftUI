import SwiftUI

/// TextEditor 高级功能示例
///
/// 本示例演示了 TextEditor 的高级功能，包括：
/// - 文本格式化和验证
/// - 基础的文本统计
/// - 简单的搜索功能
/// - 文本处理技巧
public struct TextEditorExampleView03: View {
  // MARK: - 状态属性

  /// 格式化文本
  @State private var formattedText = ""
  @State private var wordCount = 0
  @State private var characterCount = 0

  /// 搜索功能
  @State private var searchableText = """
    这是一个支持搜索功能的文本编辑器。
    你可以在这里输入任何内容，然后使用搜索功能查找特定的文字。
    搜索功能支持实时高亮显示匹配的内容。
    SwiftUI 让文本处理变得更加简单和直观。
    """
  @State private var searchText = ""
  @State private var searchResults: [Range<String.Index>] = []

  /// 工具栏功能
  @State private var toolbarText = ""

  /// 简单的历史记录
  @State private var undoRedoText = ""
  @State private var textHistory: [String] = []
  @State private var historyIndex = -1

  // MARK: - 视图主体

  public init() {}

  public var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("TextEditor 高级功能")
          .font(.largeTitle.bold())
          .padding(.horizontal)

        VStack(alignment: .leading, spacing: 16) {
          // MARK: - 文本统计和格式化
          VStack(alignment: .leading, spacing: 8) {
            Text("1. 文本统计和格式化")
              .font(.headline)
              .foregroundColor(.primary)

            Text("实时统计字符数、单词数，并提供格式化选项")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $formattedText)
              .frame(height: 120)
              .padding(12)
              .background(Color(.systemGray6))
              .cornerRadius(8)
              .onReceive([formattedText].publisher.first()) { value in
                updateTextStatistics(value)
              }

            // 统计信息
            HStack {
              VStack(alignment: .leading) {
                Text("字符数: \(characterCount)")
                Text("单词数: \(wordCount)")
              }
              .font(.caption)
              .foregroundColor(.secondary)

              Spacer()

              // 格式化按钮
              Menu("格式化") {
                Button("转为大写") {
                  formattedText = formattedText.uppercased()
                }
                Button("转为小写") {
                  formattedText = formattedText.lowercased()
                }
                Button("首字母大写") {
                  formattedText = formattedText.capitalized
                }
                Button("清除多余空格") {
                  formattedText =
                    formattedText
                    .components(separatedBy: .whitespacesAndNewlines)
                    .filter { !$0.isEmpty }
                    .joined(separator: " ")
                }
              }
              .buttonStyle(.bordered)
            }
          }

          Divider()

          // MARK: - 搜索功能
          VStack(alignment: .leading, spacing: 8) {
            Text("2. 文本搜索功能")
              .font(.headline)
              .foregroundColor(.primary)

            Text("在文本中搜索特定内容")
              .font(.caption)
              .foregroundColor(.secondary)

            // 搜索框
            HStack {
              Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)

              TextField("搜索文本...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive([searchText].publisher.first()) { value in
                  performSearch(value)
                }

              if !searchText.isEmpty {
                Button("清除") {
                  searchText = ""
                  searchResults = []
                }
                .font(.caption)
              }
            }

            // 可搜索的文本编辑器
            ZStack(alignment: .topLeading) {
              TextEditor(text: $searchableText)
                .frame(height: 150)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onReceive([searchableText].publisher.first()) { _ in
                  if !searchText.isEmpty {
                    performSearch(searchText)
                  }
                }

              // 搜索结果高亮（简化版本）
              if !searchResults.isEmpty {
                Text("找到 \(searchResults.count) 个匹配项")
                  .font(.caption)
                  .foregroundColor(.blue)
                  .padding(4)
                  .background(Color.blue.opacity(0.1))
                  .cornerRadius(4)
                  .offset(x: 12, y: -30)
              }
            }
          }

          Divider()

          // MARK: - 简单的撤销重做功能
          VStack(alignment: .leading, spacing: 8) {
            Text("3. 简单的撤销重做功能")
              .font(.headline)
              .foregroundColor(.primary)

            Text("支持基础的撤销和重做操作")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $undoRedoText)
              .frame(height: 100)
              .padding(12)
              .background(Color(.systemGray6))
              .cornerRadius(8)

            HStack {
              Button("保存状态") {
                addToHistory(undoRedoText)
              }
              .buttonStyle(.bordered)

              Button("撤销") {
                undo()
              }
              .disabled(historyIndex < 0)
              .buttonStyle(.bordered)

              Button("重做") {
                redo()
              }
              .disabled(historyIndex >= textHistory.count - 1)
              .buttonStyle(.bordered)

              Spacer()

              Text("历史记录: \(textHistory.count)")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }

          Divider()

          // MARK: - 文本处理工具
          VStack(alignment: .leading, spacing: 8) {
            Text("4. 文本处理工具")
              .font(.headline)
              .foregroundColor(.primary)

            Text("各种文本处理和格式化工具")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $toolbarText)
              .frame(height: 100)
              .padding(12)
              .background(Color(.systemGray6))
              .cornerRadius(8)

            // 工具按钮
            HStack {
              Button("添加时间戳") {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                toolbarText += "\n[\(formatter.string(from: Date()))]"
              }
              .font(.caption)
              .buttonStyle(.bordered)

              Button("清空内容") {
                toolbarText = ""
              }
              .font(.caption)
              .buttonStyle(.bordered)

              Spacer()
            }

            Text("💡 这些工具展示了如何扩展 TextEditor 的功能")
              .font(.caption)
              .foregroundColor(.blue)
          }

          // MARK: - 高级技巧
          VStack(alignment: .leading, spacing: 8) {
            Text("⚡ 高级技巧")
              .font(.headline)
              .foregroundColor(.purple)

            VStack(alignment: .leading, spacing: 4) {
              Text("• 使用 onReceive 监听文本变化（iOS 15 兼容）")
              Text("• Timer 实现自动保存功能")
              Text("• 正则表达式进行文本搜索")
              Text("• 数组管理撤销重做历史")
              Text("• 自定义工具栏和快捷操作")
              Text("• 文本统计使用字符串处理方法")
            }
            .font(.caption)
            .foregroundColor(.secondary)
          }
          .padding()
          .background(Color.purple.opacity(0.1))
          .cornerRadius(8)
        }
        .padding(.horizontal)
      }
    }
    .navigationTitle("高级功能")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      // 初始化文本统计
      updateTextStatistics(formattedText)
    }
  }

  // MARK: - 辅助方法

  /// 更新文本统计
  private func updateTextStatistics(_ text: String) {
    characterCount = text.count
    wordCount =
      text.components(separatedBy: .whitespacesAndNewlines)
      .filter { !$0.isEmpty }
      .count
  }

  /// 执行搜索
  private func performSearch(_ query: String) {
    guard !query.isEmpty else {
      searchResults = []
      return
    }

    searchResults = []
    let text = searchableText.lowercased()
    let searchQuery = query.lowercased()

    var searchStartIndex = text.startIndex

    while searchStartIndex < text.endIndex,
      let range = text.range(of: searchQuery, range: searchStartIndex..<text.endIndex)
    {
      searchResults.append(range)
      searchStartIndex = range.upperBound
    }
  }

  /// 添加到历史记录
  private func addToHistory(_ text: String) {
    // 移除当前位置之后的历史记录
    if historyIndex < textHistory.count - 1 {
      textHistory.removeSubrange((historyIndex + 1)...)
    }

    textHistory.append(text)
    historyIndex = textHistory.count - 1

    // 限制历史记录数量
    if textHistory.count > 50 {
      textHistory.removeFirst()
      historyIndex -= 1
    }
  }

  /// 撤销操作
  private func undo() {
    guard historyIndex >= 0 else { return }
    undoRedoText = textHistory[historyIndex]
    historyIndex -= 1
  }

  /// 重做操作
  private func redo() {
    guard historyIndex < textHistory.count - 1 else { return }
    historyIndex += 1
    undoRedoText = textHistory[historyIndex]
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    TextEditorExampleView03()
  }
}
