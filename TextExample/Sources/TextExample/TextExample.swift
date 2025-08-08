// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import ShareComponent

public struct TextExample: View {
  public init() {}
  public var body: some View {
    ComponentExample(componentTitle: "Text") {
      NavigationLink("基础文本显示") {
        TextExampleView01()
      }
      NavigationLink("文本修饰样式") {
        TextExampleView02()
      }
      NavigationLink("多行文本布局") {
        TextExampleView03()
      }
      NavigationLink("高级功能") {
        TextExampleView04()
      }
      NavigationLink("特殊格式化") {
        TextExampleView05()
      }
    }
  }
}

#Preview {
  NavigationStack {
    TextExample()
  }
}
