import SwiftUI

/// HelpLink 不同类型帮助内容示例
///
/// 本示例展示了如何为不同类型的帮助内容创建 HelpLink：
/// 1. 在线文档链接
/// 2. 视频教程链接
/// 3. FAQ 页面链接
/// 4. 技术支持链接
/// 5. 用户指南链接
@available(macOS 14.0, *)
struct HelpLinkExampleView02: View {
  @State private var selectedHelpType = "文档"
  @State private var lastClickedHelp = ""

  // 不同类型的帮助内容
  private let helpTypes = [
    "文档": "https://developer.apple.com/documentation/",
    "教程": "https://developer.apple.com/tutorials/",
    "论坛": "https://developer.apple.com/forums/",
    "支持": "https://developer.apple.com/support/",
    "指南": "https://developer.apple.com/design/",
  ]

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {
        // 页面标题和说明
        VStack(alignment: .leading, spacing: 10) {
          Text("不同类型的帮助内容")
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("展示如何为不同类型的帮助内容创建相应的 HelpLink")
            .font(.body)
            .foregroundColor(.secondary)
        }

        Divider()

        // 示例 1：在线文档帮助
        GroupBox("1. 在线文档帮助") {
          VStack(alignment: .leading, spacing: 15) {
            Text("链接到在线技术文档，为用户提供详细的 API 参考")
              .font(.body)

            HStack {
              Image(systemName: "doc.text")
                .foregroundColor(.blue)
              Text("SwiftUI 官方文档")
              Spacer()
              HelpLink(
                destination: URL(string: "https://developer.apple.com/documentation/swiftui")!)
            }
            .padding(10)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)

            // 代码示例
            codeExample(
              """
              HelpLink(destination: URL(string: "https://developer.apple.com/documentation/swiftui")!)
              """)
          }
          .padding()
        }

        // 示例 2：视频教程帮助
        GroupBox("2. 视频教程帮助") {
          VStack(alignment: .leading, spacing: 15) {
            Text("链接到视频教程，提供可视化的学习资源")
              .font(.body)

            HStack {
              Image(systemName: "play.rectangle")
                .foregroundColor(.red)
              Text("WWDC 视频教程")
              Spacer()
              HelpLink {
                // 自定义动作：可以先检查网络状态再打开
                if let url = URL(string: "https://developer.apple.com/videos/") {
                  NSWorkspace.shared.open(url)
                  lastClickedHelp = "视频教程"
                }
              }
            }
            .padding(10)
            .background(Color.red.opacity(0.1))
            .cornerRadius(8)

            // 代码示例
            codeExample(
              """
              HelpLink {
                  if let url = URL(string: "https://developer.apple.com/videos/") {
                      NSWorkspace.shared.open(url)
                  }
              }
              """)
          }
          .padding()
        }

        // 示例 3：FAQ 帮助
        GroupBox("3. 常见问题 (FAQ)") {
          VStack(alignment: .leading, spacing: 15) {
            Text("链接到常见问题页面，快速解决用户疑问")
              .font(.body)

            HStack {
              Image(systemName: "questionmark.circle")
                .foregroundColor(.orange)
              Text("开发者论坛 FAQ")
              Spacer()
              HelpLink(destination: URL(string: "https://developer.apple.com/forums/")!)
            }
            .padding(10)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(8)

            // 代码示例
            codeExample(
              """
              HelpLink(destination: URL(string: "https://developer.apple.com/forums/")!)
              """)
          }
          .padding()
        }

        // 示例 4：技术支持帮助
        GroupBox("4. 技术支持") {
          VStack(alignment: .leading, spacing: 15) {
            Text("链接到技术支持页面，获取专业帮助")
              .font(.body)

            HStack {
              Image(systemName: "person.fill.questionmark")
                .foregroundColor(.green)
              Text("Apple 开发者支持")
              Spacer()
              HelpLink(destination: URL(string: "https://developer.apple.com/support/")!)
            }
            .padding(10)
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)

            // 代码示例
            codeExample(
              """
              HelpLink(destination: URL(string: "https://developer.apple.com/support/")!)
              """)
          }
          .padding()
        }

        // 示例 5：动态帮助内容
        GroupBox("5. 动态帮助内容选择") {
          VStack(alignment: .leading, spacing: 15) {
            Text("根据用户选择动态改变帮助内容")
              .font(.body)

            // 帮助类型选择器
            Picker("帮助类型", selection: $selectedHelpType) {
              ForEach(Array(helpTypes.keys), id: \.self) { type in
                Text(type).tag(type)
              }
            }
            .pickerStyle(SegmentedPickerStyle())

            HStack {
              Image(systemName: "link")
                .foregroundColor(.purple)
              Text("当前选择: \(selectedHelpType)")
              Spacer()
              HelpLink {
                if let urlString = helpTypes[selectedHelpType],
                  let url = URL(string: urlString)
                {
                  NSWorkspace.shared.open(url)
                  lastClickedHelp = selectedHelpType
                }
              }
            }
            .padding(10)
            .background(Color.purple.opacity(0.1))
            .cornerRadius(8)

            // 显示最后点击的帮助类型
            if !lastClickedHelp.isEmpty {
              Text("最后打开的帮助: \(lastClickedHelp)")
                .font(.caption)
                .foregroundColor(.secondary)
            }

            // 代码示例
            codeExample(
              """
              HelpLink {
                  if let urlString = helpTypes[selectedHelpType],
                     let url = URL(string: urlString) {
                      NSWorkspace.shared.open(url)
                  }
              }
              """)
          }
          .padding()
        }

        // 最佳实践建议
        GroupBox("最佳实践") {
          VStack(alignment: .leading, spacing: 10) {
            practiceItem(
              icon: "checkmark.circle.fill",
              color: .green,
              title: "明确的帮助内容",
              description: "确保每个 HelpLink 都指向明确、相关的帮助内容"
            )

            practiceItem(
              icon: "network",
              color: .blue,
              title: "网络状态检查",
              description: "对于在线帮助，考虑检查网络连接状态"
            )

            practiceItem(
              icon: "person.crop.circle.badge.questionmark",
              color: .orange,
              title: "上下文相关",
              description: "根据当前界面上下文提供相关的帮助内容"
            )

            practiceItem(
              icon: "arrow.clockwise",
              color: .purple,
              title: "内容更新",
              description: "定期检查和更新帮助链接的有效性"
            )
          }
          .padding()
        }
      }
      .padding()
    }
    .navigationTitle("不同类型帮助内容")
  }

  // 辅助方法：创建代码示例视图
  private func codeExample(_ code: String) -> some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("代码示例：")
        .font(.caption)
        .fontWeight(.semibold)

      Text(code)
        .font(.system(.caption, design: .monospaced))
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(4)
    }
  }

  // 辅助方法：创建最佳实践条目
  private func practiceItem(icon: String, color: Color, title: String, description: String)
    -> some View
  {
    HStack(alignment: .top, spacing: 10) {
      Image(systemName: icon)
        .foregroundColor(color)
        .frame(width: 20)

      VStack(alignment: .leading, spacing: 2) {
        Text(title)
          .font(.caption)
          .fontWeight(.semibold)

        Text(description)
          .font(.caption2)
          .foregroundColor(.secondary)
      }
    }
  }
}

// 预览
@available(macOS 14.0, *)
#Preview {
  HelpLinkExampleView02()
    .frame(width: 800, height: 600)
}
