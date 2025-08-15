import SwiftUI

/// PickerExampleView04 - 高级用法示例
/// 展示 Picker 的高级使用技巧和复杂场景
public struct PickerExampleView04: View {
  // MARK: - 状态属性

  /// 多级选择 - 类别
  @State private var selectedCategory: ProductCategory = .electronics

  /// 多级选择 - 产品
  @State private var selectedProduct: Product = Product.sampleProducts[0]

  /// 自定义验证
  @State private var selectedAge: Int = 18
  @State private var ageValidationMessage: String = ""

  /// 条件选择
  @State private var isVIPMember: Bool = false
  @State private var selectedMembershipLevel: MembershipLevel = .bronze

  /// 多个相关的选择器
  @State private var selectedHour: Int = 9
  @State private var selectedMinute: Int = 0
  @State private var selectedPeriod: TimePeriod = .am

  /// 动态选项
  @State private var availableColors: [ProductColor] = ProductColor.allCases
  @State private var selectedColor: ProductColor = .red

  /// 根据类别过滤的产品
  private var filteredProducts: [Product] {
    Product.sampleProducts.filter { $0.category == selectedCategory }
  }

  /// 格式化的时间显示
  private var formattedTime: String {
    let hour12 = selectedPeriod == .am ? selectedHour : selectedHour + 12
    return String(
      format: "%02d:%02d %@", hour12, selectedMinute, selectedPeriod.rawValue.uppercased())
  }

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 多级级联选择
        Section("多级级联选择") {
          // 第一级：类别选择
          Picker("产品类别", selection: $selectedCategory) {
            ForEach(ProductCategory.allCases) { category in
              HStack {
                Image(systemName: category.iconName)
                Text(category.displayName)
              }
              .tag(category)
            }
          }
          .pickerStyle(.segmented)

          // 第二级：产品选择（依赖于类别）
          Picker("选择产品", selection: $selectedProduct) {
            ForEach(filteredProducts) { product in
              VStack(alignment: .leading) {
                Text(product.name)
                  .fontWeight(.medium)
                Text("¥\(product.price)")
                  .font(.caption)
                  .foregroundColor(.green)
              }
              .tag(product)
            }
          }
          .onChange(of: selectedCategory) { newCategory in
            // 类别改变时，自动选择该类别的第一个产品
            if let firstProduct = filteredProducts.first {
              selectedProduct = firstProduct
            }
          }

          // 显示选择结果
          VStack(alignment: .leading, spacing: 4) {
            HStack {
              Text("选择的产品:")
              Spacer()
              Text(selectedProduct.name)
                .foregroundColor(.blue)
                .fontWeight(.medium)
            }
            HStack {
              Text("价格:")
              Spacer()
              Text("¥\(selectedProduct.price)")
                .foregroundColor(.green)
                .fontWeight(.semibold)
            }
          }
        }

