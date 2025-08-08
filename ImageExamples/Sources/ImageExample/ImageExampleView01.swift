//
//  ImageExampleView01.swift
//  ImageExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Image 基础图片加载和显示示例
/// 展示 Image 组件的各种初始化方式和基本显示功能
struct ImageExampleView01: View {

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {

        // MARK: - SF Symbols 系统图标
        VStack(alignment: .leading, spacing: 12) {
          Text("SF Symbols 系统图标")
            .font(.headline)
            .foregroundColor(.primary)

          // 基础 SF Symbol 图标显示
          HStack(spacing: 15) {
            Image(systemName: "heart")
              .foregroundColor(.red)
            
            Image(systemName: "star")
              .foregroundColor(.yellow)
            
            Image(systemName: "person")
              .foregroundColor(.blue)
            
            Image(systemName: "house")
              .foregroundColor(.green)
          }
          .font(.title)

          // 不同尺寸的 SF Symbol
          VStack(alignment: .leading, spacing: 8) {
            Text("不同尺寸的 SF Symbol:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 10) {
              Image(systemName: "gear")
                .font(.caption)
              Image(systemName: "gear")
                .font(.body)
              Image(systemName: "gear")
                .font(.title3)
              Image(systemName: "gear")
                .font(.title)
              Image(systemName: "gear")
                .font(.largeTitle)
            }
            .foregroundColor(.primary)
          }

          // SF Symbol 变体
          VStack(alignment: .leading, spacing: 8) {
            Text("SF Symbol 变体:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              Image(systemName: "heart")
              Image(systemName: "heart.fill")
              Image(systemName: "heart.circle")
              Image(systemName: "heart.circle.fill")
            }
            .font(.title2)
            .foregroundColor(.red)
          }
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)

        // MARK: - Bundle 资源图片
        VStack(alignment: .leading, spacing: 12) {
          Text("Bundle 资源图片")
            .font(.headline)
            .foregroundColor(.primary)

          // 注意：在实际应用中，你需要将图片添加到 App Bundle 中
          // 这里使用占位符来演示不同的初始化方式
          VStack(alignment: .leading, spacing: 8) {
            Text("加载 Bundle 中的图片资源:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            // 使用图片名称加载（需要添加到 Bundle）
            // Image("sample-image")  // 实际项目中取消注释
            
            // 使用占位符图片演示布局
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.gray.opacity(0.3))
              .frame(width: 120, height: 80)
              .overlay(
                VStack {
                  Image(systemName: "photo")
                    .font(.title2)
                  Text("Bundle Image")
                    .font(.caption)
                }
                .foregroundColor(.gray)
              )
          }

          VStack(alignment: .leading, spacing: 8) {
            Text("指定 Bundle 加载图片:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            // 从指定 Bundle 加载图片
            // Image("image-name", bundle: .main)  // 实际项目中取消注释
            
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.blue.opacity(0.3))
              .frame(width: 120, height: 80)
              .overlay(
                VStack {
                  Image(systemName: "folder")
                    .font(.title2)
                  Text("Bundle Specific")
                    .font(.caption)
                }
                .foregroundColor(.blue)
              )
          }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 图片初始化选项
        VStack(alignment: .leading, spacing: 12) {
          Text("图片初始化选项")
            .font(.headline)
            .foregroundColor(.primary)

          // 使用 ImageResource 初始化（iOS 17+）
          VStack(alignment: .leading, spacing: 8) {
            Text("不同的初始化方式:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 4) {
              // 系统图标
              HStack {
                Image(systemName: "camera")
                Text("systemName: 加载 SF Symbols")
              }
              
              // Bundle 图片
              HStack {
                Image(systemName: "photo")
                Text("imageName: 加载 Bundle 资源")
              }
              
              // 可选图片（处理加载失败情况）
              HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("可选图片处理加载失败")
              }
            }
            .font(.body)
          }

          // 图片状态说明
          VStack(alignment: .leading, spacing: 8) {
            Text("图片加载状态:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
              // 成功状态
              VStack {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(.green)
                  .font(.title2)
                Text("加载成功")
                  .font(.caption)
              }
              
              // 加载中状态
              VStack {
                Image(systemName: "clock")
                  .foregroundColor(.orange)
                  .font(.title2)
                Text("加载中")
                  .font(.caption)
              }
              
              // 失败状态
              VStack {
                Image(systemName: "xmark.circle.fill")
                  .foregroundColor(.red)
                  .font(.title2)
                Text("加载失败")
                  .font(.caption)
              }
            }
          }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 图片属性展示
        VStack(alignment: .leading, spacing: 12) {
          Text("图片基本属性")
            .font(.headline)
            .foregroundColor(.primary)

          // 图片默认显示
          VStack(alignment: .leading, spacing: 8) {
            Text("默认显示方式:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
              // 原始大小显示
              VStack {
                Image(systemName: "photo")
                  .font(.largeTitle)
                Text("原始大小")
                  .font(.caption)
              }
              
              // 带边框显示
              VStack {
                Image(systemName: "photo.fill")
                  .font(.largeTitle)
                  .foregroundColor(.blue)
                Text("带颜色")
                  .font(.caption)
              }
            }
          }

          // 图片信息说明
          VStack(alignment: .leading, spacing: 4) {
            Text("• SF Symbols 可以像文本一样设置颜色和字体大小")
            Text("• Bundle 图片默认以原始尺寸显示")
            Text("• 图片初始化失败时会显示占位符或空白")
            Text("• resizable() 修饰符可以让图片适应容器大小")
          }
          .font(.footnote)
          .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)

      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
    .frame(maxWidth: .infinity)
    .navigationTitle("基础图片显示")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

#Preview {
  NavigationStack {
    ImageExampleView01()
  }
}