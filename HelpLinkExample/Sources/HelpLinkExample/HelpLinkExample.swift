import SwiftUI

/// HelpLink 组件示例主文件
///
/// HelpLink 是 SwiftUI 中用于显示帮助链接的组件，仅在 macOS 14.0+ 可用
/// 它提供了标准的帮助按钮外观，可以打开应用特定的帮助文档
///
/// 主要特点：
/// - 标准的帮助按钮外观
/// - 自动放置在特定位置（如警告框的右上角，工具栏的左下角）
/// - 支持多种初始化方式：URL、锚点、自定义动作
/// - 仅支持 macOS 平台
@available(macOS 14.0, *)
public struct HelpLinkExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        NavigationLink("基础 HelpLink 使用", destination: HelpLinkExampleView01())
        NavigationLink("不同类型的帮助内容", destination: HelpLinkExampleView02())
        NavigationLink("在不同容器中的使用", destination: HelpLinkExampleView03())
        NavigationLink("实际应用场景", destination: HelpLinkExampleView04())
      }
      .navigationTitle("HelpLink 示例")

      // 默认显示第一个示例
      HelpLinkExampleView01()
    }
  }
}
