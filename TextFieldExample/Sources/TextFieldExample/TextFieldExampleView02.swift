import SwiftUI

/// TextField 样式示例 - 样式和修饰符
public struct TextFieldExampleView02: View {
  @State private var plainText = ""
  @State private var roundedText = ""
  @State private var customText = ""
  @State private var iconText = ""
  @State private var searchText = ""
  @State private var fontText = ""

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("TextField 样式示例")
          .font(.largeTitle.weight(.bold))
          .padding(.bottom)

        builtInStylesSection
        customBorderSection
        iconDecorationSection
        fontColorSection
        summarySection
      }
      .padding()
    }
    .navigationTitle("样式和修饰符")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  private var builtInStylesSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("1. 内置样式")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("Plain Style (默认)")
          .font(.subheadline.weight(.medium))

        TextField("Plain 样式", text: $plainText)
          .textFieldStyle(.plain)
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)

        Text("• 最简洁的样式，无边框")
          .font(.caption)
          .foregroundColor(.secondary)
      }

      VStack(alignment: .leading, spacing: 8) {
        Text("Rounded Border Style")
          .font(.subheadline.weight(.medium))

        TextField("Rounded Border 样式", text: $roundedText)
          .textFieldStyle(.roundedBorder)

        Text("• 圆角边框样式，最常用")
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var customBorderSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("2. 自定义边框样式")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("实线边框")
          .font(.subheadline.weight(.medium))

        TextField("实线边框", text: $customText)
          .textFieldStyle(.plain)
          .padding(.horizontal, 12)
          .padding(.vertical, 10)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.blue, lineWidth: 2)
          )
      }

      Text("• 使用 overlay 添加自定义边框")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var iconDecorationSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("3. 图标装饰")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("左侧图标")
          .font(.subheadline.weight(.medium))

        HStack {
          Image(systemName: "person.fill")
            .foregroundColor(.gray)
            .frame(width: 20)

          TextField("用户名", text: $iconText)
            .textFieldStyle(.plain)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
      }

      VStack(alignment: .leading, spacing: 8) {
        Text("搜索框样式")
          .font(.subheadline.weight(.medium))

        HStack {
          Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)

          TextField("搜索...", text: $searchText)
            .textFieldStyle(.plain)

          if !searchText.isEmpty {
            Button(action: { searchText = "" }) {
              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
            }
          }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
      }

      Text("• 使用 HStack 组合图标和 TextField")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var fontColorSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("4. 字体和颜色定制")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("大字体样式")
          .font(.subheadline.weight(.medium))

        TextField("大字体输入", text: $fontText)
          .font(.title2.weight(.semibold))
          .foregroundColor(.blue)
          .textFieldStyle(.roundedBorder)
      }

      Text("• 使用 .font() 修改字体样式")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var summarySection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("🎨 样式设计要点")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 4) {
        Text("• 选择合适的 TextFieldStyle")
        Text("• 使用 overlay 和 background 创建自定义样式")
        Text("• 组合图标和文本框提升用户体验")
        Text("• 注意颜色对比度和可读性")
        Text("• 保持样式一致性")
      }
      .font(.caption)
      .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.green.opacity(0.1))
    .cornerRadius(10)
  }
}

#Preview {
  NavigationView {
    TextFieldExampleView02()
  }
}
