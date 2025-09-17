# Rectangle

Rectangle 是 SwiftUI 中最基础的形状视图之一，用于绘制矩形。它是一个简单但功能强大的视图，可以用于创建各种 UI 元素，如背景、分隔线、进度条等。

## 组件概述

Rectangle 创建一个填充其可用空间的矩形形状。它遵循 `Shape` 协议，这意味着它可以被填充、描边，并且可以应用各种视觉效果。

### 基本语法

```swift
Rectangle()
```

## 基本用法

### 1. 基础矩形

```swift
Rectangle()
    .frame(width: 200, height: 100)
```

### 2. 颜色填充

```swift
Rectangle()
    .fill(Color.blue)
    .frame(width: 200, height: 100)
```

### 3. 固定宽高比

```swift
Rectangle()
    .fill(Color.red)
    .aspectRatio(16/9, contentMode: .fit)
    .frame(width: 200)
```

## 所有 Modifier 详解

### 填充相关 Modifier

#### `.fill(_:style:)`
用于填充矩形的颜色或材质。

```swift
// 纯色填充
Rectangle()
    .fill(Color.blue)

// 渐变填充
Rectangle()
    .fill(LinearGradient(
        colors: [.red, .blue],
        startPoint: .leading,
        endPoint: .trailing
    ))

// 材质填充
Rectangle()
    .fill(.ultraThinMaterial)
```

**参数说明：**
- `content`: 填充内容，可以是颜色、渐变或材质
- `style`: 填充样式，默认为 `.nonZero`

### 描边相关 Modifier

#### `.stroke(_:lineWidth:)`
为矩形添加边框。

```swift
// 简单边框
Rectangle()
    .stroke(Color.blue, lineWidth: 3)

// 渐变边框
Rectangle()
    .stroke(LinearGradient(
        colors: [.purple, .pink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    ), lineWidth: 5)
```

#### `.stroke(_:style:)`
使用自定义样式描边。

```swift
Rectangle()
    .stroke(Color.red, style: StrokeStyle(
        lineWidth: 3,
        lineCap: .round,
        lineJoin: .round,
        miterLimit: 10,
        dash: [10, 5],
        dashPhase: 0
    ))
```

**StrokeStyle 参数：**
- `lineWidth`: 线条宽度
- `lineCap`: 线条端点样式（`.butt`, `.round`, `.square`）
- `lineJoin`: 线条连接样式（`.miter`, `.round`, `.bevel`）
- `miterLimit`: 斜接限制
- `dash`: 虚线模式数组
- `dashPhase`: 虚线相位偏移

### 尺寸相关 Modifier

#### `.frame(width:height:alignment:)`
设置矩形的固定尺寸。

```swift
Rectangle()
    .frame(width: 200, height: 100)
    .frame(width: 200, height: 100, alignment: .center)
```

#### `.frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)`
设置灵活的尺寸约束。

```swift
Rectangle()
    .frame(
        minWidth: 100,
        idealWidth: 200,
        maxWidth: 300,
        minHeight: 50,
        idealHeight: 100,
        maxHeight: 150
    )
```

#### `.aspectRatio(_:contentMode:)`
保持固定的宽高比。

```swift
// 16:9 宽高比
Rectangle()
    .aspectRatio(16/9, contentMode: .fit)

// 正方形
Rectangle()
    .aspectRatio(1, contentMode: .fit)
```

**contentMode 选项：**
- `.fit`: 完全适应可用空间，保持宽高比
- `.fill`: 填充可用空间，可能被裁剪

### 裁剪和形状修饰

#### `.clipShape(_:style:)`
裁剪为指定形状。

```swift
Rectangle()
    .fill(Color.blue)
    .clipShape(RoundedRectangle(cornerRadius: 10))

Rectangle()
    .fill(Color.red)
    .clipShape(Circle())
```

#### `.cornerRadius(_:)`
添加圆角。

```swift
Rectangle()
    .fill(Color.green)
    .cornerRadius(15)
```

### 变换相关 Modifier

#### `.rotationEffect(_:anchor:)`
旋转矩形。

```swift
Rectangle()
    .rotationEffect(.degrees(45))
    .rotationEffect(.degrees(45), anchor: .topLeading)
```

#### `.scaleEffect(_:anchor:)`
缩放矩形。

```swift
Rectangle()
    .scaleEffect(1.5)
    .scaleEffect(x: 2.0, y: 0.5)
```

#### `.offset(x:y:)`
偏移矩形位置。

```swift
Rectangle()
    .offset(x: 50, y: 100)
    .offset(CGSize(width: 50, height: 100))
```

#### `.rotation3DEffect(_:axis:anchor:anchorZ:perspective:)`
3D 旋转效果。

```swift
Rectangle()
    .rotation3DEffect(
        .degrees(45),
        axis: (x: 1, y: 0, z: 0)
    )
```

### 视觉效果 Modifier

#### `.shadow(color:radius:x:y:)`
添加阴影效果。

```swift
Rectangle()
    .shadow(radius: 5)
    .shadow(color: .gray, radius: 8, x: 5, y: 5)
```

#### `.blur(radius:opaque:)`
模糊效果。

```swift
Rectangle()
    .blur(radius: 5)
```

#### `.opacity(_:)`
设置透明度。

```swift
Rectangle()
    .opacity(0.5)
```

### 交互相关 Modifier

#### `.onTapGesture(count:perform:)`
添加点击手势。

