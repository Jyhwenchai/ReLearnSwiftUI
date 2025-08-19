import SwiftUI

/// CommandMenu 基础用法示例
///
/// 展示如何创建基本的 CommandMenu，包括：
/// - 基本菜单项
/// - 键盘快捷键
/// - 菜单分隔符
/// - 禁用状态
public struct CommandMenuExampleView01: View {
  @State private var selectedItem: String = "无选择"
  @State private var isEnabled: Bool = true
  @State private var counter: Int = 0

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      Text("CommandMenu 基础示例")
        .font(.largeTitle)
        .padding()

      VStack(alignment: .leading, spacing: 10) {
        Text("当前选择: \(selectedItem)")
        Text("计数器: \(counter)")
        Text("菜单状态: \(isEnabled ? "启用" : "禁用")")

        Toggle("启用菜单", isOn: $isEnabled)
          .padding(.top)
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(10)

      Text("在 macOS 上，CommandMenu 会在菜单栏中显示")
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)

      Text("在 iOS/iPadOS 上，带有键盘快捷键的菜单项会创建键盘命令")
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .font(.caption)

      Spacer()
    }
    .padding()
    .navigationTitle("基础 CommandMenu")

  }
}

/// 用于演示的 App 结构
/// 在实际应用中，CommandMenu 应该在 App 或 Scene 级别定义
struct CommandMenuExampleApp01: App {
  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView01()
    }
    // CommandMenu 必须在 Scene 级别使用 commands 修饰符
    .commands {
      // 创建一个名为 "示例操作" 的命令菜单
      CommandMenu("示例操作") {
        // 基本按钮 - 带有键盘快捷键 Cmd+1
        Button("选择项目 1") {
          // 这里的操作在实际应用中需要通过状态管理来实现
          print("选择了项目 1")
        }
        .keyboardShortcut("1", modifiers: .command)

        // 基本按钮 - 带有键盘快捷键 Cmd+2
        Button("选择项目 2") {
          print("选择了项目 2")
        }
        .keyboardShortcut("2", modifiers: .command)

        // 菜单分隔符
        Divider()

        // 计数器操作 - 带有键盘快捷键 Cmd+Plus
        Button("增加计数") {
          print("增加计数")
        }
        .keyboardShortcut("+", modifiers: .command)

        // 重置操作 - 带有键盘快捷键 Cmd+R
        Button("重置计数") {
          print("重置计数")
        }
        .keyboardShortcut("r", modifiers: .command)

        // 另一个分隔符
        Divider()

        // 禁用的菜单项
        Button("禁用的操作") {
          print("这个操作被禁用了")
        }
        .disabled(true)  // 禁用状态

        // 条件菜单项 - 根据状态显示不同内容
        Button("切换状态") {
          print("切换状态")
        }
        .keyboardShortcut("t", modifiers: .command)
      }
    }
  }
}

#Preview {
  CommandMenuExampleView01()
}
