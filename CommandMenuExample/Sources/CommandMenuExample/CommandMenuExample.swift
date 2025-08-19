import SwiftUI

/// CommandMenu 示例主文件
///
/// CommandMenu 是 SwiftUI 中用于创建顶级命令菜单的容器
/// 在 macOS 上显示为菜单栏菜单，在 iOS/iPadOS 上创建键盘快捷键
public struct CommandMenuExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        NavigationLink("基础 CommandMenu", destination: CommandMenuExampleView01())
        NavigationLink("CommandGroup 基础用法", destination: CommandMenuExampleView02())
        NavigationLink("CommandGroup 插入位置", destination: CommandMenuExampleView03())
        NavigationLink("嵌套菜单结构", destination: CommandMenuExampleView04())
        NavigationLink("动态菜单内容", destination: CommandMenuExampleView05())
        NavigationLink("实际应用场景", destination: CommandMenuExampleView06())
      }
      .navigationTitle("CommandMenu 示例")
    }
  }
}
