import SwiftUI

/// EditButton 组件示例集合
///
/// EditButton 是 SwiftUI 中的一个特殊按钮，用于切换编辑模式状态。
/// 它会自动在 "Edit" 和 "Done" 之间切换标题，并管理环境中的 editMode 值。
///
/// 本示例包含以下内容：
/// - EditButtonExampleView01: 基础 EditButton 使用
/// - EditButtonExampleView02: 与 List 结合的编辑功能
/// - EditButtonExampleView03: 自定义编辑行为
/// - EditButtonExampleView04: 高级功能和实际应用
public struct EditButtonExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        NavigationLink("基础 EditButton", destination: EditButtonExampleView01())
        NavigationLink("List 编辑功能", destination: EditButtonExampleView02())
        // NavigationLink("自定义编辑行为", destination: EditButtonExampleView03())
        // NavigationLink("高级功能应用", destination: EditButtonExampleView04())
      }
      .navigationTitle("EditButton 示例")
    }
  }
}
