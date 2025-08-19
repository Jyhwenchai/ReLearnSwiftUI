import SwiftUI

/// 嵌套菜单结构示例
///
/// 展示如何创建复杂的嵌套菜单结构：
/// - 多级子菜单
/// - 菜单中的菜单
/// - 复杂的菜单层次结构
public struct CommandMenuExampleView04: View {
  @State private var selectedTheme: String = "系统默认"
  @State private var selectedLanguage: String = "中文"
  @State private var selectedFormat: String = "未选择"
  @State private var recentFiles: [String] = ["文档1.txt", "项目2.md", "笔记3.rtf"]

  public init() {}

  public var body: some View {
    VStack(spacing: 20) {
      Text("嵌套菜单结构")
        .font(.largeTitle)
        .padding()

      VStack(alignment: .leading, spacing: 10) {
        Text("当前主题: \(selectedTheme)")
        Text("当前语言: \(selectedLanguage)")
        Text("导出格式: \(selectedFormat)")

        Text("最近文件:")
        ForEach(recentFiles, id: \.self) { file in
          Text("• \(file)")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(10)

      VStack(alignment: .leading, spacing: 8) {
        Text("嵌套菜单特点:")
          .font(.headline)

        Text("• 可以创建多级子菜单")
        Text("• 使用 Menu 组件创建子菜单")
        Text("• 支持无限层级嵌套")
        Text("• 每个子菜单可以有自己的快捷键")
        Text("• 可以在子菜单中使用分隔符")
      }
      .font(.caption)
      .foregroundColor(.secondary)

      Spacer()
    }
    .padding()
    .navigationTitle("嵌套菜单")

  }
}

/// 演示嵌套菜单结构的 App
struct NestedMenuExampleApp04: App {
  @State private var selectedTheme = "系统默认"
  @State private var selectedLanguage = "中文"
  @State private var recentFiles = ["文档1.txt", "项目2.md", "笔记3.rtf"]

  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView04()
    }
    .commands {
      // 1. 文件菜单 - 包含复杂的嵌套结构
      CommandMenu("文件") {
        Button("新建") {
          print("新建文件")
        }
        .keyboardShortcut("n", modifiers: .command)

        // 新建子菜单
        Menu("新建...") {
          Button("文本文档") {
            print("新建文本文档")
          }
          .keyboardShortcut("n", modifiers: [.command, .shift])

          Button("Markdown 文档") {
            print("新建 Markdown 文档")
          }

          Button("富文本文档") {
            print("新建富文本文档")
          }

          Divider()

          // 模板子菜单
          Menu("从模板新建") {
            Button("简历模板") {
              print("使用简历模板")
            }

            Button("报告模板") {
              print("使用报告模板")
            }

            Button("信件模板") {
              print("使用信件模板")
            }

            Divider()

            // 更深层的嵌套
            Menu("专业模板") {
              Button("学术论文") {
                print("学术论文模板")
              }

              Button("商业计划书") {
                print("商业计划书模板")
              }

              Button("技术文档") {
                print("技术文档模板")
              }
            }
          }
        }

        Divider()

        Button("打开") {
          print("打开文件")
        }
        .keyboardShortcut("o", modifiers: .command)

        // 最近文件子菜单
        Menu("最近打开") {
          ForEach(recentFiles, id: \.self) { file in
            Button(file) {
              print("打开最近文件: \(file)")
            }
          }

          if !recentFiles.isEmpty {
            Divider()

            Button("清除最近文件") {
              recentFiles.removeAll()
              print("清除最近文件列表")
            }
          }
        }

        Divider()

        // 导入子菜单
        Menu("导入") {
          Button("导入文本文件") {
            print("导入文本文件")
          }

          Button("导入 Word 文档") {
            print("导入 Word 文档")
          }

          Button("导入 PDF") {
            print("导入 PDF")
          }

          Divider()

          // 从云服务导入
          Menu("从云服务导入") {
            Button("从 iCloud 导入") {
              print("从 iCloud 导入")
            }

            Button("从 Dropbox 导入") {
              print("从 Dropbox 导入")
            }

            Button("从 Google Drive 导入") {
              print("从 Google Drive 导入")
            }
          }
        }

        // 导出子菜单
        Menu("导出") {
          Button("导出为 PDF") {
            print("导出为 PDF")
          }
          .keyboardShortcut("e", modifiers: .command)

          Button("导出为 Word") {
            print("导出为 Word")
          }

          Button("导出为 HTML") {
            print("导出为 HTML")
          }

          Divider()

          // 高级导出选项
          Menu("高级导出") {
            Button("导出为图片") {
              print("导出为图片")
            }

            Menu("导出格式") {
              Button("PNG 格式") {
                print("导出为 PNG")
              }

              Button("JPEG 格式") {
                print("导出为 JPEG")
              }

              Button("SVG 格式") {
                print("导出为 SVG")
              }
            }

            Divider()

            Button("批量导出") {
              print("批量导出文件")
            }
          }
        }
      }

      // 2. 视图菜单 - 主题和外观设置
      CommandMenu("视图") {
        // 主题子菜单
        Menu("主题") {
          Button("浅色主题") {
            selectedTheme = "浅色"
            print("切换到浅色主题")
          }

          Button("深色主题") {
            selectedTheme = "深色"
            print("切换到深色主题")
          }

          Button("系统默认") {
            selectedTheme = "系统默认"
            print("使用系统默认主题")
          }

          Divider()

          // 自定义主题
          Menu("自定义主题") {
            Button("蓝色主题") {
              selectedTheme = "蓝色"
              print("应用蓝色主题")
            }

            Button("绿色主题") {
              selectedTheme = "绿色"
              print("应用绿色主题")
            }

            Button("紫色主题") {
              selectedTheme = "紫色"
              print("应用紫色主题")
            }

            Divider()

            Button("创建自定义主题") {
              print("打开主题编辑器")
            }
          }
        }

        Divider()

        // 布局子菜单
        Menu("布局") {
          Button("单栏布局") {
            print("切换到单栏布局")
          }

          Button("双栏布局") {
            print("切换到双栏布局")
          }

          Button("三栏布局") {
            print("切换到三栏布局")
          }

          Divider()

          Menu("侧边栏") {
            Button("显示左侧边栏") {
              print("显示左侧边栏")
            }
            .keyboardShortcut("1", modifiers: [.command, .option])

            Button("显示右侧边栏") {
              print("显示右侧边栏")
            }
            .keyboardShortcut("2", modifiers: [.command, .option])

            Button("隐藏所有侧边栏") {
              print("隐藏所有侧边栏")
            }
            .keyboardShortcut("0", modifiers: [.command, .option])
          }
        }

        // 缩放子菜单
        Menu("缩放") {
          Button("放大") {
            print("放大视图")
          }
          .keyboardShortcut("+", modifiers: .command)

          Button("缩小") {
            print("缩小视图")
          }
          .keyboardShortcut("-", modifiers: .command)

          Button("实际大小") {
            print("恢复实际大小")
          }
          .keyboardShortcut("0", modifiers: .command)

          Divider()

          Menu("预设缩放") {
            Button("50%") {
              print("缩放到 50%")
            }

            Button("75%") {
              print("缩放到 75%")
            }

            Button("100%") {
              print("缩放到 100%")
            }

            Button("125%") {
              print("缩放到 125%")
            }

            Button("150%") {
              print("缩放到 150%")
            }

            Button("200%") {
              print("缩放到 200%")
            }
          }
        }
      }

      // 3. 工具菜单 - 语言和工具设置
      CommandMenu("工具") {
        // 语言子菜单
        Menu("语言") {
          Button("中文") {
            selectedLanguage = "中文"
            print("切换到中文")
          }

          Button("English") {
            selectedLanguage = "English"
            print("Switch to English")
          }

          Button("日本語") {
            selectedLanguage = "日本語"
            print("日本語に切り替え")
          }

          Button("Français") {
            selectedLanguage = "Français"
            print("Passer au français")
          }

          Divider()

          Button("更多语言...") {
            print("显示更多语言选项")
          }
        }

        Divider()

        // 开发工具子菜单
        Menu("开发工具") {
          Button("代码格式化") {
            print("格式化代码")
          }
          .keyboardShortcut("f", modifiers: [.command, .shift])

          Button("语法检查") {
            print("运行语法检查")
          }

          Menu("代码生成") {
            Button("生成注释") {
              print("生成代码注释")
            }

            Button("生成测试") {
              print("生成单元测试")
            }

            Button("生成文档") {
              print("生成API文档")
            }
          }

          Divider()

          Menu("版本控制") {
            Button("提交更改") {
              print("提交Git更改")
            }

            Button("推送到远程") {
              print("推送到远程仓库")
            }

            Button("拉取更新") {
              print("拉取远程更新")
            }

            Divider()

            Menu("分支操作") {
              Button("创建分支") {
                print("创建新分支")
              }

              Button("切换分支") {
                print("切换分支")
              }

              Button("合并分支") {
                print("合并分支")
              }
            }
          }
        }
      }
    }
  }
}

#Preview {
  CommandMenuExampleView04()
}
