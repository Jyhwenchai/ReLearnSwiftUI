import SwiftUI

/// PickerExample 主视图
/// 展示 SwiftUI Picker 组件的各种使用方式和样式
public struct PickerExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        // 基础使用示例
        NavigationLink("基础 Picker 使用", destination: PickerExampleView01())

        // 不同样式示例
        NavigationLink("Picker 样式展示", destination: PickerExampleView02())

        // ForEach 结合使用
        NavigationLink("与 ForEach 结合", destination: PickerExampleView03())

        // 高级用法示例
        NavigationLink("高级用法", destination: PickerExampleView04())

        // 实际应用场景
        NavigationLink("实际应用场景", destination: PickerExampleView05())
      }
      .navigationTitle("Picker 示例")
    }
  }
}
