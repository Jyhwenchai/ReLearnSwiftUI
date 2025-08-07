// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import ShareComponent

public struct TextExample: View {
  public init() {}
  public var body: some View {
    ComponentExample(componentTitle: "Text") {
      NavigationLink("Text1") {
        TextExampleView01()
      }
      NavigationLink("Text2") {
        TextExampleView01()
      }
    }
  }
}

#Preview {
  NavigationStack {
    TextExample()
  }
}
