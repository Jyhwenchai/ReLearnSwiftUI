import SwiftUI

/// 高级配置示例
/// 展示 Stepper 的高级配置选项和复杂数据操作
public struct StepperExampleView04: View {
  // 复杂数据模型
  @State private var settings = AppSettings()

  // 编辑状态跟踪
  @State private var editingStates: [String: Bool] = [:]

  // 动画状态
  @State private var isAnimating = false

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      // 标题
      Text("高级配置示例")
        .font(.largeTitle)
        .fontWeight(.bold)

      ScrollView {
        VStack(spacing: 20) {
          // 应用设置区域
          settingsSection

          // 动画控制区域
          animationSection

          // 自定义标签区域
          customLabelSection

          // 状态监听区域
          stateMonitoringSection

          // 设置摘要
          settingsSummary
        }
      }
    }
    .padding()
    .navigationTitle("高级配置")
    #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  /// 应用设置区域
  private var settingsSection: some View {
    configSection(
      title: "应用设置",
      description: "复杂数据结构的步进控制",
      icon: "gearshape.fill",
      color: .blue
    ) {
      VStack(spacing: 15) {
        // 字体大小设置
        Stepper(
          value: $settings.fontSize,
          in: 12...24,
          step: 1,
          onEditingChanged: { editing in
            editingStates["fontSize"] = editing
          }
        ) {
          HStack {
            Image(systemName: "textformat.size")
              .foregroundColor(.blue)
            VStack(alignment: .leading, spacing: 2) {
              Text("字体大小")
                .fontWeight(.medium)
              Text("\(Int(settings.fontSize))pt")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Spacer()
            if editingStates["fontSize"] == true {
              ProgressView()
                .scaleEffect(0.8)
            }
          }
        }

        // 刷新间隔设置
        Stepper(
          value: $settings.refreshInterval,
          in: 5...300,
          step: 5,
          onEditingChanged: { editing in
            editingStates["refresh"] = editing
          }
        ) {
          HStack {
            Image(systemName: "arrow.clockwise")
              .foregroundColor(.green)
            VStack(alignment: .leading, spacing: 2) {
              Text("刷新间隔")
                .fontWeight(.medium)
              Text("\(Int(settings.refreshInterval))秒")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Spacer()
            if editingStates["refresh"] == true {
              ProgressView()
                .scaleEffect(0.8)
            }
          }
        }

        // 最大连接数设置
        Stepper(
          value: $settings.maxConnections,
          in: 1...100,
          step: 5,
          onEditingChanged: { editing in
            editingStates["connections"] = editing
          }
        ) {
          HStack {
            Image(systemName: "network")
              .foregroundColor(.orange)
            VStack(alignment: .leading, spacing: 2) {
              Text("最大连接数")
                .fontWeight(.medium)
              Text("\(settings.maxConnections) 个连接")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Spacer()
            if editingStates["connections"] == true {
              ProgressView()
                .scaleEffect(0.8)
            }
          }
        }
      }
    }
  }

  /// 动画控制区域
  private var animationSection: some View {
    configSection(
      title: "动画控制",
      description: "带动画效果的步进器",
      icon: "wand.and.stars",
      color: .purple
    ) {
      VStack(spacing: 15) {
        Stepper(
          value: $settings.animationDuration,
          in: 0.1...2.0,
          step: 0.1,
          onEditingChanged: { editing in
            if editing {
              withAnimation(.easeInOut(duration: settings.animationDuration)) {
                isAnimating = true
              }
            } else {
              withAnimation(.easeInOut(duration: settings.animationDuration)) {
                isAnimating = false
              }
            }
          }
        ) {
          HStack {
            Image(systemName: "timer")
              .foregroundColor(.purple)
              .scaleEffect(isAnimating ? 1.2 : 1.0)
              .animation(
                .easeInOut(duration: settings.animationDuration).repeatForever(autoreverses: true),
                value: isAnimating)

            VStack(alignment: .leading, spacing: 2) {
              Text("动画时长")
                .fontWeight(.medium)
              Text("\(settings.animationDuration, specifier: "%.1f")秒")
                .font(.caption)
                .foregroundColor(.secondary)
            }

            Spacer()

            // 动画指示器
            Circle()
              .fill(Color.purple)
              .frame(width: 12, height: 12)
              .scaleEffect(isAnimating ? 1.5 : 1.0)
              .opacity(isAnimating ? 0.5 : 1.0)
              .animation(
                .easeInOut(duration: settings.animationDuration).repeatForever(autoreverses: true),
                value: isAnimating)
          }
        }
      }
    }
  }

  /// 自定义标签区域
  private var customLabelSection: some View {
    configSection(
      title: "自定义标签",
      description: "复杂的标签布局和样式",
      icon: "tag.fill",
      color: .red
    ) {
      VStack(spacing: 15) {
        // 带进度条的步进器
        Stepper(
          value: $settings.quality,
          in: 1...10,
          step: 1
        ) {
          VStack(alignment: .leading, spacing: 8) {
            HStack {
              Image(systemName: "dial.high.fill")
                .foregroundColor(.red)
              Text("图像质量")
                .fontWeight(.medium)
              Spacer()
              Text("\(settings.quality)/10")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(Color.red.opacity(0.2))
                .cornerRadius(4)
            }

            // 质量进度条
            GeometryReader { geometry in
              ZStack(alignment: .leading) {
                Rectangle()
                  .fill(Color.gray.opacity(0.3))
                  .frame(height: 4)
                  .cornerRadius(2)

                Rectangle()
                  .fill(qualityColor)
                  .frame(width: geometry.size.width * CGFloat(settings.quality) / 10, height: 4)
                  .cornerRadius(2)
              }
            }
            .frame(height: 4)
          }
        }

        // 带描述的步进器
        Stepper(
          value: $settings.cacheSize,
          in: 50...1000,
          step: 50
        ) {
          VStack(alignment: .leading, spacing: 4) {
            HStack {
              Image(systemName: "externaldrive.fill")
                .foregroundColor(.indigo)
              Text("缓存大小")
                .fontWeight(.medium)
              Spacer()
              Text("\(settings.cacheSize)MB")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.indigo)
            }

            Text(cacheDescription)
              .font(.caption)
              .foregroundColor(.secondary)
              .multilineTextAlignment(.leading)
          }
        }
      }
    }
  }

  /// 状态监听区域
  private var stateMonitoringSection: some View {
    configSection(
      title: "状态监听",
      description: "实时监听编辑状态变化",
      icon: "eye.fill",
      color: .green
    ) {
      VStack(alignment: .leading, spacing: 12) {
        Text("当前编辑状态:")
          .font(.headline)
          .fontWeight(.semibold)

        if editingStates.isEmpty || editingStates.values.allSatisfy({ !$0 }) {
          HStack {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(.green)
            Text("所有设置已保存")
              .foregroundColor(.green)
          }
        } else {
          ForEach(editingStates.filter { $0.value }.keys.sorted(), id: \.self) { key in
            HStack {
              Image(systemName: "pencil.circle.fill")
                .foregroundColor(.orange)
              Text("正在编辑: \(editingStateDescription(key))")
                .foregroundColor(.orange)
            }
          }
        }
      }
    }
  }

  /// 设置摘要
  private var settingsSummary: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("当前设置摘要")
        .font(.headline)
        .fontWeight(.semibold)

      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
        summaryCard("字体", "\(Int(settings.fontSize))pt", .blue)
        summaryCard("刷新", "\(Int(settings.refreshInterval))s", .green)
        summaryCard("连接", "\(settings.maxConnections)", .orange)
        summaryCard("质量", "\(settings.quality)/10", .red)
        summaryCard("缓存", "\(settings.cacheSize)MB", .indigo)
        summaryCard("动画", String(format: "%.1fs", settings.animationDuration), .purple)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(12)
  }

  /// 创建配置区域的辅助函数
  @ViewBuilder
  private func configSection<Content: View>(
    title: String,
    description: String,
    icon: String,
    color: Color,
    @ViewBuilder content: () -> Content
  ) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Image(systemName: icon)
          .foregroundColor(color)
        VStack(alignment: .leading, spacing: 2) {
          Text(title)
            .font(.headline)
            .fontWeight(.semibold)
          Text(description)
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }

      content()
    }
    .padding()
    .background(color.opacity(0.05))
    .cornerRadius(12)
  }

  /// 创建摘要卡片的辅助函数
  @ViewBuilder
  private func summaryCard(_ title: String, _ value: String, _ color: Color) -> some View {
    VStack(spacing: 4) {
      Text(title)
        .font(.caption)
        .foregroundColor(.secondary)
      Text(value)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundColor(color)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
    .background(color.opacity(0.1))
    .cornerRadius(8)
  }

  /// 质量颜色
  private var qualityColor: Color {
    switch settings.quality {
    case 1...3: return .red
    case 4...6: return .orange
    case 7...8: return .yellow
    default: return .green
    }
  }

  /// 缓存描述
  private var cacheDescription: String {
    switch settings.cacheSize {
    case 50...200: return "较小缓存，适合存储空间有限的设备"
    case 201...500: return "中等缓存，平衡性能和存储空间"
    case 501...800: return "较大缓存，提供更好的性能体验"
    default: return "最大缓存，适合高性能需求场景"
    }
  }

  /// 编辑状态描述
  private func editingStateDescription(_ key: String) -> String {
    switch key {
    case "fontSize": return "字体大小"
    case "refresh": return "刷新间隔"
    case "connections": return "连接数"
    default: return key
    }
  }
}

/// 应用设置数据模型
struct AppSettings {
  var fontSize: Double = 16
  var refreshInterval: Double = 30
  var maxConnections: Int = 10
  var quality: Int = 5
  var cacheSize: Int = 200
  var animationDuration: Double = 0.5
}

#Preview {
  NavigationView {
    StepperExampleView04()
  }
}
