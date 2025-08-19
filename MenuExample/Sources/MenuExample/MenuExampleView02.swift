import SwiftUI

/// MenuExampleView02 - 嵌套菜单和子菜单示例
/// 展示如何创建多层级的嵌套菜单结构
public struct MenuExampleView02: View {
  @State private var selectedAction = "未选择任何操作"
  @State private var exportFormat = "PDF"
  @State private var importSource = "本地文件"

  public init() {}

  public var body: some View {
    VStack(spacing: 30) {
      Text("嵌套菜单示例")
        .font(.largeTitle)
        .fontWeight(.bold)

      Text("当前状态: \(selectedAction)")
        .foregroundColor(.secondary)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)

      VStack(spacing: 20) {
        // 示例1: 基本的嵌套菜单
        Menu("文件管理") {
          Button("新建文件", action: newFile)
          Button("打开文件", action: openFile)

          // 嵌套的导出菜单
          Menu("导出") {
            Button("导出为 PDF", action: exportPDF)
            Button("导出为 Word", action: exportWord)
            Button("导出为 Excel", action: exportExcel)
            Button("导出为 PowerPoint", action: exportPowerPoint)
          }

          // 嵌套的导入菜单
          Menu("导入") {
            Button("从本地导入", action: importLocal)
            Button("从云端导入", action: importCloud)

            // 二级嵌套菜单
            Menu("从在线服务导入") {
              Button("从 Google Drive", action: importGoogleDrive)
              Button("从 Dropbox", action: importDropbox)
              Button("从 OneDrive", action: importOneDrive)
            }
          }

          Divider()

          Button("删除文件", role: .destructive, action: deleteFile)
        }
        .buttonStyle(.borderedProminent)

        // 示例2: 复杂的多层嵌套菜单
        Menu {
          // 编辑相关操作
          Menu("编辑") {
            Button("撤销", action: undoAction)
            Button("重做", action: redoAction)

            Divider()

            Button("复制", action: copyAction)
            Button("粘贴", action: pasteAction)
            Button("剪切", action: cutAction)

            // 特殊粘贴选项
            Menu("选择性粘贴") {
              Button("仅粘贴文本", action: pasteTextOnly)
              Button("仅粘贴格式", action: pasteFormatOnly)
              Button("粘贴为链接", action: pasteAsLink)
            }
          }

          // 格式相关操作
          Menu("格式") {
            Menu("字体") {
              Button("加粗", action: boldText)
              Button("斜体", action: italicText)
              Button("下划线", action: underlineText)

              Menu("字体大小") {
                Button("小", action: smallFont)
                Button("中", action: mediumFont)
                Button("大", action: largeFont)
                Button("特大", action: extraLargeFont)
              }
            }

            Menu("颜色") {
              Button("红色", action: redColor)
              Button("蓝色", action: blueColor)
              Button("绿色", action: greenColor)
              Button("黑色", action: blackColor)
            }

            Menu("对齐") {
              Button("左对齐", action: alignLeft)
              Button("居中对齐", action: alignCenter)
              Button("右对齐", action: alignRight)
              Button("两端对齐", action: alignJustify)
            }
          }

          Divider()

          // 工具菜单
          Menu("工具") {
            Button("拼写检查", action: spellCheck)
            Button("字数统计", action: wordCount)
            Button("查找替换", action: findReplace)
          }

        } label: {
          Label("高级编辑", systemImage: "textformat")
        }
        .buttonStyle(.bordered)

        // 示例3: 带图标的嵌套菜单
        Menu {
          Menu {
            Button(action: shareEmail) {
              Label("邮件", systemImage: "envelope")
            }
            Button(action: shareMessage) {
              Label("信息", systemImage: "message")
            }
            Button(action: shareAirdrop) {
              Label("AirDrop", systemImage: "airplayaudio")
            }
          } label: {
            Label("分享", systemImage: "square.and.arrow.up")
          }

          Menu {
            Button(action: printDocument) {
              Label("打印文档", systemImage: "printer")
            }
            Button(action: printPreview) {
              Label("打印预览", systemImage: "doc.text.magnifyingglass")
            }
            Menu {
              Button("A4", action: printA4)
              Button("A3", action: printA3)
              Button("Letter", action: printLetter)
            } label: {
              Label("纸张大小", systemImage: "doc.plaintext")
            }
          } label: {
            Label("打印", systemImage: "printer.fill")
          }

        } label: {
          HStack {
            Image(systemName: "ellipsis.circle")
            Text("更多操作")
          }
        }
        .buttonStyle(.borderless)
      }

      Spacer()
    }
    .padding()
    .navigationTitle("嵌套菜单")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 文件操作方法

