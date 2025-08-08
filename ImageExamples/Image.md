# SwiftUI Image 组件完整指南

## 概述

SwiftUI 的 `Image` 组件是用于显示图像的核心视图组件。它支持多种图像源，包括 SF Symbols、Bundle 资源、网络图片等，并提供了丰富的修饰符来控制图像的显示效果。

## 基本用法

### 1. 初始化方式

#### SF Symbols（系统图标）
```swift
// 基础系统图标
Image(systemName: "heart")

// 填充版本
Image(systemName: "heart.fill")

// 带变体的图标
Image(systemName: "heart.circle.fill")
```

#### Bundle 资源图片
```swift
// 加载 Bundle 中的图片
Image("image-name")

// 从指定 Bundle 加载
Image("image-name", bundle: .main)

// 使用字面量文本（不本地化）
Image(verbatim: "image-name")
```

#### 使用 ImageResource（iOS 17+）
```swift
// 使用 ImageResource
Image(.myImageResource)
```

## 2. 核心修饰符详解

### 图片尺寸控制

#### resizable()
使图片能够调整大小以适应容器：
```swift
Image("photo")
    .resizable()                    // 必须先设置为可调整大小
    .frame(width: 100, height: 100) // 然后设置尺寸
```

#### aspectRatio
控制图片的纵横比：
```swift
Image("photo")
    .resizable()
    .aspectRatio(16/9, contentMode: .fit)  // 16:9 宽屏比例
    .aspectRatio(1.0, contentMode: .fill)   // 1:1 正方形比例
```

#### scaledToFit / scaledToFill
快速设置缩放模式：
```swift
// 适应容器，保持比例，可能留有空白
Image("photo")
    .resizable()
    .scaledToFit()

// 填满容器，保持比例，可能裁剪内容
Image("photo")
    .resizable()
    .scaledToFill()
```

### 图片样式修饰

#### 圆角和形状
```swift
// 圆角
Image("photo")
    .cornerRadius(12)

// 圆形
Image("photo")
    .clipShape(Circle())

// 自定义形状
Image("photo")
    .clipShape(RoundedRectangle(cornerRadius: 16))
```

#### 边框
```swift
// 基础边框
Image("photo")
    .border(Color.black, width: 2)

// 圆角边框（使用 overlay）
Image("photo")
    .cornerRadius(12)
    .overlay(
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.blue, lineWidth: 2)
    )
```

#### 阴影效果
```swift
// 基础阴影
Image("photo")
    .shadow(radius: 5)

// 带偏移和颜色的阴影
Image("photo")
    .shadow(color: .black.opacity(0.3), radius: 8, x: 2, y: 4)

// 多层阴影
Image("photo")
    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
```

### 颜色和渲染

#### renderingMode
控制图片如何响应颜色设置：
```swift
// 自动模式（默认）
Image(systemName: "heart")
    .renderingMode(.automatic)

// 原始颜色模式
Image(systemName: "heart")
    .renderingMode(.original)

// 模板模式（可着色）
Image(systemName: "heart")
    .renderingMode(.template)
    .foregroundColor(.red)
```

#### 颜色设置
```swift
// SF Symbol 着色
Image(systemName: "star")
    .foregroundColor(.yellow)

// 渐变着色（iOS 15+）
Image(systemName: "star")
    .foregroundStyle(
        LinearGradient(
            colors: [.yellow, .orange],
            startPoint: .top,
            endPoint: .bottom
        )
    )

// 多层级着色（iOS 15+）
Image(systemName: "person.crop.circle.fill")
    .symbolRenderingMode(.palette)
    .foregroundStyle(.blue, .gray.opacity(0.3))
```

#### 颜色混合
```swift
// 颜色叠加
Image("photo")
    .colorMultiply(.blue)

// 图片滤镜
Image("photo")
    .saturation(0.5)        // 饱和度
    .brightness(0.2)        // 亮度
    .contrast(1.2)          // 对比度
    .hueRotation(.degrees(180)) // 色调旋转
```

