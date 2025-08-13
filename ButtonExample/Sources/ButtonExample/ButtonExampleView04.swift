import ShareComponent
import SwiftUI

// MARK: - ButtonExampleView04: 自定义按钮样式
// 学习目标: 掌握高级定制和自定义样式实现
// 涵盖内容: 自定义 ButtonStyle、PrimitiveButtonStyle、动画效果、复杂样式

public struct ButtonExampleView04: View {
  // MARK: - 状态属性
  @State private var isPressed = false
  @State private var animationScale: CGFloat = 1.0
  @State private var selectedTheme = "蓝色主题"
  @State private var showingCustomAlert = false

  // 主题选项
  private let themes = ["蓝色主题", "绿色主题", "紫色主题", "渐变主题"]

  public init() {}

  public var body: some View {
    ExampleContainerView("自定义按钮样式") {

      // MARK: - 基础自定义样式
      ExampleSection("基础自定义 ButtonStyle") {
        VStack(spacing: 16) {
          // 圆角阴影样式
          Button("圆角阴影按钮") {
            // 按钮动作
          }
          .buttonStyle(RoundedShadowButtonStyle())

          // 渐变背景样式
          Button("渐变背景按钮") {
            // 按钮动作
          }
          .buttonStyle(GradientButtonStyle())

          // 霓虹灯效果样式
          Button("霓虹灯效果按钮") {
            // 按钮动作
          }
          .buttonStyle(NeonButtonStyle())

          // 3D 效果样式
          Button("3D 效果按钮") {
            // 按钮动作
          }
          .buttonStyle(ThreeDButtonStyle())
        }
      }

      // MARK: - 动画按钮样式
      ExampleSection("动画效果按钮") {
        VStack(spacing: 16) {
          // 弹跳动画按钮
          Button("弹跳动画按钮") {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
              animationScale = 0.95
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                animationScale = 1.0
              }
            }
          }
          .buttonStyle(BounceButtonStyle())
          .scaleEffect(animationScale)

          // 脉冲动画按钮
          Button("脉冲动画按钮") {
            // 按钮动作
          }
          .buttonStyle(PulseButtonStyle())

          // 旋转加载按钮
          Button("旋转效果按钮") {
            // 按钮动作
          }
          .buttonStyle(RotatingButtonStyle())

          // 波纹效果按钮
          Button("波纹效果按钮") {
            // 按钮动作
          }
          .buttonStyle(RippleButtonStyle())
        }
      }

