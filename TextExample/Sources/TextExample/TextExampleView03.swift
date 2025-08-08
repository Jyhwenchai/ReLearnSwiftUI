//
//  TextExampleView03.swift
//  TextExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI

/// Text 多行文本和布局示例
/// 展示多行文本处理：对齐方式、行数限制、行间距、截断模式等
struct TextExampleView03: View {
  
  // 长文本示例
  private let longText = "这是一段很长的文本内容，用于演示多行文本的各种布局和显示效果。SwiftUI 的 Text 组件提供了丰富的选项来控制文本的显示方式，包括行数限制、截断模式、对齐方式和行间距等。通过这些修饰符，我们可以创建出美观且易读的用户界面。"
  
  private let englishLongText = "This is a long English text content used to demonstrate various layout and display effects of multi-line text. SwiftUI's Text component provides rich options to control text display, including line limits, truncation modes, alignment, and line spacing. With these modifiers, we can create beautiful and readable user interfaces."
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        
        // MARK: - 多行文本对齐
        VStack(alignment: .leading, spacing: 12) {
          Text("多行文本对齐")
            .font(.headline)
            .foregroundColor(.primary)
          
          // 左对齐（默认）
          VStack(alignment: .leading, spacing: 8) {
            Text("左对齐（默认）")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(longText)
              .multilineTextAlignment(.leading)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(8)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 居中对齐
          VStack(alignment: .leading, spacing: 8) {
            Text("居中对齐")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(longText)
              .multilineTextAlignment(.center)
              .frame(maxWidth: .infinity)
              .padding(8)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 右对齐
          VStack(alignment: .leading, spacing: 8) {
            Text("右对齐")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(longText)
              .multilineTextAlignment(.trailing)
              .frame(maxWidth: .infinity, alignment: .trailing)
              .padding(8)
              .background(Color.orange.opacity(0.1))
              .cornerRadius(6)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 行数限制
        VStack(alignment: .leading, spacing: 12) {
          Text("行数限制")
            .font(.headline)
            .foregroundColor(.primary)
          
          // 无限制（默认）
          VStack(alignment: .leading, spacing: 8) {
            Text("无行数限制")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(longText)
              .padding(8)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 限制1行
          VStack(alignment: .leading, spacing: 8) {
            Text("限制1行")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(longText)
              .lineLimit(1)
              .padding(8)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 限制3行
          VStack(alignment: .leading, spacing: 8) {
            Text("限制3行")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(longText)
              .lineLimit(3)
              .padding(8)
              .background(Color.orange.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 使用范围限制（2到4行）
          VStack(alignment: .leading, spacing: 8) {
            Text("2-4行范围限制")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(longText)
              .lineLimit(2...4)
              .padding(8)
              .background(Color.purple.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 预留空间的行数限制
          VStack(alignment: .leading, spacing: 8) {
            Text("预留空间（2行，即使内容不足）")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text("短文本")
              .lineLimit(2, reservesSpace: true)
              .padding(8)
              .background(Color.pink.opacity(0.1))
              .cornerRadius(6)
              .overlay(
                RoundedRectangle(cornerRadius: 6)
                  .stroke(Color.pink.opacity(0.3), lineWidth: 1)
              )
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 截断模式
        VStack(alignment: .leading, spacing: 12) {
          Text("截断模式")
            .font(.headline)
            .foregroundColor(.primary)
          
          // 尾部截断（默认）
          VStack(alignment: .leading, spacing: 8) {
            Text("尾部截断（默认）")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(englishLongText)
              .lineLimit(1)
              .truncationMode(.tail)
              .padding(8)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 头部截断
          VStack(alignment: .leading, spacing: 8) {
            Text("头部截断")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(englishLongText)
              .lineLimit(1)
              .truncationMode(.head)
              .padding(8)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 中间截断
          VStack(alignment: .leading, spacing: 8) {
            Text("中间截断")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text(englishLongText)
              .lineLimit(1)
              .truncationMode(.middle)
              .padding(8)
              .background(Color.orange.opacity(0.1))
              .cornerRadius(6)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 行间距
        VStack(alignment: .leading, spacing: 12) {
          Text("行间距调整")
            .font(.headline)
            .foregroundColor(.primary)
          
          // 默认行间距
          VStack(alignment: .leading, spacing: 8) {
            Text("默认行间距")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text("这是第一行文本\n这是第二行文本\n这是第三行文本")
              .padding(8)
              .background(Color.blue.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 增大行间距
          VStack(alignment: .leading, spacing: 8) {
            Text("增大行间距 (10)")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text("这是第一行文本\n这是第二行文本\n这是第三行文本")
              .lineSpacing(10)
              .padding(8)
              .background(Color.green.opacity(0.1))
              .cornerRadius(6)
          }
          
          // 减少行间距
          VStack(alignment: .leading, spacing: 8) {
            Text("减少行间距 (-2)")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Text("这是第一行文本\n这是第二行文本\n这是第三行文本")
              .lineSpacing(-2)
              .padding(8)
              .background(Color.orange.opacity(0.1))
              .cornerRadius(6)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 最小缩放因子
        VStack(alignment: .leading, spacing: 12) {
          Text("最小缩放因子")
            .font(.headline)
            .foregroundColor(.primary)
          
          Text("最小缩放因子用于在空间不足时自动缩小文本，以确保完整显示")
            .font(.caption)
            .foregroundColor(.secondary)
          
          // 无缩放
          VStack(alignment: .leading, spacing: 8) {
            Text("无缩放（默认）")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack {
              Text("这是一段很长的文本内容，在狭小空间中可能会被截断")
                .font(.title2)
                .lineLimit(1)
              Spacer()
            }
            .frame(width: 250)
            .padding(8)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(6)
          }
          
          // 缩放因子 0.5
          VStack(alignment: .leading, spacing: 8) {
            Text("缩放因子 0.5")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack {
              Text("这是一段很长的文本内容，在狭小空间中会自动缩小显示")
                .font(.title2)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
              Spacer()
            }
            .frame(width: 250)
            .padding(8)
            .background(Color.green.opacity(0.1))
            .cornerRadius(6)
          }
          
          // 缩放因子 0.8
          VStack(alignment: .leading, spacing: 8) {
            Text("缩放因子 0.8")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack {
              Text("这是一段长文本内容，最小缩放到80%")
                .font(.title2)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
              Spacer()
            }
            .frame(width: 250)
            .padding(8)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(6)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 允许紧缩
        VStack(alignment: .leading, spacing: 12) {
          Text("允许紧缩")
            .font(.headline)
            .foregroundColor(.primary)
          
          Text("allowsTightening 允许字符间距缩小以容纳更多文本")
            .font(.caption)
            .foregroundColor(.secondary)
          
          // 不允许紧缩
          VStack(alignment: .leading, spacing: 8) {
            Text("不允许紧缩（默认）")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack {
              Text("This is a long text that might be truncated")
                .font(.title3)
                .lineLimit(1)
                .allowsTightening(false)
              Spacer()
            }
            .frame(width: 280)
            .padding(8)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(6)
          }
          
          // 允许紧缩
          VStack(alignment: .leading, spacing: 8) {
            Text("允许紧缩")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            HStack {
              Text("This is a long text that can be tightened")
                .font(.title3)
                .lineLimit(1)
                .allowsTightening(true)
              Spacer()
            }
            .frame(width: 280)
            .padding(8)
            .background(Color.green.opacity(0.1))
            .cornerRadius(6)
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 综合布局示例
        VStack(alignment: .leading, spacing: 12) {
          Text("综合布局示例")
            .font(.headline)
            .foregroundColor(.primary)
          
          // 卡片式布局
          VStack(alignment: .leading, spacing: 8) {
            Text("文章标题")
              .font(.title2)
              .fontWeight(.semibold)
              .lineLimit(2)
              .multilineTextAlignment(.leading)
            
            Text("副标题或摘要内容")
              .font(.subheadline)
              .foregroundColor(.secondary)
              .lineLimit(1)
              .truncationMode(.tail)
            
            Text(longText)
              .font(.body)
              .lineLimit(4)
              .lineSpacing(2)
              .multilineTextAlignment(.leading)
              .minimumScaleFactor(0.9)
              .allowsTightening(true)
          }
          .padding()
          .background(Color.white)
          .cornerRadius(12)
          .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
      }
      .padding()
    }
    .navigationTitle("多行文本布局")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NavigationView {
    TextExampleView03()
  }
}