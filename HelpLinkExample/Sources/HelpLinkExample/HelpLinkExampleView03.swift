import SwiftUI

/// HelpLink 在不同容器中的使用示例
///
/// 本示例展示了 HelpLink 在不同 UI 容器中的自动定位和使用：
/// 1. 在 Alert 中的使用（自动定位到右上角）
/// 2. 在 Sheet 工具栏中的使用（自动定位到左下角）
/// 3. 在 Form 中的使用
/// 4. 在 NavigationView 工具栏中的使用
/// 5. 在自定义容器中的使用
@available(macOS 14.0, *)
struct HelpLinkExampleView03: View {
  @State private var showingAlert = false
  @State private var showingSheet = false
  @State private var showingConfirmationDialog = false
  @State private var formData = FormData()

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {
        // 页面标题和说明
        VStack(alignment: .leading, spacing: 10) {
          Text("在不同容器中的使用")
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("HelpLink 在特定容器中会自动定位到约定的位置")
            .font(.body)
            .foregroundColor(.secondary)
        }

        Divider()

        // 示例 1：在 Alert 中使用
        GroupBox("1. 在 Alert 中使用") {
          VStack(alignment: .leading, spacing: 15) {
            Text("在 Alert 的 actions 中使用 HelpLink，会自动定位到右上角")
              .font(.body)

            Button("显示带帮助的 Alert") {
              showingAlert = true
            }
            .buttonStyle(.borderedProminent)

            // 代码示例
            codeExample(
              """
              .alert("设置错误", isPresented: $showingAlert) {
                  Button("确定") { }
                  Button("取消", role: .cancel) { }
                  HelpLink(destination: URL(string: "https://example.com/help")!)
              }
              """)
          }
          .padding()
        }

        // 示例 2：在 Sheet 工具栏中使用
        GroupBox("2. 在 Sheet 工具栏中使用") {
          VStack(alignment: .leading, spacing: 15) {
            Text("在 Sheet 的工具栏中使用 HelpLink，会自动定位到左下角")
              .font(.body)

            Button("显示带帮助的 Sheet") {
              showingSheet = true
            }
            .buttonStyle(.borderedProminent)

            // 代码示例
            codeExample(
              """
              .sheet(isPresented: $showingSheet) {
                  SheetContentView()
                      .toolbar {
                          ToolbarItem(.confirmationAction) {
                              Button("保存") { }
                          }
                          ToolbarItem {
                              HelpLink(anchor: "sheetHelp")
                          }
                      }
              }
              """)
          }
          .padding()
        }

        // 示例 3：在 ConfirmationDialog 中使用
        GroupBox("3. 在 ConfirmationDialog 中使用") {
          VStack(alignment: .leading, spacing: 15) {
            Text("在确认对话框中提供帮助链接")
              .font(.body)

            Button("显示确认对话框") {
              showingConfirmationDialog = true
            }
            .buttonStyle(.borderedProminent)

            // 代码示例
            codeExample(
              """
              .confirmationDialog("删除文件", isPresented: $showingDialog) {
                  Button("删除", role: .destructive) { }
                  Button("取消", role: .cancel) { }
                  HelpLink(destination: URL(string: "https://example.com/delete-help")!)
              }
              """)
          }
          .padding()
        }

        // 示例 4：在 Form 中使用
        GroupBox("4. 在 Form 中使用") {
          VStack(alignment: .leading, spacing: 15) {
            Text("在表单中为特定字段提供帮助")
              .font(.body)

            Form {
              Section {
                HStack {
                  TextField("用户名", text: $formData.username)
                  HelpLink {
                    // 显示用户名帮助
                    showUsernameHelp()
                  }
                }

                HStack {
                  SecureField("密码", text: $formData.password)
                  HelpLink(destination: URL(string: "https://example.com/password-help")!)
                }

                HStack {
                  TextField("邮箱", text: $formData.email)
                  HelpLink(anchor: "emailHelp")
                }
              } header: {
                Text("账户信息")
              }
            }
            .frame(height: 150)

            // 代码示例
            codeExample(
              """
              Form {
                  Section("账户信息") {
                      HStack {
                          TextField("用户名", text: $username)
                          HelpLink { showUsernameHelp() }
                      }
                  }
              }
              """)
          }
          .padding()
        }

        // 示例 5：在自定义容器中使用
        GroupBox("5. 在自定义容器中使用") {
          VStack(alignment: .leading, spacing: 15) {
            Text("在自定义的 UI 容器中灵活使用 HelpLink")
              .font(.body)

            // 自定义设置面板
            VStack(spacing: 15) {
              // 设置项 1
              settingRow(
                title: "自动保存",
                description: "每 5 分钟自动保存文档",
                helpAction: { showAutoSaveHelp() }
              )

              // 设置项 2
              settingRow(
                title: "云同步",
                description: "将文档同步到 iCloud",
                helpURL: "https://support.apple.com/icloud"
              )

              // 设置项 3
              settingRow(
                title: "通知设置",
                description: "配置应用通知偏好",
                helpAnchor: "notificationHelp"
              )
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(10)

            // 代码示例
            codeExample(
              """
              HStack {
                  VStack(alignment: .leading) {
                      Text("设置标题")
                      Text("设置描述").font(.caption)
                  }
                  Spacer()
                  HelpLink(destination: helpURL)
              }
              """)
          }
          .padding()
        }

        // 布局和定位说明
        GroupBox("自动定位说明") {
          VStack(alignment: .leading, spacing: 10) {
            layoutInfo(
              container: "Alert",
              position: "右上角",
              description: "在警告框的操作按钮区域自动定位"
            )

            layoutInfo(
              container: "Sheet 工具栏",
              position: "左下角",
              description: "在工具栏的标准帮助位置显示"
            )

            layoutInfo(
              container: "ConfirmationDialog",
              position: "操作列表中",
              description: "作为对话框的一个操作选项"
            )

            layoutInfo(
              container: "其他容器",
              position: "内联显示",
              description: "在容器内按正常布局规则显示"
            )
          }
          .padding()
        }
      }
      .padding()
    }
    .navigationTitle("不同容器中的使用")
    .alert("设置错误", isPresented: $showingAlert) {
      Button("确定") {}
      Button("取消", role: .cancel) {}
      HelpLink(destination: URL(string: "https://developer.apple.com/documentation/swiftui/alert")!)
    } message: {
      Text("无法保存设置，请检查输入的信息是否正确。")
    }
    .sheet(isPresented: $showingSheet) {
      SheetContentView()
    }
    .confirmationDialog("删除所有数据", isPresented: $showingConfirmationDialog) {
      Button("删除", role: .destructive) {}
      Button("取消", role: .cancel) {}
      HelpLink(destination: URL(string: "https://support.apple.com/data-recovery")!)
    } message: {
      Text("此操作将永久删除所有数据，无法恢复。")
    }
  }

  // 辅助方法：创建设置行
  private func settingRow(
    title: String, description: String, helpAction: (() -> Void)? = nil, helpURL: String? = nil,
    helpAnchor: String? = nil
  ) -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 2) {
        Text(title)
          .font(.body)
          .fontWeight(.medium)

        Text(description)
          .font(.caption)
          .foregroundColor(.secondary)
      }

      Spacer()

      // 根据不同参数创建不同类型的 HelpLink
      if let action = helpAction {
        HelpLink(action: action)
      } else if let urlString = helpURL, let url = URL(string: urlString) {
        HelpLink(destination: url)
      } else if let anchor = helpAnchor {
        HelpLink(anchor: anchor)
      }
    }
    .padding(.vertical, 5)
  }

  // 辅助方法：创建布局信息
  private func layoutInfo(container: String, position: String, description: String) -> some View {
    HStack(alignment: .top, spacing: 10) {
      Image(systemName: "location.circle.fill")
        .foregroundColor(.blue)
        .frame(width: 20)

      VStack(alignment: .leading, spacing: 2) {
        HStack {
          Text(container)
            .font(.caption)
            .fontWeight(.semibold)

          Text("→ \(position)")
            .font(.caption)
            .foregroundColor(.blue)
        }

        Text(description)
          .font(.caption2)
          .foregroundColor(.secondary)
      }
    }
  }

  // 辅助方法：创建代码示例
  private func codeExample(_ code: String) -> some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("代码示例：")
        .font(.caption)
        .fontWeight(.semibold)

      Text(code)
        .font(.system(.caption, design: .monospaced))
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(4)
    }
  }

  // 帮助方法
  private func showUsernameHelp() {
    // 显示用户名帮助信息
    print("显示用户名帮助")
  }

  private func showAutoSaveHelp() {
    // 显示自动保存帮助信息
    print("显示自动保存帮助")
  }
}

