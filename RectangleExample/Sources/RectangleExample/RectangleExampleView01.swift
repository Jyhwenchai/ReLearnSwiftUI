import SwiftUI

/// Rectangle 基础示例
/// 展示 Rectangle 的基本用法、尺寸设置和基础样式
struct RectangleExampleView01: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // MARK: - 基础 Rectangle
                VStack(alignment: .leading, spacing: 15) {
                    Text("基础 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("最简单的 Rectangle，使用默认样式")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    // 基础矩形，使用默认黑色填充
                    Rectangle()
                        .frame(width: 200, height: 100)
                }
                
                Divider()
                
                // MARK: - 固定尺寸的 Rectangle
                VStack(alignment: .leading, spacing: 15) {
                    Text("固定尺寸 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("通过 frame() 修饰符设置固定的宽度和高度")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 20) {
                        // 小矩形
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 80, height: 60)
                        
                        // 中等矩形
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 120, height: 80)
                        
                        // 大矩形
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 100, height: 120)
                    }
                }
                
                Divider()
                
                // MARK: - 正方形 Rectangle
                VStack(alignment: .leading, spacing: 15) {
                    Text("正方形 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("设置相同的宽度和高度创建正方形")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 20) {
                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: 80, height: 80)
                        
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: 100, height: 100)
                        
                        Rectangle()
                            .fill(Color.pink)
                            .frame(width: 60, height: 60)
                    }
                }
                
                Divider()
                
                // MARK: - 使用 aspectRatio 的 Rectangle
                VStack(alignment: .leading, spacing: 15) {
                    Text("宽高比例 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("使用 aspectRatio() 修饰符保持固定的宽高比例")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 15) {
                        // 16:9 宽高比
                        Rectangle()
                            .fill(Color.blue)
                            .aspectRatio(16/9, contentMode: .fit)
                            .frame(width: 200)
                        
                        // 4:3 宽高比
                        Rectangle()
                            .fill(Color.green)
                            .aspectRatio(4/3, contentMode: .fit)
                            .frame(width: 200)
                        
                        // 1:1 宽高比（正方形）
                        Rectangle()
                            .fill(Color.red)
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 150)
                    }
                }
                
                Divider()
                
                // MARK: - 填充容器的 Rectangle
                VStack(alignment: .leading, spacing: 15) {
                    Text("填充容器 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Rectangle 会自动填充可用空间")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    // 使用容器限制大小
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 100)
                        .overlay(
                            Text("填充整个宽度")
                                .foregroundColor(.primary)
                        )
                }
            }
            .padding()
        }
        .navigationTitle("Rectangle 基础示例")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        RectangleExampleView01()
    }
}