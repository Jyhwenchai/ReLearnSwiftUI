import SwiftUI

/// Toggle 高级用法示例
///
/// 演示 Toggle 在实际应用场景中的高级用法
/// 包括设置页面、表单、动画效果、条件控制等
public struct ToggleExampleView04: View {
  // MARK: - 设置相关状态

  /// 通知设置
  @State private var notificationsEnabled = true
  @State private var soundEnabled = true
  @State private var badgeEnabled = false
  @State private var bannerEnabled = true

  /// 隐私设置
  @State private var locationEnabled = false
  @State private var cameraEnabled = true
  @State private var microphoneEnabled = false
  @State private var contactsEnabled = true

  /// 显示设置
  @State private var darkModeEnabled = false
  @State private var autoRotateEnabled = true
  @State private var reducedMotionEnabled = false

  /// 网络设置
  @State private var wifiEnabled = true
  @State private var cellularEnabled = true
  @State private var airplaneModeEnabled = false

  /// 表单状态
  @State private var agreeToTerms = false
  @State private var subscribeNewsletter = false
  @State private var enableAnalytics = true

  /// 动画控制
  @State private var showAdvancedSettings = false
  @State private var animatedToggle = false

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 设置页面场景
        Section("通知设置") {
          Toggle("启用通知", isOn: $notificationsEnabled)
            .onChange(of: notificationsEnabled) { newValue in
              // 当主开关关闭时，自动关闭所有子选项
              if !newValue {
                soundEnabled = false
                badgeEnabled = false
                bannerEnabled = false
              }
            }

          // 子选项，依赖于主开关
          Group {
            Toggle("声音提醒", isOn: $soundEnabled)
            Toggle("应用图标标记", isOn: $badgeEnabled)
            Toggle("横幅显示", isOn: $bannerEnabled)
          }
          .disabled(!notificationsEnabled)
          .opacity(notificationsEnabled ? 1.0 : 0.6)
          .animation(.easeInOut(duration: 0.2), value: notificationsEnabled)
        }

        // MARK: - 隐私权限场景
        Section("隐私权限") {
          Toggle(isOn: $locationEnabled) {
            HStack {
              Image(systemName: "location.fill")
                .foregroundColor(locationEnabled ? .blue : .gray)
              VStack(alignment: .leading) {
                Text("定位服务")
                if locationEnabled {
                  Text("应用可以访问您的位置")
                    .font(.caption)
                    .foregroundColor(.green)
                } else {
                  Text("某些功能可能受限")
                    .font(.caption)
                    .foregroundColor(.orange)
                }
              }
            }
          }

          Toggle(isOn: $cameraEnabled) {
            HStack {
              Image(systemName: "camera.fill")
                .foregroundColor(cameraEnabled ? .green : .gray)
              VStack(alignment: .leading) {
                Text("相机权限")
                Text(cameraEnabled ? "已授权" : "未授权")
                  .font(.caption)
                  .foregroundColor(cameraEnabled ? .green : .red)
              }
            }
          }

          Toggle(isOn: $microphoneEnabled) {
            HStack {
              Image(systemName: microphoneEnabled ? "mic.fill" : "mic.slash.fill")
                .foregroundColor(microphoneEnabled ? .green : .red)
              Text("麦克风权限")
            }
          }

          Toggle("通讯录权限", isOn: $contactsEnabled)
        }

        // MARK: - 带动画的高级控制
        Section("高级设置") {
          Toggle("显示高级选项", isOn: $showAdvancedSettings)
            .animation(.easeInOut, value: showAdvancedSettings)

          if showAdvancedSettings {
            Group {
              Toggle("深色模式", isOn: $darkModeEnabled)
                .onChange(of: darkModeEnabled) { newValue in
                  withAnimation(.easeInOut(duration: 0.5)) {
                    // 这里可以添加主题切换动画
                  }
                }

              Toggle("自动旋转", isOn: $autoRotateEnabled)

              Toggle("减少动画", isOn: $reducedMotionEnabled)
                .onChange(of: reducedMotionEnabled) { newValue in
                  // 根据设置调整动画
                  if newValue {
                    // 禁用或减少动画
                  }
                }
            }
            .transition(.slide.combined(with: .opacity))
          }
        }

