import SwiftUI

/// 实际应用场景示例
///
/// 展示 CommandMenu 在真实应用中的使用场景：
/// - 文本编辑器应用的菜单结构
/// - 图片编辑应用的工具菜单
/// - 项目管理应用的操作菜单
public struct CommandMenuExampleView06: View {
  @State private var currentApp: AppType = .textEditor
  @State private var documentCount: Int = 0
  @State private var projectCount: Int = 0
  @State private var imageCount: Int = 0

  public init() {}

  enum AppType: String, CaseIterable {
    case textEditor = "文本编辑器"
    case imageEditor = "图片编辑器"
    case projectManager = "项目管理器"
  }

  public var body: some View {
    VStack(spacing: 20) {
      Text("实际应用场景")
        .font(.largeTitle)
        .padding()

      Picker("应用类型", selection: $currentApp) {
        ForEach(AppType.allCases, id: \.self) { app in
          Text(app.rawValue).tag(app)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      .padding()

      VStack(alignment: .leading, spacing: 10) {
        Text("当前应用: \(currentApp.rawValue)")

        switch currentApp {
        case .textEditor:
          Text("文档数量: \(documentCount)")
          Text("功能: 文本编辑、格式化、导出")
        case .imageEditor:
          Text("图片数量: \(imageCount)")
          Text("功能: 图片编辑、滤镜、导出")
        case .projectManager:
          Text("项目数量: \(projectCount)")
          Text("功能: 项目管理、任务跟踪、团队协作")
        }
      }
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(10)

      VStack(alignment: .leading, spacing: 8) {
        Text("应用场景特点:")
          .font(.headline)

        Text("• 根据应用类型提供专业的菜单结构")
        Text("• 集成常用的工作流程和快捷操作")
        Text("• 提供符合用户习惯的键盘快捷键")
        Text("• 支持专业工具的复杂操作")
      }
      .font(.caption)
      .foregroundColor(.secondary)

      Spacer()
    }
    .padding()
    .navigationTitle("实际应用")
    .navigationBarTitleDisplayMode(.inline)
  }
}

/// 文本编辑器应用的菜单结构
struct TextEditorApp: App {
  @State private var documentCount = 0
  @State private var wordCount = 0
  @State private var isSpellCheckEnabled = true
  @State private var currentFont = "系统字体"

  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView06()
    }
    .commands {
      // 文件菜单
      CommandGroup(replacing: .newItem) {
        Button("新建文档") {
          documentCount += 1
          print("创建新文档，总数: \(documentCount)")
        }
        .keyboardShortcut("n", modifiers: .command)

        Button("新建模板") {
          print("从模板创建文档")
        }
        .keyboardShortcut("n", modifiers: [.command, .shift])
      }

      CommandGroup(after: .saveItem) {
        Button("导出为 PDF") {
          print("导出当前文档为 PDF")
        }
        .keyboardShortcut("e", modifiers: .command)

        Button("导出为 Word") {
          print("导出当前文档为 Word")
        }

        Button("发送邮件") {
          print("通过邮件发送文档")
        }
        .keyboardShortcut("m", modifiers: [.command, .shift])
      }

      // 编辑菜单扩展
      CommandGroup(after: .textEditing) {
        Divider()

        Button("查找和替换") {
          print("打开查找替换对话框")
        }
        .keyboardShortcut("f", modifiers: .command)

        Button("跳转到行") {
          print("跳转到指定行")
        }
        .keyboardShortcut("l", modifiers: .command)

        Button("选择全部") {
          print("选择全部文本")
        }
        .keyboardShortcut("a", modifiers: .command)
      }

      // 格式菜单
      CommandMenu("格式") {
        Menu("字体") {
          Button("系统字体") {
            currentFont = "系统字体"
            print("设置字体为系统字体")
          }

          Button("Times New Roman") {
            currentFont = "Times New Roman"
            print("设置字体为 Times New Roman")
          }

          Button("Helvetica") {
            currentFont = "Helvetica"
            print("设置字体为 Helvetica")
          }

          Divider()

          Button("更多字体...") {
            print("打开字体选择器")
          }
        }

        Menu("字体大小") {
          Button("增大字体") {
            print("增大字体大小")
          }
          .keyboardShortcut("+", modifiers: .command)

          Button("减小字体") {
            print("减小字体大小")
          }
          .keyboardShortcut("-", modifiers: .command)

          Divider()

          ForEach([12, 14, 16, 18, 24, 36], id: \.self) { size in
            Button("\(size) pt") {
              print("设置字体大小为 \(size)")
            }
          }
        }

        Divider()

        Button("粗体") {
          print("切换粗体")
        }
        .keyboardShortcut("b", modifiers: .command)

        Button("斜体") {
          print("切换斜体")
        }
        .keyboardShortcut("i", modifiers: .command)

        Button("下划线") {
          print("切换下划线")
        }
        .keyboardShortcut("u", modifiers: .command)

        Divider()

        Menu("段落") {
          Button("左对齐") {
            print("设置左对齐")
          }
          .keyboardShortcut("l", modifiers: [.command, .shift])

          Button("居中对齐") {
            print("设置居中对齐")
          }
          .keyboardShortcut("e", modifiers: [.command, .shift])

          Button("右对齐") {
            print("设置右对齐")
          }
          .keyboardShortcut("r", modifiers: [.command, .shift])

          Button("两端对齐") {
            print("设置两端对齐")
          }
          .keyboardShortcut("j", modifiers: [.command, .shift])
        }
      }

      // 工具菜单
      CommandMenu("工具") {
        Button("字数统计") {
          wordCount = Int.random(in: 100...5000)
          print("当前字数: \(wordCount)")
        }
        .keyboardShortcut("w", modifiers: [.command, .shift])

        Button(isSpellCheckEnabled ? "禁用拼写检查" : "启用拼写检查") {
          isSpellCheckEnabled.toggle()
          print("拼写检查: \(isSpellCheckEnabled ? "启用" : "禁用")")
        }
        .keyboardShortcut(":", modifiers: .command)

        Button("语法检查") {
          print("运行语法检查")
        }

        Divider()

        Menu("插入") {
          Button("插入日期") {
            print("插入当前日期")
          }

          Button("插入时间") {
            print("插入当前时间")
          }

          Button("插入页码") {
            print("插入页码")
          }

          Divider()

          Button("插入表格") {
            print("插入表格")
          }

          Button("插入图片") {
            print("插入图片")
          }

          Button("插入链接") {
            print("插入超链接")
          }
        }

        Menu("自动化") {
          Button("自动保存") {
            print("启用自动保存")
          }

          Button("自动备份") {
            print("启用自动备份")
          }

          Button("版本历史") {
            print("查看版本历史")
          }
        }
      }
    }
  }
}

