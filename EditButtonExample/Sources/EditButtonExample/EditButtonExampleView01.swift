import SwiftUI

/// EditButton 基础示例
///
/// 本示例展示了 EditButton 的基本使用方法：
/// 1. EditButton 的基本创建和放置
/// 2. 如何读取编辑模式状态
/// 3. 根据编辑模式显示不同的内容
/// 4. EditButton 的自动状态切换
public struct EditButtonExampleView01: View {
  // MARK: - 状态属性

  /// 从环境中读取编辑模式状态
  /// editMode 是一个可选的 Binding<EditMode>，当没有编辑上下文时为 nil
  @Environment(\.editMode) private var editMode

  /// 示例数据 - 用户信息
  @State private var userName = "张三"
  @State private var userEmail = "zhangsan@example.com"
  @State private var userBio = "这是一段个人简介"

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        // MARK: - 编辑模式状态显示

        Group {
          Text("编辑模式状态")
            .font(.headline)

          // 显示当前编辑模式状态
          if let editMode = editMode?.wrappedValue {
            switch editMode {
            case .active:
              Label("编辑模式：激活", systemImage: "pencil.circle.fill")
                .foregroundColor(.orange)
            case .inactive:
              Label("编辑模式：未激活", systemImage: "eye.circle.fill")
                .foregroundColor(.blue)
            case .transient:
              Label("编辑模式：过渡中", systemImage: "clock.circle.fill")
                .foregroundColor(.gray)
            @unknown default:
              Label("编辑模式：未知", systemImage: "questionmark.circle.fill")
                .foregroundColor(.red)
            }
          } else {
            Label("编辑模式：不可用", systemImage: "xmark.circle.fill")
              .foregroundColor(.red)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)

        Divider()

        // MARK: - 根据编辑模式显示不同内容

        VStack(alignment: .leading, spacing: 15) {
          Text("用户信息")
            .font(.headline)

          // 用户名显示/编辑
          HStack {
            Text("姓名:")
              .fontWeight(.medium)

            if editMode?.wrappedValue.isEditing == true {
              // 编辑模式：显示文本输入框
              TextField("请输入姓名", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
              // 查看模式：显示只读文本
              Text(userName)
                .foregroundColor(.primary)
              Spacer()
            }
          }

          // 邮箱显示/编辑
          HStack {
            Text("邮箱:")
              .fontWeight(.medium)

            if editMode?.wrappedValue.isEditing == true {
              TextField("请输入邮箱", text: $userEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
            } else {
              Text(userEmail)
                .foregroundColor(.secondary)
              Spacer()
            }
          }

          // 个人简介显示/编辑
          VStack(alignment: .leading) {
            Text("简介:")
              .fontWeight(.medium)

            if editMode?.wrappedValue.isEditing == true {
              TextEditor(text: $userBio)
                .frame(height: 80)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            } else {
              Text(userBio)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            }
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)

        Spacer()

        // MARK: - 编辑模式说明

        VStack(alignment: .leading, spacing: 8) {
          Text("💡 使用说明")
            .font(.headline)

          Text("• 点击右上角的 'Edit' 按钮进入编辑模式")
          Text("• 编辑模式下可以修改用户信息")
          Text("• 点击 'Done' 按钮退出编辑模式")
          Text("• EditButton 会自动管理按钮标题的切换")
        }
        .font(.caption)
        .foregroundColor(.secondary)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
      }
      .padding()
      .navigationTitle("基础 EditButton")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        // MARK: - EditButton 放置

        ToolbarItem(placement: .navigationBarTrailing) {
          // EditButton 会自动：
          // 1. 在 "Edit" 和 "Done" 之间切换标题
          // 2. 管理环境中的 editMode 值
          // 3. 提供标准的编辑按钮样式
          EditButton()
        }
      }
      // 添加动画效果，让编辑模式切换更流畅
      .animation(.easeInOut(duration: 0.3), value: editMode?.wrappedValue)
    }
    .navigationViewStyle(StackNavigationViewStyle())  // 确保在所有设备上都使用堆栈样式
  }
}

// MARK: - 预览

#Preview {
  EditButtonExampleView01()
}

#Preview("编辑模式") {
  EditButtonExampleView01()
    .environment(\.editMode, .constant(.active))
}
