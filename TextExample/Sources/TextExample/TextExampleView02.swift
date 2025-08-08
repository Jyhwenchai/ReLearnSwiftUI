//
//  TextExampleView02.swift
//  TextExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Text 文本修饰和样式示例
/// 展示各种文本修饰效果：粗体、斜体、下划线、删除线等
struct TextExampleView02: View {

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {

        // MARK: - 基础文本修饰
        VStack(alignment: .leading, spacing: 12) {
          Text("基础文本修饰")
            .font(.headline)
            .foregroundColor(.primary)

          // 粗体文本
          Text("粗体文本 Bold")
            .bold()

          // 斜体文本
          Text("斜体文本 Italic")
            .italic()

          // 组合修饰：粗体 + 斜体
          Text("粗斜体组合 Bold + Italic")
            .bold()
            .italic()

          // 使用 Bool 参数控制修饰
          Text("条件粗体 (true)")
            .bold(true)

          Text("条件斜体 (false)")
            .italic(false)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 下划线和删除线
        VStack(alignment: .leading, spacing: 12) {
          Text("下划线和删除线")
            .font(.headline)
            .foregroundColor(.primary)

          // 基础下划线
          Text("基础下划线文本")
            .underline()

          // 自定义颜色的下划线
          Text("红色下划线文本")
            .underline(true, color: .red)

          // 虚线下划线
          Text("虚线下划线文本")
            .underline(true, pattern: .dash, color: .blue)

          // 点线下划线
          Text("点线下划线文本")
            .underline(true, pattern: .dot, color: .green)

          // 基础删除线
          Text("基础删除线文本")
            .strikethrough()

          // 自定义颜色的删除线
          Text("紫色删除线文本")
            .strikethrough(true, color: .purple)

          // 虚线删除线
          Text("虚线删除线文本")
            .strikethrough(true, pattern: .dash, color: .orange)

          // 点线删除线
          Text("点线删除线文本")
            .strikethrough(true, pattern: .dot, color: .pink)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 等宽字体
        VStack(alignment: .leading, spacing: 12) {
          Text("等宽字体")
            .font(.headline)
            .foregroundColor(.primary)

          // 普通字体对比
          Text("普通字体: Hello World 12345")
            .font(.body)

          // 等宽字体
          Text("等宽字体: Hello World 12345")
            .monospaced()

          // 等宽字体布尔控制
          Text("条件等宽: Hello World 12345")
            .monospaced(true)

          // 等宽数字（其他字符保持比例）
          Text("等宽数字: Price is $123.45 and $67.89")
            .monospacedDigit()

          // 代码示例
          VStack(alignment: .leading, spacing: 4) {
            Text("代码示例（等宽字体）：")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("func calculateSum() {")
              .monospaced()
              .font(.system(size: 14))
              .foregroundColor(.blue)

            Text("  return a + b")
              .monospaced()
              .font(.system(size: 14))
              .foregroundColor(.blue)

            Text("}")
              .monospaced()
              .font(.system(size: 14))
              .foregroundColor(.blue)
          }
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 字符间距调整
        VStack(alignment: .leading, spacing: 12) {
          Text("字符间距调整")
            .font(.headline)
            .foregroundColor(.primary)

          // 默认间距
          Text("默认字符间距的文本")
            .font(.title3)

          // 增加字符间距 (tracking)
          Text("增加字符间距的文本")
            .font(.title3)
            .tracking(2.0)

          Text("更大字符间距的文本")
            .font(.title3)
            .tracking(5.0)

          // 减少字符间距
          Text("减少字符间距的文本")
            .font(.title3)
            .tracking(-1.0)

          // 字距调整 (kerning) - 调整字符偏移而非空白
          Text("字距调整的文本")
            .font(.title3)
            .kerning(3.0)

          VStack(alignment: .leading, spacing: 4) {
            Text("Tracking vs Kerning 区别：")
              .font(.caption)
              .foregroundColor(.secondary)

            Text("• Tracking 增加尾随空白")
              .font(.caption2)

            Text("• Kerning 调整字符偏移")
              .font(.caption2)

            Text("• 同时使用时，Tracking 优先")
              .font(.caption2)
          }
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 基线偏移
        VStack(alignment: .leading, spacing: 12) {
          Text("基线偏移")
            .font(.headline)
            .foregroundColor(.primary)

          // 基线偏移示例
          HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text("正常文本")
            Text("上标")
              .baselineOffset(8)
              .font(.caption)
            Text("正常")
            Text("下标")
              .baselineOffset(-4)
              .font(.caption)
            Text("正常文本")
          }

          // 化学公式示例
          HStack(alignment: .firstTextBaseline, spacing: 2) {
            Text("H")
              .font(.title2)
            Text("2")
              .font(.caption)
              .baselineOffset(-4)
            Text("O (水分子)")
              .font(.title2)
          }

          // 数学公式示例
          HStack(alignment: .firstTextBaseline, spacing: 2) {
            Text("E = mc")
              .font(.title2)
            Text("2")
              .font(.caption)
              .baselineOffset(8)
          }
        }
        .padding()
        .background(Color.pink.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 综合样式示例
        VStack(alignment: .leading, spacing: 12) {
          Text("综合样式示例")
            .font(.headline)
            .foregroundColor(.primary)

          // 多种修饰组合
          Text("重要提醒文本")
            .font(.title2)
            .bold()
            .underline(true, color: .red)
            .foregroundColor(.red)
            .tracking(1.0)

          // 强调文本
          Text("强调内容")
            .font(.title3)
            .italic()
            .foregroundColor(.blue)
            .underline(true, pattern: .dash, color: .blue)

          // 代码风格
          Text("console.log('Hello World');")
            .font(.system(size: 16, design: .monospaced))
            .foregroundColor(.green)
            .padding(8)
            .background(Color.black.opacity(0.8))
            .cornerRadius(4)

          // 艺术文本
          Text("艺术字体效果")
            .font(.system(size: 24, weight: .heavy, design: .rounded))
            .foregroundColor(.purple)
            .italic()
            .tracking(3.0)
            .shadow(color: .purple.opacity(0.3), radius: 2, x: 2, y: 2)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)

      }
      .padding()
    }
    .navigationTitle("文本修饰样式")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

#Preview {
  NavigationView {
    TextExampleView02()
  }
}
