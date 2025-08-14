import SwiftUI

/// LabelExample - SwiftUI Label 组件示例集合
///
/// 这个包提供了多个 Label 组件的使用示例，从基础用法到高级自定义样式。
/// Label 是 SwiftUI 中用于显示图标和文本组合的组件，常用于导航、按钮、列表项等场景。
///
/// 示例包含：
/// - LabelExampleView01: 基础 Label 创建和使用
/// - LabelExampleView02: 图标和文本的组合方式
/// - LabelExampleView03: 样式和修饰符应用
/// - LabelExampleView04: 自定义 Label 样式和高级功能
///
/// 使用方法：
/// ```swift
/// import LabelExample
///
/// struct ContentView: View {
///     var body: some View {
///         LabelExampleView01()
///     }
/// }
/// ```
public struct LabelExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        NavigationLink("基础 Label 创建", destination: LabelExampleView01())
        NavigationLink("图标和文本组合", destination: LabelExampleView02())
        NavigationLink("样式和修饰符", destination: LabelExampleView03())
        NavigationLink("自定义样式", destination: LabelExampleView04())
      }
      .navigationTitle("Label 示例")
    }
  }
}
