import SwiftUI

/// PickerExampleView03 - 与 ForEach 结合使用
/// 展示如何使用 ForEach 动态生成 Picker 选项
public struct PickerExampleView03: View {
  // MARK: - 状态属性

  /// 选中的国家
  @State private var selectedCountry: Country = Country.sampleCountries[0]

  /// 选中的城市
  @State private var selectedCity: City = City.sampleCities[0]

  /// 选中的编程语言
  @State private var selectedLanguage: ProgrammingLanguage = ProgrammingLanguage.sampleLanguages[0]

  /// 选中的年份
  @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())

  /// 选中的月份
  @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())

  /// 根据选中国家过滤的城市
  private var filteredCities: [City] {
    City.sampleCities.filter { $0.countryCode == selectedCountry.code }
  }

  public init() {}

  public var body: some View {
    NavigationView {
      Form {
        basicForEachSection
        cascadingSelectionSection
        complexObjectSection
        numericRangeSection
        dynamicDataSection
      }
      .navigationTitle("ForEach 结合使用")
      .navigationBarTitleDisplayMode(.inline)
    }
  }

  // MARK: - 视图组件

  private var basicForEachSection: some View {
    Section("基础 ForEach 使用") {
      // 使用 ForEach 遍历数组创建选项
      Picker("选择国家", selection: $selectedCountry) {
        ForEach(Country.sampleCountries) { country in
          HStack {
            Text(country.flag)
            Text(country.name)
          }
          .tag(country)
        }
      }

      // 显示选择结果
      HStack {
        Text("选择的国家:")
        Spacer()
        Text("\(selectedCountry.flag) \(selectedCountry.name)")
          .foregroundColor(.secondary)
      }
    }
  }

  private var cascadingSelectionSection: some View {
    Section("级联选择") {
      // 城市选择依赖于国家选择
      Picker("选择城市", selection: $selectedCity) {
        ForEach(filteredCities) { city in
          Text(city.name)
            .tag(city)
        }
      }
      .onChange(of: selectedCountry) { newCountry in
        // 当国家改变时，自动选择该国家的第一个城市
        if let firstCity = filteredCities.first {
          selectedCity = firstCity
        }
      }

      HStack {
        Text("选择的城市:")
        Spacer()
        Text(selectedCity.name)
          .foregroundColor(.secondary)
      }

      HStack {
        Text("完整地址:")
        Spacer()
        Text("\(selectedCountry.name), \(selectedCity.name)")
          .foregroundColor(.blue)
          .fontWeight(.medium)
      }
    }
  }

  private var complexObjectSection: some View {
    Section("复杂对象选择") {
      // 使用复杂对象创建 Picker
      Picker("编程语言", selection: $selectedLanguage) {
        ForEach(ProgrammingLanguage.sampleLanguages) { language in
          VStack(alignment: .leading) {
            Text(language.name)
              .fontWeight(.medium)
            Text(language.category)
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .tag(language)
        }
      }

      // 显示详细信息
      languageDetailsView
    }
  }

  private var languageDetailsView: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Text("语言:")
        Spacer()
        Text(selectedLanguage.name)
          .foregroundColor(.secondary)
      }

      HStack {
        Text("类型:")
        Spacer()
        Text(selectedLanguage.category)
          .foregroundColor(.secondary)
      }

      HStack {
        Text("年份:")
        Spacer()
        Text("\(selectedLanguage.year)")
          .foregroundColor(.secondary)
      }

      HStack {
        Text("描述:")
        Spacer()
      }
      Text(selectedLanguage.description)
        .font(.caption)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.leading)
    }
  }

  private var numericRangeSection: some View {
    Section("数值范围选择") {
      // 年份选择
      Picker("选择年份", selection: $selectedYear) {
        ForEach(2020...2030, id: \.self) { year in
          Text("\(year)年")
            .tag(year)
        }
      }
      .pickerStyle(.wheel)
      .frame(height: 100)

      // 月份选择
      Picker("选择月份", selection: $selectedMonth) {
        ForEach(1...12, id: \.self) { month in
          Text("\(month)月")
            .tag(month)
        }
      }
      .pickerStyle(.wheel)
      .frame(height: 100)

      // 显示选择的日期
      HStack {
        Text("选择的日期:")
        Spacer()
        Text("\(selectedYear)年\(selectedMonth)月")
          .foregroundColor(.green)
          .fontWeight(.semibold)
      }
    }
  }

  private var dynamicDataSection: some View {
    Section("动态数据处理") {
      VStack(alignment: .leading, spacing: 8) {
        Text("ForEach 使用要点:")
          .font(.headline)

        VStack(alignment: .leading, spacing: 4) {
          Text("• 数据必须遵循 Identifiable 协议")
          Text("• 或者使用 id: \\.self 指定标识符")
          Text("• tag() 修饰符用于设置选择值")
          Text("• 可以使用 onChange 监听选择变化")
          Text("• 支持级联选择和条件过滤")
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 12)
      .background(Color(.systemBlue).opacity(0.1))
      .cornerRadius(8)
    }
  }
}

