//
//  ImageExampleView03.swift
//  ImageExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Image 图片样式和修饰示例
/// 展示 Image 组件的各种视觉样式和修饰效果
struct ImageExampleView03: View {
  @State private var cornerRadius: CGFloat = 8
  @State private var shadowRadius: CGFloat = 5
  @State private var opacity: Double = 1.0

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {

        // MARK: - cornerRadius 圆角效果
        VStack(alignment: .leading, spacing: 12) {
          Text("cornerRadius 圆角效果")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("不同圆角大小:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 无圆角
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .background(Color.blue.opacity(0.2))
              
              // 小圆角
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(4)
              
              // 中等圆角
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(12)
              
              // 圆形
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .background(Color.blue.opacity(0.2))
                .clipShape(Circle())
            }
          }

          VStack(alignment: .leading, spacing: 8) {
            Text("特殊形状:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 胶囊形状
              Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 60)
                .foregroundColor(.white)
                .background(Color.green)
                .clipShape(Capsule())
              
              // 椭圆形
              Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 40)
                .foregroundColor(.white)
                .background(Color.red)
                .clipShape(Ellipse())
              
              // 自定义圆角
              Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
          }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)

        // MARK: - border 边框效果
        VStack(alignment: .leading, spacing: 12) {
          Text("border 边框效果")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("不同边框样式:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 基础边框
              Image(systemName: "photo")
                .resizable()
                .frame(width: 60, height: 60)
                .border(Color.black, width: 2)
              
              // 彩色边框
              Image(systemName: "photo")
                .resizable()
                .frame(width: 60, height: 60)
                .border(Color.red, width: 3)
              
              // 虚线边框效果（使用 overlay）
              Image(systemName: "photo")
                .resizable()
                .frame(width: 60, height: 60)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, dash: [5, 3]))
                )
              
              // 渐变边框
              Image(systemName: "photo")
                .resizable()
                .frame(width: 60, height: 60)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(
                      LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                      ),
                      lineWidth: 3
                    )
                )
            }
          }

          VStack(alignment: .leading, spacing: 8) {
            Text("边框与圆角组合:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 圆角边框
              Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
                .padding(8)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                  RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.red, lineWidth: 2)
                )
              
              // 圆形边框
              Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(
                  Circle()
                    .stroke(Color.blue, lineWidth: 2)
                )
            }
          }
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)

        // MARK: - shadow 阴影效果
        VStack(alignment: .leading, spacing: 12) {
          Text("shadow 阴影效果")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("不同阴影类型:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 基础阴影
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
                .shadow(radius: 3)
              
              // 偏移阴影
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
              
              // 彩色阴影
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
                .shadow(color: .orange, radius: 8, x: 0, y: 0)
              
              // 多层阴影效果
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
          }

          VStack(alignment: .leading, spacing: 8) {
            Text("阴影深度效果:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 浅阴影
              Image(systemName: "star.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
              
              // 中等阴影
              Image(systemName: "star.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
              
              // 深阴影
              Image(systemName: "star.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 4, y: 4)
            }
          }
        }
        .padding()
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(8)

        // MARK: - overlay 和 background 叠加层
        VStack(alignment: .leading, spacing: 12) {
          Text("overlay 和 background 叠加层")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("overlay 覆盖层:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 文字覆盖层
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
                .overlay(
                  Text("NEW")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.red)
                    .cornerRadius(4),
                  alignment: .topTrailing
                )
              
              // 图标覆盖层
              Image(systemName: "person.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .overlay(
                  Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .background(Color.white)
                    .clipShape(Circle()),
                  alignment: .bottomTrailing
                )
              
              // 渐变覆盖层
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.purple)
                .overlay(
                  LinearGradient(
                    colors: [.clear, .black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                  )
                )
            }
          }

          VStack(alignment: .leading, spacing: 8) {
            Text("background 背景层:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 彩色背景
              Image(systemName: "heart")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(12)
              
              // 渐变背景
              Image(systemName: "star")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding()
                .background(
                  LinearGradient(
                    colors: [.orange, .red],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                  )
                )
                .cornerRadius(12)
              
              // 图案背景
              Image(systemName: "sun.max")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)
                .padding()
                .background(
                  Circle()
                    .fill(
                      RadialGradient(
                        colors: [.orange.opacity(0.3), .clear],
                        center: .center,
                        startRadius: 5,
                        endRadius: 25
                      )
                    )
                )
            }
          }
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)

        // MARK: - opacity 透明度
        VStack(alignment: .leading, spacing: 12) {
          Text("opacity 透明度")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("不同透明度效果:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .opacity(1.0)
              
              Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .opacity(0.8)
              
              Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .opacity(0.5)
              
              Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .opacity(0.2)
            }
            
            Text("1.0      0.8      0.5      0.2")
              .font(.caption)
              .foregroundColor(.secondary)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 交互式样式控制
        VStack(alignment: .leading, spacing: 12) {
          Text("交互式样式控制")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(spacing: 16) {
            // 圆角控制
            VStack(alignment: .leading, spacing: 8) {
              Text("圆角半径: \(Int(cornerRadius))")
                .font(.subheadline)
              
              Slider(value: $cornerRadius, in: 0...30, step: 1)
                .accentColor(.blue)
            }

            // 阴影控制
            VStack(alignment: .leading, spacing: 8) {
              Text("阴影半径: \(Int(shadowRadius))")
                .font(.subheadline)
              
              Slider(value: $shadowRadius, in: 0...20, step: 1)
                .accentColor(.orange)
            }

            // 透明度控制
            VStack(alignment: .leading, spacing: 8) {
              Text("透明度: \(opacity, specifier: "%.1f")")
                .font(.subheadline)
              
              Slider(value: $opacity, in: 0...1, step: 0.1)
                .accentColor(.purple)
            }

            // 实时预览
            VStack {
              Text("实时预览:")
                .font(.subheadline)
                .foregroundColor(.secondary)
              
              Image(systemName: "photo.artframe")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.primary)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(cornerRadius)
                .shadow(color: .black.opacity(0.3), radius: shadowRadius)
                .opacity(opacity)
            }
          }
        }
        .padding()
        .background(Color.mint.opacity(0.1))
        .cornerRadius(8)

        // MARK: - 综合样式示例
        VStack(alignment: .leading, spacing: 12) {
          Text("综合样式示例")
            .font(.headline)
            .foregroundColor(.primary)

          VStack(alignment: .leading, spacing: 8) {
            Text("实用样式组合:")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack(spacing: 15) {
              // 头像样式
              Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue)
                .clipShape(Circle())
                .overlay(
                  Circle()
                    .stroke(Color.white, lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.2), radius: 3)
              
              // 卡片样式
              Image(systemName: "photo.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
              
              // 标签样式
              Image(systemName: "tag.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(8)
                .background(
                  LinearGradient(
                    colors: [.pink, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                  )
                )
                .cornerRadius(8)
                .shadow(color: .purple.opacity(0.5), radius: 4)
            }
          }

          // 样式技巧说明
          VStack(alignment: .leading, spacing: 4) {
            Text("🎨 样式技巧:")
              .font(.subheadline)
              .fontWeight(.medium)
            Text("• 组合使用多个修饰符创建丰富效果")
            Text("• 阴影可以增加图片的层次感")
            Text("• overlay 和 background 可创建复杂布局")
            Text("• 适当的透明度可以营造视觉层次")
            Text("• 边框和圆角让图片更加精美")
          }
          .font(.footnote)
          .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.teal.opacity(0.1))
        .cornerRadius(8)

      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
    .frame(maxWidth: .infinity)
    .navigationTitle("图片样式和修饰")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

#Preview {
  NavigationStack {
    ImageExampleView03()
  }
}