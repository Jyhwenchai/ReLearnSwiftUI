import SwiftUI

/// Toggle 不同初始化方法示例
///
/// 演示 Toggle 的各种初始化方式
/// 包括系统图标、自定义图片、复杂标签等
public struct ToggleExampleView02: View {
  // MARK: - 状态变量

  /// WiFi 开关状态
  @State private var wifiEnabled = true

  /// 蓝牙开关状态
  @State private var bluetoothEnabled = false

  /// 飞行模式状态
  @State private var airplaneModeEnabled = false

  /// 热点开关状态
  @State private var hotspotEnabled = false

  /// 定位服务状态
  @State private var locationEnabled = true

  /// 相机权限状态
  @State private var cameraEnabled = true

  /// 麦克风权限状态
  @State private var microphoneEnabled = false

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 使用系统图标的 Toggle
        Section("系统图标 Toggle") {
          // 使用系统图标和文本的 Toggle
          Toggle(
            "WiFi",
            systemImage: "wifi",
            isOn: $wifiEnabled
          )

          Toggle(
            "蓝牙",
            systemImage: "bluetooth",
            isOn: $bluetoothEnabled
          )

          Toggle(
            "飞行模式",
            systemImage: "airplane",
            isOn: $airplaneModeEnabled
          )

          Toggle(
            "个人热点",
            systemImage: "personalhotspot",
            isOn: $hotspotEnabled
          )
        }

        // MARK: - 使用自定义标签的 Toggle
        Section("自定义标签") {
          // 使用闭包创建复杂标签
          Toggle(isOn: $locationEnabled) {
            HStack {
              Image(systemName: "location.fill")
                .foregroundColor(.blue)
              VStack(alignment: .leading) {
                Text("定位服务")
                  .font(.body)
                Text("允许应用访问您的位置")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
          }

          // 带有状态指示器的标签
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

          // 带有警告信息的标签
          Toggle(isOn: $microphoneEnabled) {
            HStack {
              Image(systemName: microphoneEnabled ? "mic.fill" : "mic.slash.fill")
                .foregroundColor(microphoneEnabled ? .green : .red)
              VStack(alignment: .leading) {
                Text("麦克风权限")
                if !microphoneEnabled {
                  Text("某些功能可能无法正常使用")
                    .font(.caption)
                    .foregroundColor(.orange)
                }
              }
            }
          }
        }

        // MARK: - 多行标签的 Toggle
        Section("多行标签") {
          // 使用多个 Text 视图创建标题和副标题
          Toggle(isOn: $wifiEnabled) {
            Text("自动连接 WiFi")
            Text("在可用时自动连接到已知的 WiFi 网络")
          }

          Toggle(isOn: $bluetoothEnabled) {
            Text("蓝牙共享")
            Text("允许其他设备通过蓝牙连接到此设备")
          }
        }

        // MARK: - 带有图片的 Toggle
        Section("自定义图片") {
          Toggle(isOn: $airplaneModeEnabled) {
            Label {
              VStack(alignment: .leading) {
                Text("飞行模式")
                Text("关闭所有无线连接")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            } icon: {
              Image(systemName: "airplane.circle.fill")
                .foregroundColor(airplaneModeEnabled ? .orange : .gray)
                .font(.title2)
            }
          }

          Toggle(isOn: $hotspotEnabled) {
            Label {
              VStack(alignment: .leading) {
                Text("个人热点")
                Text("共享您的蜂窝网络连接")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            } icon: {
              Image(systemName: "wifi.router")
                .foregroundColor(hotspotEnabled ? .blue : .gray)
                .font(.title2)
            }
          }
        }

        // MARK: - 状态总览
        Section("当前状态总览") {
          VStack(alignment: .leading, spacing: 8) {
            statusRow("WiFi", isEnabled: wifiEnabled)
            statusRow("蓝牙", isEnabled: bluetoothEnabled)
            statusRow("飞行模式", isEnabled: airplaneModeEnabled)
            statusRow("个人热点", isEnabled: hotspotEnabled)
            statusRow("定位服务", isEnabled: locationEnabled)
            statusRow("相机权限", isEnabled: cameraEnabled)
            statusRow("麦克风权限", isEnabled: microphoneEnabled)
          }
        }

        // MARK: - 使用说明
        Section("初始化方法说明") {
          VStack(alignment: .leading, spacing: 8) {
            Text("Toggle 初始化方法:")
              .font(.headline)

            Text("• Toggle(\"标题\", isOn: $binding) - 纯文本标签")
            Text("• Toggle(\"标题\", systemImage: \"图标\", isOn: $binding) - 系统图标")
            Text("• Toggle(isOn: $binding) { 自定义视图 } - 自定义标签")
            Text("• 支持多行文本和复杂布局")
            Text("• 可以结合 Label 创建图标+文本标签")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
      }
      .navigationTitle("Toggle 初始化")
      #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
      #endif
    }
  }

  // MARK: - 辅助方法

  /// 创建状态行视图
  /// - Parameters:
  ///   - title: 标题
  ///   - isEnabled: 是否启用
  /// - Returns: 状态行视图
  private func statusRow(_ title: String, isEnabled: Bool) -> some View {
    HStack {
      Text(title)
      Spacer()
      Text(isEnabled ? "开启" : "关闭")
        .foregroundColor(isEnabled ? .green : .red)
        .font(.caption)
    }
  }
}

// MARK: - 预览
#Preview {
  ToggleExampleView02()
}
