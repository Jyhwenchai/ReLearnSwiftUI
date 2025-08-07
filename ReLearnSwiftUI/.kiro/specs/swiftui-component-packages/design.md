# 设计文档

## 概述

本设计文档描述了 ReLearnSwiftUI 项目的简化架构。项目的核心目标是为个人 SwiftUI 学习提供便利，通过为每个 SwiftUI 组件创建独立的 Swift Package 来组织示例代码，并在主应用中进行统一展示。

## 架构

**缩进**: 使用 2 个空格

### 项目结构

```
ReLearnSwiftUI/
├── ReLearnSwiftUI/                    # 主应用
│   ├── ReLearnSwiftUIApp.swift       # 应用入口
│   ├── ContentView.swift             # 主界面 - 组件选择列表
│   └── Views/                        # 示例展示视图
│       └── ComponentExampleView.swift # 通用示例展示页面
├── Packages/                         # 本地Swift Package目录
│   ├── TextExamples/                 # Text组件示例包
│   ├── ImageExamples/                # Image组件示例包
│   ├── ButtonExamples/               # Button组件示例包
│   └── ...                          # 其他组件包
└── Package.swift                     # 主项目依赖配置
```

### 组件包结构

每个组件包采用简单统一的结构：

```
TextExamples/                         # 以Text为例
├── Package.swift                     # 包配置
├── Sources/
│   └── TextExamples/
│       ├── TextExamples.swift        # 示例视图集合
│       └── TextExample1.swift   # Text示例1
│       └── TextExample2.swift   # Text示例2
├── Documentation/
│   └── Text.md                       # 完整的使用文档
└── README.md                         # 包说明
```

## 组件和接口

### 主应用组件

#### ContentView (主界面)

```swift
struct ContentView: View {
    let components = ["Text", "Image", "Button", "VStack", "HStack"] // 组件列表

    var body: some View {
        NavigationView {
            List(components, id: \.self) { component in
                NavigationLink(destination: getComponentView(component)) {
                    Text(component)
                }
            }
            .navigationTitle("SwiftUI 组件学习")
        }
    }

    // 根据组件名返回对应的示例视图
    private func getComponentView(_ component: String) -> some View {
        // 返回对应组件的示例视图
    }
}
```

#### ComponentExampleView (通用示例展示)

```swift
struct ComponentExampleView: View {
    let componentName: String
    @State private var selectedExample = 0

    var body: some View {
        VStack {
            // Package 示例列表
            List {

            }

            // 示例展示区域
        }
        .navigationTitle(componentName)
    }
}
```

### 组件包接口

每个组件包提供统一的接口：

```swift
// TextExamples.swift
public struct TextExamples {
    var body: some View {
        List {
            // 示例1

            // 示例2

            ...
        }
   }
}

public struct TextExample1 {
   var body: some View {
    VStack(spacing: 20) {
            // 基础Text使用，包含详细中文注释
            Text("Hello, World!")  // 最基本的文本显示
                .font(.title)      // 设置字体大小为标题样式
                .foregroundColor(.blue)  // 设置文本颜色为蓝色
        }
   }
}
```

## 数据模型

### 简化的数据结构

```swift
// 组件信息
struct ComponentInfo {
    let name: String
    let description: String
    let exampleCount: Int
}

// 示例类型
enum ExampleType: String, CaseIterable {
    case basic = "基础用法"
    case styling = "样式设置"
    case advanced = "高级特性"
}
```

## 实现重点

### 1. 完备的中文注释

每个示例代码都包含详细的中文注释，解释：

- 每行代码的作用
- SwiftUI 概念和原理
- 常见问题和注意事项
- 相关的 Modifier 说明

### 2. 完整的文档手册

每个组件包含一个完整的.md 文档，包括：

- 组件概述和用途
- 基本用法和语法
- 所有可用的 Modifier 详解
- 常见问题和解决方案
- 最佳实践建议
- 相关组件的关联说明

### 3. 简单的导航结构

- 主界面显示所有组件列表
- 点击组件进入该组件的示例页面
- 示例页面包含多个示例和完整文档
- 支持在示例和文档之间切换查看

### 4. 本地包管理

- 使用 Xcode 的本地包功能
- 每个组件一个独立的 Swift Package
- 在主项目中通过本地路径引用各个包
- 便于单独开发和维护每个组件的示例
