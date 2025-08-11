// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import ShareComponent

public struct ButtonExample: View {
  public init() {}
  public var body: some View {
    ComponentExample(componentTitle: "Button") {
      NavigationLink("基础按钮创建") {
        ButtonExampleView01()
      }
      NavigationLink("样式和修饰符") {
        ButtonExampleView02()
      }
      NavigationLink("角色和交互行为") {
        ButtonExampleView03()
      }
      NavigationLink("自定义按钮样式") {
        ButtonExampleView04()
      }
    }
  }
}

#Preview {
  NavigationStack {
    ButtonExample()
  }
}
