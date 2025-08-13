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

// MARK: - ExampleContainerView
/// 示例容器视图，提供统一的示例展示格式
public struct ExampleContainerView<Content: View, Footer: View>: View {
  let title: String
  let content: Content
  let footer: Footer?

  public init(
    _ title: String, @ViewBuilder content: () -> Content, @ViewBuilder footer: () -> Footer
  ) {
    self.title = title
    self.content = content()
    self.footer = footer()
  }

  public init(_ title: String, @ViewBuilder content: () -> Content) where Footer == EmptyView {
    self.title = title
    self.content = content()
    self.footer = nil
  }

  public var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 20) {
        content

        if let footer = footer {
          footer
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
      }
      .padding()
    }
    .navigationTitle(title)
    #if os(iOS)
      .navigationBarTitleDisplayMode(.large)
    #endif
  }
}

// MARK: - ExampleSection
/// 示例章节视图，用于组织示例内容
public struct ExampleSection<Content: View>: View {
  let title: String
  let content: Content

  public init(_ title: String, @ViewBuilder content: () -> Content) {
    self.title = title
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(.primary)

      content
    }
    .padding()
    .background(backgroundColorForPlatform())
    .cornerRadius(12)
    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
  }
}

// MARK: - Helper Functions
private func backgroundColorForPlatform() -> Color {
  #if os(iOS)
    return Color(UIColor.systemBackground)
  #else
    return Color(.controlBackgroundColor)
  #endif
}
