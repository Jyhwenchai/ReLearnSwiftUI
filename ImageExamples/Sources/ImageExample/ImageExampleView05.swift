//
//  ImageExampleView05.swift
//  ImageExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Image 异步加载和高级功能示例
/// 展示 AsyncImage 异步加载和其他高级图片处理功能
struct ImageExampleView05: View {
  @State private var imageScale: Double = 1.0
  @State private var imageRotation: Double = 0.0

  enum LoadingState {
    case idle, loading, success, failure
  }

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 20) {
        asyncImageBasicsSection
        loadingStateSection
        performanceSection
        transformationSection
        advancedSection
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
    .navigationTitle("异步加载和高级功能")
    #if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

extension ImageExampleView05 {
  private var asyncImageBasicsSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("AsyncImage 基础用法")
        .font(.headline)
        .foregroundColor(.primary)

      Text("异步图片加载是现代应用的必备功能，用于从网络加载图片。")
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.blue.opacity(0.1))
    .cornerRadius(8)
  }

  private var loadingStateSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("加载状态管理")
        .font(.headline)
        .foregroundColor(.primary)

      HStack(spacing: 20) {
        loadingStateView(state: .idle, label: "空闲", color: .gray)
        loadingStateView(state: .loading, label: "加载中", color: .blue)
        loadingStateView(state: .success, label: "成功", color: .green)
        loadingStateView(state: .failure, label: "失败", color: .red)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(8)
  }

  private var performanceSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("性能优化")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        performanceTip(icon: "internaldrive", title: "内存缓存", description: "自动缓存最近加载的图片")
        performanceTip(icon: "externaldrive", title: "磁盘缓存", description: "持久化存储已下载的图片")
        performanceTip(icon: "speedometer", title: "延迟加载", description: "使用 LazyVStack 优化长列表")
      }
    }
    .padding()
    .background(Color.orange.opacity(0.1))
    .cornerRadius(8)
  }

  private var transformationSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("图片变换")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(spacing: 16) {
        controlSlider(title: "缩放", value: $imageScale, range: 0.5...2.0)
        controlSlider(title: "旋转", value: $imageRotation, range: 0...360)

        Image(systemName: "photo.artframe")
          .resizable()
          .frame(width: 80, height: 80)
          .scaleEffect(imageScale)
          .rotationEffect(.degrees(imageRotation))
          .animation(.easeInOut(duration: 0.3), value: imageScale)
          .animation(.easeInOut(duration: 0.3), value: imageRotation)
          .padding(40)
          .background(Color.purple.opacity(0.1))
          .cornerRadius(12)
      }
    }
    .padding()
    .background(Color.purple.opacity(0.1))
    .cornerRadius(8)
  }

  private var advancedSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("高级功能")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        Text("🚀 高级技巧:")
          .font(.subheadline)
          .fontWeight(.medium)
        Text("• 合理使用 AsyncImage 的 phase 状态")
        Text("• 结合动画创建流畅的加载体验")
        Text("• 使用适当的占位符和错误状态")
        Text("• 考虑网络状况，提供离线占位符")
      }
      .font(.footnote)
      .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.cyan.opacity(0.1))
    .cornerRadius(8)
  }

  // MARK: - Helper Views
  private func loadingStateView(state: LoadingState, label: String, color: Color) -> some View {
    VStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(color.opacity(0.1))
        .frame(width: 60, height: 60)
        .overlay(
          Group {
            switch state {
            case .idle:
              Image(systemName: "photo.badge.plus")
            case .loading:
              ProgressView().scaleEffect(0.8)
            case .success:
              Image(systemName: "checkmark.circle.fill")
            case .failure:
              Image(systemName: "xmark.circle.fill")
            }
          }
          .foregroundColor(color)
        )
      Text(label)
        .font(.caption)
    }
  }

  private func performanceTip(icon: String, title: String, description: String) -> some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(.orange)
        .frame(width: 24)
      VStack(alignment: .leading) {
        Text(title)
          .font(.caption)
          .fontWeight(.medium)
        Text(description)
          .font(.caption2)
          .foregroundColor(.secondary)
      }
      Spacer()
    }
  }

  private func controlSlider(title: String, value: Binding<Double>, range: ClosedRange<Double>) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("\(title): \(Int(value.wrappedValue))")
        .font(.subheadline)
      Slider(value: value, in: range)
        .accentColor(.purple)
    }
  }
}

#Preview {
  NavigationStack {
    ImageExampleView05()
  }
}