import SwiftUI

/// DatePicker 组件示例集合
///
/// 这个包包含了 SwiftUI DatePicker 组件的各种使用示例，
/// 展示了从基础用法到高级功能的完整实现。
@MainActor
public struct DatePickerExample {

  /// 简化的 DatePicker 示例
  public static func simpleExample() -> some View {
    DatePickerExampleSimple()
  }
}

// MARK: - 导出简化示例视图
public typealias DatePickerSimple = DatePickerExampleSimple
