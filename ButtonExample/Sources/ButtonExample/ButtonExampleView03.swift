import ShareComponent
import SwiftUI

#if canImport(UIKit)
  import UIKit
#endif

// MARK: - ButtonExampleView03: 角色和交互行为
// 学习目标: 理解 Button 的语义角色和高级交互行为
// 涵盖内容: 按钮角色、重复行为、状态管理、可访问性、上下文菜单

public struct ButtonExampleView03: View {
  // MARK: - 状态属性
  @State private var isEnabled = true
  @State private var isLoading = false
  @State private var showingAlert = false
  @State private var showingSheet = false
  @State private var pressCount = 0
  @State private var longPressCount = 0
  @State private var contextMenuMessage = "等待上下文菜单操作..."

  // 模拟数据状态
  @State private var hasUnsavedChanges = true
  @State private var itemsToDelete = ["项目 1", "项目 2", "项目 3"]
  @State private var selectedItems: Set<String> = []

  public init() {}

  public var body: some View {
    ExampleContainerView("角色和交互行为") {

      // MARK: - 按钮角色演示
      ExampleSection("按钮角色 (Button Roles)") {
        VStack(spacing: 16) {
          // 默认角色（无特殊语义）
          Button("默认角色按钮") {
            showingAlert = true
          }
          .buttonStyle(.bordered)
          .modifier(
            RoleDescriptionModifier(
              role: "无角色",
              description: "标准按钮，无特殊语义"
            ))

          // 破坏性角色 - 用于删除、清除等危险操作
          Button("删除所有数据", role: .destructive) {
            showingAlert = true
          }
          .buttonStyle(.bordered)
          .modifier(
            RoleDescriptionModifier(
              role: "destructive",
              description: "破坏性操作，通常显示为红色"
            ))

          // 取消角色 - 用于取消操作
          Button("取消操作", role: .cancel) {
            showingAlert = true
          }
          .buttonStyle(.bordered)
          .modifier(
            RoleDescriptionModifier(
              role: "cancel",
              description: "取消操作，通常用于对话框"
            ))

          // 在 Alert 中的角色演示
          VStack {
            Text("在 Alert 中，角色会影响按钮的外观和位置")
              .font(.caption)
              .foregroundColor(.secondary)
              .multilineTextAlignment(.center)

            Button("显示角色演示 Alert") {
              showingAlert = true
            }
            .buttonStyle(.borderedProminent)
          }
        }
      }

      // MARK: - 按钮状态管理
      ExampleSection("按钮状态管理") {
        VStack(spacing: 16) {
          // 启用/禁用状态
          VStack(spacing: 8) {
            Toggle("启用按钮", isOn: $isEnabled)

            Button("状态控制按钮") {
              // 按钮动作
            }
            .buttonStyle(.bordered)
            .disabled(!isEnabled)
            .opacity(isEnabled ? 1.0 : 0.6)

            Text(isEnabled ? "按钮已启用" : "按钮已禁用")
              .font(.caption)
              .foregroundColor(isEnabled ? .green : .red)
          }

          // 加载状态按钮
          VStack(spacing: 8) {
            Button(action: {
              simulateAsyncOperation()
            }) {
              HStack {
                if isLoading {
                  ProgressView()
                    .scaleEffect(0.8)
                    .padding(.trailing, 4)
                }
                Text(isLoading ? "处理中..." : "开始异步操作")
              }
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)

            if isLoading {
              Text("请等待操作完成...")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }
        }
      }

      // MARK: - 重复行为演示
      ExampleSection("按钮重复行为") {
        VStack(spacing: 16) {
          // 启用重复行为的按钮
          VStack {
            Text("长按计数: \(pressCount)")
              .font(.headline)

            Button("长按重复按钮") {
              pressCount += 1
            }
            .buttonStyle(.bordered)
            .buttonRepeatBehavior(.enabled)  // 启用重复行为

            Text("💡 长按此按钮会持续触发动作")
              .font(.caption)
              .foregroundColor(.secondary)
              .multilineTextAlignment(.center)
          }

          // 重置按钮
          Button("重置计数", systemImage: "arrow.clockwise") {
            pressCount = 0
          }
          .buttonStyle(.bordered)
          .buttonRepeatBehavior(.disabled)  // 禁用重复行为（默认）
        }
      }

      // MARK: - 手势和触觉反馈
      ExampleSection("手势和触觉反馈") {
        VStack(spacing: 16) {
          // 长按手势按钮
          VStack {
            Text("长按次数: \(longPressCount)")
              .font(.headline)

            Button("长按手势按钮") {
              // 普通点击
            }
            .buttonStyle(.bordered)
            .onLongPressGesture {
              // 长按动作
              longPressCount += 1
              // 触觉反馈
              #if canImport(UIKit)
                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                impactFeedback.impactOccurred()
              #endif
            }

            Text("💡 长按会触发特殊动作和触觉反馈")
              .font(.caption)
              .foregroundColor(.secondary)
              .multilineTextAlignment(.center)
          }

          // 触觉反馈演示
          HStack(spacing: 12) {
            Button("轻触反馈") {
              #if canImport(UIKit)
                let feedback = UIImpactFeedbackGenerator(style: .light)
                feedback.impactOccurred()
              #endif
            }
            .buttonStyle(.bordered)

            Button("中等反馈") {
              #if canImport(UIKit)
                let feedback = UIImpactFeedbackGenerator(style: .medium)
                feedback.impactOccurred()
              #endif
            }
            .buttonStyle(.bordered)

            Button("重触反馈") {
              #if canImport(UIKit)
                let feedback = UIImpactFeedbackGenerator(style: .heavy)
                feedback.impactOccurred()
              #endif
            }
            .buttonStyle(.bordered)
          }
        }
      }

      // MARK: - 上下文菜单集成
      ExampleSection("上下文菜单集成") {
        VStack(spacing: 16) {
          // 带上下文菜单的按钮
          Button("长按显示菜单") {
            contextMenuMessage = "点击了主按钮"
          }
          .buttonStyle(.bordered)
          .contextMenu {
            Button("复制", systemImage: "doc.on.doc") {
              contextMenuMessage = "执行了复制操作"
            }

            Button("分享", systemImage: "square.and.arrow.up") {
              contextMenuMessage = "执行了分享操作"
            }

            Divider()

            Button("删除", systemImage: "trash", role: .destructive) {
              contextMenuMessage = "执行了删除操作"
            }
          }

          // 反馈显示
          Text(contextMenuMessage)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .font(.caption)
        }
      }

      // MARK: - 可访问性演示
      ExampleSection("可访问性支持") {
        VStack(spacing: 16) {
          // 可访问性标签和提示
          Button("可访问性按钮") {
            // 按钮动作
          }
          .buttonStyle(.bordered)
          .accessibilityLabel("执行重要操作")
          .accessibilityHint("双击执行操作，长按查看更多选项")
          .accessibilityAddTraits(.isButton)

          // 可访问性值
          Button("计数按钮: \(pressCount)") {
            pressCount += 1
          }
          .buttonStyle(.bordered)
          .accessibilityLabel("计数按钮")
          .accessibilityValue("当前计数 \(pressCount)")
          .accessibilityHint("双击增加计数")

          // 动态字体支持
          Button("支持动态字体的按钮") {
            // 按钮动作
          }
          .buttonStyle(.bordered)
          .font(.body)  // 使用系统字体，自动支持动态字体

          Text("💡 这些按钮针对 VoiceOver 和动态字体进行了优化")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
      }

      // MARK: - 复杂交互场景
      ExampleSection("复杂交互场景") {
        VStack(spacing: 16) {
          // 条件按钮组
          VStack(alignment: .leading, spacing: 8) {
            Text("文档状态: \(hasUnsavedChanges ? "有未保存更改" : "已保存")")
              .font(.headline)

            HStack {
              Button("保存", systemImage: "square.and.arrow.down") {
                hasUnsavedChanges = false
              }
              .buttonStyle(.borderedProminent)
              .disabled(!hasUnsavedChanges)

              Button("撤销更改", role: .destructive) {
                hasUnsavedChanges = true
              }
              .buttonStyle(.bordered)
              .disabled(!hasUnsavedChanges)
            }
          }

          // 批量操作按钮
          VStack(alignment: .leading, spacing: 8) {
            Text("选择项目进行批量操作:")
              .font(.headline)

            ForEach(itemsToDelete, id: \.self) { item in
              HStack {
                Button(action: {
                  if selectedItems.contains(item) {
                    selectedItems.remove(item)
                  } else {
                    selectedItems.insert(item)
                  }
                }) {
                  HStack {
                    Image(
                      systemName: selectedItems.contains(item) ? "checkmark.square.fill" : "square")
                    Text(item)
                  }
                }
                .buttonStyle(.plain)

                Spacer()
              }
            }

            Button("删除选中项目 (\(selectedItems.count))", role: .destructive) {
              itemsToDelete.removeAll { selectedItems.contains($0) }
              selectedItems.removeAll()
            }
            .buttonStyle(.bordered)
            .disabled(selectedItems.isEmpty)
          }
        }
      }

    } footer: {
      VStack(alignment: .leading, spacing: 8) {
        Text("🎯 交互设计要点:")
          .font(.headline)

        VStack(alignment: .leading, spacing: 4) {
          Text("• 使用 role 参数为按钮添加语义，提升用户体验")
          Text("• 合理管理按钮状态，避免用户在不合适的时机操作")
          Text("• buttonRepeatBehavior 适用于数值调整等场景")
          Text("• 添加触觉反馈增强交互体验")
          Text("• 重视可访问性，确保所有用户都能正常使用")
          Text("• 上下文菜单提供更多操作选项，但不应替代主要功能")
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }
    }
    .alert("按钮角色演示", isPresented: $showingAlert) {
      Button("确认") {}
      Button("取消", role: .cancel) {}
      Button("删除", role: .destructive) {}
    } message: {
      Text("注意观察不同角色按钮在 Alert 中的外观和排列顺序")
    }
  }

  // MARK: - 辅助方法

  /// 模拟异步操作
  private func simulateAsyncOperation() {
    isLoading = true

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      isLoading = false
    }
  }
}

// MARK: - 角色描述修饰符
struct RoleDescriptionModifier: ViewModifier {
  let role: String
  let description: String

  func body(content: Content) -> some View {
    VStack {
      content
      VStack {
        Text("role: .\(role)")
          .font(.caption)
          .fontWeight(.semibold)
        Text(description)
          .font(.caption2)
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)
      }
    }
  }
}

#Preview {
  NavigationStack {
    ButtonExampleView03()
  }
}