      // MARK: - PrimitiveButtonStyle 演示
      ExampleSection("PrimitiveButtonStyle 自定义") {
        VStack(spacing: 16) {
          // 完全自定义的按钮行为
          Button("自定义交互按钮") {
            // 这个动作不会被调用，因为 PrimitiveButtonStyle 接管了所有交互
          }
          .buttonStyle(CustomPrimitiveButtonStyle())

          // 多状态按钮
          Button("多状态按钮") {
            // 动作由 PrimitiveButtonStyle 处理
          }
          .buttonStyle(MultiStateButtonStyle())

          Text("💡 PrimitiveButtonStyle 可以完全控制按钮的交互行为")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
      }

      // MARK: - 主题化按钮系统
      ExampleSection("主题化按钮系统") {
        VStack(spacing: 16) {
          // 主题选择器
          Picker("选择主题", selection: $selectedTheme) {
            ForEach(themes, id: \.self) { theme in
              Text(theme).tag(theme)
            }
          }
          .pickerStyle(.segmented)

          // 应用主题的按钮组
          VStack(spacing: 12) {
            Button("主要操作按钮") {
              // 按钮动作
            }
            .buttonStyle(ThemedButtonStyle(theme: getTheme(selectedTheme), style: .primary))

            Button("次要操作按钮") {
              // 按钮动作
            }
            .buttonStyle(ThemedButtonStyle(theme: getTheme(selectedTheme), style: .secondary))

            Button("危险操作按钮") {
              // 按钮动作
            }
            .buttonStyle(ThemedButtonStyle(theme: getTheme(selectedTheme), style: .destructive))
          }
        }
      }

      // MARK: - 复杂组合样式
      ExampleSection("复杂组合样式") {
        VStack(spacing: 16) {
          // 卡片式按钮
          Button(action: {}) {
            VStack(spacing: 8) {
              Image(systemName: "star.fill")
                .font(.title)
                .foregroundColor(.yellow)

              Text("收藏")
                .font(.headline)

              Text("点击收藏此内容")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
          }
          .buttonStyle(CardButtonStyle())

          // 图标文字组合按钮
          HStack(spacing: 12) {
            Button(action: {}) {
              VStack {
                Image(systemName: "heart.fill")
                  .font(.title2)
                Text("喜欢")
                  .font(.caption)
              }
            }
            .buttonStyle(IconTextButtonStyle(color: .red))

            Button(action: {}) {
              VStack {
                Image(systemName: "square.and.arrow.up")
                  .font(.title2)
                Text("分享")
                  .font(.caption)
              }
            }
            .buttonStyle(IconTextButtonStyle(color: .blue))

            Button(action: {}) {
              VStack {
                Image(systemName: "bookmark.fill")
                  .font(.title2)
                Text("保存")
                  .font(.caption)
              }
            }
            .buttonStyle(IconTextButtonStyle(color: .green))
          }
        }
      }

      // MARK: - 条件样式演示
      ExampleSection("条件样式系统") {
        VStack(spacing: 16) {
          // 根据状态改变样式的按钮
          Button("状态感知按钮") {
            isPressed.toggle()
          }
          .buttonStyle(ConditionalButtonStyle(isActive: isPressed))

          // 角色感知样式
          VStack(spacing: 8) {
            Button("确认操作") {}
              .buttonStyle(RoleAwareButtonStyle())

            Button("取消操作", role: .cancel) {}
              .buttonStyle(RoleAwareButtonStyle())

            Button("删除操作", role: .destructive) {}
              .buttonStyle(RoleAwareButtonStyle())
          }
        }
      }

      // MARK: - 性能优化演示
      ExampleSection("性能优化技巧") {
        VStack(spacing: 16) {
          // 使用 @Environment 优化的按钮
          Button("环境优化按钮") {
            // 按钮动作
          }
          .buttonStyle(EnvironmentOptimizedButtonStyle())

          // 缓存样式的按钮
          Button("缓存样式按钮") {
            // 按钮动作
          }
          .buttonStyle(CachedStyleButtonStyle())

          Text("💡 这些按钮使用了性能优化技巧，减少不必要的重绘")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
      }

    } footer: {
      VStack(alignment: .leading, spacing: 8) {
        Text("🎨 自定义样式要点:")
          .font(.headline)

        VStack(alignment: .leading, spacing: 4) {
          Text("• ButtonStyle 适用于大多数自定义需求")
          Text("• PrimitiveButtonStyle 提供完全的交互控制")
          Text("• 使用动画增强用户体验，但要适度")
          Text("• 主题化系统提高样式的一致性和可维护性")
          Text("• 考虑性能影响，避免复杂的实时计算")
          Text("• 保持可访问性，确保自定义样式不影响功能")
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }
    }
  }

  // MARK: - 辅助方法

  /// 根据主题名称获取主题配置
  private func getTheme(_ themeName: String) -> ButtonTheme {
    switch themeName {
    case "蓝色主题":
      return ButtonTheme(primary: .blue, secondary: .blue.opacity(0.3), accent: .white)
    case "绿色主题":
      return ButtonTheme(primary: .green, secondary: .green.opacity(0.3), accent: .white)
    case "紫色主题":
      return ButtonTheme(primary: .purple, secondary: .purple.opacity(0.3), accent: .white)
    case "渐变主题":
      return ButtonTheme(primary: .pink, secondary: .orange.opacity(0.3), accent: .white)
    default:
      return ButtonTheme(primary: .blue, secondary: .blue.opacity(0.3), accent: .white)
    }
  }
}

// MARK: - 自定义样式实现

/// 圆角阴影按钮样式
struct RoundedShadowButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(Color.blue)
      .foregroundColor(.white)
      .cornerRadius(25)
      .shadow(
        color: .blue.opacity(0.3), radius: configuration.isPressed ? 2 : 8, x: 0,
        y: configuration.isPressed ? 1 : 4
      )
      .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

/// 渐变背景按钮样式
struct GradientButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(
        LinearGradient(
          gradient: Gradient(colors: [.purple, .pink]),
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .foregroundColor(.white)
      .cornerRadius(10)
      .opacity(configuration.isPressed ? 0.8 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

/// 霓虹灯效果按钮样式
struct NeonButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(Color.black)
      .foregroundColor(.cyan)
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.cyan, lineWidth: 2)
          .shadow(color: .cyan, radius: configuration.isPressed ? 5 : 10)
          .shadow(color: .cyan, radius: configuration.isPressed ? 5 : 10)
      )
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

/// 3D 效果按钮样式
struct ThreeDButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(
        ZStack {
          // 底部阴影层
          RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.6))
            .offset(y: configuration.isPressed ? 1 : 3)

          // 主体层
          RoundedRectangle(cornerRadius: 8)
            .fill(Color.orange)
        }
      )
      .foregroundColor(.white)
      .offset(y: configuration.isPressed ? 2 : 0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

/// 弹跳动画按钮样式
struct BounceButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(Color.green)
      .foregroundColor(.white)
      .cornerRadius(12)
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
  }
}

