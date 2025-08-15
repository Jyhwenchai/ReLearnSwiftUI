import SwiftUI

/// SliderExample 主文件
/// 导出所有 Slider 相关的示例视图，方便在其他项目中使用
@available(iOS 13.0, *)
public struct SliderExample {
  public init() {}
}

// MARK: - 导出简化版示例视图
@available(iOS 13.0, *)
public typealias SliderBasicExample = SliderExampleView01Simple

@available(iOS 13.0, *)
public typealias SliderLabelExample = SliderExampleView02Simple

@available(iOS 13.0, *)
public typealias SliderStepExample = SliderExampleView03Simple
