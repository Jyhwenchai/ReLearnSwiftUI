import SwiftUI

/// CommandGroup 插入位置示例
///
/// 展示 CommandGroup 的各种插入位置和标准命令组：
/// - 所有标准命令组位置
/// - before 和 after 的使用
/// - replacing 的使用
public struct CommandMenuExampleView03: View {
  @State private var selectedPlacement: String = "无选择"
  @State private var actionLog: [String] = []

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      Text("CommandGroup 插入位置")
        .font(.largeTitle)
        .padding()

      VStack(alignment: .leading, spacing: 10) {
        Text("当前选择的位置: \(selectedPlacement)")

        if !actionLog.isEmpty {
          Text("操作日志:")
          ScrollView {
            LazyVStack(alignment: .leading) {
              ForEach(actionLog.suffix(5), id: \.self) { log in
                Text("• \(log)")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
          }
          .frame(height: 100)
        }
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(10)

      VStack(alignment: .leading, spacing: 8) {
        Text("标准命令组位置:")
          .font(.headline)

        Group {
          Text("• .appInfo - 应用信息（关于、偏好设置）")
          Text("• .appSettings - 应用设置")
          Text("• .appVisibility - 应用可见性（隐藏、退出）")
          Text("• .newItem - 新建项目")
          Text("• .openItem - 打开项目")
          Text("• .saveItem - 保存项目")
          Text("• .importExport - 导入导出")
          Text("• .printItem - 打印")
          Text("• .undoRedo - 撤销重做")
          Text("• .pasteboard - 剪贴板操作")
          Text("• .textEditing - 文本编辑")
          Text("• .textFormatting - 文本格式化")
          Text("• .toolbar - 工具栏")
          Text("• .sidebar - 侧边栏")
          Text("• .windowSize - 窗口大小")
          Text("• .windowArrangement - 窗口排列")
          Text("• .help - 帮助")
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }

      Spacer()
    }
    .padding()
    .navigationTitle("插入位置")

  }
}

/// 演示所有标准命令组位置的 App 结构
struct CommandGroupPlacementExampleApp03: App {
  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView03()
    }
    .commands {
      // 1. 在应用信息组之前添加
      CommandGroup(before: .appInfo) {
        Button("启动向导") {
          print("启动向导")
        }
      }

      // 2. 在应用设置组之后添加
      CommandGroup(after: .appSettings) {
        Button("高级设置") {
          print("打开高级设置")
        }
        .keyboardShortcut(",", modifiers: [.command, .option])
      }

      // 3. 替换新建项目组
      CommandGroup(replacing: .newItem) {
        Button("新建项目") {
          print("创建新项目")
        }
        .keyboardShortcut("n", modifiers: .command)

        Button("新建文件夹") {
          print("创建新文件夹")
        }
        .keyboardShortcut("n", modifiers: [.command, .shift])

        Button("从模板新建") {
          print("从模板创建")
        }
        .keyboardShortcut("n", modifiers: [.command, .option])
      }

      // 4. 在新建项目组之后添加
      CommandGroup(after: .newItem) {
        Button("最近打开") {
          print("显示最近打开的文件")
        }
        .keyboardShortcut("o", modifiers: [.command, .shift])

        Divider()

        Button("从云端打开") {
          print("从云端打开文件")
        }
      }

      // 5. 在保存项目组之前添加
      CommandGroup(before: .saveItem) {
        Button("自动保存设置") {
          print("配置自动保存")
        }
      }

      // 6. 在导入导出组之后添加
      CommandGroup(after: .importExport) {
        Button("批量导出") {
          print("批量导出文件")
        }

        Button("同步到云端") {
          print("同步文件到云端")
        }
      }

      // 7. 在撤销重做组之前添加
      CommandGroup(before: .undoRedo) {
        Button("历史记录") {
          print("显示操作历史")
        }
        .keyboardShortcut("h", modifiers: .command)
      }

      // 8. 在剪贴板组之后添加
      CommandGroup(after: .pasteboard) {
        Button("剪贴板历史") {
          print("显示剪贴板历史")
        }
        .keyboardShortcut("v", modifiers: [.command, .shift])
      }

      // 9. 在文本编辑组之后添加
      CommandGroup(after: .textEditing) {
        Button("智能编辑") {
          print("启用智能编辑")
        }

        Button("批量替换") {
          print("批量查找替换")
        }
        .keyboardShortcut("f", modifiers: [.command, .option])
      }

      // 10. 在工具栏组之后添加
      CommandGroup(after: .toolbar) {
        Button("自定义工具栏") {
          print("自定义工具栏")
        }

        Button("重置工具栏") {
          print("重置工具栏到默认状态")
        }
      }

      // 11. 在帮助组之前添加
      CommandGroup(before: .help) {
        Button("用户手册") {
          print("打开用户手册")
        }

        Button("视频教程") {
          print("观看视频教程")
        }

        Divider()
      }
    }
  }
}

#Preview {
  CommandMenuExampleView03()
}
