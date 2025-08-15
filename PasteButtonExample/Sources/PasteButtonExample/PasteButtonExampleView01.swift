import SwiftUI

/// PasteButton 基础示例
///
/// 这个示例展示了 PasteButton 的基本用法，包括：
/// - 基础的文本粘贴功能
/// - 简单的数据处理
/// - 系统默认外观
/// - 基本的状态管理
public struct PasteButtonExampleView01: View {
  // MARK: - 状态属性

  /// 存储粘贴的文本内容
  @State private var pastedText: String = "暂无内容"

  /// 存储粘贴的数字内容
  @State private var pastedNumber: String = "0"

  /// 粘贴操作的计数器
  @State private var pasteCount: Int = 0

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        // MARK: - 标题和说明
        VStack(spacing: 10) {
          Text("PasteButton 基础示例")
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("演示 PasteButton 的基本粘贴功能")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.top)

        Divider()

        // MARK: - 基础文本粘贴
        VStack(alignment: .leading, spacing: 15) {
          Text("1. 基础文本粘贴")
            .font(.headline)
            .foregroundColor(.primary)

          Text("从剪贴板粘贴文本内容到应用中")
            .font(.caption)
            .foregroundColor(.secondary)

          HStack(spacing: 15) {
            // 创建一个接受 String 类型的粘贴按钮
            // payloadType: 指定接受的数据类型
            // onPaste: 处理粘贴数据的闭包
            PasteButton(payloadType: String.self) { strings in
              // 当用户点击按钮且剪贴板包含文本时，这个闭包会被调用
              // strings 是一个数组，包含剪贴板中的所有字符串
              if let firstString = strings.first {
                pastedText = firstString
                pasteCount += 1
              }
            }

            Divider()
              .frame(height: 30)

            // 显示粘贴的内容
            VStack(alignment: .leading, spacing: 5) {
              Text("粘贴的内容:")
                .font(.caption)
                .foregroundColor(.secondary)

              Text(pastedText)
                .font(.body)
                .foregroundColor(.primary)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(6)
            }

            Spacer()
          }
          .padding()
          .background(Color.blue.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 数字粘贴示例
        VStack(alignment: .leading, spacing: 15) {
          Text("2. 数字内容粘贴")
            .font(.headline)
            .foregroundColor(.primary)

          Text("粘贴数字内容并进行简单处理")
            .font(.caption)
            .foregroundColor(.secondary)

          HStack(spacing: 15) {
            // 虽然指定 String 类型，但可以在闭包中处理数字
            PasteButton(payloadType: String.self) { strings in
              if let firstString = strings.first {
                // 尝试将字符串转换为数字
                if let number = Double(firstString.trimmingCharacters(in: .whitespacesAndNewlines))
                {
                  pastedNumber = String(format: "%.2f", number)
                } else {
                  pastedNumber = "非数字内容: \(firstString)"
                }
                pasteCount += 1
              }
            }

            Divider()
              .frame(height: 30)

            VStack(alignment: .leading, spacing: 5) {
              Text("处理后的数字:")
                .font(.caption)
                .foregroundColor(.secondary)

              Text(pastedNumber)
                .font(.body)
                .foregroundColor(.primary)
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(6)
            }

            Spacer()
          }
          .padding()
          .background(Color.green.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 统计信息
        VStack(alignment: .leading, spacing: 15) {
          Text("3. 粘贴统计")
            .font(.headline)
            .foregroundColor(.primary)

          HStack {
            Label("粘贴次数", systemImage: "doc.on.clipboard")
            Spacer()
            Text("\(pasteCount)")
              .font(.title2)
              .fontWeight(.semibold)
              .foregroundColor(.blue)
          }
          .padding()
          .background(Color.orange.opacity(0.05))
          .cornerRadius(12)
        }

        // MARK: - 使用说明
        VStack(alignment: .leading, spacing: 10) {
          Text("💡 使用提示")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("• 复制一些文本到剪贴板，然后点击粘贴按钮")
            Text("• PasteButton 会自动检测剪贴板内容的有效性")
            Text("• 只有当剪贴板包含指定类型的数据时，按钮才会启用")
            Text("• 在 iOS 上，按钮会根据剪贴板变化自动更新状态")
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
    .navigationTitle("基础粘贴按钮")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    PasteButtonExampleView01()
  }
}
