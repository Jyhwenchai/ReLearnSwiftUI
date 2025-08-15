import SwiftUI

/// PasteButton 样式和修饰符示例
///
/// 这个示例展示了如何自定义 PasteButton 的外观，包括：
/// - 按钮边框样式
/// - 颜色主题设置
/// - 标签样式自定义
/// - 尺寸和布局调整
/// - 动画效果
public struct PasteButtonExampleView03: View {
  // MARK: - 状态属性

  /// 粘贴的内容
  @State private var pastedContent: String = ""

  /// 粘贴次数计数器
  @State private var pasteCount: Int = 0

  /// 动画状态
  @State private var isAnimating: Bool = false

  /// 选择的颜色主题
  @State private var selectedColor: Color = .blue

  /// 选择的边框样式
  @State private var selectedBorderShape: RoundedRectangle = RoundedRectangle(cornerRadius: 8)

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(spacing: 25) {
        // MARK: - 标题和说明
        VStack(spacing: 10) {
          Text("样式和修饰符")
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("演示 PasteButton 的各种样式自定义选项")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.top)

        Divider()

        // MARK: - 基础样式示例
        VStack(alignment: .leading, spacing: 15) {
          Text("1. 基础样式")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(spacing: 15) {
            // 默认样式
            HStack {
              Text("默认样式:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }

              Spacer()
            }

            // 带颜色主题
            HStack {
              Text("颜色主题:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .tint(.green)  // 设置主题颜色

              Spacer()
            }

            // 自定义颜色
            HStack {
              Text("自定义色:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .tint(.purple)

              Spacer()
            }
          }
          .padding()
          .background(Color.blue.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 边框样式示例
        VStack(alignment: .leading, spacing: 15) {
          Text("2. 边框样式")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(spacing: 15) {
            // 圆角矩形边框
            HStack {
              Text("圆角矩形:")
                .frame(width: 80, alignment: .leading)

              if #available(iOS 16.0, macOS 14.0, *) {
                PasteButton(payloadType: String.self) { strings in
                  handlePaste(strings.joined(separator: " "))
                }
                .buttonBorderShape(.roundedRectangle(radius: 12))
                .tint(.orange)
              } else {
                PasteButton(payloadType: String.self) { strings in
                  handlePaste(strings.joined(separator: " "))
                }
                .tint(.orange)
              }

              Spacer()
            }

            // 胶囊形边框
            HStack {
              Text("胶囊形:")
                .frame(width: 80, alignment: .leading)

              if #available(iOS 16.0, macOS 14.0, *) {
                PasteButton(payloadType: String.self) { strings in
                  handlePaste(strings.joined(separator: " "))
                }
                .buttonBorderShape(.capsule)
                .tint(.red)
              } else {
                PasteButton(payloadType: String.self) { strings in
                  handlePaste(strings.joined(separator: " "))
                }
                .tint(.red)
              }

              Spacer()
            }

            // 圆形边框 (iOS 17.0+)
            HStack {
              Text("圆形:")
                .frame(width: 80, alignment: .leading)

              if #available(iOS 17.0, macOS 14.0, *) {
                PasteButton(payloadType: String.self) { strings in
                  handlePaste(strings.joined(separator: " "))
                }
                .buttonBorderShape(.circle)
                .tint(.mint)
              } else {
                PasteButton(payloadType: String.self) { strings in
                  handlePaste(strings.joined(separator: " "))
                }
                .tint(.mint)
              }

              Spacer()
            }
          }
          .padding()
          .background(Color.green.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 标签样式示例
        VStack(alignment: .leading, spacing: 15) {
          Text("3. 标签样式")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(spacing: 15) {
            // 仅图标样式
            HStack {
              Text("仅图标:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .labelStyle(.iconOnly)  // 只显示图标
              .tint(.blue)

              Spacer()
            }

            // 仅标题样式
            HStack {
              Text("仅标题:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .labelStyle(.titleOnly)  // 只显示文字
              .tint(.indigo)

              Spacer()
            }

            // 标题和图标样式
            HStack {
              Text("标题+图标:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .labelStyle(.titleAndIcon)  // 显示文字和图标
              .tint(.cyan)

              Spacer()
            }
          }
          .padding()
          .background(Color.purple.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 尺寸和布局示例
        VStack(alignment: .leading, spacing: 15) {
          Text("4. 尺寸和布局")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(spacing: 15) {
            // 小尺寸
            HStack {
              Text("小尺寸:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .controlSize(.small)  // 小尺寸控件
              .tint(.pink)

              Spacer()
            }

            // 常规尺寸
            HStack {
              Text("常规尺寸:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .controlSize(.regular)  // 常规尺寸控件
              .tint(.brown)

              Spacer()
            }

            // 大尺寸
            HStack {
              Text("大尺寸:")
                .frame(width: 80, alignment: .leading)

              PasteButton(payloadType: String.self) { strings in
                handlePaste(strings.joined(separator: " "))
              }
              .controlSize(.large)  // 大尺寸控件
              .tint(.teal)

              Spacer()
            }
          }
          .padding()
          .background(Color.orange.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 动画效果示例
        VStack(alignment: .leading, spacing: 15) {
          Text("5. 动画效果")
            .font(.headline)
            .foregroundColor(.primary)

          HStack(spacing: 15) {
            PasteButton(payloadType: String.self) { strings in
              handlePaste(strings.joined(separator: " "))
              // 触发动画效果
              withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                isAnimating = true
              }

              // 重置动画状态
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                  isAnimating = false
                }
              }
            }
            .scaleEffect(isAnimating ? 1.2 : 1.0)  // 缩放动画
            .tint(.red)
            .apply { view in
              if #available(iOS 16.0, macOS 14.0, *) {
                view.buttonBorderShape(.capsule)
              } else {
                view
              }
            }

            Text("点击后有缩放动画效果")
              .font(.caption)
              .foregroundColor(.secondary)

            Spacer()
          }
          .padding()
          .background(Color.red.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 粘贴内容显示
        if !pastedContent.isEmpty {
          VStack(alignment: .leading, spacing: 10) {
            Text("粘贴的内容")
              .font(.headline)
              .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 8) {
              Text("内容: \(pastedContent)")
              Text("粘贴次数: \(pasteCount)")
            }
            .font(.body)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
          }
        }

        // MARK: - 使用说明
        VStack(alignment: .leading, spacing: 10) {
          Text("💡 样式自定义说明")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("• tint(_:): 设置按钮的主题颜色")
            Text("• buttonBorderShape(_:): 设置按钮边框形状")
            Text("• labelStyle(_:): 控制标签的显示方式")
            Text("• controlSize(_:): 调整控件的尺寸")
            Text("• 可以结合动画修饰符创建交互效果")
            Text("• 系统会自动适配当前环境的外观")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.yellow.opacity(0.05))
        .cornerRadius(12)

        Spacer()
      }
      .padding()
    }
    .navigationTitle("样式和修饰符")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 辅助方法

  /// 处理粘贴操作
  private func handlePaste(_ content: String) {
    pastedContent = content
    pasteCount += 1
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    PasteButtonExampleView03()
  }
}
