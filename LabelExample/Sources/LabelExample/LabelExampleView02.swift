import SwiftUI

/// LabelExampleView02 - 图标和文本的组合方式
///
/// 这个示例展示了 Label 中图标和文本的不同组合方式：
/// - 使用自定义图片作为图标
/// - 图标和文本的对齐方式
/// - 图标颜色和大小的控制
/// - 复杂内容的 Label 构建
public struct LabelExampleView02: View {
  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("图标和文本组合")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom)

        // MARK: - 1. 使用自定义视图作为图标
        GroupBox("1. 自定义图标视图") {
          VStack(alignment: .leading, spacing: 12) {
            // 使用闭包语法创建自定义图标
            Label {
              Text("自定义图标标签")
            } icon: {
              // 自定义图标：圆形背景 + 文字
              ZStack {
                Circle()
                  .fill(Color.blue)
                  .frame(width: 20, height: 20)
                Text("A")
                  .font(.caption)
                  .foregroundColor(.white)
              }
            }

            // 使用渐变色作为图标背景
            Label {
              Text("渐变图标")
            } icon: {
              RoundedRectangle(cornerRadius: 4)
                .fill(
                  LinearGradient(
                    colors: [.purple, .pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                  )
                )
                .frame(width: 16, height: 16)
            }

            // 使用多个图标组合
            Label {
              Text("组合图标")
            } icon: {
              HStack(spacing: 2) {
                Image(systemName: "star.fill")
                  .foregroundColor(.yellow)
                Image(systemName: "star.fill")
                  .foregroundColor(.yellow)
                Image(systemName: "star")
                  .foregroundColor(.gray)
              }
              .font(.caption)
            }

            Text("💡 使用闭包语法可以创建完全自定义的图标视图")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 2. 图标颜色控制
        GroupBox("2. 图标颜色控制") {
          VStack(alignment: .leading, spacing: 8) {
            // 默认颜色
            Label("默认颜色", systemImage: "heart")

            // 自定义图标颜色
            Label("红色图标", systemImage: "heart.fill")
              .foregroundColor(.red)

            // 只改变图标颜色，文本保持默认
            Label {
              Text("蓝色图标，默认文本")
            } icon: {
              Image(systemName: "star.fill")
                .foregroundColor(.blue)
            }

            // 图标和文本使用不同颜色
            Label {
              Text("绿色文本")
                .foregroundColor(.green)
            } icon: {
              Image(systemName: "leaf.fill")
                .foregroundColor(.orange)
            }

            // 使用系统颜色
            VStack(alignment: .leading, spacing: 4) {
              Label("主要颜色", systemImage: "circle.fill")
                .foregroundColor(.primary)
              Label("次要颜色", systemImage: "circle.fill")
                .foregroundColor(.secondary)
              Label("强调颜色", systemImage: "circle.fill")
                .foregroundColor(.accentColor)
            }

            Text("💡 可以分别控制图标和文本的颜色，也可以统一设置")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 3. 图标大小控制
        GroupBox("3. 图标大小控制") {
          VStack(alignment: .leading, spacing: 12) {
            // 通过字体大小控制图标大小
            VStack(alignment: .leading, spacing: 8) {
              Text("通过字体大小控制：")
                .font(.headline)

              Label("小图标", systemImage: "star.fill")
                .font(.caption)

              Label("正常图标", systemImage: "star.fill")
                .font(.body)

              Label("大图标", systemImage: "star.fill")
                .font(.title2)

              Label("超大图标", systemImage: "star.fill")
                .font(.largeTitle)
            }

            Divider()

            // 自定义图标大小
            VStack(alignment: .leading, spacing: 8) {
              Text("自定义图标大小：")
                .font(.headline)

              Label {
                Text("自定义小图标")
              } icon: {
                Image(systemName: "gear")
                  .font(.system(size: 12))
              }

              Label {
                Text("自定义中图标")
              } icon: {
                Image(systemName: "gear")
                  .font(.system(size: 18))
              }

              Label {
                Text("自定义大图标")
              } icon: {
                Image(systemName: "gear")
                  .font(.system(size: 24))
              }
            }

            Text("💡 图标大小可以通过字体大小或直接设置 font 修饰符控制")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 4. 复杂文本内容
        GroupBox("4. 复杂文本内容") {
          VStack(alignment: .leading, spacing: 12) {
            // 多行文本
            Label {
              VStack(alignment: .leading, spacing: 2) {
                Text("主标题")
                  .font(.headline)
                Text("这是副标题或描述信息")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            } icon: {
              Image(systemName: "doc.text")
                .foregroundColor(.blue)
            }

            // 包含格式化文本
            Label {
              HStack {
                Text("重要")
                  .fontWeight(.bold)
                  .foregroundColor(.red)
                Text("通知消息")
                  .foregroundColor(.primary)
              }
            } icon: {
              Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.orange)
            }

            // 包含数字和单位
            Label {
              HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("25")
                  .font(.title2)
                  .fontWeight(.semibold)
                Text("GB")
                  .font(.caption)
                  .foregroundColor(.secondary)
                Text("已使用")
                  .font(.body)
              }
            } icon: {
              Image(systemName: "internaldrive")
                .foregroundColor(.purple)
            }

            Text("💡 Label 的文本部分可以是任意复杂的视图组合")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 5. 图标位置和对齐
        GroupBox("5. 图标位置和对齐") {
          VStack(alignment: .leading, spacing: 12) {
            Text("默认情况下，图标在左侧，文本在右侧：")
              .font(.headline)

            // 标准布局
            Label("标准布局", systemImage: "arrow.right")

            // 通过 HStack 实现右侧图标
            HStack {
              Text("图标在右侧")
              Spacer()
              Image(systemName: "arrow.left")
            }

            // 垂直布局
            VStack(spacing: 4) {
              Image(systemName: "cloud")
                .font(.title)
                .foregroundColor(.blue)
              Text("垂直布局")
                .font(.caption)
            }

            // 居中对齐的标签
            HStack {
              Spacer()
              Label("居中标签", systemImage: "center.fill")
              Spacer()
            }

            Text("💡 虽然 Label 默认是水平布局，但可以通过组合其他视图实现不同的布局效果")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }

        // MARK: - 6. 实际应用：状态指示器
        GroupBox("6. 实际应用：状态指示器") {
          VStack(alignment: .leading, spacing: 8) {
            Text("网络状态指示器：")
              .font(.headline)

            // 在线状态
            Label {
              Text("在线")
                .foregroundColor(.green)
            } icon: {
              Circle()
                .fill(Color.green)
                .frame(width: 8, height: 8)
            }

            // 离线状态
            Label {
              Text("离线")
                .foregroundColor(.red)
            } icon: {
              Circle()
                .fill(Color.red)
                .frame(width: 8, height: 8)
            }

            // 连接中状态
            Label {
              Text("连接中...")
                .foregroundColor(.orange)
            } icon: {
              Circle()
                .fill(Color.orange)
                .frame(width: 8, height: 8)
            }

            Text("💡 Label 非常适合创建状态指示器、通知标签等 UI 元素")
              .font(.caption)
              .foregroundColor(.secondary)
              .padding(.top, 8)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding()
    }
    .navigationTitle("图标文本组合")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    LabelExampleView02()
  }
}
