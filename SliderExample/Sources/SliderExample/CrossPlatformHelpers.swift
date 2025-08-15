import SwiftUI

/// 跨平台兼容的导航标题修饰符
/// 在 iOS 上使用 navigationBarTitle，在 macOS 上使用 navigationTitle
struct CrossPlatformNavigationTitle: ViewModifier {
  let title: String

  func body(content: Content) -> some View {
    #if os(iOS)
      content.navigationBarTitle(title, displayMode: .inline)
    #elseif os(macOS)
      if #available(macOS 11.0, *) {
        content.navigationTitle(title)
      } else {
        content
      }
    #else
      content
    #endif
  }
}

/// 跨平台兼容的 SF Symbols 图标
struct CrossPlatformIcon: View {
  let systemName: String
  let fallbackText: String

  init(systemName: String, fallbackText: String = "●") {
    self.systemName = systemName
    self.fallbackText = fallbackText
  }

  var body: some View {
    #if os(iOS)
      Image(systemName: systemName)
    #elseif os(macOS)
      if #available(macOS 11.0, *) {
        Image(systemName: systemName)
      } else {
        Text(fallbackText)
      }
    #else
      Text(fallbackText)
    #endif
  }
}

/// 跨平台兼容的星级评分视图
struct CrossPlatformStarRating: View {
  let rating: Double
  let maxRating: Int = 5

  var body: some View {
    HStack(spacing: 2) {
      ForEach(1...maxRating, id: \.self) { star in
        starIcon(for: star)
          .foregroundColor(.yellow)
      }
    }
  }

  @ViewBuilder
  private func starIcon(for star: Int) -> some View {
    #if os(iOS)
      Image(
        systemName: star <= Int(rating)
          ? "star.fill" : (Double(star) - 0.5 <= rating ? "star.leadinghalf.filled" : "star"))
    #elseif os(macOS)
      if #available(macOS 11.0, *) {
        Image(
          systemName: star <= Int(rating)
            ? "star.fill" : (Double(star) - 0.5 <= rating ? "star.leadinghalf.filled" : "star"))
      } else {
        Text(star <= Int(rating) ? "★" : (Double(star) - 0.5 <= rating ? "⭐" : "☆"))
      }
    #else
      Text(star <= Int(rating) ? "★" : (Double(star) - 0.5 <= rating ? "⭐" : "☆"))
    #endif
  }
}