### 叠加层和背景

#### overlay 覆盖层
```swift
// 文字覆盖
Image("photo")
    .overlay(
        Text("NEW")
            .foregroundColor(.white)
            .padding(4)
            .background(Color.red)
            .cornerRadius(4),
        alignment: .topTrailing
    )

// 渐变覆盖
Image("photo")
    .overlay(
        LinearGradient(
            colors: [.clear, .black.opacity(0.6)],
            startPoint: .top,
            endPoint: .bottom
        )
    )
```

#### background 背景层
```swift
// 彩色背景
Image(systemName: "heart")
    .foregroundColor(.white)
    .padding()
    .background(Color.red)
    .cornerRadius(12)

// 渐变背景
Image(systemName: "star")
    .foregroundColor(.white)
    .padding()
    .background(
        LinearGradient(
            colors: [.orange, .red],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
```

## 3. AsyncImage 异步图片加载

### 基础用法
```swift
// 简单异步加载
AsyncImage(url: URL(string: "https://example.com/image.jpg"))
```

### 带占位符的异步加载
```swift
AsyncImage(url: URL(string: "https://example.com/image.jpg")) { image in
    image
        .resizable()
        .aspectRatio(contentMode: .fit)
} placeholder: {
    ProgressView()
        .frame(width: 100, height: 100)
}
```

### 完整状态处理
```swift
AsyncImage(url: URL(string: "https://example.com/image.jpg")) { phase in
    switch phase {
    case .empty:
        // 初始状态
        ProgressView()
    case .loading:
        // 加载中
        ProgressView("加载中...")
    case .success(let image):
        // 加载成功
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    case .failure(_):
        // 加载失败
        Image(systemName: "photo")
            .foregroundColor(.gray)
    @unknown default:
        EmptyView()
    }
}
.frame(width: 200, height: 200)
```

## 4. SF Symbols 高级配置

### Symbol 变体
```swift
// 基础变体
Image(systemName: "wifi")
    .symbolVariant(.none)      // 默认
    .symbolVariant(.fill)      // 填充
    .symbolVariant(.circle)    // 圆形
    .symbolVariant(.square)    // 方形
```

### Symbol 权重
```swift
Image(systemName: "star")
    .symbolWeight(.ultraLight) // 超细
    .symbolWeight(.thin)       // 细
    .symbolWeight(.light)      // 轻
    .symbolWeight(.regular)    // 常规（默认）
    .symbolWeight(.medium)     // 中等
    .symbolWeight(.semibold)   // 半粗
    .symbolWeight(.bold)       // 粗
    .symbolWeight(.heavy)      // 重
    .symbolWeight(.black)      // 黑
```

### Symbol 渲染模式（iOS 15+）
```swift
Image(systemName: "person.crop.circle.fill")
    .symbolRenderingMode(.monochrome)  // 单色
    .symbolRenderingMode(.multicolor)  // 多色
    .symbolRenderingMode(.palette)     // 调色板
    .symbolRenderingMode(.hierarchical) // 层次化
```

## 5. 高级效果和变换

### 3D 变换
```swift
Image("photo")
    .rotation3DEffect(
        .degrees(45),
        axis: (x: 1, y: 0, z: 0)
    )
```

### 混合模式
```swift
ZStack {
    Image("background")
    Image("overlay")
        .blendMode(.multiply)
}
```

### 蒙版
```swift
Image("photo")
    .mask(
        LinearGradient(
            colors: [.black, .clear],
            startPoint: .top,
            endPoint: .bottom
        )
    )
```

### 动画变换
```swift
@State private var scale: CGFloat = 1.0

Image("photo")
    .scaleEffect(scale)
    .onTapGesture {
        withAnimation(.easeInOut(duration: 0.3)) {
            scale = scale == 1.0 ? 1.2 : 1.0
        }
    }
```

## 6. 性能优化

