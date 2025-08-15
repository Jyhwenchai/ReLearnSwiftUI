import SwiftUI

/// Toggle 样式示例
///
/// 演示 SwiftUI 中所有可用的 ToggleStyle
/// 包括内置样式和自定义样式
public struct ToggleExampleView03: View {
  // MARK: - 状态变量

  /// 自动样式开关
  @State private var automaticToggle = false

  /// 开关样式开关
  @State private var switchToggle = true

  /// 按钮样式开关
  @State private var buttonToggle = false

  /// 复选框样式开关（仅 macOS）
  @State private var checkboxToggle = true

  /// 自定义样式开关
  @State private var customToggle1 = false
  @State private var customToggle2 = true
  @State private var customToggle3 = false

  /// 组合样式开关
  @State private var groupToggle1 = false
  @State private var groupToggle2 = true
  @State private var groupToggle3 = false

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 内置样式
        Section("内置 Toggle 样式") {
          // 自动样式（默认）
          VStack(alignment: .leading) {
            Text("Automatic Style (默认)")
              .font(.caption)
              .foregroundColor(.secondary)
            Toggle("自动样式", isOn: $automaticToggle)
              .toggleStyle(.automatic)
          }

          // 开关样式
          VStack(alignment: .leading) {
            Text("Switch Style")
              .font(.caption)
              .foregroundColor(.secondary)
            Toggle("开关样式", isOn: $switchToggle)
              .toggleStyle(.switch)
          }

          // 按钮样式
          VStack(alignment: .leading) {
            Text("Button Style")
              .font(.caption)
              .foregroundColor(.secondary)
            Toggle("按钮样式", isOn: $buttonToggle)
              .toggleStyle(.button)
          }

          // 复选框样式（主要在 macOS 上可见）
          #if os(macOS)
            VStack(alignment: .leading) {
              Text("Checkbox Style (macOS)")
                .font(.caption)
                .foregroundColor(.secondary)
              Toggle("复选框样式", isOn: $checkboxToggle)
                .toggleStyle(.checkbox)
            }
          #endif
        }

        // MARK: - 自定义样式
        Section("自定义 Toggle 样式") {
          VStack(alignment: .leading) {
            Text("圆形指示器样式")
              .font(.caption)
              .foregroundColor(.secondary)
            Toggle("圆形指示器", isOn: $customToggle1)
              .toggleStyle(CircleToggleStyle())
          }

          VStack(alignment: .leading) {
            Text("彩色滑块样式")
              .font(.caption)
              .foregroundColor(.secondary)
            Toggle("彩色滑块", isOn: $customToggle2)
              .toggleStyle(ColorfulToggleStyle())
          }

          VStack(alignment: .leading) {
            Text("图标切换样式")
              .font(.caption)
              .foregroundColor(.secondary)
            Toggle("图标切换", isOn: $customToggle3)
              .toggleStyle(IconToggleStyle())
          }
        }

        // MARK: - 组合样式应用
        Section("批量样式应用") {
          Text("对整个组应用相同样式")
            .font(.caption)
            .foregroundColor(.secondary)

          VStack(alignment: .leading, spacing: 12) {
            Toggle("选项 1", isOn: $groupToggle1)
            Toggle("选项 2", isOn: $groupToggle2)
            Toggle("选项 3", isOn: $groupToggle3)
          }
          .toggleStyle(.switch)  // 对整个 VStack 应用样式
        }

        // MARK: - 样式对比
        Section("样式对比") {
          VStack(spacing: 16) {
            HStack {
              Text("默认:")
              Spacer()
              Toggle("", isOn: $automaticToggle)
                .toggleStyle(.automatic)
            }

            HStack {
              Text("开关:")
              Spacer()
              Toggle("", isOn: $switchToggle)
                .toggleStyle(.switch)
            }

            HStack {
              Text("按钮:")
              Spacer()
              Toggle("", isOn: $buttonToggle)
                .toggleStyle(.button)
            }

            #if os(macOS)
              HStack {
                Text("复选框:")
                Spacer()
                Toggle("", isOn: $checkboxToggle)
                  .toggleStyle(.checkbox)
              }
            #endif
          }
        }

        // MARK: - 使用说明
        Section("样式使用说明") {
          VStack(alignment: .leading, spacing: 8) {
            Text("Toggle 样式说明:")
              .font(.headline)

            Text("• .automatic - 根据平台自动选择合适的样式")
            Text("• .switch - 经典的滑动开关样式")
            Text("• .button - 按钮式切换样式")
            Text("• .checkbox - 复选框样式（主要用于 macOS）")
            Text("• 可以创建自定义 ToggleStyle")
            Text("• 样式可以应用到单个 Toggle 或整个视图层次")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
      }
      .navigationTitle("Toggle 样式")
      #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
      #endif
    }
  }
}

// MARK: - 自定义 Toggle 样式

/// 圆形指示器样式
struct CircleToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()
      Circle()
        .fill(configuration.isOn ? Color.green : Color.gray)
        .frame(width: 20, height: 20)
        .overlay(
          Circle()
            .stroke(Color.white, lineWidth: 2)
            .scaleEffect(configuration.isOn ? 0.6 : 0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
        )
        .onTapGesture {
          configuration.isOn.toggle()
        }
        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
    }
  }
}

/// 彩色滑块样式
struct ColorfulToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()

      RoundedRectangle(cornerRadius: 16)
        .fill(
          configuration.isOn
            ? LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
            : LinearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing)
        )
        .frame(width: 50, height: 30)
        .overlay(
          Circle()
            .fill(Color.white)
            .shadow(radius: 2)
            .padding(2)
            .offset(x: configuration.isOn ? 10 : -10)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isOn)
        )
        .onTapGesture {
          configuration.isOn.toggle()
        }
    }
  }
}

/// 图标切换样式
struct IconToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()

      Button(action: {
        configuration.isOn.toggle()
      }) {
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
          .foregroundColor(configuration.isOn ? .green : .gray)
          .font(.title2)
          .scaleEffect(configuration.isOn ? 1.1 : 1.0)
          .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isOn)
      }
      .buttonStyle(PlainButtonStyle())
    }
  }
}

// MARK: - 预览
#Preview {
  ToggleExampleView03()
}
