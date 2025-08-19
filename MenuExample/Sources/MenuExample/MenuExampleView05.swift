import SwiftUI

/// MenuExampleView05 - 上下文菜单示例
/// 展示 contextMenu 修饰符的使用，包括基础上下文菜单和带预览的上下文菜单
public struct MenuExampleView05: View {
  @State private var selectedAction = "未选择任何操作"
  @State private var items = [
    ContextMenuItem(id: 1, title: "重要文档.pdf", isStarred: false, color: .blue),
    ContextMenuItem(id: 2, title: "会议记录.docx", isStarred: true, color: .green),
    ContextMenuItem(id: 3, title: "项目计划.xlsx", isStarred: false, color: .orange),
    ContextMenuItem(id: 4, title: "设计稿.psd", isStarred: true, color: .purple),
  ]

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("上下文菜单示例")
          .font(.largeTitle)
          .fontWeight(.bold)

        Text("当前状态: \(selectedAction)")
          .foregroundColor(.secondary)
          .padding()
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)

        VStack(spacing: 25) {
          // 示例1: 基础上下文菜单
          Group {
            Text("基础上下文菜单")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            Text("长按下面的文本查看上下文菜单")
              .padding()
              .background(Color.blue.opacity(0.1))
              .cornerRadius(8)
              .contextMenu {
                Button(action: { selectAction("复制文本") }) {
                  Label("复制", systemImage: "doc.on.doc")
                }
                Button(action: { selectAction("分享文本") }) {
                  Label("分享", systemImage: "square.and.arrow.up")
                }
                Button(action: { selectAction("编辑文本") }) {
                  Label("编辑", systemImage: "pencil")
                }

                Divider()

                Button(action: { selectAction("删除文本") }) {
                  Label("删除", systemImage: "trash")
                }
              }
          }

          Divider()

          // 示例2: 图片上下文菜单
          Group {
            Text("图片上下文菜单")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "photo.fill")
              .font(.system(size: 60))
              .foregroundColor(.blue)
              .frame(width: 120, height: 120)
              .background(Color.gray.opacity(0.1))
              .cornerRadius(12)
              .contextMenu {
                Button(action: { selectAction("保存图片") }) {
                  Label("保存到相册", systemImage: "square.and.arrow.down")
                }
                Button(action: { selectAction("复制图片") }) {
                  Label("复制图片", systemImage: "doc.on.doc")
                }
                Button(action: { selectAction("分享图片") }) {
                  Label("分享图片", systemImage: "square.and.arrow.up")
                }

                Divider()

                Menu("更多选项") {
                  Button("设为壁纸", action: { selectAction("设为壁纸") })
                  Button("在预览中打开", action: { selectAction("在预览中打开") })
                  Button("显示信息", action: { selectAction("显示图片信息") })
                }

                Divider()

                Button(role: .destructive, action: { selectAction("删除图片") }) {
                  Label("删除", systemImage: "trash")
                }
              }
          }

          Divider()

          // 示例3: 列表项上下文菜单
          Group {
            Text("列表项上下文菜单")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            LazyVStack(spacing: 12) {
              ForEach(items) { item in
                HStack {
                  Circle()
                    .fill(item.color)
                    .frame(width: 12, height: 12)

                  Text(item.title)
                    .fontWeight(.medium)

                  Spacer()

                  if item.isStarred {
                    Image(systemName: "star.fill")
                      .foregroundColor(.yellow)
                      .font(.caption)
                  }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(8)
                .contextMenu {
                  Button(action: { toggleStar(for: item.id) }) {
                    Label(
                      item.isStarred ? "取消收藏" : "添加收藏",
                      systemImage: item.isStarred ? "star.slash" : "star"
                    )
                  }

                  Button(action: { selectAction("重命名 \(item.title)") }) {
                    Label("重命名", systemImage: "pencil")
                  }

                  Button(action: { selectAction("复制 \(item.title)") }) {
                    Label("复制", systemImage: "doc.on.doc")
                  }

                  Button(action: { selectAction("移动 \(item.title)") }) {
                    Label("移动", systemImage: "folder")
                  }

                  Divider()

                  Menu("更多操作") {
                    Button("查看详情", action: { selectAction("查看 \(item.title) 详情") })
                    Button("导出", action: { selectAction("导出 \(item.title)") })
                    Button("压缩", action: { selectAction("压缩 \(item.title)") })
                  }

                  Divider()

                  Button(role: .destructive, action: { deleteItem(item.id) }) {
                    Label("删除", systemImage: "trash")
                  }
                }
              }
            }
          }

          Divider()

          // 示例4: 带预览的上下文菜单
          Group {
            Text("带预览的上下文菜单")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
              // 文档预览
              HStack {
                Image(systemName: "doc.text.fill")
                  .foregroundColor(.blue)
                  .font(.title2)

                VStack(alignment: .leading) {
                  Text("重要报告.pdf")
                    .fontWeight(.medium)
                  Text("2.3 MB • 昨天")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }

                Spacer()
              }
              .padding()
              .background(Color.blue.opacity(0.05))
              .cornerRadius(8)
              .contextMenu(
                menuItems: {
                  Button(action: { selectAction("打开报告") }) {
                    Label("打开", systemImage: "doc.text")
                  }
                  Button(action: { selectAction("快速查看报告") }) {
                    Label("快速查看", systemImage: "eye")
                  }
                  Button(action: { selectAction("分享报告") }) {
                    Label("分享", systemImage: "square.and.arrow.up")
                  }

                  Divider()

                  Button(action: { selectAction("移动报告到废纸篓") }) {
                    Label("移动到废纸篓", systemImage: "trash")
                  }
                },
                preview: {
                  // 预览内容
                  VStack(spacing: 12) {
                    Image(systemName: "doc.text.fill")
                      .font(.system(size: 50))
                      .foregroundColor(.blue)

                    Text("重要报告.pdf")
                      .font(.headline)

                    Text("这是一个重要的项目报告文档，包含了详细的分析和建议。")
                      .font(.body)
                      .multilineTextAlignment(.center)
                      .padding()

                    HStack {
                      Label("2.3 MB", systemImage: "doc")
                      Spacer()
                      Label("昨天", systemImage: "clock")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                  }
                  .padding()
                  .frame(width: 250, height: 200)
                  .background(Color.white)
                  .cornerRadius(12)
                  .shadow(radius: 10)
                })

              // 图片预览
              HStack {
                Image(systemName: "photo.fill")
                  .foregroundColor(.green)
                  .font(.title2)

                VStack(alignment: .leading) {
                  Text("风景照片.jpg")
                    .fontWeight(.medium)
                  Text("4.1 MB • 今天")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }

                Spacer()
              }
              .padding()
              .background(Color.green.opacity(0.05))
              .cornerRadius(8)
              .contextMenu(
                menuItems: {
                  Button(action: { selectAction("查看原图") }) {
                    Label("查看原图", systemImage: "photo")
                  }
                  Button(action: { selectAction("编辑图片") }) {
                    Label("编辑", systemImage: "slider.horizontal.3")
                  }
                  Button(action: { selectAction("设为壁纸") }) {
                    Label("设为壁纸", systemImage: "rectangle.on.rectangle")
                  }
                  Button(action: { selectAction("保存到相册") }) {
                    Label("保存到相册", systemImage: "square.and.arrow.down")
                  }
                },
                preview: {
                  // 图片预览
                  VStack {
                    RoundedRectangle(cornerRadius: 8)
                      .fill(
                        LinearGradient(
                          colors: [.green, .blue, .purple],
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing
                        )
                      )
                      .frame(width: 200, height: 150)
                      .overlay(
                        Image(systemName: "photo.fill")
                          .font(.system(size: 40))
                          .foregroundColor(.white.opacity(0.8))
                      )

                    Text("风景照片.jpg")
                      .font(.headline)
                      .padding(.top, 8)

                    Text("4.1 MB • 1920×1080")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }
                  .padding()
                  .background(Color.white)
                  .cornerRadius(12)
                  .shadow(radius: 10)
                })
            }
          }
        }

        // 说明文本
        VStack(alignment: .leading, spacing: 8) {
          Text("上下文菜单说明:")
            .fontWeight(.semibold)
          Text("• 长按元素显示上下文菜单")
          Text("• 可以包含按钮、菜单和分隔符")
          Text("• 支持预览功能，提供更丰富的交互")
          Text("• 在 macOS 上右键点击显示菜单")
        }
        .font(.caption)
        .foregroundColor(.secondary)
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(8)
      }
      .padding()
    }
    .navigationTitle("上下文菜单")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 辅助方法

  /// 选择操作
  private func selectAction(_ action: String) {
    selectedAction = action
  }

  /// 切换收藏状态
  private func toggleStar(for id: Int) {
    if let index = items.firstIndex(where: { $0.id == id }) {
      items[index].isStarred.toggle()
      let action = items[index].isStarred ? "添加收藏" : "取消收藏"
      selectAction("\(action): \(items[index].title)")
    }
  }

  /// 删除项目
  private func deleteItem(_ id: Int) {
    if let index = items.firstIndex(where: { $0.id == id }) {
      let title = items[index].title
      items.remove(at: index)
      selectAction("删除: \(title)")
    }
  }
}

// MARK: - 数据模型

/// 上下文菜单项目数据模型
struct ContextMenuItem: Identifiable {
  let id: Int
  let title: String
  var isStarred: Bool
  let color: Color
}

#Preview {
  NavigationView {
    MenuExampleView05()
  }
}