/// 图片编辑器应用的菜单结构
struct ImageEditorApp: App {
  @State private var imageCount = 0
  @State private var currentTool = "选择工具"
  @State private var zoomLevel = 100

  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView06()
    }
    .commands {
      // 文件菜单
      CommandGroup(replacing: .newItem) {
        Button("新建图片") {
          imageCount += 1
          print("创建新图片，总数: \(imageCount)")
        }
        .keyboardShortcut("n", modifiers: .command)

        Button("从剪贴板新建") {
          print("从剪贴板创建图片")
        }
        .keyboardShortcut("n", modifiers: [.command, .shift])
      }

      CommandGroup(after: .importExport) {
        Button("批量处理") {
          print("打开批量处理工具")
        }

        Button("导出为网页") {
          print("导出为网页格式")
        }
      }

      // 编辑菜单
      CommandMenu("编辑") {
        Button("撤销") {
          print("撤销上一步操作")
        }
        .keyboardShortcut("z", modifiers: .command)

        Button("重做") {
          print("重做操作")
        }
        .keyboardShortcut("z", modifiers: [.command, .shift])

        Divider()

        Button("剪切") {
          print("剪切选中内容")
        }
        .keyboardShortcut("x", modifiers: .command)

        Button("复制") {
          print("复制选中内容")
        }
        .keyboardShortcut("c", modifiers: .command)

        Button("粘贴") {
          print("粘贴内容")
        }
        .keyboardShortcut("v", modifiers: .command)

        Divider()

        Menu("变换") {
          Button("旋转 90°") {
            print("顺时针旋转 90 度")
          }
          .keyboardShortcut("r", modifiers: .command)

          Button("旋转 -90°") {
            print("逆时针旋转 90 度")
          }
          .keyboardShortcut("r", modifiers: [.command, .shift])

          Button("水平翻转") {
            print("水平翻转图片")
          }

          Button("垂直翻转") {
            print("垂直翻转图片")
          }

          Divider()

          Button("自由变换") {
            print("启用自由变换工具")
          }
          .keyboardShortcut("t", modifiers: .command)
        }
      }

      // 图像菜单
      CommandMenu("图像") {
        Menu("调整") {
          Button("亮度/对比度") {
            print("调整亮度和对比度")
          }

          Button("色相/饱和度") {
            print("调整色相和饱和度")
          }

          Button("色彩平衡") {
            print("调整色彩平衡")
          }

          Button("曲线") {
            print("打开曲线调整工具")
          }

          Button("色阶") {
            print("打开色阶调整工具")
          }
        }

        Menu("滤镜") {
          Button("模糊") {
            print("应用模糊滤镜")
          }

          Button("锐化") {
            print("应用锐化滤镜")
          }

          Button("浮雕") {
            print("应用浮雕效果")
          }

          Button("油画") {
            print("应用油画效果")
          }

          Divider()

          Menu("艺术效果") {
            Button("水彩") {
              print("应用水彩效果")
            }

            Button("素描") {
              print("应用素描效果")
            }

            Button("漫画") {
              print("应用漫画效果")
            }
          }
        }

        Divider()

        Button("图像大小") {
          print("调整图像大小")
        }
        .keyboardShortcut("i", modifiers: [.command, .option])

        Button("画布大小") {
          print("调整画布大小")
        }
        .keyboardShortcut("c", modifiers: [.command, .option])

        Button("裁剪") {
          print("裁剪图像")
        }
        .keyboardShortcut("k", modifiers: .command)
      }

      // 工具菜单
      CommandMenu("工具") {
        Button("选择工具") {
          currentTool = "选择工具"
          print("切换到选择工具")
        }
        .keyboardShortcut("v", modifiers: .command)

        Button("画笔工具") {
          currentTool = "画笔工具"
          print("切换到画笔工具")
        }
        .keyboardShortcut("b", modifiers: .command)

        Button("橡皮擦") {
          currentTool = "橡皮擦"
          print("切换到橡皮擦工具")
        }
        .keyboardShortcut("e", modifiers: .command)

        Button("文字工具") {
          currentTool = "文字工具"
          print("切换到文字工具")
        }
        .keyboardShortcut("t", modifiers: .command)

        Divider()

        Menu("颜色") {
          Button("前景色") {
            print("选择前景色")
          }

          Button("背景色") {
            print("选择背景色")
          }

          Button("交换颜色") {
            print("交换前景色和背景色")
          }
          .keyboardShortcut("x", modifiers: .command)

          Button("重置颜色") {
            print("重置为默认颜色")
          }
          .keyboardShortcut("d", modifiers: .command)
        }
      }

      // 视图菜单
      CommandGroup(after: .windowSize) {
        Button("放大") {
          zoomLevel = min(zoomLevel + 25, 800)
          print("放大到 \(zoomLevel)%")
        }
        .keyboardShortcut("+", modifiers: .command)

        Button("缩小") {
          zoomLevel = max(zoomLevel - 25, 25)
          print("缩小到 \(zoomLevel)%")
        }
        .keyboardShortcut("-", modifiers: .command)

        Button("适合窗口") {
          zoomLevel = 100
          print("适合窗口大小")
        }
        .keyboardShortcut("0", modifiers: .command)

        Button("实际大小") {
          zoomLevel = 100
          print("显示实际大小")
        }
        .keyboardShortcut("1", modifiers: .command)
      }
    }
  }
}

