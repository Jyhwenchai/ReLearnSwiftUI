import SwiftUI

/// TextField 组件示例集合
///
/// 这个包包含了 SwiftUI TextField 组件的各种使用示例，
/// 从基础的文本输入到高级的自定义样式和验证功能。
///
/// 示例包括：
/// - TextFieldExampleView01: 基础文本输入和占位符
/// - TextFieldExampleView02: 样式和修饰符应用
/// - TextFieldExampleView03: 输入验证和格式化
/// - TextFieldExampleView04: 高级功能和自定义样式
public struct TextFieldExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        NavigationLink("基础文本输入", destination: TextFieldExampleView01())
        NavigationLink("样式和修饰符", destination: TextFieldExampleView02())
        NavigationLink("输入验证和格式化", destination: TextFieldExampleView03())
        // NavigationLink("高级功能和自定义", destination: TextFieldExampleView04())
      }
      .navigationTitle("TextField 示例")
    }
  }
}
