import SwiftUI

/// PasteButton 组件示例集合
///
/// 这个文件包含了 SwiftUI PasteButton 组件的各种使用示例，
/// 从基础的粘贴功能到高级的自定义样式和数据处理。
///
/// PasteButton 是 iOS 16.0+ 引入的系统按钮，用于从系统剪贴板读取内容
/// 并将其传递给闭包进行处理。它支持多种数据类型，并提供系统标准的外观。
public struct PasteButtonExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        // 基础粘贴按钮示例
        NavigationLink("基础粘贴按钮", destination: PasteButtonExampleView01())

        // 支持的数据类型示例
        NavigationLink("支持的数据类型", destination: PasteButtonExampleView02())

        // 样式和修饰符示例
        NavigationLink("样式和修饰符", destination: PasteButtonExampleView03())

        // 高级功能和实际应用示例
        NavigationLink("高级功能和实际应用", destination: PasteButtonExampleView04())
      }
      .navigationTitle("PasteButton 示例")
    }
  }
}

// MARK: - 扩展
extension View {
  func apply<T: View>(@ViewBuilder _ transform: (Self) -> T) -> T {
    transform(self)
  }
}
