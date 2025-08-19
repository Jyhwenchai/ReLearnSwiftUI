import SwiftUI

/// MenuExampleView04 - 菜单样式和修饰符示例
/// 展示各种菜单修饰符的使用，包括样式、顺序、指示器等
public struct MenuExampleView04: View {
  @State private var selectedAction = "未选择任何操作"
  @State private var menuOrderSelection = MenuOrder.automatic
  @State private var showMenuIndicator = true
  @State private var dismissBehaviorIndex = 0
  private let dismissBehaviorOptions = ["自动", "禁用"]

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("菜单样式和修饰符")
          .font(.largeTitle)
          .fontWeight(.bold)

        Text("当前状态: \(selectedAction)")
          .foregroundColor(.secondary)
          .padding()
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)

        VStack(spacing: 25) {
          // 示例1: 不同的菜单样式
          VStack(alignment: .leading, spacing: 15) {
            Text("菜单样式示例")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 15) {
              // 默认样式
              Menu("默认样式") {
                Button("选项 1", action: { selectOption("默认样式 - 选项 1") })
                Button("选项 2", action: { selectOption("默认样式 - 选项 2") })
                Button("选项 3", action: { selectOption("默认样式 - 选项 3") })
              }
              .buttonStyle(.bordered)

              // 自动样式（明确指定）
              Menu("自动样式") {
                Button("选项 A", action: { selectOption("自动样式 - 选项 A") })
                Button("选项 B", action: { selectOption("自动样式 - 选项 B") })
                Button("选项 C", action: { selectOption("自动样式 - 选项 C") })
              }
              .menuStyle(.automatic)
              .buttonStyle(.borderedProminent)
            }
          }

          Divider()

          // 示例2: 菜单顺序控制
          VStack(alignment: .leading, spacing: 15) {
            Text("菜单顺序控制")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              // 顺序选择器
              Picker("菜单顺序", selection: $menuOrderSelection) {
                Text("自动").tag(MenuOrder.automatic)
                Text("固定").tag(MenuOrder.fixed)
              }
              .pickerStyle(.segmented)

              // 应用选定的菜单顺序
              Menu("菜单顺序示例") {
                Button("第一项", action: { selectOption("第一项") })
                Button("第二项", action: { selectOption("第二项") })
                Button("第三项", action: { selectOption("第三项") })
                Button("第四项", action: { selectOption("第四项") })
                Button("第五项", action: { selectOption("第五项") })
              }
              .menuOrder(menuOrderSelection)
              .buttonStyle(.bordered)
            }
          }

          Divider()

          // 示例3: 菜单指示器控制
          VStack(alignment: .leading, spacing: 15) {
            Text("菜单指示器控制")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              Toggle("显示菜单指示器", isOn: $showMenuIndicator)

              HStack(spacing: 15) {
                Menu("显示指示器") {
                  Button("操作 1", action: { selectOption("显示指示器 - 操作 1") })
                  Button("操作 2", action: { selectOption("显示指示器 - 操作 2") })
                  Button("操作 3", action: { selectOption("显示指示器 - 操作 3") })
                }
                .menuIndicator(.visible)
                .buttonStyle(.bordered)

                Menu("隐藏指示器") {
                  Button("操作 A", action: { selectOption("隐藏指示器 - 操作 A") })
                  Button("操作 B", action: { selectOption("隐藏指示器 - 操作 B") })
                  Button("操作 C", action: { selectOption("隐藏指示器 - 操作 C") })
                }
                .menuIndicator(.hidden)
                .buttonStyle(.bordered)

                Menu("自动指示器") {
                  Button("操作 X", action: { selectOption("自动指示器 - 操作 X") })
                  Button("操作 Y", action: { selectOption("自动指示器 - 操作 Y") })
                  Button("操作 Z", action: { selectOption("自动指示器 - 操作 Z") })
                }
                .menuIndicator(showMenuIndicator ? .visible : .hidden)
                .buttonStyle(.borderedProminent)
              }
            }
          }

          Divider()

          // 示例4: 菜单关闭行为控制
          VStack(alignment: .leading, spacing: 15) {
            Text("菜单关闭行为控制")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              Picker("关闭行为", selection: $dismissBehaviorIndex) {
                ForEach(0..<dismissBehaviorOptions.count, id: \.self) { index in
                  Text(dismissBehaviorOptions[index]).tag(index)
                }
              }
              .pickerStyle(.segmented)

              Menu("关闭行为示例") {
                Button("普通操作", action: { selectOption("普通操作") })
                Button("不关闭菜单的操作", action: { selectOption("不关闭菜单的操作") })

                Toggle("切换选项", isOn: .constant(false))
                  #if os(iOS)
                    .menuActionDismissBehavior(.disabled)
                  #endif

                Button("这个操作会关闭菜单", action: { selectOption("关闭菜单的操作") })
                  .menuActionDismissBehavior(.automatic)
              }
              #if os(iOS)
                .menuActionDismissBehavior(dismissBehaviorIndex == 0 ? .automatic : .disabled)
              #else
                .menuActionDismissBehavior(.automatic)
              #endif
              .buttonStyle(.bordered)
            }
          }

          Divider()

          // 示例5: 组合多个修饰符
          VStack(alignment: .leading, spacing: 15) {
            Text("组合修饰符示例")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            Menu {
              Button("重要操作", action: { selectOption("重要操作") })
              Button("次要操作", action: { selectOption("次要操作") })

              Divider()

              Menu("子菜单") {
                Button("子选项 1", action: { selectOption("子选项 1") })
                Button("子选项 2", action: { selectOption("子选项 2") })
              }

              Toggle("保持菜单打开", isOn: .constant(false))
                #if os(iOS)
                  .menuActionDismissBehavior(.disabled)
                #endif

            } label: {
              HStack {
                Image(systemName: "gearshape.fill")
                  .foregroundColor(.blue)
                Text("高级设置")
                  .fontWeight(.medium)
                Image(systemName: "chevron.down")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
              .padding(.horizontal, 16)
              .padding(.vertical, 12)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(10)
            }
            .menuStyle(.automatic)
            .menuOrder(.fixed)
            .menuIndicator(.visible)
            .menuActionDismissBehavior(.automatic)
          }

          Divider()

          // 示例6: 环境值的使用
          VStack(alignment: .leading, spacing: 15) {
            Text("环境值示例")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              // 通过环境值设置所有子菜单的样式
              VStack {
                Menu("环境菜单 1") {
                  Button("选项 1", action: { selectOption("环境菜单 1 - 选项 1") })
                  Button("选项 2", action: { selectOption("环境菜单 1 - 选项 2") })
                }
                .buttonStyle(.bordered)

                Menu("环境菜单 2") {
                  Button("选项 A", action: { selectOption("环境菜单 2 - 选项 A") })
                  Button("选项 B", action: { selectOption("环境菜单 2 - 选项 B") })
                }
                .buttonStyle(.bordered)
              }
              .environment(\.menuOrder, .fixed)
              .environment(\.menuIndicatorVisibility, .hidden)
            }
          }
        }

        // 说明文本
        VStack(alignment: .leading, spacing: 8) {
          Text("修饰符说明:")
            .fontWeight(.semibold)
          Text("• .menuStyle() - 设置菜单样式")
          Text("• .menuOrder() - 控制菜单项顺序")
          Text("• .menuIndicator() - 控制菜单指示器显示")
          Text("• .menuActionDismissBehavior() - 控制菜单关闭行为")
        }
        .font(.caption)
        .foregroundColor(.secondary)
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(8)
      }
      .padding()
    }
    .navigationTitle("菜单样式")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 辅助方法

  /// 选择操作
  private func selectOption(_ option: String) {
    selectedAction = option
  }
}

#Preview {
  NavigationView {
    MenuExampleView04()
  }
}