/// 脉冲动画按钮样式
struct PulseButtonStyle: ButtonStyle {
  @State private var isPulsing = false

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(Color.red)
      .foregroundColor(.white)
      .cornerRadius(10)
      .scaleEffect(isPulsing ? 1.05 : 1.0)
      .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
      .onAppear {
        isPulsing = true
      }
  }
}

/// 旋转效果按钮样式
struct RotatingButtonStyle: ButtonStyle {
  @State private var isRotating = false

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(Color.indigo)
      .foregroundColor(.white)
      .cornerRadius(10)
      .rotationEffect(.degrees(isRotating ? 360 : 0))
      .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isRotating)
      .onTapGesture {
        isRotating.toggle()
      }
  }
}

/// 波纹效果按钮样式
struct RippleButtonStyle: ButtonStyle {
  @State private var rippleScale: CGFloat = 0
  @State private var rippleOpacity: Double = 0

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(Color.teal)
      .foregroundColor(.white)
      .cornerRadius(10)
      .overlay(
        Circle()
          .fill(Color.white.opacity(rippleOpacity))
          .scaleEffect(rippleScale)
          .animation(.easeOut(duration: 0.6), value: rippleScale)
      )
      .onChange(of: configuration.isPressed) { _, isPressed in
        if isPressed {
          rippleScale = 0
          rippleOpacity = 0.3
          withAnimation(.easeOut(duration: 0.6)) {
            rippleScale = 2
            rippleOpacity = 0
          }
        }
      }
  }
}

/// 自定义原始按钮样式
struct CustomPrimitiveButtonStyle: PrimitiveButtonStyle {
  @State private var isPressed = false

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(isPressed ? Color.gray : Color.blue)
      .foregroundColor(.white)
      .cornerRadius(8)
      .scaleEffect(isPressed ? 0.95 : 1.0)
      .onLongPressGesture(
        minimumDuration: 0, maximumDistance: .infinity,
        pressing: { pressing in
          withAnimation(.easeInOut(duration: 0.1)) {
            isPressed = pressing
          }
        },
        perform: {
          configuration.trigger()
        })
  }
}

/// 多状态按钮样式
struct MultiStateButtonStyle: PrimitiveButtonStyle {
  @State private var tapCount = 0

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(getBackgroundColor())
      .foregroundColor(.white)
      .cornerRadius(8)
      .overlay(
        Text("\(tapCount)")
          .font(.caption)
          .foregroundColor(.white)
          .padding(4)
          .background(Color.black.opacity(0.3))
          .cornerRadius(4)
          .offset(x: 25, y: -15)
      )
      .onTapGesture {
        tapCount += 1
        configuration.trigger()
      }
  }

  private func getBackgroundColor() -> Color {
    switch tapCount % 4 {
    case 0: return .blue
    case 1: return .green
    case 2: return .orange
    case 3: return .purple
    default: return .blue
    }
  }
}