  private func newFile() { selectedAction = "新建文件" }
  private func openFile() { selectedAction = "打开文件" }
  private func deleteFile() { selectedAction = "删除文件" }

  // MARK: - 导出操作方法

  private func exportPDF() {
    selectedAction = "导出为 PDF"
    exportFormat = "PDF"
  }
  private func exportWord() {
    selectedAction = "导出为 Word"
    exportFormat = "Word"
  }
  private func exportExcel() {
    selectedAction = "导出为 Excel"
    exportFormat = "Excel"
  }
  private func exportPowerPoint() {
    selectedAction = "导出为 PowerPoint"
    exportFormat = "PowerPoint"
  }

  // MARK: - 导入操作方法

  private func importLocal() {
    selectedAction = "从本地导入"
    importSource = "本地文件"
  }
  private func importCloud() {
    selectedAction = "从云端导入"
    importSource = "云端"
  }
  private func importGoogleDrive() {
    selectedAction = "从 Google Drive 导入"
    importSource = "Google Drive"
  }
  private func importDropbox() {
    selectedAction = "从 Dropbox 导入"
    importSource = "Dropbox"
  }
  private func importOneDrive() {
    selectedAction = "从 OneDrive 导入"
    importSource = "OneDrive"
  }

  // MARK: - 编辑操作方法

  private func undoAction() { selectedAction = "撤销操作" }
  private func redoAction() { selectedAction = "重做操作" }
  private func copyAction() { selectedAction = "复制内容" }
  private func pasteAction() { selectedAction = "粘贴内容" }
  private func cutAction() { selectedAction = "剪切内容" }
  private func pasteTextOnly() { selectedAction = "仅粘贴文本" }
  private func pasteFormatOnly() { selectedAction = "仅粘贴格式" }
  private func pasteAsLink() { selectedAction = "粘贴为链接" }

  // MARK: - 格式操作方法

  private func boldText() { selectedAction = "设置粗体" }
  private func italicText() { selectedAction = "设置斜体" }
  private func underlineText() { selectedAction = "设置下划线" }
  private func smallFont() { selectedAction = "设置小字体" }
  private func mediumFont() { selectedAction = "设置中字体" }
  private func largeFont() { selectedAction = "设置大字体" }
  private func extraLargeFont() { selectedAction = "设置特大字体" }
  private func redColor() { selectedAction = "设置红色" }
  private func blueColor() { selectedAction = "设置蓝色" }
  private func greenColor() { selectedAction = "设置绿色" }
  private func blackColor() { selectedAction = "设置黑色" }
  private func alignLeft() { selectedAction = "左对齐" }
  private func alignCenter() { selectedAction = "居中对齐" }
  private func alignRight() { selectedAction = "右对齐" }
  private func alignJustify() { selectedAction = "两端对齐" }

  // MARK: - 工具操作方法

  private func spellCheck() { selectedAction = "拼写检查" }
  private func wordCount() { selectedAction = "字数统计" }
  private func findReplace() { selectedAction = "查找替换" }

  // MARK: - 分享和打印操作方法

  private func shareEmail() { selectedAction = "通过邮件分享" }
  private func shareMessage() { selectedAction = "通过信息分享" }
  private func shareAirdrop() { selectedAction = "通过 AirDrop 分享" }
  private func printDocument() { selectedAction = "打印文档" }
  private func printPreview() { selectedAction = "打印预览" }
  private func printA4() { selectedAction = "打印 A4 纸张" }
  private func printA3() { selectedAction = "打印 A3 纸张" }
  private func printLetter() { selectedAction = "打印 Letter 纸张" }
}

#Preview {
  NavigationView {
    MenuExampleView02()
  }
}
