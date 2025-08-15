import SwiftUI

/// HelpLink 基础使用示例
///
/// 本示例展示了 HelpLink 的三种基本初始化方式：
/// 1. 使用 URL 打开网页帮助
/// 2. 使用锚点打开本地帮助书籍
/// 3. 使用自定义动作执行特定操作
@available(macOS 14.0, *)
struct HelpLinkExampleView01: View {
  // 状态变量用于显示自定义动作的结果
  @State private var actionMessage = ""
  @State private var showingAlert = false

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {
        // 页面标题和说明
        VStack(alignment: .leading, spacing: 10) {
          Text("HelpLink 基础使用")
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("HelpLink 是 macOS 专用的帮助链接组件，提供标准的帮助按钮外观")
            .font(.body)
            .foregroundColor(.secondary)
        }

        Divider()

        // 示例 1：使用 URL 的 HelpLink
        GroupBox("1. 使用 URL 打开网页帮助") {
          VStack(alignment: .leading, spacing: 15) {
            Text("这种方式会打开指定的网页 URL，适合链接到在线帮助文档")
              .font(.body)

            HStack {
              Text("点击帮助按钮打开 Apple 开发者文档：")

              // 使用 URL 初始化的 HelpLink
              HelpLink(
                destination: URL(
                  string: "https://developer.apple.com/documentation/swiftui/helplink")!)
            }

            // 代码示例
            VStack(alignment: .leading, spacing: 5) {
              Text("代码示例：")
                .font(.caption)
                .fontWeight(.semibold)

              Text(
                """
                HelpLink(destination: URL(string: "https://example.com/help")!)
                """
              )
              .font(.system(.caption, design: .monospaced))
              .padding(8)
              .background(Color.gray.opacity(0.1))
              .cornerRadius(4)
            }
          }
          .padding()
        }

        // 示例 2：使用锚点的 HelpLink
        GroupBox("2. 使用锚点打开本地帮助书籍") {
          VStack(alignment: .leading, spacing: 15) {
            Text("这种方式会打开应用的本地帮助书籍中的特定锚点")
              .font(.body)

            HStack {
              Text("点击帮助按钮打开本地帮助：")

              // 使用锚点初始化的 HelpLink
              // 注意：这需要应用配置了 CFBundleHelpBookName
              HelpLink(anchor: "mainHelp")
            }

            // 说明文本
            Text("注意：需要在 Info.plist 中配置 CFBundleHelpBookName 键")
              .font(.caption)
              .foregroundColor(.orange)

            // 代码示例
            VStack(alignment: .leading, spacing: 5) {
              Text("代码示例：")
                .font(.caption)
                .fontWeight(.semibold)

              Text(
                """
                HelpLink(anchor: "mainHelp")
                """
              )
              .font(.system(.caption, design: .monospaced))
              .padding(8)
              .background(Color.gray.opacity(0.1))
              .cornerRadius(4)
            }
          }
          .padding()
        }

        // 示例 3：使用自定义动作的 HelpLink
        GroupBox("3. 使用自定义动作") {
          VStack(alignment: .leading, spacing: 15) {
            Text("这种方式允许你执行自定义的帮助动作，比如显示弹窗或执行特定逻辑")
              .font(.body)

            HStack {
              Text("点击帮助按钮执行自定义动作：")

              // 使用自定义动作初始化的 HelpLink
              HelpLink {
                // 自定义动作：显示警告框
                actionMessage = "自定义帮助动作被触发！"
                showingAlert = true
              }
            }

            // 显示动作结果
            if !actionMessage.isEmpty {
              Text("动作结果: \(actionMessage)")
                .font(.caption)
                .foregroundColor(.green)
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(4)
            }

            // 代码示例
            VStack(alignment: .leading, spacing: 5) {
              Text("代码示例：")
                .font(.caption)
                .fontWeight(.semibold)

              Text(
                """
                HelpLink {
                    // 执行自定义帮助动作
                    showHelpDialog()
                }
                """
              )
              .font(.system(.caption, design: .monospaced))
              .padding(8)
              .background(Color.gray.opacity(0.1))
              .cornerRadius(4)
            }
          }
          .padding()
        }

        // 重要说明
        GroupBox("重要说明") {
          VStack(alignment: .leading, spacing: 10) {
            Label("HelpLink 仅在 macOS 14.0+ 可用", systemImage: "info.circle")
              .foregroundColor(.blue)

            Label("HelpLink 具有标准的帮助按钮外观，无法自定义样式", systemImage: "paintbrush")
              .foregroundColor(.orange)

            Label("在特定容器中会自动定位（如警告框、工具栏）", systemImage: "location")
              .foregroundColor(.green)
          }
          .padding()
        }
      }
      .padding()
    }
    .navigationTitle("基础使用")
    .alert("帮助", isPresented: $showingAlert) {
      Button("确定") {
        actionMessage = ""
      }
    } message: {
      Text(actionMessage)
    }
  }
}

// 预览
@available(macOS 14.0, *)
#Preview {
  HelpLinkExampleView01()
    .frame(width: 800, height: 600)
}