/// 项目管理器应用的菜单结构
struct ProjectManagerApp: App {
  @State private var projectCount = 0
  @State private var taskCount = 0
  @State private var teamMembers = 0

  var body: some Scene {
    WindowGroup {
      CommandMenuExampleView06()
    }
    .commands {
      // 项目菜单
      CommandMenu("项目") {
        Button("新建项目") {
          projectCount += 1
          print("创建新项目，总数: \(projectCount)")
        }
        .keyboardShortcut("n", modifiers: .command)

        Button("打开项目") {
          print("打开现有项目")
        }
        .keyboardShortcut("o", modifiers: .command)

        Button("最近项目") {
          print("显示最近项目列表")
        }
        .keyboardShortcut("r", modifiers: .command)

        Divider()

        Button("项目设置") {
          print("打开项目设置")
        }
        .keyboardShortcut(",", modifiers: .command)

        Button("项目统计") {
          print("显示项目统计信息")
        }

        Button("导出项目") {
          print("导出项目数据")
        }
        .keyboardShortcut("e", modifiers: .command)
      }

      // 任务菜单
      CommandMenu("任务") {
        Button("新建任务") {
          taskCount += 1
          print("创建新任务，总数: \(taskCount)")
        }
        .keyboardShortcut("t", modifiers: .command)

        Button("快速添加") {
          print("快速添加任务")
        }
        .keyboardShortcut("q", modifiers: .command)

        Divider()

        Menu("任务状态") {
          Button("标记为完成") {
            print("标记任务为完成")
          }
          .keyboardShortcut("d", modifiers: .command)

          Button("标记为进行中") {
            print("标记任务为进行中")
          }

          Button("标记为暂停") {
            print("标记任务为暂停")
          }

          Button("重新打开") {
            print("重新打开任务")
          }
        }

        Menu("优先级") {
          Button("高优先级") {
            print("设置为高优先级")
          }
          .keyboardShortcut("1", modifiers: [.command, .shift])

          Button("中优先级") {
            print("设置为中优先级")
          }
          .keyboardShortcut("2", modifiers: [.command, .shift])

          Button("低优先级") {
            print("设置为低优先级")
          }
          .keyboardShortcut("3", modifiers: [.command, .shift])
        }

        Divider()

        Button("分配任务") {
          print("分配任务给团队成员")
        }
        .keyboardShortcut("a", modifiers: .command)

        Button("设置截止日期") {
          print("设置任务截止日期")
        }

        Button("添加备注") {
          print("为任务添加备注")
        }
      }

      // 团队菜单
      CommandMenu("团队") {
        Button("邀请成员") {
          teamMembers += 1
          print("邀请新成员，总数: \(teamMembers)")
        }
        .keyboardShortcut("i", modifiers: .command)

        Button("成员管理") {
          print("管理团队成员")
        }

        Button("权限设置") {
          print("设置成员权限")
        }

        Divider()

        Menu("协作") {
          Button("团队聊天") {
            print("打开团队聊天")
          }
          .keyboardShortcut("c", modifiers: [.command, .shift])

          Button("视频会议") {
            print("发起视频会议")
          }

          Button("共享屏幕") {
            print("共享屏幕")
          }

          Button("文件共享") {
            print("共享文件")
          }
        }

        Menu("通知") {
          Button("发送通知") {
            print("发送团队通知")
          }

          Button("@提醒") {
            print("@提醒特定成员")
          }

          Button("紧急通知") {
            print("发送紧急通知")
          }
        }
      }

      // 报告菜单
      CommandMenu("报告") {
        Button("项目进度") {
          print("生成项目进度报告")
        }
        .keyboardShortcut("p", modifiers: [.command, .shift])

        Button("团队效率") {
          print("生成团队效率报告")
        }

        Button("时间统计") {
          print("生成时间统计报告")
        }

        Divider()

        Menu("导出报告") {
          Button("导出为 PDF") {
            print("导出报告为 PDF")
          }

          Button("导出为 Excel") {
            print("导出报告为 Excel")
          }

          Button("导出为 CSV") {
            print("导出报告为 CSV")
          }
        }

        Button("定期报告") {
          print("设置定期报告")
        }

        Button("自定义报告") {
          print("创建自定义报告")
        }
      }
    }
  }
}

#Preview {
  CommandMenuExampleView06()
}
