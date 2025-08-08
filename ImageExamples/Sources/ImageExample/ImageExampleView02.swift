//
//  ImageExampleView02.swift
//  ImageExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Image 图片尺寸和缩放示例
/// 展示 Image 组件的尺寸控制和缩放模式
struct ImageExampleView02: View {
  @State private var imageSize: CGFloat = 100
  @State private var aspectRatio: CGFloat = 1.0

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {

        // MARK: - resizable() 可调整大小
        VStack(alignment: .leading, spacing: 12) {
          Text("resizable() 可调整大小")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("未使用 resizable() 的图片:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
              // 原始大小，无法调整
              Image(systemName: "photo")
                .font(.largeTitle)
                .frame(width: 60, height: 60)
                .background(Color.red.opacity(0.2))
                .overlay(
                  Text("固定大小")
                    .font(.caption2)
                    .foregroundColor(.red),
                  alignment: .bottom
                )
              
              Text("frame 无效果")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }

          VStack(alignment: .leading, spacing: 8) {
            Text("使用 resizable() 的图片:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
              // 使用 resizable，可以调整大小
              Image(systemName: "photo")
                .resizable()
                .frame(width: 60, height: 60)
                .background(Color.green.opacity(0.2))
                .overlay(
                  Text("可调整")
                    .font(.caption2)
                    .foregroundColor(.green),
                  alignment: .bottom
                )
              
              Text("frame 生效")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 缩放模式对比
        VStack(alignment: .leading, spacing: 12) {
          Text("缩放模式对比")
            .font(.headline)
            .foregroundColor(.primary)

          // scaledToFit 适应填充
          VStack(alignment: .leading, spacing: 8) {
            Text("scaledToFit - 适应容器，保持比例:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 正方形容器
              Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .background(Color.blue.opacity(0.2))
              
              // 矩形容器（宽）
              Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 60)
                .background(Color.blue.opacity(0.2))
              
              // 矩形容器（高）
              Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 120)
                .background(Color.blue.opacity(0.2))
            }
          }

          // scaledToFill 填满容器
          VStack(alignment: .leading, spacing: 8) {
            Text("scaledToFill - 填满容器，可能裁剪:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 正方形容器
              Image(systemName: "photo.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .background(Color.orange.opacity(0.2))
                .clipped()
              
              // 矩形容器（宽）
              Image(systemName: "photo.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 60)
                .background(Color.orange.opacity(0.2))
                .clipped()
              
              // 矩形容器（高）
              Image(systemName: "photo.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 120)
                .background(Color.orange.opacity(0.2))
                .clipped()
            }
          }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)

        // MARK: - aspectRatio 纵横比控制
        VStack(alignment: .leading, spacing: 12) {
          Text("aspectRatio 纵横比控制")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("不同纵横比的图片:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 1:1 正方形
              VStack {
                Image(systemName: "square")
                  .resizable()
                  .aspectRatio(1.0, contentMode: .fit)
                  .frame(height: 60)
                  .foregroundColor(.purple)
                Text("1:1")
                  .font(.caption2)
              }
              
              // 16:9 宽屏
              VStack {
                Image(systemName: "rectangle")
                  .resizable()
                  .aspectRatio(16/9, contentMode: .fit)
                  .frame(height: 60)
                  .foregroundColor(.purple)
                Text("16:9")
                  .font(.caption2)
              }
              
              // 4:3 传统比例
              VStack {
                Image(systemName: "rectangle")
                  .resizable()
                  .aspectRatio(4/3, contentMode: .fit)
                  .frame(height: 60)
                  .foregroundColor(.purple)
                Text("4:3")
                  .font(.caption2)
              }
            }
          }

          VStack(alignment: .leading, spacing: 8) {
            Text("纵横比与内容模式组合:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // .fit 模式
              VStack {
                Image(systemName: "photo.fill.on.rectangle.fill")
                  .resizable()
                  .aspectRatio(1.0, contentMode: .fit)
                  .frame(width: 80, height: 80)
                  .background(Color.green.opacity(0.2))
                Text(".fit")
                  .font(.caption2)
              }
              
              // .fill 模式
              VStack {
                Image(systemName: "photo.fill.on.rectangle.fill")
                  .resizable()
                  .aspectRatio(1.0, contentMode: .fill)
                  .frame(width: 80, height: 80)
                  .background(Color.red.opacity(0.2))
                  .clipped()
                Text(".fill")
                  .font(.caption2)
              }
            }
          }
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 交互式尺寸控制
        VStack(alignment: .leading, spacing: 12) {
          Text("交互式尺寸控制")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(spacing: 16) {
            // 大小滑块
            VStack(alignment: .leading, spacing: 8) {
              Text("图片大小: \(Int(imageSize))")
                .font(.subheadline)
              
              Slider(value: $imageSize, in: 50...200, step: 10)
                .accentColor(.blue)
            }

            // 纵横比滑块
            VStack(alignment: .leading, spacing: 8) {
              Text("纵横比: \(aspectRatio, specifier: "%.1f")")
                .font(.subheadline)
              
              Slider(value: $aspectRatio, in: 0.5...2.0, step: 0.1)
                .accentColor(.green)
            }

            // 实时预览
            VStack {
              Text("实时预览:")
                .font(.subheadline)
                .foregroundColor(.secondary)
              
              Image(systemName: "photo.artframe")
                .resizable()
                .aspectRatio(aspectRatio, contentMode: .fit)
                .frame(width: imageSize, height: imageSize)
                .background(Color.orange.opacity(0.2))
                .cornerRadius(8)
            }
          }
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 高级尺寸控制
        VStack(alignment: .leading, spacing: 12) {
          Text("高级尺寸控制技巧")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 12) {
            // 最大尺寸限制
            VStack(alignment: .leading, spacing: 8) {
              Text("最大尺寸限制:")
                .font(.subheadline)
                .foregroundColor(.secondary)
              
              Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150, maxHeight: 80)
                .background(Color.cyan.opacity(0.2))
                .cornerRadius(4)
            }

            // 最小尺寸保证
            VStack(alignment: .leading, spacing: 8) {
              Text("最小尺寸保证:")
                .font(.subheadline)
                .foregroundColor(.secondary)
              
              Image(systemName: "photo.on.rectangle")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 100, minHeight: 60)
                .background(Color.mint.opacity(0.2))
                .cornerRadius(4)
            }

            // 固定宽度，自适应高度
            VStack(alignment: .leading, spacing: 8) {
              Text("固定宽度，自适应高度:")
                .font(.subheadline)
                .foregroundColor(.secondary)
              
              Image(systemName: "rectangle.portrait")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .background(Color.teal.opacity(0.2))
                .cornerRadius(4)
            }
          }

          // 使用技巧说明
          VStack(alignment: .leading, spacing: 4) {
            Text("💡 使用技巧:")
              .font(.subheadline)
              .fontWeight(.medium)
            Text("• 始终在 resizable() 后使用尺寸修饰符")
            Text("• scaledToFit 保持比例，不会裁剪内容")
            Text("• scaledToFill 可能裁剪内容，需配合 clipped()")
            Text("• aspectRatio 优于手动计算宽高比例")
            Text("• 使用 maxWidth/maxHeight 创建响应式布局")
          }
          .font(.footnote)
          .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.cyan.opacity(0.1))
        .cornerRadius(8)

      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
    .frame(maxWidth: .infinity)
    .navigationTitle("图片尺寸和缩放")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

#Preview {
  NavigationStack {
    ImageExampleView02()
  }
}