        // MARK: - 网络设置场景
        Section("网络设置") {
          Toggle("飞行模式", isOn: $airplaneModeEnabled)
            .onChange(of: airplaneModeEnabled) { newValue in
              if newValue {
                // 飞行模式开启时，关闭所有网络连接
                wifiEnabled = false
                cellularEnabled = false
              }
            }

          Toggle("WiFi", isOn: $wifiEnabled)
            .disabled(airplaneModeEnabled)
            .opacity(airplaneModeEnabled ? 0.6 : 1.0)

          Toggle("蜂窝网络", isOn: $cellularEnabled)
            .disabled(airplaneModeEnabled)
            .opacity(airplaneModeEnabled ? 0.6 : 1.0)
        }

        // MARK: - 表单验证场景
        Section("用户协议") {
          Toggle(isOn: $agreeToTerms) {
            HStack {
              Text("我已阅读并同意")
              Button("《用户协议》") {
                // 显示用户协议
              }
              .foregroundColor(.blue)
            }
          }

          Toggle("订阅邮件通知", isOn: $subscribeNewsletter)

          Toggle(isOn: $enableAnalytics) {
            VStack(alignment: .leading) {
              Text("启用数据分析")
              Text("帮助我们改进产品体验")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }

          // 提交按钮，依赖于协议同意状态
          Button("提交") {
            // 处理提交逻辑
          }
          .disabled(!agreeToTerms)
          .foregroundColor(agreeToTerms ? .blue : .gray)
        }

        // MARK: - 动画演示
        Section("动画效果演示") {
          Toggle("动画开关", isOn: $animatedToggle)
            .scaleEffect(animatedToggle ? 1.1 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: animatedToggle)

          // 根据开关状态显示不同内容
          if animatedToggle {
            VStack(alignment: .leading, spacing: 8) {
              Text("✅ 动画已启用")
                .foregroundColor(.green)
              Text("您将看到流畅的过渡效果")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .transition(
              .asymmetric(
                insertion: .scale.combined(with: .opacity),
                removal: .opacity
              ))
          } else {
            Text("❌ 动画已禁用")
              .foregroundColor(.red)
              .transition(.opacity)
          }
        }

        // MARK: - 状态总览
        Section("当前配置总览") {
          VStack(alignment: .leading, spacing: 4) {
            statusSummary()
          }
          .font(.caption)
        }

        // MARK: - 使用说明
        Section("高级用法说明") {
          VStack(alignment: .leading, spacing: 8) {
            Text("Toggle 高级用法要点:")
              .font(.headline)

            Text("• 使用 onChange 监听状态变化")
            Text("• 通过 disabled() 实现条件控制")
            Text("• 结合动画创建流畅的用户体验")
            Text("• 在表单中进行数据验证")
            Text("• 实现主从关系的开关控制")
            Text("• 使用 transition 添加出现/消失动画")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
      }
      .navigationTitle("Toggle 高级用法")
      #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
      #endif
    }
  }

  // MARK: - 辅助方法

  /// 生成状态总览
  /// - Returns: 状态总览视图
  private func statusSummary() -> some View {
    VStack(alignment: .leading, spacing: 2) {
      Text("通知: \(notificationsEnabled ? "开启" : "关闭")")
      Text("定位: \(locationEnabled ? "开启" : "关闭")")
      Text("相机: \(cameraEnabled ? "开启" : "关闭")")
      Text("深色模式: \(darkModeEnabled ? "开启" : "关闭")")
      Text("飞行模式: \(airplaneModeEnabled ? "开启" : "关闭")")
      Text("用户协议: \(agreeToTerms ? "已同意" : "未同意")")
    }
    .foregroundColor(.secondary)
  }
}

// MARK: - 预览
#Preview {
  ToggleExampleView04()
}
