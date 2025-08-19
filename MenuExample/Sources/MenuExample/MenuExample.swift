import SwiftUI

/// Menu 组件示例的主要入口
/// 展示 SwiftUI Menu 组件的各种用法和功能
public struct MenuExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        // 基础 Menu 示例
        NavigationLink("基础 Menu", destination: MenuExampleView01())

        // 嵌套菜单示例
        NavigationLink("嵌套菜单和子菜单", destination: MenuExampleView02())

        // 带主要操作的菜单
        NavigationLink("带主要操作的菜单", destination: MenuExampleView03())

        // 菜单样式和修饰符
        NavigationLink("菜单样式和修饰符", destination: MenuExampleView04())

        // 上下文菜单
        NavigationLink("上下文菜单", destination: MenuExampleView05())

        // 高级菜单功能
        NavigationLink("高级菜单功能", destination: MenuExampleView06())
      }
      .navigationTitle("Menu 示例")
    }
  }
}
