import SwiftUI

/// Rectangle 高级示例
/// 展示 Rectangle 的颜色填充、渐变、边框、阴影等高级样式
struct RectangleExampleView02: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // MARK: - 颜色填充
                VStack(alignment: .leading, spacing: 15) {
                    Text("颜色填充 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("使用 fill() 修饰符设置不同的颜色填充")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                        // 系统颜色
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 80)
                            .overlay(Text("Red").foregroundColor(.white))
                        
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 80)
                            .overlay(Text("Blue").foregroundColor(.white))
                        
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 80)
                            .overlay(Text("Green").foregroundColor(.white))
                        
                        // 自定义颜色
                        Rectangle()
                            .fill(Color(red: 0.8, green: 0.2, blue: 0.6))
                            .frame(height: 80)
                            .overlay(Text("Custom").foregroundColor(.white))
                        
                        // 透明度颜色
                        Rectangle()
                            .fill(Color.purple.opacity(0.6))
                            .frame(height: 80)
                            .overlay(Text("Opacity").foregroundColor(.white))
                        
                        // 材质颜色
                        Rectangle()
                            .fill(Color.primary)
                            .frame(height: 80)
                            .overlay(Text("Primary").foregroundColor(.white))
                    }
                }
                
                Divider()
                
                // MARK: - 线性渐变
                VStack(alignment: .leading, spacing: 15) {
                    Text("线性渐变 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("使用 LinearGradient 创建线性渐变效果")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 15) {
                        // 水平渐变
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [.red, .orange, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(height: 60)
                            .overlay(Text("水平渐变").foregroundColor(.white))
                        
                        // 垂直渐变
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .frame(height: 60)
                            .overlay(Text("垂直渐变").foregroundColor(.white))
                        
                        // 对角线渐变
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [.green, .blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(height: 60)
                            .overlay(Text("对角线渐变").foregroundColor(.white))
                    }
                }
                
                Divider()
                
                // MARK: - 径向渐变
                VStack(alignment: .leading, spacing: 15) {
                    Text("径向渐变 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("使用 RadialGradient 创建径向渐变效果")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 15) {
                        // 中心径向渐变
                        Rectangle()
                            .fill(RadialGradient(
                                colors: [.yellow, .orange, .red],
                                center: .center,
                                startRadius: 20,
                                endRadius: 100
                            ))
                            .frame(height: 100)
                            .overlay(Text("中心径向渐变").foregroundColor(.white))
                        
                        // 偏移径向渐变
                        Rectangle()
                            .fill(RadialGradient(
                                colors: [.white, .blue, .black],
                                center: UnitPoint(x: 0.3, y: 0.3),
                                startRadius: 10,
                                endRadius: 80
                            ))
                            .frame(height: 100)
                            .overlay(Text("偏移径向渐变").foregroundColor(.white))
                    }
                }
                
                Divider()
                
                // MARK: - 角度渐变
                VStack(alignment: .leading, spacing: 15) {
                    Text("角度渐变 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("使用 AngularGradient 创建角度渐变效果")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 20) {
                        Rectangle()
                            .fill(AngularGradient(
                                colors: [.red, .orange, .yellow, .green, .blue, .purple, .red],
                                center: .center
                            ))
                            .frame(width: 120, height: 120)
                            .overlay(Text("彩虹").foregroundColor(.white))
                        
                        Rectangle()
                            .fill(AngularGradient(
                                colors: [.black, .gray, .white, .gray, .black],
                                center: .center,
                                startAngle: .degrees(0),
                                endAngle: .degrees(360)
                            ))
                            .frame(width: 120, height: 120)
                            .overlay(Text("灰度").foregroundColor(.black))
                    }
                }
                
                Divider()
                
                // MARK: - 边框样式
                VStack(alignment: .leading, spacing: 15) {
                    Text("边框样式 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("使用 stroke() 和 overlay() 添加边框效果")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                        // 简单边框
                        Rectangle()
                            .stroke(Color.blue, lineWidth: 3)
                            .frame(height: 80)
                            .overlay(Text("简单边框"))
                        
                        // 虚线边框
                        Rectangle()
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 3, dash: [10, 5]))
                            .frame(height: 80)
                            .overlay(Text("虚线边框"))
                        
                        // 填充+边框
                        Rectangle()
                            .fill(Color.yellow.opacity(0.3))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.orange, lineWidth: 4)
                            )
                            .frame(height: 80)
                            .overlay(Text("填充+边框"))
                        
                        // 渐变边框
                        Rectangle()
                            .stroke(LinearGradient(
                                colors: [.purple, .pink],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ), lineWidth: 5)
                            .frame(height: 80)
                            .overlay(Text("渐变边框"))
                    }
                }
                
                Divider()
                
                // MARK: - 阴影效果
                VStack(alignment: .leading, spacing: 15) {
                    Text("阴影效果 Rectangle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("使用 shadow() 修饰符添加阴影效果")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        // 简单阴影
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 100, height: 80)
                            .shadow(radius: 5)
                            .overlay(Text("简单阴影").foregroundColor(.white))
                        
                        // 偏移阴影
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 100, height: 80)
                            .shadow(color: .gray, radius: 8, x: 5, y: 5)
                            .overlay(Text("偏移阴影").foregroundColor(.white))
                        
                        // 彩色阴影
                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: 100, height: 80)
                            .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 10)
                            .overlay(Text("彩色阴影").foregroundColor(.white))
                        
                        // 内阴影效果
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 100, height: 80)
                            .overlay(
                                Rectangle()
                                    .fill(Color.black.opacity(0.1))
                                    .blur(radius: 3)
                                    .offset(x: 2, y: 2)
                                    .mask(Rectangle())
                            )
                            .overlay(Text("内阴影").foregroundColor(.black))
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Rectangle 高级样式")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        RectangleExampleView02()
    }
}