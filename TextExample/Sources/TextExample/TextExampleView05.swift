//
//  TextExampleView05.swift
//  TextExample
//
//  Created by AI on 2025/8/8.
//

import SwiftUI
import Foundation

/// Text 特殊格式化示例
/// 展示日期时间格式化、数字货币格式化、定时器显示、本地化等特殊功能
struct TextExampleView05: View {
  
  // 状态变量
  @State private var currentDate = Date()
  @State private var price: Double = 1234.56
  @State private var percentage: Double = 0.758
  @State private var timerEndDate = Date().addingTimeInterval(3600) // 1小时后
  
  // 计时器用于更新当前时间
  private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        
        // MARK: - 日期和时间格式化
        VStack(alignment: .leading, spacing: 12) {
          Text("日期和时间格式化")
            .font(.headline)
            .foregroundColor(.primary)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("不同的日期时间样式")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Group {
              // 日期样式
              HStack {
                Text("完整日期：")
                  .foregroundColor(.secondary)
                Text(currentDate, style: .date)
                  .bold()
              }
              
              HStack {
                Text("时间：")
                  .foregroundColor(.secondary)
                Text(currentDate, style: .time)
                  .bold()
              }
              
              HStack {
                Text("相对时间：")
                  .foregroundColor(.secondary)
                Text(currentDate, style: .relative)
                  .bold()
              }
              
              HStack {
                Text("偏移时间：")
                  .foregroundColor(.secondary)
                Text(currentDate, style: .offset)
                  .bold()
              }
            }
          }
          .padding(8)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(6)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        .onReceive(timer) { _ in
          currentDate = Date()
        }
        
        // MARK: - 自定义日期格式化
        VStack(alignment: .leading, spacing: 12) {
          Text("自定义日期格式化")
            .font(.headline)
            .foregroundColor(.primary)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("使用 FormatStyle 自定义格式")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Group {
              // 自定义日期格式
              HStack {
                Text("年月日：")
                  .foregroundColor(.secondary)
                Text(currentDate, format: Date.FormatStyle()
                  .year(.defaultDigits)
                  .month(.abbreviated)
                  .day(.defaultDigits))
                  .bold()
                  .foregroundColor(.blue)
              }
              
              HStack {
                Text("时分秒：")
                  .foregroundColor(.secondary)
                Text(currentDate, format: Date.FormatStyle()
                  .hour(.defaultDigits(amPM: .wide))
                  .minute(.twoDigits)
                  .second(.twoDigits))
                  .bold()
                  .foregroundColor(.green)
              }
              
              HStack {
                Text("星期：")
                  .foregroundColor(.secondary)
                Text(currentDate, format: Date.FormatStyle()
                  .weekday(.wide))
                  .bold()
                  .foregroundColor(.orange)
              }
              
              HStack {
                Text("完整格式：")
                  .foregroundColor(.secondary)
                Text(currentDate, format: Date.FormatStyle()
                  .year(.defaultDigits)
                  .month(.wide)
                  .day(.defaultDigits)
                  .weekday(.abbreviated)
                  .hour(.defaultDigits(amPM: .omitted))
                  .minute(.twoDigits))
                  .bold()
                  .foregroundColor(.purple)
              }
            }
          }
          .padding(8)
          .background(Color.green.opacity(0.1))
          .cornerRadius(6)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 数字和货币格式化
        VStack(alignment: .leading, spacing: 12) {
          Text("数字和货币格式化")
            .font(.headline)
            .foregroundColor(.primary)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("不同的数字格式")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Group {
              // 基础数字
              HStack {
                Text("原始数字：")
                  .foregroundColor(.secondary)
                Text(price, format: .number)
                  .bold()
              }
              
              // 货币格式
              HStack {
                Text("货币格式：")
                  .foregroundColor(.secondary)
                Text(price, format: .currency(code: "USD"))
                  .bold()
                  .foregroundColor(.green)
              }
              
              HStack {
                Text("人民币格式：")
                  .foregroundColor(.secondary)
                Text(price, format: .currency(code: "CNY"))
                  .bold()
                  .foregroundColor(.red)
              }
              
              // 百分比格式
              HStack {
                Text("百分比：")
                  .foregroundColor(.secondary)
                Text(percentage, format: .percent)
                  .bold()
                  .foregroundColor(.blue)
              }
              
              // 自定义精度
              HStack {
                Text("精确到整数：")
                  .foregroundColor(.secondary)
                Text(price, format: .number.precision(.fractionLength(0)))
                  .bold()
                  .foregroundColor(.orange)
              }
              
              // 科学计数法
              HStack {
                Text("科学计数法：")
                  .foregroundColor(.secondary)
                Text(123456.789, format: .number.notation(.scientific))
                  .bold()
                  .foregroundColor(.purple)
              }
            }
          }
          .padding(8)
          .background(Color.orange.opacity(0.1))
          .cornerRadius(6)
          
