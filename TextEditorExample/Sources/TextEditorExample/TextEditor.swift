import SwiftUI

/// TextEditor 组件示例主文件
///
/// TextEditor 是 SwiftUI 中用于多行文本编辑的组件，适用于需要用户输入大量文本的场景。
/// 本示例包含了从基础使用到高级自定义的完整演示。
///
/// 示例包含：
/// - TextEditorExampleView01: 基础多行文本编辑
/// - TextEditorExampleView02: 样式和修饰符
/// - TextEditorExampleView03: 高级功能和自定义
/// - TextEditorExampleView04: 实际应用场景
public struct TextEditorExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        Section("基础示例") {
          NavigationLink("基础多行文本编辑", destination: TextEditorExampleView01())
          NavigationLink("样式和修饰符", destination: TextEditorExampleView02())
        }

        Section("高级示例") {
          NavigationLink("高级功能和自定义", destination: TextEditorExampleView03())
          NavigationLink("实际应用场景", destination: TextEditorExampleView04())
        }
      }
      .navigationTitle("TextEditor 示例")
    }
  }
}
