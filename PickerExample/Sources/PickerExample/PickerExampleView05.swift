import SwiftUI

/// PickerExampleView05 - 实际应用场景
/// 展示 Picker 在真实应用中的使用场景
public struct PickerExampleView05: View {
  // MARK: - 状态属性

  // 用户设置
  @State private var language: AppLanguage = .chinese
  @State private var theme: AppTheme = .system
  @State private var fontSize: FontSize = .medium
  @State private var notificationFrequency: NotificationFrequency = .daily

  // 订单表单
  @State private var deliveryMethod: DeliveryMethod = .standard
  @State private var paymentMethod: PaymentMethod = .alipay
  @State private var deliveryTime: DeliveryTime = .morning
  @State private var quantity: Int = 1

  // 搜索过滤器
  @State private var priceRange: PriceRange = .all
  @State private var sortBy: SortOption = .popularity
  @State private var category: ShopCategory = .all
  @State private var brand: Brand = .all

  // 预约系统
  @State private var serviceType: ServiceType = .consultation
  @State private var duration: ServiceDuration = .thirtyMinutes
  @State private var preferredDate: Date = Date()
  @State private var timeSlot: TimeSlot = .morning9to10

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        // MARK: - 应用设置场景
        Section("应用设置") {
          // 语言设置
          Picker("语言", selection: $language) {
            ForEach(AppLanguage.allCases) { lang in
              HStack {
                Text(lang.flag)
                Text(lang.displayName)
              }
              .tag(lang)
            }
          }

          // 主题设置
          Picker("主题", selection: $theme) {
            ForEach(AppTheme.allCases) { theme in
              Label(theme.displayName, systemImage: theme.iconName)
                .tag(theme)
            }
          }
          .pickerStyle(.segmented)

          // 字体大小
          Picker("字体大小", selection: $fontSize) {
            ForEach(FontSize.allCases) { size in
              Text(size.displayName)
                .font(size.font)
                .tag(size)
            }
          }
          .pickerStyle(.wheel)
          .frame(height: 100)

          // 通知频率
          Picker("通知频率", selection: $notificationFrequency) {
            ForEach(NotificationFrequency.allCases) { freq in
              VStack(alignment: .leading) {
                Text(freq.displayName)
                Text(freq.description)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
              .tag(freq)
            }
          }
        }

        // MARK: - 订单表单场景
        Section("订单信息") {
          // 配送方式
          Picker("配送方式", selection: $deliveryMethod) {
            ForEach(DeliveryMethod.allCases) { method in
              VStack(alignment: .leading) {
                HStack {
                  Image(systemName: method.iconName)
                  Text(method.displayName)
                  Spacer()
                  Text(method.priceText)
                    .foregroundColor(.green)
                    .fontWeight(.medium)
                }
                Text(method.description)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
              .tag(method)
            }
          }

          // 支付方式
          Picker("支付方式", selection: $paymentMethod) {
            ForEach(PaymentMethod.allCases) { method in
              HStack {
                Image(systemName: method.iconName)
                  .foregroundColor(method.color)
                Text(method.displayName)
              }
              .tag(method)
            }
          }
          .pickerStyle(.segmented)

          // 配送时间
          HStack {
            Picker("配送时间", selection: $deliveryTime) {
              ForEach(DeliveryTime.allCases) { time in
                Text(time.displayName)
                  .tag(time)
              }
            }
            .pickerStyle(.menu)

            Spacer()

            // 数量选择
            Picker("数量", selection: $quantity) {
              ForEach(1...10, id: \.self) { num in
                Text("\(num)")
                  .tag(num)
              }
            }
            .pickerStyle(.menu)
            .frame(width: 80)
          }

          // 订单总结
          VStack(alignment: .leading, spacing: 4) {
            Text("订单总结")
              .font(.headline)

            HStack {
              Text("配送:")
              Spacer()
              Text("\(deliveryMethod.displayName) (\(deliveryMethod.priceText))")
            }

            HStack {
              Text("支付:")
              Spacer()
              Text(paymentMethod.displayName)
            }

            HStack {
              Text("时间:")
              Spacer()
              Text(deliveryTime.displayName)
            }

            HStack {
              Text("数量:")
              Spacer()
              Text("\(quantity) 件")
            }
          }
          .padding(.vertical, 8)
          .padding(.horizontal, 12)
          .background(Color(.systemGray6))
          .cornerRadius(8)
        }

        // MARK: - 搜索过滤器场景
        Section("商品筛选") {
          // 价格范围
          Picker("价格范围", selection: $priceRange) {
            ForEach(PriceRange.allCases) { range in
              Text(range.displayName)
                .tag(range)
            }
          }
          .pickerStyle(.segmented)

          HStack {
            // 分类筛选
            Picker("分类", selection: $category) {
              ForEach(ShopCategory.allCases) { cat in
                Text(cat.displayName)
                  .tag(cat)
              }
            }
            .pickerStyle(.menu)

            Spacer()

            // 品牌筛选
            Picker("品牌", selection: $brand) {
              ForEach(Brand.allCases) { brand in
                Text(brand.displayName)
                  .tag(brand)
              }
            }
            .pickerStyle(.menu)
          }

          // 排序方式
          Picker("排序方式", selection: $sortBy) {
            ForEach(SortOption.allCases) { option in
              HStack {
                Image(systemName: option.iconName)
                Text(option.displayName)
              }
              .tag(option)
            }
          }

          // 筛选结果预览
          Text(
            "筛选条件: \(priceRange.displayName) | \(category.displayName) | \(brand.displayName) | \(sortBy.displayName)"
          )
          .font(.caption)
          .foregroundColor(.secondary)
          .padding(.vertical, 4)
        }

        // MARK: - 预约系统场景
        Section("服务预约") {
          // 服务类型
          Picker("服务类型", selection: $serviceType) {
            ForEach(ServiceType.allCases) { service in
              VStack(alignment: .leading) {
                HStack {
                  Image(systemName: service.iconName)
                  Text(service.displayName)
                  Spacer()
                  Text("¥\(service.price)")
                    .foregroundColor(.green)
                }
                Text(service.description)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
              .tag(service)
            }
          }

          // 服务时长
          Picker("服务时长", selection: $duration) {
            ForEach(ServiceDuration.allCases) { dur in
              Text(dur.displayName)
                .tag(dur)
            }
          }
          .pickerStyle(.segmented)

          // 预约日期
          DatePicker("预约日期", selection: $preferredDate, displayedComponents: .date)

          // 时间段选择
          Picker("时间段", selection: $timeSlot) {
            ForEach(TimeSlot.allCases) { slot in
              VStack(alignment: .leading) {
                Text(slot.displayName)
                Text(slot.availability)
                  .font(.caption)
                  .foregroundColor(slot.isAvailable ? .green : .red)
              }
              .tag(slot)
            }
          }

          // 预约总结
          VStack(alignment: .leading, spacing: 4) {
            Text("预约信息")
              .font(.headline)

            HStack {
              Text("服务:")
              Spacer()
              Text(serviceType.displayName)
            }

            HStack {
              Text("时长:")
              Spacer()
              Text(duration.displayName)
            }

            HStack {
              Text("时间:")
              Spacer()
              Text(timeSlot.displayName)
            }

            HStack {
              Text("费用:")
              Spacer()
              Text("¥\(serviceType.price)")
                .foregroundColor(.green)
                .fontWeight(.semibold)
            }
          }
          .padding(.vertical, 8)
          .padding(.horizontal, 12)
          .background(Color(.systemBlue).opacity(0.1))
          .cornerRadius(8)
        }
      }
      .navigationTitle("实际应用场景")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

// MARK: - 支持类型定义

// 应用设置相关
public enum AppLanguage: String, CaseIterable, Identifiable {
  case chinese, english, japanese, korean

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .chinese: return "中文"
    case .english: return "English"
    case .japanese: return "日本語"
    case .korean: return "한국어"
    }
  }

  var flag: String {
    switch self {
    case .chinese: return "🇨🇳"
    case .english: return "🇺🇸"
    case .japanese: return "🇯🇵"
    case .korean: return "🇰🇷"
    }
  }
}

public enum AppTheme: String, CaseIterable, Identifiable {
  case light, dark, system

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .light: return "浅色"
    case .dark: return "深色"
    case .system: return "跟随系统"
    }
  }

  var iconName: String {
    switch self {
    case .light: return "sun.max"
    case .dark: return "moon"
    case .system: return "gear"
    }
  }
}

