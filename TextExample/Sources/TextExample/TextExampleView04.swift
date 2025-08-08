//
//  TextExampleView04.swift
//  TextExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Text 高级功能示例
/// 展示 AttributedString、Markdown、文本选择、动态类型、文本合并等高级功能
struct TextExampleView04: View {

  // 状态变量
  @State private var isTextSelectable = true
  @State private var selectedDynamicTypeSize: DynamicTypeSize = .medium
  @State private var currentScale: Text.Scale = .default

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {

        markdownSection
        textSelectionSection
        dynamicTypeSection
        textScaleSection
        textCombinationSection
        textVariantsSection
        comprehensiveExampleSection

      }
      .padding()
    }
    .navigationTitle("高级功能")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - Markdown Section
  private var markdownSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("AttributedString 和 Markdown")
        .font(.headline)
        .foregroundColor(.primary)

      // Markdown 文本
      VStack(alignment: .leading, spacing: 8) {
        Text("Markdown 支持")
          .font(.subheadline)
          .foregroundColor(.secondary)

        // 使用 Markdown 语法
        Text("这里支持 **粗体文本**、*斜体文本*、以及 `代码文本`")
          .padding(8)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(6)

        // 更复杂的 Markdown
        Text("支持 [链接文本](https://apple.com)、~~删除线~~、以及 **_组合样式_**")
          .padding(8)
          .background(Color.green.opacity(0.1))
          .cornerRadius(6)
      }

      // AttributedString 示例
      VStack(alignment: .leading, spacing: 8) {
        Text("AttributedString 示例")
          .font(.subheadline)
          .foregroundColor(.secondary)

        // 创建复杂的 AttributedString
        Text(createAttributedString())
          .padding(8)
          .background(Color.orange.opacity(0.1))
          .cornerRadius(6)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }

  // MARK: - Text Selection Section
  private var textSelectionSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("文本选择功能")
        .font(.headline)
        .foregroundColor(.primary)

      // 选择开关
      Toggle("启用文本选择", isOn: $isTextSelectable)
        .font(.subheadline)

      VStack(alignment: .leading, spacing: 8) {
        Text("可选择文本示例")
          .font(.subheadline)
          .foregroundColor(.secondary)

        Group {
          if isTextSelectable {
            Text(
              "长按此文本即可选择和复制。这个功能在需要用户复制内容时非常有用，比如邮箱地址、电话号码、代码片段等。选择功能可以通过 textSelection 修饰符来控制启用或禁用。"
            )
            .textSelection(.enabled)
          } else {
            Text(
              "长按此文本即可选择和复制。这个功能在需要用户复制内容时非常有用，比如邮箱地址、电话号码、代码片段等。选择功能可以通过 textSelection 修饰符来控制启用或禁用。"
            )
          }
        }
        .padding(8)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(6)

        Text("提示：长按文本试试看！")
          .font(.caption)
          .foregroundColor(.secondary)
          .italic()
      }
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }

  // MARK: - Dynamic Type Section
  private var dynamicTypeSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("动态类型大小")
        .font(.headline)
        .foregroundColor(.primary)

      // 类型大小选择器
      Picker("选择字体大小", selection: $selectedDynamicTypeSize) {
        Text("Extra Small").tag(DynamicTypeSize.xSmall)
        Text("Small").tag(DynamicTypeSize.small)
        Text("Medium").tag(DynamicTypeSize.medium)
        Text("Large").tag(DynamicTypeSize.large)
        Text("Extra Large").tag(DynamicTypeSize.xLarge)
        Text("XXX Large").tag(DynamicTypeSize.xxxLarge)
      }
      .pickerStyle(MenuPickerStyle())

      VStack(alignment: .leading, spacing: 8) {
        Text("动态文本示例")
          .font(.subheadline)
          .foregroundColor(.secondary)

        Text("这段文本会根据上面选择的动态类型大小进行调整。动态类型是 iOS 的辅助功能特性，可以帮助视力不佳的用户更好地阅读文本内容。")
          .dynamicTypeSize(selectedDynamicTypeSize)
          .padding(8)
          .background(Color.green.opacity(0.1))
          .cornerRadius(6)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }

  // MARK: - Text Scale Section
  private var textScaleSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("文本缩放")
        .font(.headline)
        .foregroundColor(.primary)

      // 缩放选择器
      Picker("选择缩放比例", selection: $currentScale) {
        Text("默认").tag(Text.Scale.default)
        Text("次要").tag(Text.Scale.secondary)
      }
      .pickerStyle(SegmentedPickerStyle())

      VStack(alignment: .leading, spacing: 8) {
        Text("缩放文本示例")
          .font(.subheadline)
          .foregroundColor(.secondary)

        Text("这段文本应用了文本缩放效果。文本缩放可以根据上下文调整文本的显示大小，secondary 缩放通常会使文本稍微小一些。")
          .textScale(currentScale, isEnabled: true)
          .padding(8)
          .background(Color.purple.opacity(0.1))
          .cornerRadius(6)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }

  // MARK: - Text Combination Section
  private var textCombinationSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("文本合并操作符")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("使用 + 操作符合并文本")
          .font(.subheadline)
          .foregroundColor(.secondary)

        // 文本合并示例
        (Text("这是")
          + Text(" 合并的 ")
          .bold()
          .foregroundColor(.blue)
          + Text("文本内容，")
          + Text("每部分可以有")
          .italic()
          .foregroundColor(.green)
          + Text("不同的样式。")
          .underline()
          .foregroundColor(.red))
          .padding(8)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(6)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }

  // MARK: - Text Variants Section
  private var textVariantsSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("文本变体和自适应")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("文本大小写变换")
          .font(.subheadline)
          .foregroundColor(.secondary)

        // 不同的大小写变换
        Group {
          Text("原始文本 Original Text")
            .padding(4)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(4)

          Text("原始文本 Original Text")
            .textCase(.uppercase)
            .padding(4)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(4)

          Text("原始文本 Original Text")
            .textCase(.lowercase)
            .padding(4)
            .background(Color.green.opacity(0.1))
            .cornerRadius(4)
        }
      }
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }

  // MARK: - Comprehensive Example Section
  private var comprehensiveExampleSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("综合高级示例")
        .font(.headline)
        .foregroundColor(.primary)

      // 富文本消息卡片
      VStack(alignment: .leading, spacing: 8) {
        // 标题
        (Text("系统通知 ")
          .font(.headline)
          .fontWeight(.semibold)
          + Text("重要")
          .font(.caption)
          .foregroundColor(.white)
          .bold())
          .padding(.vertical, 4)

        // 内容
        let messageContent =
          Text("您的账户余额不足。当前余额：")
          .foregroundColor(.primary)
          + Text("$12.34")
          .foregroundColor(.red)
          .bold()
          + Text("。请及时充值以免影响服务使用。")
          .foregroundColor(.primary)

        messageContent
          .textSelection(.enabled)
          .lineSpacing(2)
          .multilineTextAlignment(.leading)

        // 时间戳
        Text("2025年8月8日 14:30")
          .font(.caption)
          .foregroundColor(.secondary)
          .italic()
      }
      .padding()
      .background(Color.yellow.opacity(0.1))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.yellow.opacity(0.3), lineWidth: 1)
      )
      .cornerRadius(8)
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
  }

  // MARK: - 创建 AttributedString
  private func createAttributedString() -> AttributedString {
    var attributedString = AttributedString("这是一个复杂的 AttributedString 示例")

    // 查找并设置不同部分的属性
    if let range = attributedString.range(of: "复杂的") {
      attributedString[range].foregroundColor = .blue
      attributedString[range].font = .system(size: 16, weight: .bold)
    }

    if let range = attributedString.range(of: "AttributedString") {
      attributedString[range].foregroundColor = .green
      attributedString[range].font = .system(size: 14, weight: .medium, design: .monospaced)
      attributedString[range].underlineStyle = .single
    }

    if let range = attributedString.range(of: "示例") {
      attributedString[range].foregroundColor = .red
      attributedString[range].font = .system(size: 16, weight: .regular).italic()
    }

    return attributedString
  }
}

#Preview {
  NavigationView {
    TextExampleView04()
  }
}