        // MARK: - 带验证的选择器
        Section("带验证的选择器") {
          VStack(alignment: .leading, spacing: 8) {
            Picker("选择年龄", selection: $selectedAge) {
              ForEach(1...100, id: \.self) { age in
                Text("\(age) 岁")
                  .tag(age)
              }
            }
            .pickerStyle(.wheel)
            .frame(height: 100)
            .onChange(of: selectedAge) { newAge in
              validateAge(newAge)
            }

            // 验证消息显示
            if !ageValidationMessage.isEmpty {
              Text(ageValidationMessage)
                .font(.caption)
                .foregroundColor(selectedAge >= 18 ? .green : .red)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                  (selectedAge >= 18 ? Color.green : Color.red)
                    .opacity(0.1)
                )
                .cornerRadius(6)
            }
          }
        }

        // MARK: - 条件选择器
        Section("条件选择器") {
          // VIP 会员开关
          Toggle("VIP 会员", isOn: $isVIPMember)
            .onChange(of: isVIPMember) { newValue in
              if !newValue {
                selectedMembershipLevel = .bronze
              }
            }

          // 只有 VIP 会员才能选择高级会员等级
          if isVIPMember {
            Picker("会员等级", selection: $selectedMembershipLevel) {
              ForEach(MembershipLevel.allCases) { level in
                HStack {
                  Image(systemName: level.iconName)
                    .foregroundColor(level.color)
                  Text(level.displayName)
                }
                .tag(level)
              }
            }
            .pickerStyle(.segmented)

            // 显示会员权益
            VStack(alignment: .leading, spacing: 4) {
              Text("会员权益:")
                .font(.caption)
                .foregroundColor(.secondary)

              ForEach(selectedMembershipLevel.benefits, id: \.self) { benefit in
                HStack {
                  Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.caption)
                  Text(benefit)
                    .font(.caption)
                }
              }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(selectedMembershipLevel.color.opacity(0.1))
            .cornerRadius(8)
          }
        }

        // MARK: - 多个相关选择器（时间选择）
        Section("时间选择器组合") {
          HStack(spacing: 0) {
            // 小时选择
            Picker("小时", selection: $selectedHour) {
              ForEach(1...12, id: \.self) { hour in
                Text("\(hour)")
                  .tag(hour)
              }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)

            Text(":")
              .font(.title2)
              .fontWeight(.bold)

            // 分钟选择
            Picker("分钟", selection: $selectedMinute) {
              ForEach(Array(stride(from: 0, to: 60, by: 5)), id: \.self) { minute in
                Text(String(format: "%02d", minute))
                  .tag(minute)
              }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)

            // 上午/下午选择
            Picker("时段", selection: $selectedPeriod) {
              ForEach(TimePeriod.allCases, id: \.self) { period in
                Text(period.displayName)
                  .tag(period)
              }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
          }
          .frame(height: 120)

          // 显示完整时间
          HStack {
            Text("选择的时间:")
            Spacer()
            Text(formattedTime)
              .foregroundColor(.blue)
              .fontWeight(.bold)
              .font(.title3)
          }
        }

        // MARK: - 动态选项更新
        Section("动态选项更新") {
          // 颜色选择
          Picker("选择颜色", selection: $selectedColor) {
            ForEach(availableColors) { color in
              HStack {
                Circle()
                  .fill(color.swiftUIColor)
                  .frame(width: 20, height: 20)
                Text(color.displayName)
              }
              .tag(color)
            }
          }

          // 动态添加/移除选项的按钮
          HStack {
            Button("随机移除颜色") {
              if availableColors.count > 1 {
                availableColors.removeAll { $0 == availableColors.randomElement() }
                // 如果当前选择的颜色被移除，选择第一个可用颜色
                if !availableColors.contains(selectedColor) {
                  selectedColor = availableColors.first ?? .red
                }
              }
            }
            .disabled(availableColors.count <= 1)

            Spacer()

            Button("重置所有颜色") {
              availableColors = ProductColor.allCases
              selectedColor = .red
            }
          }
          .buttonStyle(.bordered)

          Text("可用颜色数量: \(availableColors.count)")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      .navigationTitle("高级用法")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        validateAge(selectedAge)
      }
    }
  }

  // MARK: - 私有方法

  /// 验证年龄
  private func validateAge(_ age: Int) {
    if age < 18 {
      ageValidationMessage = "未成年用户，部分功能受限"
    } else if age >= 18 && age < 65 {
      ageValidationMessage = "成年用户，享受完整功能"
    } else {
      ageValidationMessage = "长者用户，享受专属优惠"
    }
  }
}

// MARK: - 支持类型定义

/// 产品类别枚举
public enum ProductCategory: String, CaseIterable, Identifiable, Sendable {
  case electronics = "electronics"
  case clothing = "clothing"
  case books = "books"
  case sports = "sports"

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .electronics: return "电子产品"
    case .clothing: return "服装"
    case .books: return "图书"
    case .sports: return "运动用品"
    }
  }

  var iconName: String {
    switch self {
    case .electronics: return "laptopcomputer"
    case .clothing: return "tshirt"
    case .books: return "book"
    case .sports: return "sportscourt"
    }
  }
}

