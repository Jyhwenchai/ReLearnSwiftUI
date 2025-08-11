import SwiftUI

// MARK: - ButtonExampleView01: 基础按钮创建
// 学习目标: 掌握 Button 的基本创建方法和基础样式
// 涵盖内容: 不同初始化方法、基础样式、简单交互

public struct ButtonExampleView01: View {
  // MARK: - 状态属性
  @State private var actionMessage = "等待按钮点击..."
  @State private var clickCount = 0
  @State private var isLoading = false
  
  public init() {}
  
  public var body: some View {
    ExampleContainerView("基础按钮创建") {
      
      // MARK: - 基础按钮创建方法
      ExampleSection("基础创建方法") {
        VStack(spacing: 16) {
          // 1. 最简单的文本按钮
          Button("简单文本按钮") {
            updateActionMessage("点击了简单文本按钮")
          }
          
          // 2. 系统图标按钮
          Button("系统图标按钮", systemImage: "star.fill") {
            updateActionMessage("点击了系统图标按钮")
          }
          
          // 3. 自定义图片按钮（使用 Image 资源）
          Button("自定义标签按钮", action: {
            updateActionMessage("点击了自定义标签按钮")
          })
          
          // 4. 完全自定义标签的按钮
          Button(action: {
            updateActionMessage("点击了复杂自定义按钮")
          }) {
            HStack {
              Image(systemName: "heart.fill")
                .foregroundColor(.red)
              Text("复杂自定义按钮")
                .font(.headline)
                .foregroundColor(.blue)
              Image(systemName: "arrow.right")
                .foregroundColor(.green)
            }
            .padding(.horizontal, 8)
          }
        }
      }
      
      // MARK: - 基础样式演示
      ExampleSection("基础内置样式") {
        VStack(spacing: 16) {
          // .automatic 样式（默认样式）
          Button("Automatic 样式") {
            updateActionMessage("点击了 Automatic 样式按钮")
          }
          .buttonStyle(.automatic)
          .modifier(StyleLabelModifier("automatic"))
          
          // .bordered 样式（有边框）
          Button("Bordered 样式") {
            updateActionMessage("点击了 Bordered 样式按钮")
          }
          .buttonStyle(.bordered)
          .modifier(StyleLabelModifier("bordered"))
          
          // .plain 样式（朴素样式，无装饰）
          Button("Plain 样式") {
            updateActionMessage("点击了 Plain 样式按钮")
          }
          .buttonStyle(.plain)
          .modifier(StyleLabelModifier("plain"))
        }
      }
      
      // MARK: - 按钮状态管理
      ExampleSection("按钮状态管理") {
        VStack(spacing: 16) {
          // 计数器按钮
          Button("点击计数: \\(clickCount)") {
            clickCount += 1
            updateActionMessage("按钮被点击了 \\(clickCount) 次")
          }
          .buttonStyle(.bordered)
          
          // 重置按钮
          Button("重置计数", systemImage: "arrow.clockwise") {
            clickCount = 0
            actionMessage = "计数已重置"
          }
          .buttonStyle(.bordered)
          
          // 模拟加载状态的按钮
          Button(action: {
            simulateLoading()
          }) {
            HStack {
              if isLoading {
                ProgressView()
                  .scaleEffect(0.8)
                  .padding(.trailing, 4)
              } else {
                Image(systemName: "cloud.fill")
              }
              Text(isLoading ? "加载中..." : "开始加载")
            }
          }
          .buttonStyle(.borderedProminent)
          .disabled(isLoading) // 加载时禁用按钮
        }
      }
      
      // MARK: - 标签样式变化
      ExampleSection("标签样式控制") {
        VStack(spacing: 16) {
          // 只显示图标
          Button("只显示图标", systemImage: "gear") {
            updateActionMessage("点击了只显示图标的按钮")
          }
          .labelStyle(.iconOnly)
          .buttonStyle(.bordered)
          
          // 只显示标题
          Button("只显示标题", systemImage: "gear") {
            updateActionMessage("点击了只显示标题的按钮")
          }
          .labelStyle(.titleOnly)
          .buttonStyle(.bordered)
          
          // 显示标题和图标（默认）
          Button("标题和图标", systemImage: "gear") {
            updateActionMessage("点击了显示标题和图标的按钮")
          }
          .labelStyle(.titleAndIcon)
          .buttonStyle(.bordered)
          
          // 自动样式（根据上下文自动调整）
          Button("自动标签样式", systemImage: "gear") {
            updateActionMessage("点击了自动标签样式的按钮")
          }
          .labelStyle(.automatic)
          .buttonStyle(.bordered)
        }
      }
      
      // MARK: - 动作反馈区域
      ExampleSection("动作反馈") {
        VStack {
          Text("动作消息:")
            .font(.headline)
          
          Text(actionMessage)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.secondary)
        }
      }
      
    } footer: {
      VStack(alignment: .leading, spacing: 8) {
        Text("💡 学习要点:")
          .font(.headline)
        
        VStack(alignment: .leading, spacing: 4) {
          Text("• Button 有多种初始化方法，适用于不同场景")
          Text("• .automatic、.bordered、.plain 是最基础的三种样式")
          Text("• labelStyle 可以控制标签的显示方式")
          Text("• 使用 @State 管理按钮的状态和用户交互")
          Text("• disabled() 可以根据条件禁用按钮")
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }
    }
  }
  
  // MARK: - 辅助方法
  
  /// 更新动作消息的辅助方法
  private func updateActionMessage(_ message: String) {
    actionMessage = message
  }
  
  /// 模拟加载过程的辅助方法
  private func simulateLoading() {
    isLoading = true
    actionMessage = "正在执行网络请求..."
    
    // 模拟网络请求延迟
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      isLoading = false
      actionMessage = "加载完成！"
    }
  }
}

// MARK: - 样式标签修饰符
/// 用于显示按钮样式名称的辅助修饰符
struct StyleLabelModifier: ViewModifier {
  let styleName: String
  
  init(_ styleName: String) {
    self.styleName = styleName
  }
  
  func body(content: Content) -> some View {
    VStack {
      content
      Text(".\(styleName)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }
}

#Preview {
  NavigationStack {
    ButtonExampleView01()
  }
}