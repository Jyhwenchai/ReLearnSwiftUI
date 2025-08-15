//
//  ContentView.swift
//  ReLearnSwiftUI
//
//  Created by didong on 2025/8/7.
//

import ButtonExample
import ImageExample
import SliderExample
import SwiftUI
import TextExample

/// 主应用界面 - 显示所有可用的 SwiftUI 组件列表
/// 用户可以从这里选择要学习的组件，然后跳转到对应的示例页面
struct ContentView: View {
  /// 可用的 SwiftUI 组件列表
  /// 每个组件都有对应的示例包和详细说明
  let components = [
    ComponentInfo(
      name: "Text",
      description: "文本显示组件",
      icon: "textformat",
      view: AnyView(TextExample())
    ),
    ComponentInfo(
      name: "Image",
      description: "图片显示组件",
      icon: "photo",
      view: AnyView(ImageExample())
    ),
    ComponentInfo(
      name: "Button",
      description: "按钮交互组件",
      icon: "button.programmable",
      view: AnyView(ButtonExample())
    ),
  ]

  var body: some View {
    NavigationStack {
      List(components, id: \.name) { component in
        // 使用 NavigationLink 实现页面跳转
        NavigationLink(destination: component.view) {
          ComponentRowView(component: component)
        }
      }
      .navigationTitle("SwiftUI 组件学习")
      .navigationBarTitleDisplayMode(.large)
    }
    .navigationViewStyle(StackNavigationViewStyle())  // 确保在 iPad 上也使用堆叠样式
  }
}

/// 组件信息数据模型
/// 包含组件的基本信息，用于在列表中显示
struct ComponentInfo {
  /// 组件名称
  let name: String
  /// 组件描述
  let description: String
  /// 组件图标（SF Symbol 名称）
  let icon: String

  let view: AnyView
}

/// 组件列表行视图
/// 用于在主列表中显示每个组件的信息
struct ComponentRowView: View {
  /// 组件信息
  let component: ComponentInfo

  var body: some View {
    HStack(spacing: 16) {
      // 组件图标
      Image(systemName: component.icon)
        .font(.title2)
        .foregroundColor(.blue)
        .frame(width: 32, height: 32)

      // 组件信息
      VStack(alignment: .leading, spacing: 4) {
        Text(component.name)
          .font(.headline)
          .foregroundColor(.primary)

        Text(component.description)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }

      Spacer()
    }
    .padding(.vertical, 4)
  }
}

#Preview {
  ContentView()
}
