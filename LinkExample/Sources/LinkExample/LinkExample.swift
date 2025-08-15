import SwiftUI

/// LinkExample - SwiftUI Link 组件完整示例集合
///
/// 本模块提供了 SwiftUI Link 组件的完整学习示例，包含：
/// - 基础链接创建和使用方法
/// - 样式定制和修饰符应用
/// - 不同类型链接的实现
/// - 高级功能和实际应用场景
///
/// 使用方法：
/// ```swift
/// import LinkExample
///
/// // 在你的视图中使用
/// LinkExampleView01() // 基础用法
/// LinkExampleView02() // 样式定制
/// LinkExampleView03() // 链接类型
/// LinkExampleView04() // 高级应用
/// ```
public struct LinkExample: View {
  public init() {}

  public var body: some View {
    NavigationView {
      List {
        Section("Link 组件学习示例") {
          NavigationLink("01 - 基础链接创建", destination: LinkExampleView01())
          NavigationLink("02 - 样式和修饰符", destination: LinkExampleView02())
          NavigationLink("03 - 不同类型的链接", destination: LinkExampleView03())
          NavigationLink("04 - 高级功能和实际应用", destination: LinkExampleView04())
        }

        Section("学习指南") {
          VStack(alignment: .leading, spacing: 8) {
            Text("建议学习顺序：")
              .font(.headline)

            VStack(alignment: .leading, spacing: 4) {
              Text("1. 基础链接创建 - 掌握 Link 的基本用法")
              Text("2. 样式和修饰符 - 学习视觉定制技巧")
              Text("3. 不同类型的链接 - 了解各种链接协议")
              Text("4. 高级功能和实际应用 - 掌握复杂场景")
            }
            .font(.caption)
            .foregroundColor(.secondary)
          }
          .padding(.vertical, 8)
        }

        Section("组件特点") {
          VStack(alignment: .leading, spacing: 8) {
            Text("Link 组件核心特性：")
              .font(.headline)

            VStack(alignment: .leading, spacing: 4) {
              Text("• 支持多种 URL 协议（HTTP、mailto、tel 等）")
              Text("• 自动处理系统默认应用打开")
              Text("• 完整的可访问性支持")
              Text("• 灵活的样式定制能力")
              Text("• 跨平台兼容性（iOS 14.0+, macOS 11.0+）")
            }
            .font(.caption)
            .foregroundColor(.secondary)
          }
          .padding(.vertical, 8)
        }
      }
      .navigationTitle("Link 组件示例")
      #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
      #endif
    }
  }
}

// MARK: - 公开接口
// 导出所有示例视图供外部使用
public typealias LinkBasicExample = LinkExampleView01
public typealias LinkStyleExample = LinkExampleView02
public typealias LinkTypesExample = LinkExampleView03
public typealias LinkAdvancedExample = LinkExampleView04

// MARK: - 预览
#Preview("Link 示例总览") {
  LinkExample()
}

#Preview("基础用法") {
  LinkExampleView01()
}

#Preview("样式定制") {
  LinkExampleView02()
}

#Preview("链接类型") {
  LinkExampleView03()
}

#Preview("高级应用") {
  LinkExampleView04()
}
