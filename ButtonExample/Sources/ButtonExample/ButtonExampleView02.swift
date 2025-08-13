import ShareComponent
import SwiftUI

// MARK: - ButtonExampleView02: 样式和修饰符
// 学习目标: 掌握 Button 的外观定制和各种修饰符
// 涵盖内容: 所有内置样式、边框形状、控制大小、颜色主题

public struct ButtonExampleView02: View {
  // MARK: - 状态属性
  @State private var selectedStyle = "bordered"
  @State private var selectedSize = "regular"
  @State private var selectedShape = "automatic"
  @State private var selectedColor = Color.blue

  // 样式选项
  private let buttonStyles = ["automatic", "bordered", "borderedProminent", "plain", "link"]
  private let controlSizes = ["mini", "small", "regular", "large"]
  private let borderShapes = ["automatic", "capsule", "roundedRectangle", "circle"]
  private let colorOptions: [(String, Color)] = [
    ("蓝色", .blue),
    ("绿色", .green),
    ("红色", .red),
    ("紫色", .purple),
    ("橙色", .orange),
    ("粉色", .pink),
  ]

  public init() {}

  public var body: some View {
    ExampleContainerView("样式和修饰符") {

      // MARK: - 所有内置按钮样式
      ExampleSection("内置按钮样式完整展示") {
        VStack(spacing: 12) {
          // .automatic - 默认样式，根据上下文自动调整
          Button("Automatic 样式") {}
            .buttonStyle(.automatic)
            .modifier(
              StyleDescriptionModifier(
                name: "automatic",
                description: "默认样式，根据上下文自动调整"
              ))

          // .bordered - 标准边框样式
          Button("Bordered 样式") {}
            .buttonStyle(.bordered)
            .modifier(
              StyleDescriptionModifier(
                name: "bordered",
                description: "标准边框样式，适合大多数场景"
              ))

          // .borderedProminent - 突出的边框样式
          Button("Bordered Prominent 样式") {}
            .buttonStyle(.borderedProminent)
            .modifier(
              StyleDescriptionModifier(
                name: "borderedProminent",
                description: "突出样式，用于主要操作"
              ))

          // .plain - 朴素样式，无装饰
          Button("Plain 样式") {}
            .buttonStyle(.plain)
            .modifier(
              StyleDescriptionModifier(
                name: "plain",
                description: "朴素样式，无装饰效果"
              ))

          // .link - 链接样式（仅 macOS 可用）
          #if os(macOS)
            Button("Link 样式") {}
              .buttonStyle(.link)
              .modifier(
                StyleDescriptionModifier(
                  name: "link",
                  description: "链接样式，类似网页链接（仅 macOS）"
                ))
          #else
            Button("Link 样式 (macOS only)") {}
              .buttonStyle(.plain)
              .modifier(
                StyleDescriptionModifier(
                  name: "link",
                  description: "链接样式，仅在 macOS 上可用"
                )
              )
              .foregroundColor(.secondary)
          #endif
        }
      }

      // MARK: - 控制大小演示
      ExampleSection("控制大小演示") {
        VStack(spacing: 16) {
          // 不同大小的按钮对比
          VStack(spacing: 8) {
            Button("Mini 大小") {}
              .controlSize(.mini)
              .buttonStyle(.bordered)

            Button("Small 大小") {}
              .controlSize(.small)
              .buttonStyle(.bordered)

            Button("Regular 大小") {}
              .controlSize(.regular)
              .buttonStyle(.bordered)

            Button("Large 大小") {}
              .controlSize(.large)
              .buttonStyle(.bordered)
          }

          Text("💡 controlSize 会影响按钮的内边距和字体大小")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
      }

      // MARK: - 边框形状演示
      ExampleSection("按钮边框形状") {
        VStack(spacing: 12) {
          // .automatic - 自动形状
          Button("Automatic 形状") {}
            .buttonStyle(.bordered)
            .buttonBorderShape(.automatic)
            .modifier(ShapeDescriptionModifier("automatic", "系统默认形状"))

          // .capsule - 胶囊形状
          Button("Capsule 形状") {}
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .modifier(ShapeDescriptionModifier("capsule", "胶囊形状，圆润边角"))

          // .roundedRectangle - 圆角矩形
          Button("Rounded Rectangle") {}
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .modifier(ShapeDescriptionModifier("roundedRectangle", "圆角矩形"))

          // .circle - 圆形（适用于正方形按钮）
          Button("⭐") {}
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
            .frame(width: 44, height: 44)
            .modifier(ShapeDescriptionModifier("circle", "圆形，适合图标按钮"))
        }
      }

      // MARK: - 颜色和主题
      ExampleSection("颜色和主题定制") {
        VStack(spacing: 16) {
          // 使用 tint 修改主题色
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
            ForEach(colorOptions, id: \.0) { name, color in
              Button(name) {}
                .buttonStyle(.borderedProminent)
                .tint(color)
            }
          }

          // 前景色和背景色组合
          VStack(spacing: 8) {
            Button("自定义前景色") {}
              .buttonStyle(.bordered)
              .foregroundColor(.white)
              .background(Color.purple)
              .cornerRadius(8)

            Button("渐变背景按钮") {}
              .buttonStyle(.plain)
              .foregroundColor(.white)
              .padding()
              .background(
                LinearGradient(
                  gradient: Gradient(colors: [.blue, .purple]),
                  startPoint: .leading,
                  endPoint: .trailing
                )
              )
              .cornerRadius(10)
          }
        }
      }

      // MARK: - 动态样式调试器
      ExampleSection("动态样式调试器") {
        VStack(spacing: 16) {
          // 样式选择器
          VStack(alignment: .leading, spacing: 8) {
            Text("样式选择:")
              .font(.headline)

            Picker("样式", selection: $selectedStyle) {
              ForEach(buttonStyles, id: \.self) { style in
                Text(style).tag(style)
              }
            }
            .pickerStyle(.segmented)
          }

          // 大小选择器
          VStack(alignment: .leading, spacing: 8) {
            Text("大小选择:")
              .font(.headline)

            Picker("大小", selection: $selectedSize) {
              ForEach(controlSizes, id: \.self) { size in
                Text(size).tag(size)
              }
            }
            .pickerStyle(.segmented)
          }

          // 颜色选择器
          VStack(alignment: .leading, spacing: 8) {
            Text("颜色选择:")
              .font(.headline)

            ColorPicker("选择颜色", selection: $selectedColor)
          }

          // 预览按钮
          VStack {
            Text("预览效果:")
              .font(.headline)

            styledButton(selectedStyle)
              .controlSize(getControlSize(selectedSize))
              .tint(selectedColor)
          }
          .padding()
          .background(Color.gray.opacity(0.1))
          .cornerRadius(10)
        }
      }

      // MARK: - 组合效果演示
      ExampleSection("样式组合效果") {
        VStack(spacing: 12) {
          // 组合1：大型突出按钮
          Button("主要操作按钮", systemImage: "checkmark.circle.fill") {
          }
          .buttonStyle(.borderedProminent)
          .controlSize(.large)
          .tint(.green)

          // 组合2：小型链接按钮
          #if os(macOS)
            Button("次要链接", systemImage: "link") {
            }
            .buttonStyle(.link)
            .controlSize(.small)
            .tint(.blue)
          #else
            Button("次要链接", systemImage: "link") {
            }
            .buttonStyle(.plain)
            .controlSize(.small)
            .tint(.blue)
          #endif

          // 组合3：圆形图标按钮
          Button(action: {}) {
            Image(systemName: "heart.fill")
              .font(.title2)
          }
          .buttonStyle(.bordered)
          .buttonBorderShape(.circle)
          .tint(.red)
          .frame(width: 50, height: 50)

          // 组合4：胶囊形主题按钮
          Button("胶囊按钮", systemImage: "star.fill") {
          }
          .buttonStyle(.borderedProminent)
          .buttonBorderShape(.capsule)
          .controlSize(.large)
          .tint(.orange)
        }
      }

    } footer: {
      VStack(alignment: .leading, spacing: 8) {
        Text("🎨 样式设计要点:")
          .font(.headline)

        VStack(alignment: .leading, spacing: 4) {
          Text("• borderedProminent 适用于主要操作，吸引用户注意")
          Text("• bordered 适用于次要操作，保持界面整洁")
          Text("• plain 和 link 适用于辅助操作，减少视觉噪音")
          Text("• controlSize 影响按钮大小，需要与界面层级匹配")
          Text("• 使用 tint 统一主题色，保持视觉一致性")
          Text("• buttonBorderShape 影响视觉风格，选择合适的形状")
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }
    }
  }

  // MARK: - 辅助方法

  /// 应用按钮样式的辅助方法
  @ViewBuilder
  private func styledButton(_ style: String) -> some View {
    let button = Button("动态预览按钮") {}

    switch style {
    case "automatic":
      button.buttonStyle(.automatic)
    case "bordered":
      button.buttonStyle(.bordered)
    case "borderedProminent":
      button.buttonStyle(.borderedProminent)
    case "plain":
      button.buttonStyle(.plain)
    case "link":
      #if os(macOS)
        button.buttonStyle(.link)
      #else
        button.buttonStyle(.plain)
      #endif
    default:
      button.buttonStyle(.bordered)
    }
  }

  /// 根据字符串获取控制大小
  private func getControlSize(_ size: String) -> ControlSize {
    switch size {
    case "mini":
      return .mini
    case "small":
      return .small
    case "regular":
      return .regular
    case "large":
      return .large
    default:
      return .regular
    }
  }
}

// MARK: - 样式描述修饰符
struct StyleDescriptionModifier: ViewModifier {
  let name: String
  let description: String

  func body(content: Content) -> some View {
    VStack {
      content
      VStack {
        Text(".\(name)")
          .font(.caption)
          .fontWeight(.semibold)
        Text(description)
          .font(.caption2)
          .foregroundColor(.secondary)
      }
    }
  }
}

// MARK: - 形状描述修饰符
struct ShapeDescriptionModifier: ViewModifier {
  let name: String
  let description: String

  init(_ name: String, _ description: String) {
    self.name = name
    self.description = description
  }

  func body(content: Content) -> some View {
    VStack {
      content
      VStack {
        Text(".\(name)")
          .font(.caption)
          .fontWeight(.semibold)
        Text(description)
          .font(.caption2)
          .foregroundColor(.secondary)
      }
    }
  }
}

#Preview {
  NavigationStack {
    ButtonExampleView02()
  }
}
