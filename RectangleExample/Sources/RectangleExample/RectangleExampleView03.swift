import SwiftUI

/// Rectangle 复杂示例
/// 展示 Rectangle 的动画、交互、变换等复杂功能
struct RectangleExampleView03: View {
    // MARK: - 状态变量
    @State private var isAnimating = false
    @State private var rotationAngle: Double = 0
    @State private var scaleAmount: CGFloat = 1.0
    @State private var offsetAmount: CGSize = .zero
    @State private var selectedColor = Color.blue
    @State private var rectangleWidth: CGFloat = 200
    @State private var rectangleHeight: CGFloat = 100
    @State private var cornerRadius: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                animationEffects
                Divider()
                continuousAnimations
                Divider()
                interactiveControls
                Divider()
                transform3DEffects
                Divider()
                gestureInteractions
            }
            .padding()
        }
        .navigationTitle("Rectangle 复杂交互")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - 子视图组件
extension RectangleExampleView03 {
    
    private var animationEffects: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("动画效果 Rectangle")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("点击矩形查看各种动画效果")
                .font(.caption)
                .foregroundColor(.secondary)
            
            VStack(spacing: 20) {
                // 旋转动画
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(rotationAngle))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            rotationAngle += 90
                        }
                    }
                    .overlay(Text("旋转").foregroundColor(.white))
                
                HStack(spacing: 20) {
                    scaleButton
                    offsetButton
                }
            }
        }
    }
    
    private var scaleButton: some View {
        Rectangle()
            .fill(Color.green)
            .frame(width: 60, height: 60)
            .scaleEffect(scaleAmount)
            .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    scaleAmount = scaleAmount == 1.0 ? 1.5 : 1.0
                }
            }
            .overlay(Text("缩放").foregroundColor(.white).font(.caption))
    }
    
    private var offsetButton: some View {
        Rectangle()
            .fill(Color.red)
            .frame(width: 60, height: 60)
            .offset(offsetAmount)
            .onTapGesture {
                withAnimation(.bouncy(duration: 1)) {
                    offsetAmount = offsetAmount == .zero ? CGSize(width: 50, height: 30) : .zero
                }
            }
            .overlay(Text("位移").foregroundColor(.white).font(.caption))
    }
    
    private var continuousAnimations: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("连续动画 Rectangle")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("自动播放的连续动画效果")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack(spacing: 30) {
                pulseAnimation
                rotationAnimation
            }
            .onAppear {
                isAnimating = true
            }
        }
    }
    
    private var pulseAnimation: some View {
        Rectangle()
            .fill(Color.purple)
            .frame(width: 80, height: 80)
            .scaleEffect(isAnimating ? 1.2 : 0.8)
            .opacity(isAnimating ? 0.6 : 1.0)
            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
            .overlay(Text("脉冲").foregroundColor(.white))
    }
    
    private var rotationAnimation: some View {
        Rectangle()
            .fill(LinearGradient(
                colors: [.orange, .red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .frame(width: 80, height: 80)
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
            .overlay(Text("旋转").foregroundColor(.white))
    }
    
    private var interactiveControls: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("交互式控制 Rectangle")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("通过滑块和按钮控制矩形的各种属性")
                .font(.caption)
                .foregroundColor(.secondary)
            
            controlledRectangle
            controlPanel
        }
    }
    
    private var controlledRectangle: some View {
        Rectangle()
            .fill(selectedColor)
            .frame(width: rectangleWidth, height: rectangleHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .animation(.easeInOut(duration: 0.3), value: rectangleWidth)
            .animation(.easeInOut(duration: 0.3), value: rectangleHeight)
            .animation(.easeInOut(duration: 0.3), value: cornerRadius)
            .animation(.easeInOut(duration: 0.3), value: selectedColor)
    }
    
    private var controlPanel: some View {
        VStack(spacing: 15) {
            sliderControls
            colorSelector
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var sliderControls: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text("宽度: \\(Int(rectangleWidth))")
                    .font(.caption)
                Slider(value: $rectangleWidth, in: 100...300, step: 10)
            }
            
            VStack(alignment: .leading) {
                Text("高度: \\(Int(rectangleHeight))")
                    .font(.caption)
                Slider(value: $rectangleHeight, in: 50...200, step: 10)
            }
            
            VStack(alignment: .leading) {
                Text("圆角: \\(Int(cornerRadius))")
                    .font(.caption)
                Slider(value: $cornerRadius, in: 0...50, step: 5)
            }
        }
    }
    
    private var colorSelector: some View {
        VStack(alignment: .leading) {
            Text("颜色选择")
                .font(.caption)
            HStack {
                ForEach([Color.blue, Color.green, Color.red, Color.purple, Color.orange], id: \.self) { color in
                    colorButton(color)
                }
            }
        }
    }
    
    private func colorButton(_ color: Color) -> some View {
        Circle()
            .fill(color)
            .frame(width: 30, height: 30)
            .overlay(
                Circle()
                    .stroke(Color.primary, lineWidth: selectedColor == color ? 3 : 0)
            )
            .onTapGesture {
                selectedColor = color
            }
    }
    
    private var transform3DEffects: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("3D 变换效果 Rectangle")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("使用 3D 变换创建立体效果")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
                xAxisRotation
                yAxisRotation
                zAxisRotation
            }
        }
    }
    
    private var xAxisRotation: some View {
        Rectangle()
            .fill(LinearGradient(
                colors: [.cyan, .blue],
                startPoint: .top,
                endPoint: .bottom
            ))
            .frame(width: 100, height: 100)
            .rotation3DEffect(
                .degrees(45),
                axis: (x: 1, y: 0, z: 0)
            )
            .overlay(Text("X轴").foregroundColor(.white))
    }
    
    private var yAxisRotation: some View {
        Rectangle()
            .fill(LinearGradient(
                colors: [.pink, .purple],
                startPoint: .leading,
                endPoint: .trailing
            ))
            .frame(width: 100, height: 100)
            .rotation3DEffect(
                .degrees(45),
                axis: (x: 0, y: 1, z: 0)
            )
            .overlay(Text("Y轴").foregroundColor(.white))
    }
    
    private var zAxisRotation: some View {
        Rectangle()
            .fill(LinearGradient(
                colors: [.yellow, .orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .frame(width: 100, height: 100)
            .rotation3DEffect(
                .degrees(45),
                axis: (x: 0, y: 0, z: 1)
            )
            .overlay(Text("Z轴").foregroundColor(.white))
    }
    
    private var gestureInteractions: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("手势交互 Rectangle")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("支持拖拽、捏合、旋转等手势操作")
                .font(.caption)
                .foregroundColor(.secondary)
            
            GestureRectangleView()
        }
    }
}

/// 支持手势操作的矩形视图
struct GestureRectangleView: View {
    @State private var offset = CGSize.zero
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .degrees(0)
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                colors: [.indigo, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .frame(width: 150, height: 150)
            .scaleEffect(scale)
            .rotationEffect(rotation)
            .offset(offset)
            .gesture(combinedGesture)
            .overlay(
                Text("拖拽、缩放、旋转")
                    .foregroundColor(.white)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            )
    }
    
    private var combinedGesture: some Gesture {
        SimultaneousGesture(
            dragGesture,
            SimultaneousGesture(
                magnificationGesture,
                rotationGesture
            )
        )
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation(.spring()) {
                    offset = .zero
                }
            }
    }
    
    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                scale = value
            }
            .onEnded { _ in
                withAnimation(.spring()) {
                    scale = 1.0
                }
            }
    }
    
    private var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { value in
                rotation = value
            }
            .onEnded { _ in
                withAnimation(.spring()) {
                    rotation = .degrees(0)
                }
            }
    }
}

#Preview {
    NavigationView {
        RectangleExampleView03()
    }
}