import SwiftUI

/// TextField 高级示例 - 高级功能和自定义样式
public struct TextFieldExampleView04: View {
  // MARK: - 状态变量
  @State private var floatingText = ""
  @State private var animatedText = ""
  @State private var tagText = ""
  @State private var chatText = ""

  // 焦点状态
  @FocusState private var isFloatingFocused: Bool
  @FocusState private var isAnimatedFocused: Bool
  @FocusState private var isChatFocused: Bool

  // 标签数组
  @State private var tags: [String] = ["SwiftUI", "iOS"]

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        headerView
        floatingLabelSection
        animatedBorderSection
        tagInputSection
        chatInputSection
        summarySection
      }
      .padding()
    }
    .navigationTitle("高级功能和自定义")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 子视图组件

  private var headerView: some View {
    Text("TextField 高级示例")
      .font(.largeTitle.weight(.bold))
      .padding(.bottom)
  }

  private var floatingLabelSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("1. 浮动标签样式")
        .font(.headline)
        .foregroundColor(.primary)

      floatingLabelView

      Text("• 标签在获得焦点时浮动到上方")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(10)
  }

  private var floatingLabelView: some View {
    VStack(alignment: .leading, spacing: 8) {
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color(.systemGray6))
          .frame(height: 56)

        Text("邮箱地址")
          .font(isFloatingFocused || !floatingText.isEmpty ? .caption : .body)
          .foregroundColor(isFloatingFocused ? .blue : .secondary)
          .offset(
            x: 16,
            y: isFloatingFocused || !floatingText.isEmpty ? -20 : 0
          )
          .animation(.easeInOut(duration: 0.2), value: isFloatingFocused)

        TextField("", text: $floatingText)
          .textFieldStyle(.plain)
          .padding(.horizontal, 16)
          .padding(.top, isFloatingFocused || !floatingText.isEmpty ? 8 : 0)
          .focused($isFloatingFocused)
      }
      .overlay(
        RoundedRectangle(cornerRadius: 12)
          .stroke(isFloatingFocused ? Color.blue : Color.clear, lineWidth: 2)
      )

      if !floatingText.isEmpty {
        Text("输入内容：\(floatingText)")
          .font(.caption)
          .foregroundColor(.blue)
      }
    }
  }

  private var animatedBorderSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("2. 动画边框效果")
        .font(.headline)
        .foregroundColor(.primary)

      animatedBorderView

      Text("• 焦点时显示渐变边框和阴影")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(10)
  }

  private var animatedBorderView: some View {
    VStack(alignment: .leading, spacing: 8) {
      TextField("输入文本查看动画效果", text: $animatedText)
        .textFieldStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(
              color: isAnimatedFocused ? .blue.opacity(0.3) : .gray.opacity(0.1),
              radius: isAnimatedFocused ? 8 : 2)
        )
        .scaleEffect(isAnimatedFocused ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isAnimatedFocused)
        .focused($isAnimatedFocused)

      if isAnimatedFocused {
        Text("✨ 焦点状态激活")
          .font(.caption)
          .foregroundColor(.blue)
          .transition(.opacity)
      }
    }
  }

  private var tagInputSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("3. 标签输入系统")
        .font(.headline)
        .foregroundColor(.primary)

      tagInputView

      Text("• 支持添加和删除标签")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(10)
  }

  private var tagInputView: some View {
    VStack(alignment: .leading, spacing: 8) {
      if !tags.isEmpty {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
              tagView(tag)
            }
          }
          .padding(.horizontal, 4)
        }
      }

      HStack {
        TextField("添加标签", text: $tagText)
          .textFieldStyle(.plain)
          .onSubmit {
            addTag()
          }

        Button(action: addTag) {
          Image(systemName: "plus.circle.fill")
            .foregroundColor(.blue)
        }
        .disabled(tagText.trimmingCharacters(in: .whitespaces).isEmpty)
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 8)
      .background(Color(.systemGray5))
      .cornerRadius(8)

      Text("当前标签：\(tags.count) 个")
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }

  private func tagView(_ tag: String) -> some View {
    HStack(spacing: 4) {
      Text(tag)
        .font(.caption)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.blue.opacity(0.2))
        .foregroundColor(.blue)
        .cornerRadius(12)

      Button(action: { removeTag(tag) }) {
        Image(systemName: "xmark.circle.fill")
          .font(.caption)
          .foregroundColor(.blue)
      }
    }
    .background(Color.blue.opacity(0.1))
    .cornerRadius(16)
  }

  private var chatInputSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("4. 聊天输入框")
        .font(.headline)
        .foregroundColor(.primary)

      chatInputView

      Text("• 多行文本输入支持")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(10)
  }

  private var chatInputView: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .bottom, spacing: 8) {
        if #available(iOS 16.0, macOS 13.0, *) {
          TextField("输入消息...", text: $chatText, axis: .vertical)
            .textFieldStyle(.plain)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray5))
            .cornerRadius(20)
            .lineLimit(1...5)
            .focused($isChatFocused)
        } else {
          TextField("输入消息...", text: $chatText)
            .textFieldStyle(.plain)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray5))
            .cornerRadius(20)
            .focused($isChatFocused)
        }

        Button(action: sendMessage) {
          Image(systemName: "arrow.up.circle.fill")
            .font(.title2)
            .foregroundColor(chatText.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .blue)
        }
        .disabled(chatText.trimmingCharacters(in: .whitespaces).isEmpty)
      }

      if isChatFocused {
        HStack {
          Text("字符数：\(chatText.count)")
            .font(.caption)
            .foregroundColor(.secondary)

          Spacer()

          Text("按 Enter 发送")
            .font(.caption)
            .foregroundColor(.blue)
        }
        .transition(.opacity)
      }
    }
  }

  private var summarySection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("🚀 高级功能要点")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 4) {
        Text("• 使用 @FocusState 管理焦点状态")
        Text("• 添加动画提升用户体验")
        Text("• 创建复杂的交互组件")
        Text("• 支持多行文本输入（iOS 16+）")
      }
      .font(.caption)
      .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.purple.opacity(0.1))
    .cornerRadius(10)
  }

  // MARK: - 辅助方法

  private func addTag() {
    let newTag = tagText.trimmingCharacters(in: .whitespaces)
    if !newTag.isEmpty && !tags.contains(newTag) {
      tags.append(newTag)
      tagText = ""
    }
  }

  private func removeTag(_ tag: String) {
    tags.removeAll { $0 == tag }
  }

  private func sendMessage() {
    print("发送消息：\(chatText)")
    chatText = ""
  }
}

#Preview {
  NavigationView {
    TextFieldExampleView04()
  }
}
