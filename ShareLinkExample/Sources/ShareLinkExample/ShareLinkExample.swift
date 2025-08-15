import SwiftUI

/// ShareLink 组件示例集合
///
/// ShareLink 是 SwiftUI 中用于分享内容的组件，支持分享各种类型的数据
/// 包括 URL、文本、图片等，并提供系统标准的分享界面
///
/// 主要特性：
/// - 支持分享任何符合 Transferable 协议的内容
/// - 提供系统标准的分享界面
/// - 支持自定义预览和标签
/// - 支持预填充主题和消息
/// - 跨平台兼容（iOS 16.0+, macOS 13.0+, watchOS 9.0+, visionOS 1.0+）
@available(iOS 16.0, macOS 13.0, watchOS 9.0, visionOS 1.0, *)
public struct ShareLinkExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        // 示例 1：基础分享功能
        NavigationLink("基础分享功能") {
          ShareLinkExampleView01()
        }

        // 示例 2：分享不同类型的内容
        NavigationLink("分享不同类型内容") {
          ShareLinkExampleView02()
        }

        // 示例 3：样式和修饰符
        NavigationLink("样式和修饰符") {
          ShareLinkExampleView03()
        }

        // 示例 4：高级功能和实际应用
        NavigationLink("高级功能和实际应用") {
          ShareLinkExampleView04()
        }
      }
      .navigationTitle("ShareLink 示例")
    }
  }
}
