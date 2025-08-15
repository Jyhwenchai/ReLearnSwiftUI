import SwiftUI

/// TextEditor 基础示例
///
/// 本示例演示了 TextEditor 的基础用法，包括：
/// - 基本的多行文本编辑
/// - 占位符文本的实现
/// - 基础样式设置
/// - 文本绑定和状态管理
public struct TextEditorExampleView01: View {
  // MARK: - 状态属性

  /// 基础文本内容
  @State private var basicText = ""

  /// 带初始内容的文本
  @State private var textWithContent = """
    这是一个多行文本编辑器的示例。
    你可以在这里输入多行文本，
    支持换行和长文本编辑。
    """

  /// 限制字符数的文本
  @State private var limitedText = ""

  /// 只读文本
  @State private var readOnlyText = """
    这是一个只读的 TextEditor 示例。
    虽然看起来可以编辑，但实际上是禁用状态。
    用于展示文本内容而不允许修改。
    """

  // MARK: - 视图主体

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("TextEditor 基础示例")
          .font(.largeTitle.bold())
          .padding(.horizontal)

        VStack(alignment: .leading, spacing: 16) {
          // MARK: - 基础 TextEditor
          VStack(alignment: .leading, spacing: 8) {
            Text("1. 基础多行文本编辑")
              .font(.headline)
              .foregroundColor(.primary)

            Text("最简单的 TextEditor，支持多行文本输入")
              .font(.caption)
              .foregroundColor(.secondary)

            // 基础的 TextEditor
            TextEditor(text: $basicText)
              .frame(height: 100)
              .padding(8)
              .background(Color(.systemGray6))
              .cornerRadius(8)
              .overlay(
                // 自定义占位符实现
                Group {
                  if basicText.isEmpty {
                    Text("请输入多行文本...")
                      .foregroundColor(.secondary)
                      .padding(.horizontal, 12)
                      .padding(.vertical, 16)
                      .allowsHitTesting(false)  // 允许点击穿透到 TextEditor
                  }
                },
                alignment: .topLeading
              )

            // 显示当前字符数
            HStack {
              Spacer()
              Text("字符数: \(basicText.count)")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }

          Divider()

          // MARK: - 带初始内容的 TextEditor
          VStack(alignment: .leading, spacing: 8) {
            Text("2. 带初始内容的文本编辑")
              .font(.headline)
              .foregroundColor(.primary)

            Text("TextEditor 可以预设初始内容，用户可以在此基础上编辑")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: $textWithContent)
              .frame(height: 120)
              .padding(8)
              .background(Color(.systemGray6))
              .cornerRadius(8)

            // 重置按钮
            HStack {
              Button("重置内容") {
                textWithContent = """
                  这是一个多行文本编辑器的示例。
                  你可以在这里输入多行文本，
                  支持换行和长文本编辑。
                  """
              }
              .buttonStyle(.bordered)

              Spacer()

              Text("行数: \(textWithContent.components(separatedBy: .newlines).count)")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }

          Divider()

          // MARK: - 字符限制的 TextEditor
          VStack(alignment: .leading, spacing: 8) {
            Text("3. 字符数限制的文本编辑")
              .font(.headline)
              .foregroundColor(.primary)

            Text("通过绑定控制，可以限制输入的字符数量")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(
              text: Binding(
                get: { limitedText },
                set: { newValue in
                  // 限制最多 100 个字符
                  if newValue.count <= 100 {
                    limitedText = newValue
                  }
                }
              )
            )
            .frame(height: 80)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
              Group {
                if limitedText.isEmpty {
                  Text("最多可输入 100 个字符...")
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
                    .allowsHitTesting(false)
                }
              },
              alignment: .topLeading
            )

            // 字符数进度条
            HStack {
              ProgressView(value: Double(limitedText.count), total: 100)
                .progressViewStyle(LinearProgressViewStyle())

              Text("\(limitedText.count)/100")
                .font(.caption)
                .foregroundColor(limitedText.count > 80 ? .orange : .secondary)
                .monospacedDigit()  // 使用等宽数字字体
            }
          }

          Divider()

          // MARK: - 只读 TextEditor
          VStack(alignment: .leading, spacing: 8) {
            Text("4. 只读文本显示")
              .font(.headline)
              .foregroundColor(.primary)

            Text("禁用编辑功能，仅用于文本展示")
              .font(.caption)
              .foregroundColor(.secondary)

            TextEditor(text: .constant(readOnlyText))
              .frame(height: 100)
              .padding(8)
              .background(Color(.systemGray5))
              .cornerRadius(8)
              .disabled(true)  // 禁用编辑
              .opacity(0.8)  // 视觉上表示禁用状态
          }

          // MARK: - 使用说明
          VStack(alignment: .leading, spacing: 8) {
            Text("💡 使用要点")
              .font(.headline)
              .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 4) {
              Text("• TextEditor 没有内置占位符，需要自定义实现")
              Text("• 使用 @State 或 @Binding 管理文本状态")
              Text("• 可以通过 Binding 的 set 方法实现输入限制")
              Text("• disabled() 修饰符可以禁用编辑功能")
              Text("• 适合多行文本输入，如评论、描述等场景")
            }
            .font(.caption)
            .foregroundColor(.secondary)
          }
          .padding()
          .background(Color.blue.opacity(0.1))
          .cornerRadius(8)
        }
        .padding(.horizontal)
      }
    }
    .navigationTitle("基础示例")
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    TextEditorExampleView01()
  }
}
