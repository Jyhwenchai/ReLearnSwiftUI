import SwiftUI

/// SharePreview 组件示例集合
///
/// SharePreview 是 SwiftUI 中用于创建分享预览的组件，通常与 ShareLink 一起使用。
/// 它允许开发者为分享的内容提供自定义的预览信息，包括标题、图片和图标。
///
/// 主要特点：
/// - 支持自定义预览标题
/// - 支持预览图片和图标
/// - 与 ShareLink 无缝集成
/// - 跨平台支持（iOS 16.0+, macOS 13.0+, watchOS 9.0+, visionOS 1.0+）
public struct SharePreviewExample {

  /// 所有示例视图的集合
  @MainActor
  public static let allExamples: [any View] = [
    SharePreviewExampleView01(),
    SharePreviewExampleView02(),
    SharePreviewExampleView03(),
    SharePreviewExampleView04(),
  ]

  /// 示例标题列表
  public static let exampleTitles = [
    "基础分享预览",
    "不同内容类型的预览",
    "样式和修饰符",
    "高级功能和实际应用",
  ]

  /// 示例描述列表
  public static let exampleDescriptions = [
    "演示 SharePreview 的基本创建和使用方法",
    "展示不同类型内容的分享预览实现",
    "学习 SharePreview 的样式定制和修饰符应用",
    "掌握高级功能和实际应用场景",
  ]
}
