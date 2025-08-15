import SwiftUI

/// PickerExampleView02 - Picker 样式展示
/// 演示不同的 PickerStyle 样式效果
public struct PickerExampleView02: View {
  // MARK: - 状态属性

  /// 用于分段控件的选择
  @State private var segmentedSelection: TransportMode = .car

  /// 用于菜单样式的选择
  @State private var menuSelection: Priority = .medium

  /// 用于滚轮样式的选择
  @State private var wheelSelection: Int = 5

  /// 用于自动样式的选择
  @State private var automaticSelection: Theme = .system

  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 30) {

          // MARK: - 分段控件样式 (.segmented)
          VStack(alignment: .leading, spacing: 12) {
            Text("分段控件样式 (.segmented)")
              .font(.headline)
              .padding(.horizontal)

            Text("适用于选项较少(2-5个)的场景，所有选项同时可见")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.horizontal)

            Picker("交通方式", selection: $segmentedSelection) {
              ForEach(TransportMode.allCases) { mode in
                Label(mode.displayName, systemImage: mode.iconName)
                  .tag(mode)
              }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            // 显示选择结果
            HStack {
              Text("选择的交通方式:")
              Spacer()
              Text(segmentedSelection.displayName)
                .foregroundColor(.blue)
                .fontWeight(.medium)
            }
            .padding(.horizontal)
          }
          .padding(.vertical)
          .background(Color(.systemGray6))
          .cornerRadius(12)
          .padding(.horizontal)

          // MARK: - 菜单样式 (.menu)
          VStack(alignment: .leading, spacing: 12) {
            Text("菜单样式 (.menu)")
              .font(.headline)
              .padding(.horizontal)

            Text("节省空间，点击后显示下拉菜单，适用于选项较多的场景")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.horizontal)

            HStack {
              Picker("优先级", selection: $menuSelection) {
                ForEach(Priority.allCases) { priority in
                  Label(priority.displayName, systemImage: priority.iconName)
                    .tag(priority)
                }
              }
              .pickerStyle(.menu)

              Spacer()

              // 显示选择的优先级颜色
              Circle()
                .fill(menuSelection.color)
                .frame(width: 20, height: 20)
            }
            .padding(.horizontal)

            HStack {
              Text("当前优先级:")
              Spacer()
              Text(menuSelection.displayName)
                .foregroundColor(menuSelection.color)
                .fontWeight(.medium)
            }
            .padding(.horizontal)
          }
          .padding(.vertical)
          .background(Color(.systemGray6))
          .cornerRadius(12)
          .padding(.horizontal)

          // MARK: - 滚轮样式 (.wheel)
          VStack(alignment: .leading, spacing: 12) {
            Text("滚轮样式 (.wheel)")
              .font(.headline)
              .padding(.horizontal)

            Text("经典的滚轮选择器，适用于数值选择或大量选项")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.horizontal)

            Picker("选择数字", selection: $wheelSelection) {
              ForEach(1...20, id: \.self) { number in
                Text("\(number)")
                  .tag(number)
              }
            }
            .pickerStyle(.wheel)
            .frame(height: 120)
            .clipped()
            .padding(.horizontal)

            HStack {
              Text("选择的数字:")
              Spacer()
              Text("\(wheelSelection)")
                .foregroundColor(.orange)
                .fontWeight(.bold)
                .font(.title2)
            }
            .padding(.horizontal)
          }
          .padding(.vertical)
          .background(Color(.systemGray6))
          .cornerRadius(12)
          .padding(.horizontal)

          // MARK: - 自动样式 (.automatic)
          VStack(alignment: .leading, spacing: 12) {
            Text("自动样式 (.automatic)")
              .font(.headline)
              .padding(.horizontal)

            Text("系统根据上下文自动选择最合适的样式")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.horizontal)

            Form {
              Picker("主题设置", selection: $automaticSelection) {
                ForEach(Theme.allCases) { theme in
                  HStack {
                    Image(systemName: theme.iconName)
                    Text(theme.displayName)
                  }
                  .tag(theme)
                }
              }
              .pickerStyle(.automatic)

              HStack {
                Text("当前主题:")
                Spacer()
                Text(automaticSelection.displayName)
                  .foregroundColor(.secondary)
              }
            }
            .frame(height: 120)
            .padding(.horizontal)
          }
          .padding(.vertical)
          .background(Color(.systemGray6))
          .cornerRadius(12)
          .padding(.horizontal)

          // MARK: - 样式对比总结
          VStack(alignment: .leading, spacing: 8) {
            Text("样式选择建议")
              .font(.headline)
              .padding(.horizontal)

            VStack(alignment: .leading, spacing: 4) {
              Text("• Segmented: 2-5个选项，需要快速切换")
              Text("• Menu: 选项较多，需要节省空间")
              Text("• Wheel: 数值选择，或需要滚动浏览")
              Text("• Automatic: 让系统自动选择最佳样式")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal)
          }
          .padding(.vertical)
          .background(Color(.systemBlue).opacity(0.1))
          .cornerRadius(12)
          .padding(.horizontal)
        }
        .padding(.vertical)
      }
      .navigationTitle("Picker 样式展示")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

// MARK: - 支持类型定义

/// 交通方式枚举
public enum TransportMode: String, CaseIterable, Identifiable {
  case car, bus, train, plane

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .car: return "汽车"
    case .bus: return "公交"
    case .train: return "火车"
    case .plane: return "飞机"
    }
  }

  var iconName: String {
    switch self {
    case .car: return "car.fill"
    case .bus: return "bus.fill"
    case .train: return "tram.fill"
    case .plane: return "airplane"
    }
  }
}

/// 优先级枚举
public enum Priority: String, CaseIterable, Identifiable {
  case low, medium, high, urgent

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .low: return "低"
    case .medium: return "中"
    case .high: return "高"
    case .urgent: return "紧急"
    }
  }

  var iconName: String {
    switch self {
    case .low: return "arrow.down.circle"
    case .medium: return "minus.circle"
    case .high: return "arrow.up.circle"
    case .urgent: return "exclamationmark.triangle.fill"
    }
  }

  var color: Color {
    switch self {
    case .low: return .green
    case .medium: return .blue
    case .high: return .orange
    case .urgent: return .red
    }
  }
}

/// 主题枚举
public enum Theme: String, CaseIterable, Identifiable {
  case light, dark, system

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .light: return "浅色"
    case .dark: return "深色"
    case .system: return "跟随系统"
    }
  }

  var iconName: String {
    switch self {
    case .light: return "sun.max"
    case .dark: return "moon"
    case .system: return "gear"
    }
  }
}

// MARK: - 预览
#Preview {
  PickerExampleView02()
}
