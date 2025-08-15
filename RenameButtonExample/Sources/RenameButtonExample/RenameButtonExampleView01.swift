import SwiftUI

/// RenameButton 基础示例
/// 演示 RenameButton 的基本用法和重命名功能
public struct RenameButtonExampleView01: View {
  // MARK: - 状态属性

  /// 文件项目数据模型
  struct FileItem: Identifiable {
    let id = UUID()
    var name: String
    var type: String
    var size: String
  }

  /// 文件列表状态
  @State private var files: [FileItem] = [
    FileItem(name: "文档.txt", type: "文本文件", size: "2.5 KB"),
    FileItem(name: "图片.jpg", type: "图像文件", size: "1.2 MB"),
    FileItem(name: "音乐.mp3", type: "音频文件", size: "3.8 MB"),
    FileItem(name: "视频.mp4", type: "视频文件", size: "15.6 MB"),
  ]

  /// 当前选中的文件索引
  @State private var selectedFileIndex: Int?

  /// 焦点状态管理
  @FocusState private var isTextFieldFocused: Bool

  /// 当前编辑的文件名
  @State private var editingFileName: String = ""

  /// 是否显示重命名成功提示
  @State private var showRenameSuccess = false

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        // MARK: - 标题和说明
        VStack(alignment: .leading, spacing: 8) {
          Text("RenameButton 基础用法")
            .font(.title2)
            .fontWeight(.bold)

          Text("长按文件项目显示上下文菜单，选择重命名按钮进行重命名操作")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)

        // MARK: - 文件列表
        List {
          ForEach(files.indices, id: \.self) { index in
            FileRowView(
              file: files[index],
              isEditing: selectedFileIndex == index,
              editingName: $editingFileName,
              isFocused: $isTextFieldFocused
            )
            .contextMenu {
              // RenameButton 在上下文菜单中的基本用法
              RenameButton()

              Divider()

              Button("复制", systemImage: "doc.on.doc") {
                // 复制文件的逻辑
                print("复制文件: \(files[index].name)")
              }

              Button("删除", systemImage: "trash", role: .destructive) {
                // 删除文件的逻辑
                files.remove(at: index)
              }
            }
            // 设置重命名操作的处理逻辑
            .renameAction {
              startRenaming(at: index)
            }
          }
        }
        .listStyle(PlainListStyle())

        // MARK: - 操作说明
        VStack(alignment: .leading, spacing: 8) {
          Text("操作说明:")
            .font(.headline)

          VStack(alignment: .leading, spacing: 4) {
            Text("• 长按任意文件项目显示上下文菜单")
            Text("• 点击 '重命名' 按钮开始编辑文件名")
            Text("• 编辑完成后按回车键确认修改")
            Text("• 按 ESC 键取消编辑")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)

        Spacer()
      }
      .navigationTitle("RenameButton 示例")
      .navigationBarTitleDisplayMode(.inline)
    }
    // 显示重命名成功提示
    .alert("重命名成功", isPresented: $showRenameSuccess) {
      Button("确定") {}
    } message: {
      Text("文件已成功重命名")
    }
    // 监听键盘事件
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
    { _ in
      // 键盘隐藏时完成重命名
      if selectedFileIndex != nil && !editingFileName.isEmpty {
        completeRenaming()
      }
    }
  }

  // MARK: - 辅助方法

  /// 开始重命名操作
  private func startRenaming(at index: Int) {
    selectedFileIndex = index
    editingFileName = files[index].name

    // 延迟一点时间再聚焦，确保界面更新完成
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isTextFieldFocused = true
    }
  }

  /// 完成重命名操作
  private func completeRenaming() {
    guard let index = selectedFileIndex else { return }

    // 验证文件名不为空
    let trimmedName = editingFileName.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedName.isEmpty {
      files[index].name = trimmedName
      showRenameSuccess = true
    }

    // 重置状态
    selectedFileIndex = nil
    editingFileName = ""
    isTextFieldFocused = false
  }

  /// 取消重命名操作
  private func cancelRenaming() {
    selectedFileIndex = nil
    editingFileName = ""
    isTextFieldFocused = false
  }
}

// MARK: - 文件行视图
struct FileRowView: View {
  let file: RenameButtonExampleView01.FileItem
  let isEditing: Bool
  @Binding var editingName: String
  @FocusState.Binding var isFocused: Bool

  var body: some View {
    HStack(spacing: 12) {
      // 文件图标
      Image(systemName: fileIcon)
        .font(.title2)
        .foregroundColor(fileIconColor)
        .frame(width: 30)

      VStack(alignment: .leading, spacing: 2) {
        // 文件名 - 可编辑或显示状态
        if isEditing {
          TextField("文件名", text: $editingName)
            .focused($isFocused)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
              // 提交编辑
              isFocused = false
            }
        } else {
          Text(file.name)
            .font(.body)
            .fontWeight(.medium)
        }

        // 文件信息
        HStack {
          Text(file.type)
            .font(.caption)
            .foregroundColor(.secondary)

          Spacer()

          Text(file.size)
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }

      Spacer()
    }
    .padding(.vertical, 4)
  }

  /// 根据文件类型返回对应的图标
  private var fileIcon: String {
    switch file.type {
    case "文本文件":
      return "doc.text"
    case "图像文件":
      return "photo"
    case "音频文件":
      return "music.note"
    case "视频文件":
      return "video"
    default:
      return "doc"
    }
  }

  /// 根据文件类型返回对应的图标颜色
  private var fileIconColor: Color {
    switch file.type {
    case "文本文件":
      return .blue
    case "图像文件":
      return .green
    case "音频文件":
      return .orange
    case "视频文件":
      return .red
    default:
      return .gray
    }
  }
}

// MARK: - 预览
#Preview {
  RenameButtonExampleView01()
}