public enum FontSize: String, CaseIterable, Identifiable {
  case small, medium, large, extraLarge

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .small: return "小"
    case .medium: return "中"
    case .large: return "大"
    case .extraLarge: return "特大"
    }
  }

  var font: Font {
    switch self {
    case .small: return .caption
    case .medium: return .body
    case .large: return .title3
    case .extraLarge: return .title2
    }
  }
}

public enum NotificationFrequency: String, CaseIterable, Identifiable {
  case never, daily, weekly, monthly

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .never: return "从不"
    case .daily: return "每日"
    case .weekly: return "每周"
    case .monthly: return "每月"
    }
  }

  var description: String {
    switch self {
    case .never: return "不接收任何通知"
    case .daily: return "每天推送重要消息"
    case .weekly: return "每周汇总推送"
    case .monthly: return "每月总结推送"
    }
  }
}

// 订单相关
public enum DeliveryMethod: String, CaseIterable, Identifiable {
  case standard, express, overnight

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .standard: return "标准配送"
    case .express: return "快速配送"
    case .overnight: return "次日达"
    }
  }

  var iconName: String {
    switch self {
    case .standard: return "truck"
    case .express: return "bolt"
    case .overnight: return "airplane"
    }
  }

  var priceText: String {
    switch self {
    case .standard: return "免费"
    case .express: return "¥15"
    case .overnight: return "¥30"
    }
  }

  var description: String {
    switch self {
    case .standard: return "3-5个工作日送达"
    case .express: return "1-2个工作日送达"
    case .overnight: return "次日上午送达"
    }
  }
}