// 表单数据模型
@available(macOS 14.0, *)
private struct FormData {
  var username = ""
  var password = ""
  var email = ""
}

// Sheet 内容视图
@available(macOS 14.0, *)
private struct SheetContentView: View {
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationView {
      Form {
        Section("文档设置") {
          Toggle("启用自动保存", isOn: .constant(true))
          Toggle("启用版本控制", isOn: .constant(false))
          Toggle("启用云同步", isOn: .constant(true))
        }

        Section("导出选项") {
          Picker("格式", selection: .constant("PDF")) {
            Text("PDF").tag("PDF")
            Text("Word").tag("Word")
            Text("HTML").tag("HTML")
          }

          Toggle("包含图片", isOn: .constant(true))
          Toggle("包含注释", isOn: .constant(false))
        }
      }
      .navigationTitle("文档设置")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("保存") {
            dismiss()
          }
        }

        ToolbarItem(placement: .cancellationAction) {
          Button("取消") {
            dismiss()
          }
        }

        ToolbarItem {
          HelpLink(
            destination: URL(string: "https://developer.apple.com/documentation/swiftui/sheet")!)
        }
      }
    }
    .frame(width: 400, height: 300)
  }
}

// 预览
@available(macOS 14.0, *)
#Preview {
  HelpLinkExampleView03()
    .frame(width: 800, height: 600)
}