// MARK: - 支持类型定义

/// 国家数据模型
public struct Country: Identifiable, Equatable, Hashable, Sendable {
  public let id = UUID()
  let name: String
  let code: String
  let flag: String

  nonisolated(unsafe) static let sampleCountries = [
    Country(name: "中国", code: "CN", flag: "🇨🇳"),
    Country(name: "美国", code: "US", flag: "🇺🇸"),
    Country(name: "日本", code: "JP", flag: "🇯🇵"),
    Country(name: "英国", code: "GB", flag: "🇬🇧"),
    Country(name: "法国", code: "FR", flag: "🇫🇷"),
    Country(name: "德国", code: "DE", flag: "🇩🇪"),
  ]
}

/// 城市数据模型
public struct City: Identifiable, Equatable, Hashable, Sendable {
  public let id = UUID()
  let name: String
  let countryCode: String

  nonisolated(unsafe) static let sampleCities = [
    // 中国城市
    City(name: "北京", countryCode: "CN"),
    City(name: "上海", countryCode: "CN"),
    City(name: "深圳", countryCode: "CN"),
    City(name: "广州", countryCode: "CN"),

    // 美国城市
    City(name: "纽约", countryCode: "US"),
    City(name: "洛杉矶", countryCode: "US"),
    City(name: "芝加哥", countryCode: "US"),
    City(name: "旧金山", countryCode: "US"),

    // 日本城市
    City(name: "东京", countryCode: "JP"),
    City(name: "大阪", countryCode: "JP"),
    City(name: "京都", countryCode: "JP"),

    // 英国城市
    City(name: "伦敦", countryCode: "GB"),
    City(name: "曼彻斯特", countryCode: "GB"),
    City(name: "爱丁堡", countryCode: "GB"),

    // 法国城市
    City(name: "巴黎", countryCode: "FR"),
    City(name: "里昂", countryCode: "FR"),
    City(name: "马赛", countryCode: "FR"),

    // 德国城市
    City(name: "柏林", countryCode: "DE"),
    City(name: "慕尼黑", countryCode: "DE"),
    City(name: "汉堡", countryCode: "DE"),
  ]
}

/// 编程语言数据模型
public struct ProgrammingLanguage: Identifiable, Equatable, Hashable, Sendable {
  public let id = UUID()
  let name: String
  let category: String
  let year: Int
  let description: String

  nonisolated(unsafe) static let sampleLanguages = [
    ProgrammingLanguage(
      name: "Swift",
      category: "编译型",
      year: 2014,
      description: "苹果开发的现代编程语言，用于 iOS 和 macOS 开发"
    ),
    ProgrammingLanguage(
      name: "Python",
      category: "解释型",
      year: 1991,
      description: "简洁易学的编程语言，广泛用于数据科学和 Web 开发"
    ),
    ProgrammingLanguage(
      name: "JavaScript",
      category: "解释型",
      year: 1995,
      description: "Web 开发的核心语言，支持前端和后端开发"
    ),
    ProgrammingLanguage(
      name: "Java",
      category: "编译型",
      year: 1995,
      description: "跨平台的面向对象编程语言，企业级应用首选"
    ),
    ProgrammingLanguage(
      name: "C++",
      category: "编译型",
      year: 1985,
      description: "高性能的系统编程语言，广泛用于游戏和系统开发"
    ),
    ProgrammingLanguage(
      name: "Rust",
      category: "编译型",
      year: 2010,
      description: "内存安全的系统编程语言，性能优异"
    ),
  ]
}

// MARK: - 预览
#Preview {
  PickerExampleView03()
}
