//
//  TextExampleView01.swift
//  TextExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Text 基础文本显示示例
/// 展示 Text 组件的基本初始化方式和字体样式设置
struct TextExampleView01: View {

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {

        // MARK: - 基础文本初始化
        VStack(alignment: .leading, spacing: 12) {
          Text("基础文本初始化")
            .font(.headline)
            .foregroundColor(.primary)

          // 最简单的文本显示
          Text("Hello, SwiftUI!")

          // 使用 verbatim 显示字面量文本（不进行本地化）
          Text(verbatim: "Verbatim Text - 字面量文本")

          // 本地化文本（从字符串资源中读取，支持多语言）
          Text("localized.greeting")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 字体样式设置
        VStack(alignment: .leading, spacing: 12) {
          Text("字体样式")
            .font(.headline)
            .foregroundColor(.primary)

          // 系统预定义字体大小
          Group {
            Text("Large Title 样式").font(.largeTitle)
            Text("Title 样式").font(.title)
            Text("Title2 样式").font(.title2)
            Text("Title3 样式").font(.title3)
            Text("Headline 样式").font(.headline)
            Text("Subheadline 样式").font(.subheadline)
            Text("Body 样式").font(.body)
            Text("Callout 样式").font(.callout)
            Text("Footnote 样式").font(.footnote)
            Text("Caption 样式").font(.caption)
            Text("Caption2 样式").font(.caption2)
          }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 自定义字体设置
        VStack(alignment: .leading, spacing: 12) {
          Text("自定义字体")
            .font(.headline)
            .foregroundColor(.primary)

          // 自定义字体大小和权重
          Text("自定义字体 - 大小24，粗体")
            .font(.system(size: 24, weight: .bold))

          // 设置字体设计风格
          Text("Default 设计风格")
            .font(.system(size: 16, design: .default))

          Text("Monospaced 等宽设计")
            .font(.system(size: 16, design: .monospaced))

          Text("Rounded 圆角设计")
            .font(.system(size: 16, design: .rounded))

          Text("Serif 衬线设计")
            .font(.system(size: 16, design: .serif))
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 字体权重
        VStack(alignment: .leading, spacing: 12) {
          Text("字体权重")
            .font(.headline)
            .foregroundColor(.primary)

          Group {
            Text("Ultra Light 权重").fontWeight(.ultraLight)
            Text("Thin 权重").fontWeight(.thin)
            Text("Light 权重").fontWeight(.light)
            Text("Regular 权重").fontWeight(.regular)
            Text("Medium 权重").fontWeight(.medium)
            Text("Semibold 权重").fontWeight(.semibold)
            Text("Bold 权重").fontWeight(.bold)
            Text("Heavy 权重").fontWeight(.heavy)
            Text("Black 权重").fontWeight(.black)
          }
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 颜色设置
        VStack(alignment: .leading, spacing: 12) {
          Text("文本颜色")
            .font(.headline)
            .foregroundColor(.primary)

          // 系统预定义颜色
          Group {
            Text("Primary 主色").foregroundColor(.primary)
            Text("Secondary 次要色").foregroundColor(.secondary)
            Text("Blue 蓝色").foregroundColor(.blue)
            Text("Green 绿色").foregroundColor(.green)
            Text("Red 红色").foregroundColor(.red)
            Text("Orange 橙色").foregroundColor(.orange)
            Text("Purple 紫色").foregroundColor(.purple)
            Text("Pink 粉色").foregroundColor(.pink)
          }

          // 自定义颜色
          Text("自定义RGB颜色")
            .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.6))

          Text("十六进制颜色")
            .foregroundColor(Color(hex: 0xFF5733))
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)

      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
    .frame(maxWidth: .infinity)
    .navigationTitle("基础文本显示")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

// MARK: - Color 扩展，支持十六进制颜色
extension Color {
  fileprivate init(hex: UInt, opacity: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 08) & 0xff) / 255,
      blue: Double((hex >> 00) & 0xff) / 255,
      opacity: opacity
    )
  }
}

#Preview {
  NavigationStack {
    TextExampleView01()
  }
}
