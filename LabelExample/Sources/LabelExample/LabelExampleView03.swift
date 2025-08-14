import SwiftUI

/// LabelExampleView03 - 样式和修饰符
///
/// 这个示例展示了 Label 的样式定制和各种修饰符的应用：
/// - 内置的 Label 样式
/// - 背景和边框效果
/// - 间距和填充控制
/// - 动画效果
/// - 交互状态
public struct LabelExampleView03: View {
  @State private var isSelected = false
  @State private var animationScale: CGFloat = 1.0
  @State private var rotationAngle: Double = 0

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("样式和修饰符")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom)

        // MARK: - 1. 内置 Label 样式
        GroupBox("1. 内置 Label 样式") {
          VStack(alignment: .leading, spacing: 12) {
            Text("SwiftUI 提供了几种内置的 Label 样式：")
              .font(.headline)

            // 默认样式（图标 + 文本）
            Label("默认样式", systemImage: "star")
              .labelStyle(.automatic)

            // 只显示图标
            Label("只显示图标", systemImage: "heart.fill")
              .labelStyle(.iconOnly)

            // 只显示文本
            Label("只显示文本", systemImage: "text.alignleft")
              .labelStyle(.titleOnly)

            // 标题和图标样式（默认）
            Label("标题和图标", systemImage: "doc.text")
              .labelStyle(.titleAndIcon)

            Text("💡 使用 .labelStyle() 修饰符可以控制 Label 的显示方式")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 2. 背景和边框样式
        GroupBox("2. 背景和边框样式") {
          VStack(alignment: .leading, spacing: 12) {
            // 纯色背景
            Label("纯色背景", systemImage: "paintbrush.fill")
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(8)

            // 渐变背景
            Label("渐变背景", systemImage: "rainbow")
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(
                LinearGradient(
                  colors: [.purple.opacity(0.3), .pink.opacity(0.3)],
                  startPoint: .leading,
                  endPoint: .trailing
                )
              )
              .cornerRadius(8)

            // 边框样式
            Label("边框样式", systemImage: "rectangle")
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color.blue, lineWidth: 2)
              )

            // 阴影效果
            Label("阴影效果", systemImage: "cloud")
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(Color.white)
              .cornerRadius(8)
              .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)

            // 胶囊形状
            Label("胶囊形状", systemImage: "capsule")
              .padding(.horizontal, 16)
              .padding(.vertical, 8)
              .background(Color.green.opacity(0.2))
              .clipShape(Capsule())

            Text("💡 通过组合背景、边框、阴影等修饰符可以创建丰富的视觉效果")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 3. 间距和填充控制
        GroupBox("3. 间距和填充控制") {
          VStack(alignment: .leading, spacing: 12) {
            Text("不同的填充设置：")
              .font(.headline)

            // 无填充
            Label("无填充", systemImage: "minus")
              .background(Color.gray.opacity(0.1))

            // 小填充
            Label("小填充", systemImage: "plus")
              .padding(4)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(4)

            // 中等填充
            Label("中等填充", systemImage: "equal")
              .padding(8)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)

            // 大填充
            Label("大填充", systemImage: "multiply")
              .padding(16)
              .background(Color.orange.opacity(0.1))
              .cornerRadius(8)

            // 不对称填充
            Label("不对称填充", systemImage: "arrow.up.and.down")
              .padding(.horizontal, 20)
              .padding(.vertical, 6)
              .background(Color.purple.opacity(0.1))
              .cornerRadius(8)

            Text("💡 合适的填充可以提升 Label 的视觉层次和点击体验")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 4. 交互状态样式
        GroupBox("4. 交互状态样式") {
          VStack(alignment: .leading, spacing: 12) {
            Text("可点击的 Label：")
              .font(.headline)

            // 选中状态切换
            Button(action: {
              withAnimation(.easeInOut(duration: 0.2)) {
                isSelected.toggle()
              }
            }) {
              Label(
                isSelected ? "已选中" : "未选中",
                systemImage: isSelected ? "checkmark.circle.fill" : "circle"
              )
              .foregroundColor(isSelected ? .white : .primary)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)
              .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
              .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())

            // 悬停效果（在 macOS 上有效）
            Label("悬停效果", systemImage: "hand.point.up")
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(Color.gray.opacity(0.1))
              .cornerRadius(8)
              .onHover { isHovering in
                withAnimation(.easeInOut(duration: 0.2)) {
                  // 在实际应用中可以改变背景色或其他属性
                }
              }

            // 长按效果
            Label("长按效果", systemImage: "hand.tap")
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(Color.gray.opacity(0.1))
              .cornerRadius(8)
              .scaleEffect(animationScale)
              .onLongPressGesture {
                // 长按完成后的操作
              } onPressingChanged: { isPressing in
                withAnimation(.easeInOut(duration: 0.1)) {
                  animationScale = isPressing ? 0.95 : 1.0
                }
              }

            Text("💡 通过状态管理和动画可以创建丰富的交互反馈")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 5. 动画效果
        GroupBox("5. 动画效果") {
          VStack(alignment: .leading, spacing: 12) {
            Text("带动画的 Label：")
              .font(.headline)

            // 旋转动画
            Button("点击旋转") {
              withAnimation(.easeInOut(duration: 0.5)) {
                rotationAngle += 360
              }
            }

            Label("旋转动画", systemImage: "arrow.clockwise")
              .rotationEffect(.degrees(rotationAngle))
              .padding()

            // 脉冲动画
            Label("脉冲动画", systemImage: "heart.fill")
              .foregroundColor(.red)
              .scaleEffect(animationScale)
              .onAppear {
                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                  animationScale = 1.2
                }
              }

            // 渐变色动画
            Label("渐变动画", systemImage: "paintpalette")
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(
                LinearGradient(
                  colors: [.blue, .purple, .pink],
                  startPoint: .leading,
                  endPoint: .trailing
                )
                .opacity(0.3)
                .animation(
                  .easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: animationScale
                )
              )
              .cornerRadius(8)

            Text("💡 动画可以让 Label 更加生动，但要适度使用避免干扰用户")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 6. 可访问性支持
        GroupBox("6. 可访问性支持") {
          VStack(alignment: .leading, spacing: 12) {
            Text("增强可访问性的 Label：")
              .font(.headline)

            // 添加可访问性标签
            Label("重要通知", systemImage: "exclamationmark.triangle.fill")
              .foregroundColor(.orange)
              .accessibilityLabel("重要通知：需要您的注意")
              .accessibilityHint("点击查看详细信息")

            // 可访问性值
            Label("电池电量", systemImage: "battery.75")
              .accessibilityLabel("电池电量")
              .accessibilityValue("75%")

            // 可访问性特征
            Label("设置按钮", systemImage: "gear")
              .accessibilityAddTraits(.isButton)
              .accessibilityRemoveTraits(.isStaticText)

            Text("💡 良好的可访问性支持让更多用户能够使用您的应用")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 7. 实际应用：通知标签
        GroupBox("7. 实际应用：通知标签") {
          VStack(alignment: .leading, spacing: 8) {
            Text("不同类型的通知：")
              .font(.headline)

            // 成功通知
            Label("操作成功", systemImage: "checkmark.circle.fill")
              .foregroundColor(.green)
              .padding(.horizontal, 12)
              .padding(.vertical, 6)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)

            // 警告通知
            Label("注意事项", systemImage: "exclamationmark.triangle.fill")
              .foregroundColor(.orange)
              .padding(.horizontal, 12)
              .padding(.vertical, 6)
              .background(Color.orange.opacity(0.1))
              .cornerRadius(6)

            // 错误通知
            Label("操作失败", systemImage: "xmark.circle.fill")
              .foregroundColor(.red)
              .padding(.horizontal, 12)
              .padding(.vertical, 6)
              .background(Color.red.opacity(0.1))
              .cornerRadius(6)

            // 信息通知
            Label("提示信息", systemImage: "info.circle.fill")
              .foregroundColor(.blue)
              .padding(.horizontal, 12)
              .padding(.vertical, 6)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(6)

            Text("💡 通过颜色和图标的组合可以快速传达不同类型的信息")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding()
    }
    .navigationTitle("样式修饰符")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    LabelExampleView03()
  }
}