public enum PaymentMethod: String, CaseIterable, Identifiable {
  case alipay, wechat, card, cash

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .alipay: return "支付宝"
    case .wechat: return "微信"
    case .card: return "银行卡"
    case .cash: return "货到付款"
    }
  }

  var iconName: String {
    switch self {
    case .alipay: return "a.circle.fill"
    case .wechat: return "w.circle.fill"
    case .card: return "creditcard.fill"
    case .cash: return "banknote"
    }
  }

  var color: Color {
    switch self {
    case .alipay: return .blue
    case .wechat: return .green
    case .card: return .orange
    case .cash: return .gray
    }
  }
}

public enum DeliveryTime: String, CaseIterable, Identifiable {
  case morning, afternoon, evening, anytime

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .morning: return "上午 (9:00-12:00)"
    case .afternoon: return "下午 (13:00-17:00)"
    case .evening: return "晚上 (18:00-21:00)"
    case .anytime: return "任意时间"
    }
  }
}

// 搜索筛选相关
public enum PriceRange: String, CaseIterable, Identifiable {
  case all, under100, range100to500, range500to1000, over1000

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .all: return "全部"
    case .under100: return "¥100以下"
    case .range100to500: return "¥100-500"
    case .range500to1000: return "¥500-1000"
    case .over1000: return "¥1000以上"
    }
  }
}

public enum ShopCategory: String, CaseIterable, Identifiable {
  case all, electronics, clothing, books, home, sports

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .all: return "全部分类"
    case .electronics: return "数码电子"
    case .clothing: return "服装鞋帽"
    case .books: return "图书文具"
    case .home: return "家居用品"
    case .sports: return "运动户外"
    }
  }
}

public enum Brand: String, CaseIterable, Identifiable {
  case all, apple, samsung, nike, adidas, uniqlo

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .all: return "全部品牌"
    case .apple: return "Apple"
    case .samsung: return "Samsung"
    case .nike: return "Nike"
    case .adidas: return "Adidas"
    case .uniqlo: return "Uniqlo"
    }
  }
}

public enum SortOption: String, CaseIterable, Identifiable {
  case popularity, priceAsc, priceDesc, newest, rating

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .popularity: return "人气排序"
    case .priceAsc: return "价格从低到高"
    case .priceDesc: return "价格从高到低"
    case .newest: return "最新上架"
    case .rating: return "评分最高"
    }
  }

  var iconName: String {
    switch self {
    case .popularity: return "heart.fill"
    case .priceAsc: return "arrow.up"
    case .priceDesc: return "arrow.down"
    case .newest: return "clock"
    case .rating: return "star.fill"
    }
  }
}

// 预约系统相关
public enum ServiceType: String, CaseIterable, Identifiable {
  case consultation, maintenance, training, customization

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .consultation: return "咨询服务"
    case .maintenance: return "维护服务"
    case .training: return "培训服务"
    case .customization: return "定制服务"
    }
  }

  var iconName: String {
    switch self {
    case .consultation: return "person.2.fill"
    case .maintenance: return "wrench.fill"
    case .training: return "graduationcap.fill"
    case .customization: return "paintbrush.fill"
    }
  }

  var price: Int {
    switch self {
    case .consultation: return 200
    case .maintenance: return 300
    case .training: return 500
    case .customization: return 800
    }
  }

  var description: String {
    switch self {
    case .consultation: return "专业咨询和建议"
    case .maintenance: return "设备维护和检修"
    case .training: return "技能培训和指导"
    case .customization: return "个性化定制服务"
    }
  }
}

public enum ServiceDuration: String, CaseIterable, Identifiable {
  case thirtyMinutes, oneHour, twoHours, halfDay

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .thirtyMinutes: return "30分钟"
    case .oneHour: return "1小时"
    case .twoHours: return "2小时"
    case .halfDay: return "半天"
    }
  }
}

public enum TimeSlot: String, CaseIterable, Identifiable {
  case morning9to10, morning10to11, afternoon2to3, afternoon3to4, evening7to8

  public var id: Self { self }

  var displayName: String {
    switch self {
    case .morning9to10: return "09:00-10:00"
    case .morning10to11: return "10:00-11:00"
    case .afternoon2to3: return "14:00-15:00"
    case .afternoon3to4: return "15:00-16:00"
    case .evening7to8: return "19:00-20:00"
    }
  }

  var isAvailable: Bool {
    switch self {
    case .morning9to10, .afternoon2to3, .evening7to8: return true
    case .morning10to11, .afternoon3to4: return false
    }
  }

  var availability: String {
    return isAvailable ? "可预约" : "已满"
  }
}

// MARK: - 预览
#Preview {
  PickerExampleView05()
}
