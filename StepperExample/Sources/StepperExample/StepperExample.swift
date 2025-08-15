import SwiftUI

/// StepperExample 主视图
/// 展示 SwiftUI Stepper 组件的各种使用方式
public struct StepperExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        Group {
          NavigationLink("基础 Stepper 示例", destination: StepperExampleView01())
          NavigationLink("数值绑定示例", destination: StepperExampleView02())
          NavigationLink("范围限制示例", destination: StepperExampleView03())
          NavigationLink("高级配置示例", destination: StepperExampleView04())
          NavigationLink("样式定制示例", destination: StepperExampleView05())
        }
      }
      .navigationTitle("Stepper 示例")
    }
  }
}

#Preview {
  StepperExample()
}
