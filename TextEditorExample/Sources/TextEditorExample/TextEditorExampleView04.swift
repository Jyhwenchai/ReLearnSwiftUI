import SwiftUI

/// TextEditor 实际应用场景示例
///
/// 本示例演示了 TextEditor 在实际应用中的使用场景，包括：
/// - 笔记应用界面
/// - 评论和反馈系统
/// - 邮件编写界面
/// - 代码编辑器
/// - 日记应用
public struct TextEditorExampleView04: View {
  // MARK: - 状态属性

  /// 笔记应用
  @State private var noteTitle = ""
  @State private var noteContent = ""
  @State private var noteDate = Date()

  /// 评论系统
  @State private var commentText = ""
  @State private var rating = 5
  @State private var comments: [Comment] = []

  /// 邮件编写
  @State private var emailTo = ""
  @State private var emailSubject = ""
  @State private var emailBody = ""
  @State private var emailPriority = EmailPriority.normal

  /// 代码编辑器
  @State private var codeContent = """
    import SwiftUI

    struct ContentView: View {
        var body: some View {
            Text("Hello, SwiftUI!")
                .padding()
        }
    }
    """
  @State private var selectedLanguage = "Swift"

  /// 日记应用
  @State private var diaryEntry = ""
  @State private var mood = Mood.neutral
  @State private var weather = "☀️"

  // MARK: - 视图主体

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // MARK: - 标题
        Text("TextEditor 实际应用")
          .font(.largeTitle.bold())
          .padding(.horizontal)

        VStack(alignment: .leading, spacing: 16) {
          // MARK: - 笔记应用
          VStack(alignment: .leading, spacing: 8) {
            Text("1. 笔记应用")
              .font(.headline)
              .foregroundColor(.primary)

            Text("完整的笔记编写界面，包含标题、内容和时间戳")
              .font(.caption)
              .foregroundColor(.secondary)

            VStack(spacing: 12) {
              // 笔记标题
              TextField("笔记标题", text: $noteTitle)
                .font(.title2.weight(.semibold))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)

              // 笔记内容
              TextEditor(text: $noteContent)
                .font(.body)
                .frame(minHeight: 150)
                .padding(16)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                  Group {
                    if noteContent.isEmpty {
                      Text("开始记录你的想法...")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .allowsHitTesting(false)
                    }
                  },
                  alignment: .topLeading
                )

              // 笔记信息栏
              HStack {
                Image(systemName: "calendar")
                  .foregroundColor(.secondary)
                Text(noteDate, style: .date)
                  .font(.caption)
                  .foregroundColor(.secondary)

                Spacer()

                Text("\(noteContent.count) 字符")
                  .font(.caption)
                  .foregroundColor(.secondary)

                Button("保存笔记") {
                  saveNote()
                }
                .buttonStyle(.borderedProminent)
                .disabled(noteTitle.isEmpty && noteContent.isEmpty)
              }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
          }

          Divider()

          // MARK: - 评论系统
          VStack(alignment: .leading, spacing: 8) {
            Text("2. 评论和反馈系统")
              .font(.headline)
              .foregroundColor(.primary)

            Text("用户评论和评分界面")
              .font(.caption)
              .foregroundColor(.secondary)

            VStack(spacing: 12) {
              // 评分选择
              HStack {
                Text("评分:")
                  .font(.subheadline)

                ForEach(1...5, id: \.self) { star in
                  Button(action: {
                    rating = star
                  }) {
                    Image(systemName: star <= rating ? "star.fill" : "star")
                      .foregroundColor(star <= rating ? .yellow : .gray)
                  }
                }

                Spacer()
              }

              // 评论输入
              TextEditor(text: $commentText)
                .frame(height: 100)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                  Group {
                    if commentText.isEmpty {
                      Text("分享你的使用体验...")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .allowsHitTesting(false)
                    }
                  },
                  alignment: .topLeading
                )

              // 提交按钮
              HStack {
                Text("\(commentText.count)/500")
                  .font(.caption)
                  .foregroundColor(commentText.count > 450 ? .red : .secondary)

                Spacer()

                Button("提交评论") {
                  submitComment()
                }
                .buttonStyle(.borderedProminent)
                .disabled(commentText.isEmpty || commentText.count > 500)
              }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

            // 显示已提交的评论
            if !comments.isEmpty {
              VStack(alignment: .leading, spacing: 8) {
                Text("最近评论:")
                  .font(.subheadline.weight(.medium))

                ForEach(comments.prefix(2)) { comment in
                  CommentView(comment: comment)
                }
              }
            }
          }