```swift
Rectangle()
    .onTapGesture {
        print("Rectangle tapped")
    }
    .onTapGesture(count: 2) {
        print("Double tapped")
    }
```

#### `.gesture(_:including:)`
添加复杂手势。

```swift
Rectangle()
    .gesture(
        DragGesture()
            .onChanged { value in
                // 处理拖拽
            }
    )
```

## 渐变类型详解

### LinearGradient（线性渐变）

```swift
Rectangle()
    .fill(LinearGradient(
        colors: [.red, .blue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    ))
```

**常用起止点：**
- `.top` / `.bottom`: 垂直渐变
- `.leading` / `.trailing`: 水平渐变
- `.topLeading` / `.bottomTrailing`: 对角线渐变

### RadialGradient（径向渐变）

```swift
Rectangle()
    .fill(RadialGradient(
        colors: [.yellow, .red],
        center: .center,
        startRadius: 20,
        endRadius: 100
    ))
```

### AngularGradient（角度渐变）

```swift
Rectangle()
    .fill(AngularGradient(
        colors: [.red, .yellow, .green, .blue, .purple, .red],
        center: .center
    ))
```

## 常见问题

### 1. 为什么 Rectangle 没有显示？

**问题：** Rectangle 创建后看不见。

**解决方案：**
- 确保设置了 `frame` 或容器有明确的尺寸
- 检查填充颜色是否与背景颜色相同
- 确保没有被其他视图遮挡

```swift
// ❌ 可能看不见
Rectangle()

// ✅ 正确做法
Rectangle()
    .fill(Color.blue)
    .frame(width: 100, height: 100)
```

### 2. 如何创建空心矩形？

**解决方案：** 使用 `stroke` 而不是 `fill`。

```swift
Rectangle()
    .stroke(Color.blue, lineWidth: 3)
    .frame(width: 100, height: 100)
```

### 3. 如何实现不同的圆角？

**解决方案：** 使用 `clipShape` 和自定义形状。

```swift
Rectangle()
    .fill(Color.blue)
    .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
```

### 4. 动画不流畅怎么办？

**解决方案：**
- 使用合适的动画类型
- 避免在动画中改变形状本身
- 使用 `withAnimation` 包装状态改变

```swift
@State private var isAnimating = false

Rectangle()
    .fill(Color.blue)
    .scaleEffect(isAnimating ? 1.2 : 1.0)
    .animation(.easeInOut(duration: 1), value: isAnimating)
```

## 注意事项

### 1. 性能考虑
- Rectangle 是轻量级视图，性能很好
- 大量动画时考虑使用 `drawingGroup()` 优化
- 复杂渐变可能影响性能

### 2. 布局行为
- Rectangle 默认会填充所有可用空间
- 使用 `frame` 限制尺寸
- 在 `ScrollView` 中需要明确指定尺寸

### 3. 适配性
- Rectangle 自适应容器尺寸
- 在不同屏幕尺寸上表现一致
- 支持动态类型和辅助功能

## 最佳实践

### 1. 语义化使用
```swift
// ✅ 明确用途
Rectangle() // 作为分隔线
    .fill(Color.gray)
    .frame(height: 1)

Rectangle() // 作为背景
    .fill(Color.blue.opacity(0.1))
```

### 2. 性能优化
```swift
// ✅ 简单场景使用基础颜色
Rectangle()
    .fill(Color.blue)

// ✅ 复杂场景合理使用渐变
Rectangle()
    .fill(LinearGradient(...))
    .drawingGroup() // 复杂渐变时使用
```

### 3. 响应式设计
```swift
// ✅ 使用相对尺寸
Rectangle()
    .aspectRatio(16/9, contentMode: .fit)
    .frame(maxWidth: .infinity)
```

### 4. 可访问性
```swift
Rectangle()
    .fill(Color.blue)
    .accessibilityLabel("装饰性矩形")
    .accessibilityHidden(true) // 装饰性元素隐藏
```

## 使用场景

### 1. UI 分隔线
```swift
Rectangle()
    .fill(Color.gray.opacity(0.3))
    .frame(height: 1)
```

### 2. 进度条
```swift
ZStack(alignment: .leading) {
    Rectangle()
        .fill(Color.gray.opacity(0.3))
    
    Rectangle()
        .fill(Color.blue)
        .frame(width: geometry.size.width * progress)
}
.frame(height: 8)
.cornerRadius(4)
```

### 3. 背景装饰
```swift
Rectangle()
    .fill(LinearGradient(...))
    .ignoresSafeArea()
```

### 4. 按钮背景
```swift
Rectangle()
    .fill(Color.blue)
    .cornerRadius(8)
    .overlay(
        Text("按钮")
            .foregroundColor(.white)
    )
```

## 相关组件

### 形状组件
- **Circle**: 圆形形状
- **Ellipse**: 椭圆形状
- **RoundedRectangle**: 圆角矩形
- **Capsule**: 胶囊形状

### 容器组件
- **VStack/HStack/ZStack**: 布局容器
- **ScrollView**: 滚动容器
- **LazyVGrid/LazyHGrid**: 网格容器

### 修饰相关
- **Path**: 自定义路径
- **Shape**: 形状协议
- **InsettableShape**: 可内缩形状协议

Rectangle 是 SwiftUI 中最基础但也是最实用的形状组件之一，掌握它的各种用法对于构建美观的用户界面至关重要。