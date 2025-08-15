import SwiftUI

/// HelpLink 实际应用场景示例
///
/// 本示例展示了 HelpLink 在实际应用中的使用场景：
/// 1. 应用设置界面
/// 2. 错误处理和故障排除
/// 3. 功能介绍和新手引导
/// 4. 复杂表单的字段帮助
/// 5. 开发者工具和调试界面
@available(macOS 14.0, *)
struct HelpLinkExampleView04: View {
  @State private var appSettings = AppSettings()
  @State private var showingErrorAlert = false
  @State private var showingOnboarding = false
  @State private var debugMode = false
  @State private var selectedTab = 0

  var body: some View {
    TabView(selection: $selectedTab) {
      // Tab 1: 应用设置
      settingsView()
        .tabItem {
          Image(systemName: "gear")
          Text("设置")
        }
        .tag(0)

      // Tab 2: 错误处理
      errorHandlingView()
        .tabItem {
          Image(systemName: "exclamationmark.triangle")
          Text("错误处理")
        }
        .tag(1)

      // Tab 3: 新手引导
      onboardingView()
        .tabItem {
          Image(systemName: "person.crop.circle.badge.questionmark")
          Text("新手引导")
        }
        .tag(2)

      // Tab 4: 开发者工具
      developerToolsView()
        .tabItem {
          Image(systemName: "hammer")
          Text("开发者工具")
        }
        .tag(3)
    }
    .navigationTitle("实际应用场景")
  }

  // MARK: - 应用设置界面
  private func settingsView() -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("应用设置")
          .font(.largeTitle)
          .fontWeight(.bold)

        // 通用设置
        GroupBox("通用设置") {
          VStack(spacing: 15) {
            settingRow(
              title: "启动时显示欢迎界面",
              binding: $appSettings.showWelcomeScreen,
              helpURL: "https://example.com/help/welcome-screen"
            )

            settingRow(
              title: "自动检查更新",
              binding: $appSettings.autoCheckUpdates,
              helpAnchor: "autoUpdateHelp"
            )

            settingRow(
              title: "发送匿名使用统计",
              binding: $appSettings.sendAnalytics,
              helpAction: { showAnalyticsHelp() }
            )
          }
          .padding()
        }