### 图片尺寸优化
```swift
// ❌ 避免不必要的大图缩放
Image("large-image")
    .resizable()
    .frame(width: 50, height: 50)

// ✅ 使用适当尺寸的图片
Image("small-image")  // 已经是 50x50 的图片
    .frame(width: 50, height: 50)
```

### AsyncImage 缓存
```swift
// AsyncImage 自动处理缓存，无需额外配置
AsyncImage(url: imageURL) { image in
    image.resizable().scaledToFit()
} placeholder: {
    ProgressView()
}
```

### 长列表优化
```swift
// 使用 LazyVStack 延迟加载
LazyVStack {
    ForEach(imageURLs, id: \.self) { url in
        AsyncImage(url: url) { image in
            image.resizable().scaledToFit()
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
        }
        .frame(height: 200)
    }
}
```

## 7. 常见问题和解决方案

### Q: 为什么设置 frame 对图片无效？
A: 需要先调用 `.resizable()` 使图片可调整大小：
```swift
// ❌ 错误
Image("photo")
    .frame(width: 100, height: 100)

// ✅ 正确
Image("photo")
    .resizable()
    .frame(width: 100, height: 100)
```

### Q: 如何让图片保持比例且不变形？
A: 使用 `scaledToFit()` 或设置适当的 `aspectRatio`：
```swift
Image("photo")
    .resizable()
    .scaledToFit()
    .frame(width: 200, height: 200)
```

### Q: SF Symbol 为什么不能着色？
A: 检查 `renderingMode` 设置：
```swift
// ✅ 确保使用 template 模式
Image(systemName: "heart")
    .renderingMode(.template)
    .foregroundColor(.red)
```

### Q: AsyncImage 加载失败怎么处理？
A: 使用 phase 参数处理所有状态：
```swift
AsyncImage(url: url) { phase in
    switch phase {
    case .failure(_):
        Button("重试") {
            // 重新加载逻辑
        }
    default:
        // 其他状态处理
    }
}
```

## 8. 最佳实践

### 图片资源管理
1. **使用 Asset Catalog**：将图片添加到 Asset Catalog 以支持多种设备和分辨率
2. **提供多种尺寸**：为不同使用场景准备不同尺寸的图片
3. **优化图片格式**：使用适当的图片格式（HEIF、WebP 等）

### 用户体验
1. **提供占位符**：异步加载时显示有意义的占位符
2. **错误处理**：优雅处理加载失败情况
3. **加载状态**：显示加载进度或状态指示

### 性能考虑
1. **延迟加载**：在长列表中使用 LazyVStack
2. **图片缓存**：利用 AsyncImage 的自动缓存
3. **内存管理**：避免同时加载过多大图片

### 可访问性
1. **添加描述**：为图片添加适当的可访问性标签
```swift
Image("photo")
    .accessibilityLabel("产品照片")
    .accessibilityHidden(false)
```

2. **支持动态类型**：确保图片在不同字体大小下正常显示

## 9. 相关组件

### 与其他组件的协作
- **Button**：图片按钮
- **NavigationLink**：图片导航链接  
- **TabView**：图片轮播
- **List/LazyVGrid**：图片网格展示

### 替代方案
- **AsyncImage**：网络图片加载
- **PhotosPicker**：系统照片选择器
- **CameraView**：相机捕获（第三方）

## 10. 版本兼容性

| 功能 | iOS 版本 | 说明 |
|------|----------|------|
| Image 基础功能 | iOS 13+ | 核心图片显示功能 |
| AsyncImage | iOS 15+ | 异步图片加载 |
| symbolRenderingMode | iOS 15+ | SF Symbol 渲染模式 |
| foregroundStyle | iOS 15+ | 渐变和多色前景 |
| ImageResource | iOS 17+ | 类型安全的图片资源 |

通过掌握这些 Image 组件的功能和最佳实践，你可以在 SwiftUI 应用中创建丰富、高性能的图片展示体验。