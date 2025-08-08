// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

#if canImport(UIKit)
  import UIKit
#endif

public struct ComponentExample<Content: View>: View {
  let componentTitle: String
  let content: Content
  public init(componentTitle: String, @ViewBuilder content: () -> Content) {
    self.componentTitle = componentTitle
    self.content = content()
  }

  public var body: some View {
    List {
      // 组件描述
      VStack(alignment: .leading, spacing: 8) {
        Text("这里将展示 \(componentTitle) 组件的各种使用示例和详细说明。")
          .font(.body)
          .foregroundColor(.secondary)
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(12)
      .listRowInsets(EdgeInsets())
      .frame(maxWidth: .infinity, alignment: .center)
      .listRowSeparator(.hidden)

      ForEach(subviews: content) { subView in
        subView
          .padding()
      }
    }
    .listStyle(.plain)
    .navigationTitle("\(componentTitle)")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.large)
    #endif
  }
}

#Preview {
  NavigationStack {
    ComponentExample(componentTitle: "Text") {
      Text("Text的基本使用")
      Text("Text的复杂使用")
    }
  }
}
