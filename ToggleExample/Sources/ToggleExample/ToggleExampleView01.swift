import SwiftUI

/// Toggle 基础用法示例
///
/// 演示 Toggle 的基本创建和使用方法
/// 包括简单的文本标签和状态绑定
public struct ToggleExampleView01: View {
  // MARK: - 状态变量

  /// 控制振动开关的状态
  @State private var vibrateOnRing = false

  /// 控制静音时振动的状态
  @State private var vibrateOnSilent = true

  /// 控制通知开关的状态
  @State private var notificationsEnabled = false

  /// 控制深色模式的状态
  @State private var darkModeEnabled = true

  /// 控制自动锁定的状态
  @State private var autoLockEnabled = false

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 基础 Toggle 示例
        Section("基础用法") {
          // 最简单的 Toggle，只有文本标签
          Toggle("来电时振动", isOn: $vibrateOnRing)

          // 带有初始值的 Toggle
          Toggle("静音时振动", isOn: $vibrateOnSilent)

          // 使用本地化字符串键的 Toggle
          Toggle("启用通知", isOn: $notificationsEnabled)
        }

        // MARK: - 状态显示
        Section("当前状态") {
          HStack {
            Text("来电振动:")
            Spacer()
            Text(vibrateOnRing ? "开启" : "关闭")
              .foregroundColor(vibrateOnRing ? .green : .red)
          }

          HStack {
            Text("静音振动:")
            Spacer()
            Text(vibrateOnSilent ? "开启" : "关闭")
              .foregroundColor(vibrateOnSilent ? .green : .red)
          }

          HStack {
            Text("通知状态:")
            Spacer()
            Text(notificationsEnabled ? "开启" : "关闭")
              .foregroundColor(notificationsEnabled ? .green : .red)
          }
        }

        // MARK: - 带动画效果的 Toggle
        Section("动画效果") {
          Toggle("深色模式", isOn: $darkModeEnabled)
            .onChange(of: darkModeEnabled) { newValue in
              // 状态改变时的动画效果
              withAnimation(.easeInOut(duration: 0.3)) {
                // 这里可以添加状态改变时的动画逻辑
              }
            }

          Toggle("自动锁定", isOn: $autoLockEnabled)
            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: autoLockEnabled)
        }

        // MARK: - 条件控制的 Toggle
        Section("条件控制") {
          Toggle("主开关", isOn: $notificationsEnabled)

          // 只有当通知开启时，子选项才可用
          Toggle("声音提醒", isOn: $vibrateOnRing)
            .disabled(!notificationsEnabled)
            .opacity(notificationsEnabled ? 1.0 : 0.6)

          Toggle("横幅显示", isOn: $vibrateOnSilent)
            .disabled(!notificationsEnabled)
            .opacity(notificationsEnabled ? 1.0 : 0.6)
        }

        // MARK: - 使用说明
        Section("使用说明") {
          VStack(alignment: .leading, spacing: 8) {
            Text("Toggle 基础用法要点:")
              .font(.headline)

            Text("• 使用 @State 变量绑定 Toggle 状态")
            Text("• 通过 $ 符号创建绑定")
            Text("• 可以使用 disabled() 禁用 Toggle")
            Text("• 支持动画效果和状态变化监听")
            Text("• 适用于设置页面和表单控件")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
      }
      .navigationTitle("Toggle 基础用法")
      #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
      #endif
    }
  }
}

// MARK: - 预览
#Preview {
  ToggleExampleView01()
}
