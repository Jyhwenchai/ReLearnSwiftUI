import SwiftUI

/// TextEditor 样式和修饰符示例
///
/// 本示例演示了 TextEditor 的各种样式设置，包括：
/// - 字体和颜色自定义
/// - 背景和边框样式
/// - 内边距和圆角设置
/// - 滚动和选择行为
public struct TextEditorExampleView02: View {
  // MARK: - 状态属性

  /// 基础样式文本
  @State private var styledText = "这是一个带样式的 TextEditor 示例。\n你可以看到不同的字体、颜色和背景效果。"

  /// 自定义背景文本
  @State private var backgroundText = "这个 TextEditor 有自定义的背景和边框样式。"

  /// 大字体文本
  @State private var largeText = "这是大字体的文本编辑器。"

  /// 代码样式文本
  @State private var codeText = """
    func example() {
        print("Hello, SwiftUI!")
        let text = "代码样式的文本编辑器"
        return text
    }
    """

  /// 主题色文本
  @State private var themedText = "这是使用主题色的文本编辑器示例。"

  // MARK: - 视图主体

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("TextEditor 样式示例")
          .font(.largeTitle.bold())
          .padding(.horizontal)

        VStack(alignment: .leading, spacing: 16) {
          // MARK: - 字体和颜色样式
          VStack(alignment: .leading, spacing: 8) {
            Text("1. 字体和颜色自定义")
              .font(.headline)
              .foregroundColor(.primary)

            Text("自定义字体大小、颜色和字重")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $styledText)
              .font(.title3)  // 设置字体大小
              .foregroundColor(.blue)  // 设置文字颜色
              .frame(height: 100)
              .padding(12)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(12)
          }

          Divider()

          // MARK: - 背景和边框样式
          VStack(alignment: .leading, spacing: 8) {
            Text("2. 背景和边框样式")
              .font(.headline)
              .foregroundColor(.primary)

            Text("渐变背景和自定义边框效果")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $backgroundText)
              .font(.body)
              .frame(height: 80)
              .padding(16)
              .background(
                // 渐变背景
                LinearGradient(
                  colors: [Color.purple.opacity(0.1), Color.pink.opacity(0.1)],
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                )
              )
              .overlay(
                // 自定义边框
                RoundedRectangle(cornerRadius: 16)
                  .stroke(
                    LinearGradient(
                      colors: [.purple, .pink],
                      startPoint: .topLeading,
                      endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                  )
              )
              .cornerRadius(16)
          }

          Divider()

          // MARK: - 大字体样式
          VStack(alignment: .leading, spacing: 8) {
            Text("3. 大字体显示")
              .font(.headline)
              .foregroundColor(.primary)

            Text("适合标题或重要内容编辑的大字体样式")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $largeText)
              .font(.largeTitle.bold())  // 大字体和粗体
              .multilineTextAlignment(.center)  // 居中对齐
              .frame(height: 120)
              .padding(20)
              .background(Color.orange.opacity(0.1))
              .cornerRadius(20)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.orange, lineWidth: 1)
              )
          }

          Divider()

          // MARK: - 代码样式
          VStack(alignment: .leading, spacing: 8) {
            Text("4. 代码编辑样式")
              .font(.headline)
              .foregroundColor(.primary)

            Text("等宽字体，适合代码编辑")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $codeText)
              .font(.system(.body, design: .monospaced))  // 等宽字体
              .frame(height: 140)
              .padding(16)
              .background(Color.black.opacity(0.05))
              .cornerRadius(8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color.gray.opacity(0.3), lineWidth: 1)
              )

            // 代码行数显示
            HStack {
              Text("行数: \(codeText.components(separatedBy: .newlines).count)")
                .font(.caption)
                .foregroundColor(.secondary)

              Spacer()

              Button("格式化代码") {
                // 简单的代码格式化示例
                codeText =
                  codeText
                  .replacingOccurrences(of: "    ", with: "\t")
                  .replacingOccurrences(of: "  ", with: " ")
              }
              .font(.caption)
              .buttonStyle(.bordered)
            }
          }

          Divider()

          // MARK: - 主题色样式
          VStack(alignment: .leading, spacing: 8) {
            Text("5. 主题色样式")
              .font(.headline)
              .foregroundColor(.primary)

            Text("使用系统主题色的现代化样式")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $themedText)
              .font(.body)
              .frame(height: 80)
              .padding(16)
              .background(Color.accentColor.opacity(0.1))
              .cornerRadius(12)
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
              )
              .tint(.accentColor)  // 设置光标和选择颜色
          }

          // MARK: - 样式对比
          VStack(alignment: .leading, spacing: 8) {
            Text("6. 样式对比")
              .font(.headline)
              .foregroundColor(.primary)

            Text("不同样式的并排对比")
              .font(.caption)
              .foregroundColor(.secondary)

            HStack(spacing: 12) {
              // 简约样式
              VStack {
                Text("简约")
                  .font(.caption)
                  .foregroundColor(.secondary)

                TextEditor(text: .constant("简约样式"))
                  .font(.body)
                  .frame(height: 60)
                  .padding(8)
                  .background(Color(.systemGray6))
                  .cornerRadius(8)
              }

              // 现代样式
              VStack {
                Text("现代")
                  .font(.caption)
                  .foregroundColor(.secondary)

                TextEditor(text: .constant("现代样式"))
                  .font(.body)
                  .frame(height: 60)
                  .padding(12)
                  .background(
                    RoundedRectangle(cornerRadius: 12)
                      .fill(Color.blue.opacity(0.1))
                      .shadow(color: .blue.opacity(0.2), radius: 4, x: 0, y: 2)
                  )
              }

              // 经典样式
              VStack {
                Text("经典")
                  .font(.caption)
                  .foregroundColor(.secondary)

                TextEditor(text: .constant("经典样式"))
                  .font(.body)
                  .frame(height: 60)
                  .padding(10)
                  .background(Color.white)
                  .overlay(
                    RoundedRectangle(cornerRadius: 4)
                      .stroke(Color.gray, lineWidth: 1)
                  )
              }
            }
          }

          // MARK: - 样式技巧
          VStack(alignment: .leading, spacing: 8) {
            Text("🎨 样式技巧")
              .font(.headline)
              .foregroundColor(.green)

            VStack(alignment: .leading, spacing: 4) {
              Text("• 使用 font() 修饰符设置字体样式")
              Text("• foregroundColor() 设置文字颜色")
              Text("• background() 添加背景效果")
              Text("• overlay() 添加边框和装饰")
              Text("• tint() 设置光标和选择颜色")
              Text("• cornerRadius() 设置圆角")
              Text("• padding() 调整内边距")
              Text("• shadow() 添加阴影效果")
            }
            .font(.caption)
            .foregroundColor(.secondary)
          }
          .padding()
          .background(Color.green.opacity(0.1))
          .cornerRadius(8)
        }
        .padding(.horizontal)
      }
    }
    .navigationTitle("样式示例")
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    TextEditorExampleView02()
  }
}