        // 高级设置
        GroupBox("高级设置") {
          VStack(spacing: 15) {
            HStack {
              VStack(alignment: .leading) {
                Text("缓存大小限制")
                  .fontWeight(.medium)
                Text("设置应用缓存的最大大小")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              Picker("", selection: $appSettings.cacheSize) {
                Text("100 MB").tag(100)
                Text("500 MB").tag(500)
                Text("1 GB").tag(1000)
                Text("无限制").tag(-1)
              }
              .frame(width: 120)

              HelpLink(destination: URL(string: "https://example.com/help/cache-management")!)
            }

            HStack {
              VStack(alignment: .leading) {
                Text("网络超时设置")
                  .fontWeight(.medium)
                Text("网络请求的超时时间（秒）")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              TextField("超时时间", value: $appSettings.networkTimeout, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 80)

              HelpLink {
                showNetworkTimeoutHelp()
              }
            }
          }
          .padding()
        }

        // 代码示例
        codeExampleBox(
          """
          // 在设置界面中使用 HelpLink
          HStack {
              Toggle("启用功能", isOn: $setting)
              HelpLink(destination: URL(string: "https://help.example.com/feature")!)
          }
          """)
      }
      .padding()
    }
  }

  // MARK: - 错误处理界面
  private func errorHandlingView() -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("错误处理和故障排除")
          .font(.largeTitle)
          .fontWeight(.bold)

        // 常见错误
        GroupBox("常见错误") {
          VStack(spacing: 15) {
            errorItem(
              icon: "wifi.slash",
              title: "网络连接错误",
              description: "无法连接到服务器",
              helpURL: "https://support.example.com/network-issues"
            )

            errorItem(
              icon: "externaldrive.badge.xmark",
              title: "文件访问错误",
              description: "无法读取或写入文件",
              helpAnchor: "fileAccessHelp"
            )

            errorItem(
              icon: "memorychip.fill",
              title: "内存不足",
              description: "应用内存使用过高",
              helpAction: { showMemoryHelp() }
            )
          }
          .padding()
        }

        // 故障排除工具
        GroupBox("故障排除工具") {
          VStack(spacing: 15) {
            Button("显示网络错误示例") {
              showingErrorAlert = true
            }
            .buttonStyle(.borderedProminent)

            HStack {
              Text("系统诊断报告")
              Spacer()
              Button("生成报告") {
                generateDiagnosticReport()
              }
              HelpLink(destination: URL(string: "https://support.example.com/diagnostic-reports")!)
            }

            HStack {
              Text("重置应用设置")
              Spacer()
              Button("重置", role: .destructive) {
                resetAppSettings()
              }
              HelpLink {
                showResetHelp()
              }
            }
          }
          .padding()
        }

        // 代码示例
        codeExampleBox(
          """
          // 在错误处理中使用 HelpLink
          .alert("网络错误", isPresented: $showingError) {
              Button("重试") { retry() }
              Button("取消", role: .cancel) { }
              HelpLink(destination: URL(string: "https://support.example.com/network")!)
          } message: {
              Text("无法连接到服务器，请检查网络设置。")
          }
          """)
      }
      .padding()
    }
    .alert("网络连接失败", isPresented: $showingErrorAlert) {
      Button("重试") {}
      Button("取消", role: .cancel) {}
      HelpLink(destination: URL(string: "https://support.example.com/network-troubleshooting")!)
    } message: {
      Text("无法连接到服务器。请检查您的网络连接并重试。")
    }
  }

  // MARK: - 新手引导界面
  private func onboardingView() -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("新手引导和功能介绍")
          .font(.largeTitle)
          .fontWeight(.bold)

        // 功能介绍卡片
        GroupBox("主要功能") {
          VStack(spacing: 15) {
            featureCard(
              icon: "doc.text",
              title: "文档管理",
              description: "创建、编辑和组织您的文档",
              helpURL: "https://help.example.com/document-management"
            )

            featureCard(
              icon: "icloud",
              title: "云同步",
              description: "在所有设备间同步您的数据",
              helpAnchor: "cloudSyncHelp"
            )

            featureCard(
              icon: "person.2",
              title: "协作功能",
              description: "与团队成员实时协作",
              helpAction: { showCollaborationHelp() }
            )
          }
          .padding()
        }

        // 快速开始
        GroupBox("快速开始") {
          VStack(spacing: 15) {
            HStack {
              VStack(alignment: .leading) {
                Text("创建您的第一个项目")
                  .fontWeight(.medium)
                Text("跟随向导创建新项目")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              Button("开始") {
                startProjectWizard()
              }
              .buttonStyle(.borderedProminent)

              HelpLink(destination: URL(string: "https://help.example.com/getting-started")!)
            }

            HStack {
              VStack(alignment: .leading) {
                Text("导入现有数据")
                  .fontWeight(.medium)
                Text("从其他应用导入您的数据")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              Button("导入") {
                showImportDialog()
              }

              HelpLink(anchor: "dataImportHelp")
            }
          }
          .padding()
        }

        // 代码示例
        codeExampleBox(
          """
          // 在新手引导中使用 HelpLink
          VStack {
              Text("功能介绍")
              Text("详细描述...")
              HStack {
                  Button("下一步") { }
                  HelpLink(destination: URL(string: "https://help.example.com/tutorial")!)
              }
          }
          """)
      }
      .padding()
    }
  }

  // MARK: - 开发者工具界面
  private func developerToolsView() -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("开发者工具")
          .font(.largeTitle)
          .fontWeight(.bold)

        // 调试工具
        GroupBox("调试工具") {
          VStack(spacing: 15) {
            HStack {
              Toggle("调试模式", isOn: $debugMode)
              Spacer()
              HelpLink(destination: URL(string: "https://developer.example.com/debug-mode")!)
            }

            HStack {
              Text("日志级别")
              Spacer()
              Picker("", selection: .constant("Info")) {
                Text("Error").tag("Error")
                Text("Warning").tag("Warning")
                Text("Info").tag("Info")
                Text("Debug").tag("Debug")
              }
              .frame(width: 100)
              HelpLink(anchor: "logLevelHelp")
            }

            HStack {
              Button("导出日志") {
                exportLogs()
              }
              Spacer()
              HelpLink {
                showLogExportHelp()
              }
            }
          }
          .padding()
        }

        // API 测试工具
        GroupBox("API 测试工具") {
          VStack(spacing: 15) {
            HStack {
              Text("API 端点")
              TextField("URL", text: .constant("https://api.example.com"))
                .textFieldStyle(.roundedBorder)
              HelpLink(destination: URL(string: "https://developer.example.com/api-testing")!)
            }

            HStack {
              Button("测试连接") {
                testAPIConnection()
              }
              Button("查看文档") {
                openAPIDocumentation()
              }
              Spacer()
              HelpLink(anchor: "apiDocumentationHelp")
            }
          }
          .padding()
        }

        // 性能监控
        GroupBox("性能监控") {
          VStack(spacing: 15) {
            HStack {
              Text("内存使用: 245 MB")
              Spacer()
              HelpLink(destination: URL(string: "https://developer.example.com/memory-profiling")!)
            }

            HStack {
              Text("CPU 使用: 12%")
              Spacer()
              HelpLink(anchor: "cpuProfilingHelp")
            }

            HStack {
              Button("生成性能报告") {
                generatePerformanceReport()
              }
              Spacer()
              HelpLink {
                showPerformanceHelp()
              }
            }
          }
          .padding()
        }

        // 代码示例
        codeExampleBox(
          """
          // 在开发者工具中使用 HelpLink
          HStack {
              Toggle("启用调试", isOn: $debugMode)
              HelpLink(destination: URL(string: "https://dev.example.com/debug")!)
          }
          """)
      }
      .padding()
    }
  }

  // MARK: - 辅助方法

  private func settingRow(
    title: String, binding: Binding<Bool>, helpURL: String? = nil, helpAnchor: String? = nil,
    helpAction: (() -> Void)? = nil
  ) -> some View {
    HStack {
      Toggle(title, isOn: binding)
      Spacer()

      if let urlString = helpURL, let url = URL(string: urlString) {
        HelpLink(destination: url)
      } else if let anchor = helpAnchor {
        HelpLink(anchor: anchor)
      } else if let action = helpAction {
        HelpLink(action: action)
      }
    }
  }

  private func errorItem(
    icon: String, title: String, description: String, helpURL: String? = nil,
    helpAnchor: String? = nil, helpAction: (() -> Void)? = nil
  ) -> some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(.red)
        .frame(width: 30)

      VStack(alignment: .leading) {
        Text(title)
          .fontWeight(.medium)
        Text(description)
          .font(.caption)
          .foregroundColor(.secondary)
      }

      Spacer()

      if let urlString = helpURL, let url = URL(string: urlString) {
        HelpLink(destination: url)
      } else if let anchor = helpAnchor {
        HelpLink(anchor: anchor)
      } else if let action = helpAction {
        HelpLink(action: action)
      }
    }
  }

  private func featureCard(
    icon: String, title: String, description: String, helpURL: String? = nil,
    helpAnchor: String? = nil, helpAction: (() -> Void)? = nil
  ) -> some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(.blue)
        .frame(width: 30)

      VStack(alignment: .leading) {
        Text(title)
          .fontWeight(.medium)
        Text(description)
          .font(.caption)
          .foregroundColor(.secondary)
      }

      Spacer()

      if let urlString = helpURL, let url = URL(string: urlString) {
        HelpLink(destination: url)
      } else if let anchor = helpAnchor {
        HelpLink(anchor: anchor)
      } else if let action = helpAction {
        HelpLink(action: action)
      }
    }
    .padding()
    .background(Color.blue.opacity(0.05))
    .cornerRadius(8)
  }

  private func codeExampleBox(_ code: String) -> some View {
    GroupBox("代码示例") {
      Text(code)
        .font(.system(.caption, design: .monospaced))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(4)
    }
  }

  // MARK: - 帮助方法

  private func showAnalyticsHelp() {
    print("显示分析数据帮助")
  }

  private func showNetworkTimeoutHelp() {
    print("显示网络超时帮助")
  }

  private func showMemoryHelp() {
    print("显示内存管理帮助")
  }

  private func showResetHelp() {
    print("显示重置设置帮助")
  }

  private func showCollaborationHelp() {
    print("显示协作功能帮助")
  }

  private func showLogExportHelp() {
    print("显示日志导出帮助")
  }

  private func showPerformanceHelp() {
    print("显示性能监控帮助")
  }

  private func generateDiagnosticReport() {
    print("生成诊断报告")
  }

  private func resetAppSettings() {
    print("重置应用设置")
  }

  private func startProjectWizard() {
    print("启动项目向导")
  }

  private func showImportDialog() {
    print("显示导入对话框")
  }

  private func exportLogs() {
    print("导出日志")
  }

  private func testAPIConnection() {
    print("测试 API 连接")
  }

  private func openAPIDocumentation() {
    print("打开 API 文档")
  }

  private func generatePerformanceReport() {
    print("生成性能报告")
  }
}

// 应用设置数据模型
@available(macOS 14.0, *)
private struct AppSettings {
  var showWelcomeScreen = true
  var autoCheckUpdates = true
  var sendAnalytics = false
  var cacheSize = 500
  var networkTimeout = 30
}

// 预览
@available(macOS 14.0, *)
#Preview {
  HelpLinkExampleView04()
    .frame(width: 900, height: 700)
}
