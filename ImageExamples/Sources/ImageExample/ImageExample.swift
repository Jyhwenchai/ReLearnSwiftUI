//
//  ImageExample.swift
//  ImageExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI
import ShareComponent

/// SwiftUI Image 组件示例主入口
/// 使用 ShareComponent 的 ComponentExample 包装器展示所有 Image 相关示例
public struct ImageExample: View {
  
  public init() {}
  
  public var body: some View {
    ComponentExample(componentTitle: "Image") {
      
      // Image 基础图片加载和显示示例
      NavigationLink(destination: ImageExampleView01()) {
        ExampleRowView(
          title: "基础图片显示",
          description: "SF Symbols、Bundle 资源、基础初始化方式",
          icon: "photo",
          color: .blue
        )
      }
      
      // Image 图片尺寸和缩放示例
      NavigationLink(destination: ImageExampleView02()) {
        ExampleRowView(
          title: "尺寸和缩放",
          description: "resizable、aspectRatio、scaledToFit/Fill",
          icon: "arrow.up.left.and.arrow.down.right",
          color: .green
        )
      }
      
      // Image 图片样式和修饰示例
      NavigationLink(destination: ImageExampleView03()) {
        ExampleRowView(
          title: "样式和修饰",
          description: "圆角、边框、阴影、overlay、透明度",
          icon: "paintbrush",
          color: .orange
        )
      }
      
      // Image 图片渲染和颜色示例
      NavigationLink(destination: ImageExampleView04()) {
        ExampleRowView(
          title: "渲染和颜色",
          description: "renderingMode、foregroundColor、滤镜",
          icon: "eyedropper",
          color: .purple
        )
      }
      
      // Image 异步加载和高级功能示例
      NavigationLink(destination: ImageExampleView05()) {
        ExampleRowView(
          title: "异步加载和高级功能",
          description: "AsyncImage、缓存、变换、动画",
          icon: "network",
          color: .red
        )
      }
      
    }
  }
}

/// 示例行视图组件
/// 用于统一显示每个示例的信息
struct ExampleRowView: View {
  let title: String
  let description: String
  let icon: String
  let color: Color
  
  var body: some View {
    HStack(spacing: 16) {
      // 图标
      Image(systemName: icon)
        .font(.title2)
        .foregroundColor(.white)
        .frame(width: 40, height: 40)
        .background(color)
        .cornerRadius(8)
      
      // 文字内容
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.headline)
          .foregroundColor(.primary)
        
        Text(description)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .multilineTextAlignment(.leading)
      }
      
      Spacer()
      
      // 箭头指示器
      Image(systemName: "chevron.right")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding(.vertical, 8)
    .contentShape(Rectangle())
  }
}

#Preview {
  NavigationStack {
    ImageExample()
  }
}
