import SwiftUI

/// RenameButton 示例集合
/// 提供多个 RenameButton 使用场景的完整示例
public struct RenameButtonExample: View {

  /// 示例页面枚举
  public enum ExamplePage: String, CaseIterable, Identifiable {
    case basic = "基础用法"
    case navigation = "导航标题"
    case advanced = "高级功能"
    case realWorld = "实际应用"

    public var id: String { rawValue }

    public var description: String {
      switch self {
      case .basic:
        return "演示 RenameButton 的基本用法和重命名功能"
      case .navigation:
        return "在导航标题菜单中使用 RenameButton"
      case .advanced:
        return "自定义样式和高级功能演示"
      case .realWorld:
        return "文件管理器、笔记应用等实际应用场景"
      }
    }

    public var icon: String {
      switch self {
      case .basic:
        return "pencil"
      case .navigation:
        return "doc.text"
      case .advanced:
        return "gear"
      case .realWorld:
        return "app.badge"
      }
    }
  }

  /// 当前选中的示例页面
  @State private var selectedPage: ExamplePage = .basic

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        // MARK: - 示例选择器
        Picker("示例选择", selection: $selectedPage) {
          ForEach(ExamplePage.allCases) { page in
            Text(page.rawValue)
              .tag(page)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()

        // MARK: - 示例内容
        Group {
          switch selectedPage {
          case .basic:
            RenameButtonExampleView01()
          case .navigation:
            RenameButtonExampleView02()
          case .advanced:
            RenameButtonExampleView03()
          case .realWorld:
            RenameButtonExampleView04()
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .navigationTitle("RenameButton 示例")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

// MARK: - 示例页面信息视图
public struct RenameButtonExampleInfo: View {
  public init() {}

  public var body: some View {
    List {
      Section("RenameButton 概述") {
        VStack(alignment: .leading, spacing: 8) {
          Text("RenameButton 是 SwiftUI 中的一个特殊用途按钮，用于触发标准的重命名操作。")
            .font(.body)

          Text("主要特点：")
            .font(.headline)
            .padding(.top, 8)

          VStack(alignment: .leading, spacing: 4) {
            Text("• 自动从环境中获取重命名操作")
            Text("• 支持在上下文菜单中使用")
            Text("• 支持在导航标题菜单中使用")
            Text("• 系统会自动禁用没有定义操作的按钮")
          }
          .font(.body)
        }
      }

      Section("示例说明") {
        ForEach(RenameButtonExample.ExamplePage.allCases) { page in
          HStack {
            Image(systemName: page.icon)
              .foregroundColor(.blue)
              .frame(width: 24)

            VStack(alignment: .leading, spacing: 2) {
              Text(page.rawValue)
                .font(.headline)

              Text(page.description)
                .font(.caption)
                .foregroundColor(.secondary)
            }

            Spacer()
          }
          .padding(.vertical, 4)
        }
      }

      Section("平台支持") {
        VStack(alignment: .leading, spacing: 4) {
          Text("• iOS 16.0+")
          Text("• iPadOS 16.0+")
          Text("• macOS 13.0+")
          Text("• tvOS 16.0+")
          Text("• watchOS 9.0+")
          Text("• visionOS 1.0+")
        }
        .font(.body)
      }
    }
    .navigationTitle("RenameButton 信息")
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - 预览
#Preview("RenameButton 示例") {
  RenameButtonExample()
}

#Preview("RenameButton 信息") {
  NavigationView {
    RenameButtonExampleInfo()
  }
}