          // 控制滑块
          VStack(alignment: .leading, spacing: 4) {
            Text("调整数值")
              .font(.caption)
              .foregroundColor(.secondary)
            
            Slider(value: $price, in: 0...10000) {
              Text("价格")
            }
            
            Slider(value: $percentage, in: 0...1) {
              Text("百分比")
            }
          }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 定时器和计时显示
        VStack(alignment: .leading, spacing: 12) {
          Text("定时器和计时显示")
            .font(.headline)
            .foregroundColor(.primary)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("倒计时显示")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            // 简单倒计时
            HStack {
              Text("倒计时到：")
                .foregroundColor(.secondary)
              Text(timerEndDate, style: .timer)
                .bold()
                .foregroundColor(.red)
                .font(.title2)
                .monospacedDigit()
            }
            
            // 带秒数的详细计时器
            HStack {
              Text("详细倒计时：")
                .foregroundColor(.secondary)
              Text(timerInterval: Date.now...timerEndDate,
                   pauseTime: nil,
                   countsDown: true,
                   showsHours: true)
                .bold()
                .foregroundColor(.blue)
                .font(.title3)
                .monospacedDigit()
            }
            
            // 正计时
            HStack {
              Text("已运行时间：")
                .foregroundColor(.secondary)
              Text(timerInterval: Date().addingTimeInterval(-300)...Date.distantFuture,
                   pauseTime: nil,
                   countsDown: false,
                   showsHours: false)
                .bold()
                .foregroundColor(.green)
                .font(.title3)
                .monospacedDigit()
            }
            
            // 控制按钮
            Button("重置计时器（1小时后）") {
              timerEndDate = Date().addingTimeInterval(3600)
            }
            .buttonStyle(.bordered)
          }
          .padding(8)
          .background(Color.purple.opacity(0.1))
          .cornerRadius(6)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 本地化文本
        VStack(alignment: .leading, spacing: 12) {
          Text("本地化文本")
            .font(.headline)
            .foregroundColor(.primary)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("系统本地化示例")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Group {
              // 注意：这些是示例，实际使用需要在 Localizable.strings 中定义
              Text("Hello, World!")
                .foregroundColor(.blue)
              
              Text("Welcome")
                .foregroundColor(.green)
              
              // 带参数的本地化（示例）
              Text("Today is \(currentDate.formatted(date: .abbreviated, time: .omitted))")
                .foregroundColor(.orange)
              
              // 复数形式（英文示例）
              Text("^[\(Int.random(in: 1...10)) person](inflect: true)")
                .foregroundColor(.purple)
            }
          }
          .padding(8)
          .background(Color.pink.opacity(0.1))
          .cornerRadius(6)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 旧版 Formatter 支持
        VStack(alignment: .leading, spacing: 12) {
          Text("传统 Formatter 支持")
            .font(.headline)
            .foregroundColor(.primary)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("使用 Foundation Formatter")
              .font(.subheadline)
              .foregroundColor(.secondary)
            
            Group {
              // NumberFormatter
              HStack {
                Text("数字格式器：")
                  .foregroundColor(.secondary)
                Text(price as NSNumber, formatter: createNumberFormatter())
                  .bold()
                  .foregroundColor(.blue)
              }
              
              // DateFormatter
              HStack {
                Text("日期格式器：")
                  .foregroundColor(.secondary)
                Text(currentDate, formatter: createDateFormatter())
                  .bold()
                  .foregroundColor(.green)
              }
              
              // ByteCountFormatter
              HStack {
                Text("字节格式器：")
                  .foregroundColor(.secondary)
                Text(1024 * 1024 * 150 as NSNumber, formatter: ByteCountFormatter())
                  .bold()
                  .foregroundColor(.orange)
              }
              
              // DateComponentsFormatter
              HStack {
                Text("时长格式器：")
                  .foregroundColor(.secondary)
                Text(3665 as NSNumber, formatter: createDurationFormatter())
                  .bold()
                  .foregroundColor(.purple)
              }
            }
          }
          .padding(8)
          .background(Color.cyan.opacity(0.1))
          .cornerRadius(6)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        
        // MARK: - 综合格式化示例
        VStack(alignment: .leading, spacing: 12) {
          Text("综合格式化示例")
            .font(.headline)
            .foregroundColor(.primary)
          
          // 电商商品卡片
          VStack(alignment: .leading, spacing: 8) {
            Text("商品信息卡片")
              .font(.subheadline)
              .fontWeight(.semibold)
              .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 6) {
              // 商品名称
              Text("iPhone 15 Pro Max")
                .font(.title2)
                .fontWeight(.bold)
              
              // 价格信息
              HStack {
                Text("价格：")
                  .foregroundColor(.secondary)
                Text(price, format: .currency(code: "CNY"))
                  .font(.title3)
                  .fontWeight(.bold)
                  .foregroundColor(.red)
                
                Spacer()
                
                Text("折扣：")
                  .foregroundColor(.secondary)
                Text(percentage, format: .percent.precision(.fractionLength(1)))
                  .fontWeight(.bold)
                  .foregroundColor(.green)
              }
              
              // 时间信息
              HStack {
                Text("更新时间：")
                  .foregroundColor(.secondary)
                Text(currentDate, format: Date.FormatStyle()
                  .month(.abbreviated)
                  .day(.defaultDigits)
                  .hour(.defaultDigits(amPM: .omitted))
                  .minute(.twoDigits))
                  .foregroundColor(.blue)
                
                Spacer()
                
                Text("剩余时间：")
                  .foregroundColor(.secondary)
                Text(timerEndDate, style: .relative)
                  .foregroundColor(.orange)
                  .bold()
              }
              
              // 库存信息
              HStack {
                Text("库存：")
                  .foregroundColor(.secondary)
                Text(Int.random(in: 10...100), format: .number)
                  .fontWeight(.bold)
                  .foregroundColor(.primary)
                Text("台")
                  .foregroundColor(.secondary)
              }
            }
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
    .navigationTitle("特殊格式化")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  // MARK: - Formatter 创建方法
  private func createNumberFormatter() -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    return formatter
  }
  
  private func createDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter
  }
  
  private func createDurationFormatter() -> DateComponentsFormatter {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    return formatter
  }
}

#Preview {
  NavigationView {
    TextExampleView05()
  }
}