/// 产品数据模型
public struct Product: Identifiable, Equatable, Hashable, Sendable {
  public let id = UUID()
  let name: String
  let category: ProductCategory
  let price: Int

  nonisolated(unsafe) static let sampleProducts = [
    // 电子产品
    Product(name: "iPhone 15", category: .electronics, price: 5999),
    Product(name: "MacBook Pro", category: .electronics, price: 14999),
    Product(name: "iPad Air", category: .electronics, price: 4399),
    Product(name: "AirPods Pro", category: .electronics, price: 1899),

    // 服装
    Product(name: "休闲T恤", category: .clothing, price: 199),
    Product(name: "牛仔裤", category: .clothing, price: 399),
    Product(name: "运动鞋", category: .clothing, price: 699),
    Product(name: "羽绒服", category: .clothing, price: 899),

    // 图书
    Product(name: "Swift 编程指南", category: .books, price: 89),
    Product(name: "设计模式", category: .books, price: 79),
    Product(name: "算法导论", category: .books, price: 129),
    Product(name: "iOS 开发实战", category: .books, price: 99),

    // 运动用品
    Product(name: "篮球", category: .sports, price: 299),
    Product(name: "跑步机", category: .sports, price: 2999),
    Product(name: "瑜伽垫", category: .sports, price: 159),
    Product(name: "哑铃套装", category: .sports, price: 599),
  ]
}

/// 会员等级枚举
public enum MembershipLevel: String, CaseIterable, Identifiable {
  case bronze = "bronze"
  case silver = "silver"
  case gold = "gold"
  case platinum = "platinum"

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .bronze: return "青铜"
    case .silver: return "白银"
    case .gold: return "黄金"
    case .platinum: return "铂金"
    }
  }

  var iconName: String {
    switch self {
    case .bronze: return "3.circle.fill"
    case .silver: return "2.circle.fill"
    case .gold: return "1.circle.fill"
    case .platinum: return "crown.fill"
    }
  }

  var color: Color {
    switch self {
    case .bronze: return .brown
    case .silver: return .gray
    case .gold: return .yellow
    case .platinum: return .purple
    }
  }

  var benefits: [String] {
    switch self {
    case .bronze:
      return ["基础会员权益", "生日优惠券"]
    case .silver:
      return ["基础会员权益", "生日优惠券", "免费配送", "专属客服"]
    case .gold:
      return ["基础会员权益", "生日优惠券", "免费配送", "专属客服", "积分翻倍", "优先退换货"]
    case .platinum:
      return ["基础会员权益", "生日优惠券", "免费配送", "专属客服", "积分翻倍", "优先退换货", "专属活动", "年度大礼包"]
    }
  }
}

/// 时间段枚举
public enum TimePeriod: String, CaseIterable {
  case am = "am"
  case pm = "pm"

  var displayName: String {
    switch self {
    case .am: return "上午"
    case .pm: return "下午"
    }
  }
}

/// 产品颜色枚举
public enum ProductColor: String, CaseIterable, Identifiable {
  case red, blue, green, yellow, purple, orange, pink, black, white, gray

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .red: return "红色"
    case .blue: return "蓝色"
    case .green: return "绿色"
    case .yellow: return "黄色"
    case .purple: return "紫色"
    case .orange: return "橙色"
    case .pink: return "粉色"
    case .black: return "黑色"
    case .white: return "白色"
    case .gray: return "灰色"
    }
  }

  var swiftUIColor: Color {
    switch self {
    case .red: return .red
    case .blue: return .blue
    case .green: return .green
    case .yellow: return .yellow
    case .purple: return .purple
    case .orange: return .orange
    case .pink: return .pink
    case .black: return .black
    case .white: return .white
    case .gray: return .gray
    }
  }
}

// MARK: - 预览
#Preview {
  PickerExampleView04()
}
