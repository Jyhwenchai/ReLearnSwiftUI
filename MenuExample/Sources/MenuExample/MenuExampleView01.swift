import SwiftUI

/// MenuExampleView01 - 基础 Menu 示例
/// 展示 Menu 组件的基本用法，包括文本标签和图标标签
public struct MenuExampleView01: View {
  // 状态变量用于显示用户选择的操作
  @State private var selectedAction = "未选择任何操作"
  @State private var documentName = "我的文档"

  public init() {}

  public var body: some View {
    VStack(spacing: 30) {
      Text("基础 Menu 示例")
        .font(.largeTitle)
        .fontWeight(.bold)

      Text("当前状态: \(selectedAction)")
        .foregroundColor(.secondary)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)

      VStack(spacing: 20) {
        // 示例1: 最简单的文本菜单
        Menu("文件操作") {
          Button("新建", action: newDocument)
          Button("打开", action: openDocument)
          Button("保存", action: saveDocument)
          Button("另存为", action: saveAsDocument)
        }
        .buttonStyle(.borderedProminent)

        // 示例2: 带图标的菜单标签
        Menu {
          Button("复制", action: copyAction)
          Button("粘贴", action: pasteAction)
          Button("剪切", action: cutAction)
          Button("删除", action: deleteAction)
        } label: {
          // 使用 Label 创建带图标的菜单标签
          Label("编辑", systemImage: "pencil.circle")
        }
        .buttonStyle(.bordered)

        // 示例3: 自定义菜单标签样式
        Menu {
          Button("重命名", action: renameAction)
          Button("移动", action: moveAction)
          Button("复制", action: duplicateAction)
          Button("删除", action: trashAction)
        } label: {
          HStack {
            Image(systemName: "folder.fill")
              .foregroundColor(.blue)
            Text(documentName)
              .fontWeight(.medium)
            Image(systemName: "chevron.down")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(8)
        }

        // 示例4: 带分隔符的菜单
        Menu("更多选项") {
          Button("设置", action: settingsAction)
          Button("帮助", action: helpAction)

          // 分隔符
          Divider()

          Button("关于", action: aboutAction)
          Button("退出", action: quitAction)
        }
        .buttonStyle(.borderless)
        .foregroundColor(.primary)
      }

      Spacer()
    }
    .padding()
    .navigationTitle("基础 Menu")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 操作方法

  /// 新建文档操作
  private func newDocument() {
    selectedAction = "新建文档"
  }

  /// 打开文档操作
  private func openDocument() {
    selectedAction = "打开文档"
  }

  /// 保存文档操作
  private func saveDocument() {
    selectedAction = "保存文档"
  }

  /// 另存为文档操作
  private func saveAsDocument() {
    selectedAction = "另存为文档"
  }

  /// 复制操作
  private func copyAction() {
    selectedAction = "复制内容"
  }

  /// 粘贴操作
  private func pasteAction() {
    selectedAction = "粘贴内容"
  }

  /// 剪切操作
  private func cutAction() {
    selectedAction = "剪切内容"
  }

  /// 删除操作
  private func deleteAction() {
    selectedAction = "删除内容"
  }

  /// 重命名操作
  private func renameAction() {
    selectedAction = "重命名文档"
    documentName = "重命名的文档"
  }

  /// 移动操作
  private func moveAction() {
    selectedAction = "移动文档"
  }

  /// 复制操作
  private func duplicateAction() {
    selectedAction = "复制文档"
  }

  /// 删除到废纸篓操作
  private func trashAction() {
    selectedAction = "删除到废纸篓"
  }

  /// 设置操作
  private func settingsAction() {
    selectedAction = "打开设置"
  }

  /// 帮助操作
  private func helpAction() {
    selectedAction = "显示帮助"
  }

  /// 关于操作
  private func aboutAction() {
    selectedAction = "显示关于信息"
  }

  /// 退出操作
  private func quitAction() {
    selectedAction = "退出应用"
  }
}

#Preview {
  NavigationView {
    MenuExampleView01()
  }
}
