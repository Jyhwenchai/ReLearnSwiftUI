import SwiftUI

/// PickerExampleView01 - 基础 Picker 使用示例
/// 展示 Picker 的基本创建和使用方法
public struct PickerExampleView01: View {
  // MARK: - 状态属性

  /// 选中的冰淇淋口味
  @State private var selectedFlavor: IceCreamFlavor = .chocolate

  /// 选中的尺寸
  @State private var selectedSize: String = "中杯"

  /// 选中的数字
  @State private var selectedNumber: Int = 1

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 基础字符串 Picker
        Section("基础字符串选择") {
          // 使用字符串数组创建简单的 Picker
          Picker("选择尺寸", selection: $selectedSize) {
            Text("小杯").tag("小杯")
            Text("中杯").tag("中杯")
            Text("大杯").tag("大杯")
            Text("超大杯").tag("超大杯")
          }

          // 显示当前选择
          HStack {
            Text("当前选择:")
            Spacer()
            Text(selectedSize)
              .foregroundColor(.secondary)
          }
        }

        // MARK: - 枚举类型 Picker
        Section("枚举类型选择") {
          // 使用枚举类型创建 Picker
          Picker("选择口味", selection: $selectedFlavor) {
            Text("巧克力").tag(IceCreamFlavor.chocolate)
            Text("香草").tag(IceCreamFlavor.vanilla)
            Text("草莓").tag(IceCreamFlavor.strawberry)
            Text("薄荷").tag(IceCreamFlavor.mint)
          }

          // 显示当前选择的详细信息
          VStack(alignment: .leading, spacing: 4) {
            HStack {
              Text("当前口味:")
              Spacer()
              Text(selectedFlavor.displayName)
                .foregroundColor(.secondary)
            }
            HStack {
              Text("描述:")
              Spacer()
              Text(selectedFlavor.description)
                .foregroundColor(.secondary)
                .font(.caption)
            }
          }
        }

        // MARK: - 数字类型 Picker
        Section("数字类型选择") {
          // 使用整数类型创建 Picker
          Picker("选择数量", selection: $selectedNumber) {
            ForEach(1...10, id: \.self) { number in
              Text("\(number) 个").tag(number)
            }
          }

          // 显示总价计算
          HStack {
            Text("数量:")
            Spacer()
            Text("\(selectedNumber) 个")
              .foregroundColor(.secondary)
          }

          HStack {
            Text("预估价格:")
            Spacer()
            Text("¥\(selectedNumber * 15)")
              .foregroundColor(.green)
              .fontWeight(.semibold)
          }
        }

        // MARK: - 自定义标签 Picker
        Section("自定义标签") {
          // 使用自定义视图作为标签
          Picker(selection: $selectedFlavor) {
            Text("巧克力").tag(IceCreamFlavor.chocolate)
            Text("香草").tag(IceCreamFlavor.vanilla)
            Text("草莓").tag(IceCreamFlavor.strawberry)
            Text("薄荷").tag(IceCreamFlavor.mint)
          } label: {
            HStack {
              Image(systemName: "heart.fill")
                .foregroundColor(.red)
              VStack(alignment: .leading) {
                Text("最喜欢的口味")
                  .font(.headline)
                Text("选择你最爱的冰淇淋口味")
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
          }
        }
      }
      .navigationTitle("基础 Picker 使用")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

// MARK: - 支持类型定义

/// 冰淇淋口味枚举
/// 实现 CaseIterable 和 Identifiable 协议以支持 Picker 使用
public enum IceCreamFlavor: String, CaseIterable, Identifiable {
  case chocolate = "chocolate"
  case vanilla = "vanilla"
  case strawberry = "strawberry"
  case mint = "mint"

  /// Identifiable 协议要求的 id 属性
  public var id: Self { self }

  /// 显示名称
  var displayName: String {
    switch self {
    case .chocolate: return "巧克力"
    case .vanilla: return "香草"
    case .strawberry: return "草莓"
    case .mint: return "薄荷"
    }
  }

  /// 口味描述
  var description: String {
    switch self {
    case .chocolate: return "浓郁香甜的巧克力味"
    case .vanilla: return "经典温和的香草味"
    case .strawberry: return "清新甜美的草莓味"
    case .mint: return "清凉薄荷味"
    }
  }
}

// MARK: - 预览
#Preview {
  PickerExampleView01()
}