          Divider()

          // MARK: - 邮件编写
          VStack(alignment: .leading, spacing: 8) {
            Text("3. 邮件编写界面")
              .font(.headline)
              .foregroundColor(.primary)

            Text("完整的邮件编写功能")
              .font(.caption)
              .foregroundColor(.secondary)

            VStack(spacing: 12) {
              // 收件人
              HStack {
                Text("收件人:")
                  .frame(width: 60, alignment: .leading)
                TextField("输入邮箱地址", text: $emailTo)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
              }

              // 主题
              HStack {
                Text("主题:")
                  .frame(width: 60, alignment: .leading)
                TextField("邮件主题", text: $emailSubject)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
              }

              // 优先级
              HStack {
                Text("优先级:")
                  .frame(width: 60, alignment: .leading)
                Picker("优先级", selection: $emailPriority) {
                  ForEach(EmailPriority.allCases, id: \.self) { priority in
                    Text(priority.rawValue).tag(priority)
                  }
                }
                .pickerStyle(SegmentedPickerStyle())
              }

              // 邮件正文
              VStack(alignment: .leading) {
                Text("正文:")
                  .font(.subheadline)

                TextEditor(text: $emailBody)
                  .frame(minHeight: 120)
                  .padding(12)
                  .background(Color(.systemGray6))
                  .cornerRadius(8)
                  .overlay(
                    Group {
                      if emailBody.isEmpty {
                        Text("输入邮件内容...")
                          .foregroundColor(.secondary)
                          .padding(.horizontal, 16)
                          .padding(.vertical, 16)
                          .allowsHitTesting(false)
                      }
                    },
                    alignment: .topLeading
                  )
              }

              // 发送按钮
              HStack {
                Button("保存草稿") {
                  saveDraft()
                }
                .buttonStyle(.bordered)

                Spacer()

                Button("发送邮件") {
                  sendEmail()
                }
                .buttonStyle(.borderedProminent)
                .disabled(emailTo.isEmpty || emailSubject.isEmpty || emailBody.isEmpty)
              }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
          }

          Divider()

          // MARK: - 代码编辑器
          VStack(alignment: .leading, spacing: 8) {
            Text("4. 代码编辑器")
              .font(.headline)
              .foregroundColor(.primary)

            Text("支持语法高亮的代码编辑界面")
              .font(.caption)
              .foregroundColor(.secondary)

            VStack(spacing: 12) {
              // 语言选择
              HStack {
                Text("语言:")
                Picker("语言", selection: $selectedLanguage) {
                  Text("Swift").tag("Swift")
                  Text("JavaScript").tag("JavaScript")
                  Text("Python").tag("Python")
                  Text("HTML").tag("HTML")
                }
                .pickerStyle(MenuPickerStyle())

                Spacer()

                Text("行数: \(codeContent.components(separatedBy: .newlines).count)")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              // 代码编辑器
              TextEditor(text: $codeContent)
                .font(.system(.body, design: .monospaced))
                .frame(minHeight: 150)
                .padding(16)
                .background(Color.black.opacity(0.05))
                .cornerRadius(8)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )

              // 工具栏
              HStack {
                Button("格式化") {
                  formatCode()
                }
                .buttonStyle(.bordered)

                Button("运行") {
                  runCode()
                }
                .buttonStyle(.borderedProminent)

                Spacer()

                Text("字符: \(codeContent.count)")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
          }

          Divider()

          // MARK: - 日记应用
          VStack(alignment: .leading, spacing: 8) {
            Text("5. 日记应用")
              .font(.headline)
              .foregroundColor(.primary)

            Text("记录每日心情和生活的日记界面")
              .font(.caption)
              .foregroundColor(.secondary)

            VStack(spacing: 12) {
              // 日期和天气
              HStack {
                VStack(alignment: .leading) {
                  Text(Date(), style: .date)
                    .font(.title3.weight(.semibold))
                  Text(Date(), style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
                }

                Spacer()

                // 天气选择
                HStack {
                  ForEach(["☀️", "⛅", "🌧️", "❄️"], id: \.self) { weatherIcon in
                    Button(weatherIcon) {
                      weather = weatherIcon
                    }
                    .font(.title2)
                    .opacity(weather == weatherIcon ? 1.0 : 0.5)
                  }
                }
              }

              // 心情选择
              HStack {
                Text("今日心情:")
                  .font(.subheadline)

                ForEach(Mood.allCases, id: \.self) { moodOption in
                  Button(moodOption.emoji) {
                    mood = moodOption
                  }
                  .font(.title2)
                  .opacity(mood == moodOption ? 1.0 : 0.5)
                }

                Spacer()
              }

              // 日记内容
              TextEditor(text: $diaryEntry)
                .frame(minHeight: 150)
                .padding(16)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                  Group {
                    if diaryEntry.isEmpty {
                      Text("记录今天发生的事情...")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .allowsHitTesting(false)
                    }
                  },
                  alignment: .topLeading
                )

              // 保存按钮
              HStack {
                Text("心情: \(mood.rawValue) \(weather)")
                  .font(.caption)
                  .foregroundColor(.secondary)

                Spacer()

                Button("保存日记") {
                  saveDiary()
                }
                .buttonStyle(.borderedProminent)
                .disabled(diaryEntry.isEmpty)
              }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
          }

          // MARK: - 应用场景总结
          VStack(alignment: .leading, spacing: 8) {
            Text("📱 应用场景总结")
              .font(.headline)
              .foregroundColor(.orange)

            VStack(alignment: .leading, spacing: 4) {
              Text("• 笔记和文档编辑应用")
              Text("• 社交媒体评论和反馈系统")
              Text("• 邮件和消息编写界面")
              Text("• 代码编辑和开发工具")
              Text("• 日记和个人记录应用")
              Text("• 博客和内容创作平台")
              Text("• 表单和数据收集界面")
            }
            .font(.caption)
            .foregroundColor(.secondary)
          }
          .padding()
          .background(Color.orange.opacity(0.1))
          .cornerRadius(8)
        }
        .padding(.horizontal)
      }
    }
    .navigationTitle("实际应用")
    .navigationBarTitleDisplayMode(.inline)
  }

