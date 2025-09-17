import SwiftUI

/// Rectangle 特殊用法示例
/// 展示 Rectangle 的特殊用法、实用技巧和创意应用
struct RectangleExampleView04: View {
    @State private var progressValue: Double = 0.6
    @State private var isLoading = false
    @State private var selectedIndex = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                separatorSection
                Divider()
                progressBarSection
                Divider()
                loadingIndicatorSection
                Divider()
                tabIndicatorSection
                Divider()
                chartBackgroundSection
                Divider()
                maskEffectSection
            }
            .padding()
        }
        .navigationTitle("Rectangle 特殊用法")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - 子视图组件
extension RectangleExampleView04 {
    
    private var separatorSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Rectangle 作为分隔线")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("使用 Rectangle 创建各种样式的分隔线")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 20) {
                // 水平分隔线
                VStack(spacing: 10) {
                    Text("内容区域 1")
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                    Text("内容区域 2")
                }
                
                // 彩色分隔线
                VStack(spacing: 10) {
                    Text("彩色分隔线")
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [.clear, .blue, .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(height: 2)
                    Text("下方内容")
                }
                
                // 虚线分隔线
                VStack(spacing: 10) {
                    Text("虚线分隔线")
                    Rectangle()
                        .stroke(Color.orange, style: StrokeStyle(lineWidth: 2, dash: [5, 3]))
                        .frame(height: 1)
                    Text("分隔内容")
                }
            }
        }
    }
    
    private var progressBarSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Rectangle 作为进度条")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("使用 Rectangle 创建各种样式的进度条")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 20) {
                // 简单进度条
                VStack(alignment: .leading, spacing: 5) {
                    Text("下载进度: \\(Int(progressValue * 100))%")
                        .font(.caption)
                    
                    ProgressBar(progress: progressValue, color: .blue)
                }
                
                // 渐变进度条
                VStack(alignment: .leading, spacing: 5) {
                    Text("任务进度")
                        .font(.caption)
                    
                    GradientProgressBar(progress: progressValue)
                }
                
                // 控制按钮
                HStack {
                    Button("25%") { progressValue = 0.25 }
                    Button("50%") { progressValue = 0.5 }
                    Button("75%") { progressValue = 0.75 }
                    Button("100%") { progressValue = 1.0 }
                }
                .buttonStyle(.bordered)
            }
        }
    }
    
    private var loadingIndicatorSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Rectangle 作为加载指示器")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("创建各种动画效果的加载指示器")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 30) {
                // 跳跃的方块
                BouncingSquares(isAnimating: isLoading)
                
                // 波浪效果
                WaveEffect(isAnimating: isLoading)
                
                // 控制按钮
                Button(isLoading ? "停止动画" : "开始动画") {
                    isLoading.toggle()
                }
                .buttonStyle(.bordered)
            }
            .onAppear {
                isLoading = true
            }
        }
    }
    
    private var tabIndicatorSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Rectangle 作为选项卡指示器")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("用于标识当前选中的选项卡")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 15) {
                // 选项卡
                TabIndicator(selectedIndex: $selectedIndex)
                
                // 内容区域
                Rectangle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 100)
                    .overlay(
                        Text("选项卡 \\(selectedIndex + 1) 的内容")
                            .foregroundColor(.blue)
                    )
            }
        }
    }
    
    private var chartBackgroundSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Rectangle 作为图表背景")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("创建简单的柱状图和条形图")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 20) {
                // 柱状图
                BarChart()
                
                // 水平条形图
                HorizontalBarChart()
            }
        }
    }
    
    private var maskEffectSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Rectangle 作为遮罩")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("创建各种遮罩和蒙版效果")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 20) {
                // 半透明遮罩
                ZStack {
                    Image(systemName: "photo")
                        .font(.system(size: 100))
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                        .overlay(
                            Text("遮罩文字")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                }
                .frame(width: 200, height: 150)
                .cornerRadius(10)
                
                // 渐变遮罩
                ZStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 200, height: 100)
                    
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [.clear, .black.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .overlay(
                            VStack {
                                Spacer()
                                Text("渐变遮罩效果")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                            .padding()
                        )
                }
                .frame(width: 200, height: 100)
                .cornerRadius(10)
            }
        }
    }
}

// MARK: - 辅助组件
struct ProgressBar: View {
    let progress: Double
    let color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 8)
            
            Rectangle()
                .fill(color)
                .frame(width: 250 * progress, height: 8)
                .animation(.easeInOut(duration: 0.3), value: progress)
        }
        .frame(width: 250)
        .cornerRadius(4)
    }
}

struct GradientProgressBar: View {
    let progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 12)
            
            Rectangle()
                .fill(LinearGradient(
                    colors: [.green, .blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(width: 250 * progress, height: 12)
                .animation(.spring(response: 0.5), value: progress)
        }
        .frame(width: 250)
        .cornerRadius(6)
    }
}

struct BouncingSquares: View {
    let isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<5, id: \.self) { index in
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .scaleEffect(isAnimating ? 1.2 : 0.8)
                    .animation(
                        .easeInOut(duration: 0.6)
                        .repeatForever()
                        .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }
}

struct WaveEffect: View {
    let isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<8, id: \.self) { index in
                Rectangle()
                    .fill(LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(width: 6, height: isAnimating ? 40 : 10)
                    .animation(
                        .easeInOut(duration: 0.8)
                        .repeatForever()
                        .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }
}

struct TabIndicator: View {
    @Binding var selectedIndex: Int
    let tabs = ["首页", "发现", "我的"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedIndex = index
                    }
                }) {
                    VStack(spacing: 8) {
                        Text(tabs[index])
                            .foregroundColor(selectedIndex == index ? .blue : .gray)
                            .font(.system(size: 16, weight: selectedIndex == index ? .semibold : .regular))
                        
                        Rectangle()
                            .fill(selectedIndex == index ? Color.blue : Color.clear)
                            .frame(height: 3)
                            .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
        }
        .background(Color.gray.opacity(0.1))
    }
}

struct BarChart: View {
    let data = [30, 45, 60, 40, 70, 55]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("月销售数据")
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(data.indices, id: \.self) { index in
                    VStack(spacing: 4) {
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [.orange, .red],
                                startPoint: .bottom,
                                endPoint: .top
                            ))
                            .frame(width: 30, height: CGFloat(data[index] * 2))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        
                        Text("\\(index + 1)月")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 150)
        }
    }
}

struct HorizontalBarChart: View {
    let products = ["产品A", "产品B", "产品C", "产品D"]
    let scores = [80, 60, 90, 70]
    let widths = [120, 90, 135, 105]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("产品评分")
                .font(.subheadline)
                .fontWeight(.medium)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(products.indices, id: \.self) { index in
                    HStack {
                        Text(products[index])
                            .frame(width: 60, alignment: .leading)
                            .font(.caption)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 150, height: 16)
                            
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: CGFloat(widths[index]), height: 16)
                        }
                        .cornerRadius(8)
                        
                        Text("\\(scores[index])%")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        RectangleExampleView04()
    }
}