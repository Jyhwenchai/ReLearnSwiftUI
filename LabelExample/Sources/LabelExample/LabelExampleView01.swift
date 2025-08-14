import SwiftUI

/// LabelExampleView01 - 基础 Label 创建和使用
///
/// 这个示例展示了 SwiftUI Label 组件的基础用法：
/// - 基本的 Label 创建语法
/// - 文本和图标的组合
/// - 系统图标的使用
/// - Label 的基本属性
public struct LabelExampleView01: View {
  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("基础 Label 创建")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom)

        // MARK: - 1. 最简单的 Label
        GroupBox("1. 最简单的 Label") {
          VStack(alignment: .leading, spacing: 12) {
            // 基础 Label：文本 + 系统图标
            Label("设置", systemImage: "gear")

            // 解释：Label 接受两个参数
            // 第一个参数：显示的文本内容
            // 第二个参数：系统图标名称（SF Symbols）
            Text("💡 Label 由文本和图标组成，这是最基本的用法")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 2. 常用系统图标示例
        GroupBox("2. 常用系统图标示例") {
          VStack(alignment: .leading, spacing: 8) {
            // 文件相关
            Label("文档", systemImage: "doc")
            Label("文件夹", systemImage: "folder")
            Label("下载", systemImage: "arrow.down.circle")

            Divider()

            // 通信相关
            Label("邮件", systemImage: "envelope")
            Label("电话", systemImage: "phone")
            Label("消息", systemImage: "message")

            Divider()

            // 系统功能
            Label("搜索", systemImage: "magnifyingglass")
            Label("收藏", systemImage: "heart")
            Label("分享", systemImage: "square.and.arrow.up")

            Text("💡 SF Symbols 提供了数千个系统图标，覆盖各种使用场景")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 3. 自定义文本内容
        GroupBox("3. 自定义文本内容") {
          VStack(alignment: .leading, spacing: 8) {
            // 简单文本
            Label("主页", systemImage: "house")

            // 包含数字的文本
            Label("消息 (5)", systemImage: "message.badge")

            // 多语言文本
            Label("设置", systemImage: "gear")
            Label("Settings", systemImage: "gear")

            // 长文本
            Label(
              "这是一个很长的标签文本，用来测试 Label 如何处理长内容",
              systemImage: "text.alignleft")

            Text("💡 Label 的文本内容可以是任意字符串，支持多语言")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 4. Label 的基本特性
        GroupBox("4. Label 的基本特性") {
          VStack(alignment: .leading, spacing: 12) {
            // 默认布局：图标在左，文本在右
            Label("默认布局", systemImage: "arrow.right")

            // Label 会自动适应内容大小
            HStack {
              Label("短", systemImage: "1.circle")
              Spacer()
              Label("这是一个较长的标签", systemImage: "2.circle")
            }

            // Label 继承父视图的样式
            VStack(alignment: .leading) {
              Text("不同字体大小的 Label：")
                .font(.headline)

              Label("标题样式", systemImage: "textformat.size")
                .font(.title2)

              Label("正文样式", systemImage: "textformat")
                .font(.body)

              Label("说明样式", systemImage: "textformat.size.smaller")
                .font(.caption)
            }

            Text("💡 Label 会自动适应内容和继承样式，无需额外配置")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 5. 实际应用场景
        GroupBox("5. 实际应用场景") {
          VStack(alignment: .leading, spacing: 8) {
            Text("导航菜单：")
              .font(.headline)

            VStack(alignment: .leading, spacing: 4) {
              Label("个人资料", systemImage: "person.circle")
              Label("账户设置", systemImage: "gear")
              Label("隐私设置", systemImage: "lock")
              Label("帮助中心", systemImage: "questionmark.circle")
              Label("退出登录", systemImage: "arrow.right.square")
            }
            .padding(.leading)

            Text("💡 Label 非常适合用于导航菜单、工具栏、列表项等场景")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding()
    }
    .navigationTitle("基础 Label")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    LabelExampleView01()
  }
}
