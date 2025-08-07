//
//  ComponentExampleView.swift
//  ReLearnSwiftUI
//
//  Created by Kiro on 2025/8/7.
//

import SwiftUI

/// 通用的组件示例展示视图
/// 用于展示各个 SwiftUI 组件的示例代码和效果
struct TextExampleView01: View {
  /// 当前选中的示例索引
  @State private var selectedExample = 0

  var body: some View {
    // Text 组件示例
    VStack(alignment: .leading, spacing: 12) {
      Text("基础文本示例")
        .font(.subheadline)
        .foregroundColor(.secondary)

      Text("Hello, SwiftUI!")
        .font(.title)
        .foregroundColor(.blue)

      Text("这是一个带样式的文本")
        .font(.body)
        .fontWeight(.medium)
        .foregroundColor(.green)
    }
  }
}

#Preview {
  NavigationView {
    TextExampleView01()
  }
}