/// 主题配置结构
struct ButtonTheme {
  let primary: Color
  let secondary: Color
  let accent: Color
}

/// 主题化按钮样式
struct ThemedButtonStyle: ButtonStyle {
  let theme: ButtonTheme
  let style: ButtonStyleType

  enum ButtonStyleType {
    case primary, secondary, destructive
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(getBackgroundColor())
      .foregroundColor(getForegroundColor())
      .cornerRadius(8)
      .opacity(configuration.isPressed ? 0.8 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }

  private func getBackgroundColor() -> Color {
    switch style {
    case .primary:
      return theme.primary
    case .secondary:
      return theme.secondary
    case .destructive:
      return .red
    }
  }

  private func getForegroundColor() -> Color {
    switch style {
    case .primary, .destructive:
      return theme.accent
    case .secondary:
      return theme.primary
    }
  }
}

/// 卡片式按钮样式
struct CardButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(backgroundColorForPlatform())
      .cornerRadius(12)
      .shadow(
        color: .black.opacity(0.1), radius: configuration.isPressed ? 2 : 8, x: 0,
        y: configuration.isPressed ? 1 : 4
      )
      .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

/// 图标文字组合按钮样式
struct IconTextButtonStyle: ButtonStyle {
  let color: Color

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(12)
      .background(color.opacity(configuration.isPressed ? 0.3 : 0.1))
      .foregroundColor(color)
      .cornerRadius(8)
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

/// 条件按钮样式
struct ConditionalButtonStyle: ButtonStyle {
  let isActive: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(isActive ? Color.green : Color.gray)
      .foregroundColor(.white)
      .cornerRadius(8)
      .overlay(
        Text(isActive ? "激活" : "未激活")
          .font(.caption)
          .foregroundColor(.white)
          .padding(4)
          .background(Color.black.opacity(0.3))
          .cornerRadius(4)
          .offset(x: 30, y: -15)
      )
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

/// 角色感知按钮样式
struct RoleAwareButtonStyle: ButtonStyle {
  // Note: buttonRole environment is not available in current SwiftUI version
  // Using a workaround approach

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(getBackgroundColor())
      .foregroundColor(.white)
      .cornerRadius(8)
      .opacity(configuration.isPressed ? 0.8 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }

  private func getBackgroundColor() -> Color {
    // Since buttonRole environment is not available, using default blue
    return .blue
  }
}

/// 环境优化按钮样式
struct EnvironmentOptimizedButtonStyle: ButtonStyle {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.dynamicTypeSize) private var dynamicTypeSize

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, getPadding())
      .padding(.vertical, getPadding() * 0.6)
      .background(getBackgroundColor())
      .foregroundColor(getForegroundColor())
      .cornerRadius(8)
      .font(getFont())
      .opacity(configuration.isPressed ? 0.8 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }

  private func getBackgroundColor() -> Color {
    colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.1)
  }

  private func getForegroundColor() -> Color {
    colorScheme == .dark ? .white : .black
  }

  private func getPadding() -> CGFloat {
    switch dynamicTypeSize {
    case .xSmall, .small:
      return 12
    case .medium, .large:
      return 16
    case .xLarge, .xxLarge:
      return 20
    default:
      return 24
    }
  }

  private func getFont() -> Font {
    switch dynamicTypeSize {
    case .xSmall, .small:
      return .caption
    case .medium, .large:
      return .body
    default:
      return .title3
    }
  }
}

/// 缓存样式按钮样式
struct CachedStyleButtonStyle: ButtonStyle {
  // 使用静态属性缓存计算结果
  private static let cachedGradient = LinearGradient(
    gradient: Gradient(colors: [.blue, .purple]),
    startPoint: .leading,
    endPoint: .trailing
  )

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background(Self.cachedGradient)
      .foregroundColor(.white)
      .cornerRadius(8)
      .opacity(configuration.isPressed ? 0.8 : 1.0)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

#Preview {
  NavigationStack {
    ButtonExampleView04()
  }
}
// MARK: - Helper Functions
private func backgroundColorForPlatform() -> Color {
  #if os(iOS)
    return Color(UIColor.systemBackground)
  #else
    return Color(.controlBackgroundColor)
  #endif
}