  // MARK: - 辅助方法

  private func saveNote() {
    print("保存笔记: \(noteTitle)")
    // 实际应用中这里会保存到数据库或文件
  }

  private func submitComment() {
    let newComment = Comment(
      id: UUID(),
      rating: rating,
      text: commentText,
      date: Date()
    )
    comments.insert(newComment, at: 0)
    commentText = ""
    rating = 5
  }

  private func saveDraft() {
    print("保存邮件草稿")
    // 实际应用中这里会保存草稿
  }

  private func sendEmail() {
    print("发送邮件到: \(emailTo)")
    // 实际应用中这里会发送邮件
    emailTo = ""
    emailSubject = ""
    emailBody = ""
  }

  private func formatCode() {
    // 简单的代码格式化
    codeContent =
      codeContent
      .replacingOccurrences(of: "    ", with: "\t")
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }

  private func runCode() {
    print("运行 \(selectedLanguage) 代码")
    // 实际应用中这里会执行代码
  }

  private func saveDiary() {
    print("保存日记: \(mood.rawValue) \(weather)")
    // 实际应用中这里会保存到数据库
  }
}

// MARK: - 数据模型

struct Comment: Identifiable {
  let id: UUID
  let rating: Int
  let text: String
  let date: Date
}

enum EmailPriority: String, CaseIterable {
  case low = "低"
  case normal = "普通"
  case high = "高"
}

enum Mood: String, CaseIterable {
  case happy = "开心"
  case neutral = "平静"
  case sad = "难过"
  case excited = "兴奋"
  case tired = "疲惫"

  var emoji: String {
    switch self {
    case .happy: return "😊"
    case .neutral: return "😐"
    case .sad: return "😢"
    case .excited: return "🤩"
    case .tired: return "😴"
    }
  }
}

// MARK: - 评论视图组件

struct CommentView: View {
  let comment: Comment

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        // 星级显示
        HStack(spacing: 2) {
          ForEach(1...5, id: \.self) { star in
            Image(systemName: star <= comment.rating ? "star.fill" : "star")
              .foregroundColor(star <= comment.rating ? .yellow : .gray)
              .font(.caption)
          }
        }

        Spacer()

        Text(comment.date, style: .relative)
          .font(.caption2)
          .foregroundColor(.secondary)
      }

      Text(comment.text)
        .font(.caption)
        .foregroundColor(.primary)
    }
    .padding(8)
    .background(Color(.systemGray6))
    .cornerRadius(6)
  }
}

// MARK: - 预览
#Preview {
  NavigationView {
    TextEditorExampleView04()
  }
}
