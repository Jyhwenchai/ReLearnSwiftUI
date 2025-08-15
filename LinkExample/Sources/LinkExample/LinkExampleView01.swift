import SwiftUI

/// LinkExampleView01 - 基础链接创建和使用
///
/// 本示例演示了 SwiftUI Link 组件的基础用法：
/// - 创建基本的网页链接
/// - 使用不同的文本样式
/// - 链接的基本属性和行为
public struct LinkExampleView01: View {
  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          // MARK: - 基础链接创建
          GroupBox("基础链接创建") {
            VStack(alignment: .leading, spacing: 15) {
              // 最简单的链接创建
              Link("访问 Apple 官网", destination: URL(string: "https://www.apple.com")!)

              // 带有描述的链接
              VStack(alignment: .leading, spacing: 5) {
                Text("官方网站")
                  .font(.caption)
                  .foregroundColor(.secondary)
                Link(
                  "https://developer.apple.com",
                  destination: URL(string: "https://developer.apple.com")!)
              }

              // 使用自定义文本的链接
              Link(
                "SwiftUI 官方文档",
                destination: URL(string: "https://developer.apple.com/documentation/swiftui")!)
            }
            .padding()
          }

          // MARK: - 不同文本样式的链接
          GroupBox("文本样式") {
            VStack(alignment: .leading, spacing: 15) {
              // 标题样式链接
              Link("大标题链接", destination: URL(string: "https://www.apple.com")!)
                .font(.title2.bold())

              // 副标题样式链接
              Link("副标题链接", destination: URL(string: "https://www.apple.com")!)
                .font(.headline)

              // 正文样式链接
              Link("正文样式链接", destination: URL(string: "https://www.apple.com")!)
                .font(.body)

              // 小字体链接
              Link("小字体链接", destination: URL(string: "https://www.apple.com")!)
                .font(.caption)
            }
            .padding()
          }

          // MARK: - 颜色自定义
          GroupBox("颜色自定义") {
            VStack(alignment: .leading, spacing: 15) {
              // 默认蓝色链接
              Link("默认蓝色链接", destination: URL(string: "https://www.apple.com")!)

              // 自定义颜色链接
              Link("红色链接", destination: URL(string: "https://www.apple.com")!)
                .foregroundColor(.red)

              Link("绿色链接", destination: URL(string: "https://www.apple.com")!)
                .foregroundColor(.green)

              Link("紫色链接", destination: URL(string: "https://www.apple.com")!)
                .foregroundColor(.purple)
            }
            .padding()
          }

          // MARK: - 链接状态演示
          GroupBox("链接状态") {
            VStack(alignment: .leading, spacing: 15) {
              Text("链接的基本特性：")
                .font(.headline)

              VStack(alignment: .leading, spacing: 8) {
                Text("• 点击时会在默认浏览器中打开")
                Text("• 支持长按预览（iOS）")
                Text("• 自动应用系统链接样式")
                Text("• 支持可访问性功能")
              }
              .font(.caption)
              .foregroundColor(.secondary)

              Divider()

              // 测试链接
              Link("测试链接 - Apple", destination: URL(string: "https://www.apple.com")!)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            }
            .padding()
          }

          // MARK: - 安全提示
          GroupBox("安全提示") {
            VStack(alignment: .leading, spacing: 10) {
              HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                  .foregroundColor(.orange)
                Text("链接安全注意事项")
                  .font(.headline)
              }

              VStack(alignment: .leading, spacing: 5) {
                Text("• 确保 URL 的有效性和安全性")
                Text("• 避免链接到恶意网站")
                Text("• 考虑用户体验和网络连接")
                Text("• 提供清晰的链接描述")
              }
              .font(.caption)
              .foregroundColor(.secondary)
            }
            .padding()
          }
        }
        .padding()
      }
      .navigationTitle("Link 基础用法")
      #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
      #endif
    }
  }
}

// MARK: - 预览
#Preview {
  LinkExampleView01()
}
