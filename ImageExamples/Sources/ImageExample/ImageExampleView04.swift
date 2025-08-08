//
//  ImageExampleView04.swift
//  ImageExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Image 图片渲染和颜色示例
/// 展示 Image 组件的渲染模式和颜色控制功能
struct ImageExampleView04: View {
  @State private var selectedColor = Color.blue
  @State private var saturation: Double = 1.0
  @State private var brightness: Double = 1.0

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 20) {
        renderingModeSection
        colorControlSection
        filtersSection
        interactiveSection
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
    .navigationTitle("图片渲染和颜色")
    #if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

extension ImageExampleView04 {
  private var renderingModeSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("渲染模式")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(spacing: 12) {
        renderingModeExample(title: "默认模式", mode: nil)
        renderingModeExample(title: "原始模式", mode: .original)
        renderingModeExample(title: "模板模式", mode: .template)
      }
    }
    .padding()
    .background(Color.blue.opacity(0.1))
    .cornerRadius(8)
  }

  private var colorControlSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("颜色控制")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("系统颜色:")
          .font(.subheadline)
          .foregroundColor(.secondary)
        
        HStack(spacing: 15) {
          colorExample(.red, "红色")
          colorExample(.green, "绿色")
          colorExample(.blue, "蓝色")
          colorExample(.orange, "橙色")
        }
      }
    }
    .padding()
    .background(Color.green.opacity(0.1))
    .cornerRadius(8)
  }

  private var filtersSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("图片滤镜")
        .font(.headline)
        .foregroundColor(.primary)

      HStack(spacing: 15) {
        filterExample("原始", saturation: 1.0, brightness: 0.0)
        filterExample("低饱和度", saturation: 0.3, brightness: 0.0)
        filterExample("高亮度", saturation: 1.0, brightness: 0.3)
        filterExample("低亮度", saturation: 1.0, brightness: -0.3)
      }
    }
    .padding()
    .background(Color.orange.opacity(0.1))
    .cornerRadius(8)
  }

  private var interactiveSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("交互式控制")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(spacing: 16) {
        sliderControl("饱和度", value: $saturation, range: 0...2)
        sliderControl("亮度", value: $brightness, range: -1...1)

        Image(systemName: "photo.artframe")
          .resizable()
          .frame(width: 100, height: 100)
          .foregroundColor(selectedColor)
          .saturation(saturation)
          .brightness(brightness)
          .padding()
          .background(Color.gray.opacity(0.1))
          .cornerRadius(12)
      }
    }
    .padding()
    .background(Color.purple.opacity(0.1))
    .cornerRadius(8)
  }

  // MARK: - Helper Views
  private func renderingModeExample(title: String, mode: Image.TemplateRenderingMode?) -> some View {
    HStack {
      Group {
        if let mode = mode {
          Image(systemName: "heart.fill")
            .renderingMode(mode)
        } else {
          Image(systemName: "heart.fill")
        }
      }
      .font(.title)
      .foregroundColor(.red)
      
      VStack(alignment: .leading) {
        Text(title)
          .font(.caption)
          .fontWeight(.medium)
      }
      
      Spacer()
    }
  }

  private func colorExample(_ color: Color, _ name: String) -> VStack<TupleView<(some View, Text)>> {
    VStack {
      Image(systemName: "heart.fill")
        .font(.title)
        .foregroundColor(color)
      Text(name)
        .font(.caption)
    }
  }

  private func filterExample(_ name: String, saturation: Double, brightness: Double) -> VStack<TupleView<(some View, Text)>> {
    VStack {
      Image(systemName: "photo.artframe")
        .resizable()
        .frame(width: 50, height: 50)
        .foregroundColor(.purple)
        .saturation(saturation)
        .brightness(brightness)
      Text(name)
        .font(.caption2)
    }
  }

  private func sliderControl(_ title: String, value: Binding<Double>, range: ClosedRange<Double>) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("\(title): \(value.wrappedValue, specifier: "%.1f")")
        .font(.subheadline)
      Slider(value: value, in: range)
        .accentColor(.purple)
    }
  }
}

#Preview {
  NavigationStack {
    ImageExampleView04()
  }
}