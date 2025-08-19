import SwiftUI

/// CommandGroup 基础用法示例
///
/// 展示如何使用 CommandGroup 来扩展现有的系统菜单：
/// - 替换现有命令组
/// - 添加到现有命令组
/// - 使用标准命令组位置
public struct CommandMenuExampleView02: View {
  @State private var documentName: String = "未命名文档"
  @State private var isDocumentSaved: Bool = false
  @State private var recentActions: [String] = []

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      Text("CommandGroup 基础示例")
        .font(.largeTitle)
        .padding()

      VStack(alignment: .leading, spacing: 10) {
        Text("文档名称: \(documentName)")
        Text("保存状态: \(isDocumentSaved ? "已保存" : "未保存")")

        if !recentActions.isEmpty {
          Text("最近操作:")
          ForEach(recentActions.prefix(3), id: \.self) { action in
            Text("• \(action)")
              .font(.caption)
              .foregroundColor(.secondary)
          }
        }
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(10)

      VStack(alignment: .leading, spacing: 8) {
        Text("CommandGroup 功能:")
          .font(.headline)

        Text("• 扩展系统标准菜单（如文件、编辑菜单）")
        Text("• 在现有菜单组前后插入命令")
        Text("• 替换现有命令组的内容")
        Text("• 使用标准位置放置命令")
      }
      .font(.caption)
      .foregroundColor(.secondary)

      Spacer()
    }
    .padding()
    .navigationTitle("CommandGroup 基础")

  }
}

/// 演示 CommandGroup 的 App 结构
struct CommandGroupExampleApp02: App {
  @State private var documentName = "未命名文档"
  @State private var isDocumentSaved = false

  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView02()
    }
    .commands {
      // 1. 替换标准的新建命令组
      CommandGroup(replacing: .newItem) {
        Button("新建文档") {
          documentName = "新文档"
          isDocumentSaved = false
          print("创建新文档")
        }
        .keyboardShortcut("n", modifiers: .command)

        Button("从模板新建") {
          documentName = "模板文档"
          isDocumentSaved = false
          print("从模板创建文档")
        }
        .keyboardShortcut("n", modifiers: [.command, .shift])
      }

      // 2. 在保存命令组之后添加命令
      CommandGroup(after: .saveItem) {
        Button("导出为 PDF") {
          print("导出为 PDF")
        }
        .keyboardShortcut("e", modifiers: .command)

        Button("发送副本") {
          print("发送文档副本")
        }
        .keyboardShortcut("s", modifiers: [.command, .shift])

        Divider()

        Button("文档属性") {
          print("显示文档属性")
        }
        .keyboardShortcut("i", modifiers: .command)
      }

      // 3. 在编辑菜单前添加命令
      CommandGroup(before: .undoRedo) {
        Button("快速编辑") {
          print("快速编辑模式")
        }
        .keyboardShortcut("q", modifiers: .command)

        Divider()
      }

      // 4. 在帮助菜单后添加自定义命令
      CommandGroup(after: .help) {
        Button("关于此文档") {
          print("显示文档信息")
        }

        Button("检查更新") {
          print("检查应用更新")
        }
      }

      // 5. 创建完全自定义的命令菜单
      CommandMenu("工具") {
        Button("字数统计") {
          print("显示字数统计")
        }
        .keyboardShortcut("w", modifiers: [.command, .option])

        Button("拼写检查") {
          print("运行拼写检查")
        }
        .keyboardShortcut(";", modifiers: .command)

        Divider()

        Menu("导入") {
          Button("导入文本文件") {
            print("导入文本文件")
          }

          Button("导入图片") {
            print("导入图片")
          }

          Button("导入 CSV") {
            print("导入 CSV 文件")
          }
        }

        Menu("导出") {
          Button("导出为文本") {
            print("导出为文本")
          }

          Button("导出为 HTML") {
            print("导出为 HTML")
          }

          Button("导出为 Markdown") {
            print("导出为 Markdown")
          }
        }
      }
    }
  }
}

#Preview {
  CommandMenuExampleView02()
}
