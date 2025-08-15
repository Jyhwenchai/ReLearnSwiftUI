import SwiftUI

/// LinkExampleView02 - 样式和修饰符
///
/// 本示例演示了 Link 组件的样式定制：
/// - 应用各种修饰符
/// - 创建自定义链接样式
/// - 组合不同的视觉效果
public struct LinkExampleView02: View {
  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          // MARK: - 基础修饰符
          GroupBox("基础修饰符") {
            VStack(alignment: .leading, spacing: 15) {
              // 字体修饰符
              Link("大字体链接", destination: URL(string: "https://www.apple.com")!)
                .font(.title)

              Link("粗体链接", destination: URL(string: "https://www.apple.com")!)
                .font(.body.bold())

              Link("斜体链接", destination: URL(string: "https://www.apple.com")!)
                .font(.body.italic())

              // 颜色修饰符
              Link("渐变色链接", destination: URL(string: "https://www.apple.com")!)
                .foregroundColor(.blue)
            }
            .padding()
          }

          // MARK: - 背景和边框
          GroupBox("背景和边框") {
            VStack(alignment: .leading, spacing: 15) {
              // 背景色链接
              Link("背景色链接", destination: URL(string: "https://www.apple.com")!)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)

              // 边框链接
              Link("边框链接", destination: URL(string: "https://www.apple.com")!)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
                )

              // 胶囊形状链接
              Link("胶囊形状链接", destination: URL(string: "https://www.apple.com")!)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())

              // 圆角矩形链接
              Link("圆角矩形链接", destination: URL(string: "https://www.apple.com")!)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.green.opacity(0.2))
                .cornerRadius(12)
                .overlay(
                  RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.green, lineWidth: 1)
                )
            }
            .padding()
          }

          // MARK: - 阴影效果
          GroupBox("阴影效果") {
            VStack(alignment: .leading, spacing: 15) {
              // 基础阴影
              Link("基础阴影链接", destination: URL(string: "https://www.apple.com")!)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)

              // 彩色阴影
              Link("彩色阴影链接", destination: URL(string: "https://www.apple.com")!)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.purple.opacity(0.1))
                .cornerRadius(8)
                .shadow(color: .purple.opacity(0.3), radius: 8, x: 0, y: 4)

              // 多层阴影
              Link("多层阴影链接", destination: URL(string: "https://www.apple.com")!)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
                .shadow(color: .orange.opacity(0.2), radius: 2, x: 0, y: 2)
                .shadow(color: .orange.opacity(0.1), radius: 8, x: 0, y: 8)
            }
            .padding()
          }

          // MARK: - 图标组合
          GroupBox("图标组合") {
            VStack(alignment: .leading, spacing: 15) {
              // 前置图标
              Link(destination: URL(string: "https://www.apple.com")!) {
                HStack {
                  Image(systemName: "globe")
                  Text("网站链接")
                }
              }

              // 后置图标
              Link(destination: URL(string: "https://developer.apple.com")!) {
                HStack {
                  Text("开发者文档")
                  Image(systemName: "arrow.up.right.square")
                }
              }

              // 图标在上方
              Link(destination: URL(string: "https://www.apple.com")!) {
                VStack {
                  Image(systemName: "house.fill")
                    .font(.title2)
                  Text("主页")
                    .font(.caption)
                }
              }
              .padding()
              .background(Color.blue.opacity(0.1))
              .cornerRadius(12)

              // 复杂图标组合
              Link(destination: URL(string: "mailto:support@example.com")!) {
                HStack {
                  Image(systemName: "envelope.fill")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue)
                    .clipShape(Circle())

                  VStack(alignment: .leading) {
                    Text("联系我们")
                      .font(.headline)
                    Text("发送邮件")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }

                  Spacer()

                  Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                }
              }
              .padding()
              .background(Color.gray.opacity(0.1))
              .cornerRadius(12)
            }
            .padding()
          }

          // MARK: - 响应式设计
          GroupBox("响应式设计") {
            VStack(alignment: .leading, spacing: 15) {
              Text("不同屏幕尺寸的适配：")
                .font(.headline)

              // 自适应宽度
              Link("自适应宽度链接", destination: URL(string: "https://www.apple.com")!)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)

              // 固定宽度
              HStack {
                Link("固定宽度", destination: URL(string: "https://www.apple.com")!)
                  .frame(width: 120)
                  .padding(.vertical, 8)
                  .background(Color.green.opacity(0.1))
                  .cornerRadius(8)

                Spacer()

                Link("另一个固定宽度", destination: URL(string: "https://www.apple.com")!)
                  .frame(width: 150)
                  .padding(.vertical, 8)
                  .background(Color.orange.opacity(0.1))
                  .cornerRadius(8)
              }
            }
            .padding()
          }

          // MARK: - 样式组合示例
          GroupBox("样式组合示例") {
            VStack(spacing: 15) {
              // 卡片式链接
              Link(destination: URL(string: "https://www.apple.com")!) {
                VStack(alignment: .leading, spacing: 8) {
                  HStack {
                    Image(systemName: "star.fill")
                      .foregroundColor(.yellow)
                    Text("精选内容")
                      .font(.headline)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }

                  Text("查看我们精心挑选的优质内容")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
              }
              .foregroundColor(.primary)

              // 按钮式链接
              Link("立即开始", destination: URL(string: "https://www.apple.com")!)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                  LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                  )
                )
                .cornerRadius(12)
                .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .padding()
          }
        }
        .padding()
      }
      .navigationTitle("Link 样式定制")
      #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
      #endif
    }
  }
}

// MARK: - 预览
#Preview {
  LinkExampleView02()
}
