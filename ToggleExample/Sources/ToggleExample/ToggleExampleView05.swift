import SwiftUI

/// Toggle 集合操作示例
///
/// 演示 Toggle 的批量操作和集合管理
/// 包括全选/取消全选、批量控制、状态统计等
public struct ToggleExampleView05: View {
  // MARK: - 数据模型

  /// 应用权限项
  struct PermissionItem: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let description: String
    var isEnabled: Bool
  }

  /// 功能选项
  struct FeatureOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    var isSelected: Bool
  }

  // MARK: - 状态变量

  /// 权限列表
  @State private var permissions: [PermissionItem] = [
    PermissionItem(name: "相机", icon: "camera.fill", description: "拍照和录制视频", isEnabled: true),
    PermissionItem(name: "麦克风", icon: "mic.fill", description: "录制音频", isEnabled: false),
    PermissionItem(name: "定位", icon: "location.fill", description: "访问位置信息", isEnabled: true),
    PermissionItem(
      name: "通讯录", icon: "person.crop.circle.fill", description: "访问联系人", isEnabled: false),
    PermissionItem(name: "日历", icon: "calendar", description: "访问日历事件", isEnabled: true),
    PermissionItem(name: "提醒事项", icon: "checklist", description: "访问提醒事项", isEnabled: false),
    PermissionItem(name: "照片", icon: "photo.fill", description: "访问照片库", isEnabled: true),
  ]

  /// 功能选项列表
  @State private var features: [FeatureOption] = [
    FeatureOption(title: "推送通知", subtitle: "接收应用通知", isSelected: true),
    FeatureOption(title: "后台刷新", subtitle: "在后台更新内容", isSelected: false),
    FeatureOption(title: "数据分析", subtitle: "帮助改进产品", isSelected: true),
    FeatureOption(title: "广告个性化", subtitle: "显示相关广告", isSelected: false),
    FeatureOption(title: "自动备份", subtitle: "自动备份数据", isSelected: true),
  ]

  /// 简单的布尔选项
  @State private var simpleOptions = [
    "选项 A": false,
    "选项 B": true,
    "选项 C": false,
    "选项 D": true,
    "选项 E": false,
  ]

  /// 全选状态
  @State private var selectAllPermissions = false
  @State private var selectAllFeatures = false
  @State private var selectAllSimple = false

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 权限管理
        Section("应用权限管理") {
          // 全选/取消全选控制
          Toggle("全选权限", isOn: $selectAllPermissions)
            .font(.headline)
            .onChange(of: selectAllPermissions) { newValue in
              // 批量设置所有权限
              for index in permissions.indices {
                permissions[index].isEnabled = newValue
              }
            }

          // 权限列表
          ForEach(permissions.indices, id: \.self) { index in
            Toggle(
              isOn: Binding(
                get: { permissions[index].isEnabled },
                set: { newValue in
                  permissions[index].isEnabled = newValue
                  updateSelectAllPermissions()
                }
              )
            ) {
              HStack {
                Image(systemName: permissions[index].icon)
                  .foregroundColor(permissions[index].isEnabled ? .blue : .gray)
                  .frame(width: 24)

                VStack(alignment: .leading) {
                  Text(permissions[index].name)
                    .font(.body)
                  Text(permissions[index].description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
              }
            }
          }

          // 权限统计
          HStack {
            Text("已启用权限:")
            Spacer()
            Text("\(enabledPermissionsCount)/\(permissions.count)")
              .foregroundColor(.blue)
          }
          .font(.caption)
        }

        // MARK: - 功能选项管理
        Section("功能选项") {
          // 全选控制
          Toggle("全选功能", isOn: $selectAllFeatures)
            .font(.headline)
            .onChange(of: selectAllFeatures) { newValue in
              for index in features.indices {
                features[index].isSelected = newValue
              }
            }

          // 功能列表
          ForEach(features.indices, id: \.self) { index in
            Toggle(
              isOn: Binding(
                get: { features[index].isSelected },
                set: { newValue in
                  features[index].isSelected = newValue
                  updateSelectAllFeatures()
                }
              )
            ) {
              VStack(alignment: .leading) {
                Text(features[index].title)
                  .font(.body)
                Text(features[index].subtitle)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
            .toggleStyle(.switch)
          }

          // 功能统计
          HStack {
            Text("已选择功能:")
            Spacer()
            Text("\(selectedFeaturesCount)/\(features.count)")
              .foregroundColor(.green)
          }
          .font(.caption)
        }

        // MARK: - 简单选项组
        Section("简单选项组") {
          // 全选控制
          Toggle("全选", isOn: $selectAllSimple)
            .font(.headline)
            .onChange(of: selectAllSimple) { newValue in
              for key in simpleOptions.keys {
                simpleOptions[key] = newValue
              }
            }

          // 选项列表
          ForEach(Array(simpleOptions.keys.sorted()), id: \.self) { key in
            Toggle(
              key,
              isOn: Binding(
                get: { simpleOptions[key] ?? false },
                set: { newValue in
                  simpleOptions[key] = newValue
                  updateSelectAllSimple()
                }
              )
            )
            .toggleStyle(.button)
          }

          // 选项统计
          HStack {
            Text("已选择:")
            Spacer()
            Text("\(selectedSimpleCount)/\(simpleOptions.count)")
              .foregroundColor(.orange)
          }
          .font(.caption)
        }

        // MARK: - 批量操作
        Section("批量操作") {
          HStack {
            Button("全部启用") {
              enableAllOptions()
            }
            .buttonStyle(.bordered)

            Spacer()

            Button("全部禁用") {
              disableAllOptions()
            }
            .buttonStyle(.bordered)

            Spacer()

            Button("反选") {
              toggleAllOptions()
            }
            .buttonStyle(.bordered)
          }
        }

        // MARK: - 状态统计
        Section("状态统计") {
          VStack(alignment: .leading, spacing: 8) {
            statisticRow(
              "权限", enabled: enabledPermissionsCount, total: permissions.count, color: .blue)
            statisticRow("功能", enabled: selectedFeaturesCount, total: features.count, color: .green)
            statisticRow(
              "选项", enabled: selectedSimpleCount, total: simpleOptions.count, color: .orange)

            Divider()

            HStack {
              Text("总计:")
                .font(.headline)
              Spacer()
              Text("\(totalEnabledCount)/\(totalOptionsCount)")
                .font(.headline)
                .foregroundColor(.primary)
            }

            // 进度条
            ProgressView(value: Double(totalEnabledCount), total: Double(totalOptionsCount))
              .progressViewStyle(LinearProgressViewStyle(tint: .blue))
          }
        }

        // MARK: - 使用说明
        Section("集合操作说明") {
          VStack(alignment: .leading, spacing: 8) {
            Text("Toggle 集合操作要点:")
              .font(.headline)

            Text("• 使用 Binding 创建双向数据绑定")
            Text("• 通过 onChange 监听状态变化")
            Text("• 实现全选/取消全选功能")
            Text("• 使用 ForEach 动态生成 Toggle 列表")
            Text("• 统计和显示选择状态")
            Text("• 支持批量操作和状态管理")
          }
          .font(.caption)
          .foregroundColor(.secondary)
        }
      }
      .navigationTitle("Toggle 集合操作")
      #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
      #endif
    }
  }

  // MARK: - 计算属性

  /// 已启用权限数量
  private var enabledPermissionsCount: Int {
    permissions.filter { $0.isEnabled }.count
  }

  /// 已选择功能数量
  private var selectedFeaturesCount: Int {
    features.filter { $0.isSelected }.count
  }

  /// 已选择简单选项数量
  private var selectedSimpleCount: Int {
    simpleOptions.values.filter { $0 }.count
  }

  /// 总启用数量
  private var totalEnabledCount: Int {
    enabledPermissionsCount + selectedFeaturesCount + selectedSimpleCount
  }

  /// 总选项数量
  private var totalOptionsCount: Int {
    permissions.count + features.count + simpleOptions.count
  }

  // MARK: - 辅助方法

  /// 更新权限全选状态
  private func updateSelectAllPermissions() {
    selectAllPermissions = permissions.allSatisfy { $0.isEnabled }
  }

  /// 更新功能全选状态
  private func updateSelectAllFeatures() {
    selectAllFeatures = features.allSatisfy { $0.isSelected }
  }

  /// 更新简单选项全选状态
  private func updateSelectAllSimple() {
    selectAllSimple = simpleOptions.values.allSatisfy { $0 }
  }

  /// 启用所有选项
  private func enableAllOptions() {
    for index in permissions.indices {
      permissions[index].isEnabled = true
    }
    for index in features.indices {
      features[index].isSelected = true
    }
    for key in simpleOptions.keys {
      simpleOptions[key] = true
    }
    selectAllPermissions = true
    selectAllFeatures = true
    selectAllSimple = true
  }

  /// 禁用所有选项
  private func disableAllOptions() {
    for index in permissions.indices {
      permissions[index].isEnabled = false
    }
    for index in features.indices {
      features[index].isSelected = false
    }
    for key in simpleOptions.keys {
      simpleOptions[key] = false
    }
    selectAllPermissions = false
    selectAllFeatures = false
    selectAllSimple = false
  }

  /// 反选所有选项
  private func toggleAllOptions() {
    for index in permissions.indices {
      permissions[index].isEnabled.toggle()
    }
    for index in features.indices {
      features[index].isSelected.toggle()
    }
    for key in simpleOptions.keys {
      simpleOptions[key]?.toggle()
    }
    updateSelectAllPermissions()
    updateSelectAllFeatures()
    updateSelectAllSimple()
  }

  /// 创建统计行
  /// - Parameters:
  ///   - title: 标题
  ///   - enabled: 启用数量
  ///   - total: 总数量
  ///   - color: 颜色
  /// - Returns: 统计行视图
  private func statisticRow(_ title: String, enabled: Int, total: Int, color: Color) -> some View {
    HStack {
      Text("\(title):")
      Spacer()
      Text("\(enabled)/\(total)")
        .foregroundColor(color)

      // 百分比
      Text("(\(Int(Double(enabled) / Double(total) * 100))%)")
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }
}

// MARK: - 预览
#Preview {
  ToggleExampleView05()
}
