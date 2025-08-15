import SwiftUI

/// Toggle 组件示例的主入口
///
/// Toggle 是 SwiftUI 中用于在开/关状态之间切换的控件
/// 本示例包含了 Toggle 的各种用法和样式演示
public struct ToggleExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        // 基础用法示例
        NavigationLink("基础用法", destination: ToggleExampleView01())

        // 不同初始化方法
        NavigationLink("初始化方法", destination: ToggleExampleView02())

        // Toggle 样式
        NavigationLink("Toggle 样式", destination: ToggleExampleView03())

        // 高级用法
        NavigationLink("高级用法", destination: ToggleExampleView04())

        // 集合操作
        NavigationLink("集合操作", destination: ToggleExampleView05())
      }
      .navigationTitle("Toggle 示例")
    }
  }
}
