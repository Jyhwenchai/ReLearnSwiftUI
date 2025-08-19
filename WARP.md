# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## 项目概述

ReLearnSwiftUI 是一个系统化的 SwiftUI 组件学习与演示工程，旨在通过渐进式示例帮助开发者全面掌握 SwiftUI 各个组件的使用方法和最佳实践。

### 目标与定位

该仓库采用模块化架构，每个独立的 Swift Package 专注演示一个特定的 SwiftUI 组件或主题。每个包都提供从基础用法到高级功能的渐进式示例，确保学习者能够逐步深入理解。主应用 ReLearnSwiftUI 作为统一的容器和导航中心，整合所有组件包并提供统一的用户体验。

### 架构总览

- **主应用** (`ReLearnSwiftUI`): 作为入口点，维护组件列表并提供导航功能
- **组件包** (如 `TextExample`, `ButtonExample`): 每个包包含 3-6 个渐进式示例视图
- **共享组件** (`ShareComponent`): 提供统一的 UI 模式和布局组件，确保所有示例包的一致性
- **文档体系**: 由 AI 辅助生成详尽的中文技术文档，包含代码片段和最佳实践

### 渐进式示例哲学

本项目采用渐进式示例设计哲学：每个组件包包含多个编号的示例视图（从 01 开始），每个示例专注一个特定学习目标，从基础概念逐步过渡到复杂应用场景。这种设计确保学习者能够循序渐进地掌握知识，避免认知过载。

ShareComponent 的存在是为了标准化所有示例包的 UI 呈现模式，提供 `ComponentExample`、`ExampleContainerView` 和 `ExampleSection` 等可复用组件，确保学习体验的一致性和专业性。

### 学习路径

建议学习顺序：
1. **基础组件**: Text → Image → Button → Label
2. **交互组件**: TextField → TextEditor → Picker → Slider → Stepper
3. **导航和菜单**: Link → Menu → CommandMenu
4. **高级功能**: DatePicker → Toggle → ShareLink
5. **平台特定**: HelpLink (macOS)、EditButton (iOS)

---

## 快速导航

- [项目概述](#项目概述)
- [代码架构](#代码架构)
- [常用开发命令](#常用开发命令)
- [包开发工作流](#包开发工作流)
- [项目约定与模式](#项目约定与模式)
- [组件清单与平台说明](#组件清单与平台说明)
- [维护与版本管理](#维护与版本管理)
- [附录：模板与代码片段](#附录模板与代码片段)

---

## 代码架构

### 主应用结构

#### ContentView 角色

ContentView 是主应用的核心视图，维护一个包含所有可用组件信息的数组。每个组件项包含展示名称、描述、图标和对应的包入口视图。采用 NavigationStack 和 List 构建清晰的层级导航结构。

```swift
struct ContentView: View {
  let components = [
    ComponentInfo(
      name: "Text",
      description: "文本显示组件", 
      icon: "textformat",
      view: AnyView(TextExample())
    ),
    ComponentInfo(
      name: "Image", 
      description: "图片显示组件",
      icon: "photo", 
      view: AnyView(ImageExample())
    )
  ]
  
  var body: some View {
    NavigationStack {
      List(components, id: \.name) { component in
        NavigationLink(destination: component.view) {
          ComponentRowView(component: component)
        }
      }
      .navigationTitle("SwiftUI 组件学习")
    }
  }
}
```

#### 数据模型

- **ComponentInfo**: 组件信息数据模型，包含 `name`（组件名称）、`description`（组件描述）、`icon`（SF Symbol 图标名）、`view`（对应的包入口视图）
- **ComponentRowView**: 统一的列表行视图，使用系统色彩和 SF Symbols 确保一致的视觉呈现

### 组件包结构模式

#### 目录约定

每个组件包遵循统一的目录结构：

```
ComponentNameExample/
├── Package.swift                    # Swift Package 配置
├── Sources/
│   └── ComponentNameExample/
│       ├── ComponentNameExample.swift     # 包入口聚合视图
│       ├── ComponentNameExampleView01.swift # 渐进式示例视图
│       ├── ComponentNameExampleView02.swift
│       └── ...
├── README.md 或 ComponentName.md    # 详细技术文档
├── CLAUDE.md                        # 示例功能说明
└── Task.md                          # 开发任务记录
```

#### 入口视图模式

每个包的主入口视图使用 ShareComponent 提供的 `ComponentExample` 组件，包装多个 NavigationLink 到各个示例视图：

```swift
import SwiftUI
import ShareComponent

public struct TextExample: View {
  public init() {}
  public var body: some View {
    ComponentExample(componentTitle: "Text") {
      NavigationLink("基础文本显示") { TextExampleView01() }
      NavigationLink("文本修饰样式") { TextExampleView02() }
      NavigationLink("多行文本布局") { TextExampleView03() }
      NavigationLink("高级功能") { TextExampleView04() }
    }
  }
}
```

### 共享组件 (ShareComponent)

ShareComponent 提供统一的 UI 模式和可复用组件：

#### 核心组件

1. **ComponentExample**: 在包入口提供统一的列表布局和标题样式
2. **ExampleContainerView**: 单个示例页的容器组件，提供标题、滚动布局和可选的脚注区域
3. **ExampleSection**: 示例页内的分区块组件，提供统一的标题样式、背景色和阴影效果

#### 平台适配处理

ShareComponent 内置平台条件编译，确保在不同平台上的最佳呈现：

```swift
#if os(iOS)
  .navigationBarTitleDisplayMode(.large)
#endif

private func backgroundColorForPlatform() -> Color {
  #if os(iOS)
    return Color(UIColor.systemBackground)
  #else
    return Color(.controlBackgroundColor)
  #endif
}
```

#### 示例页内容组织

在每个示例视图中，使用 ExampleContainerView 和 ExampleSection 组织内容：

```swift
struct TextExampleView01: View {
  var body: some View {
    ExampleContainerView("基础文本显示") {
      ExampleSection("系统字体样式") {
        // 示例内容
      }
      
      ExampleSection("自定义字体") {
        // 示例内容  
      }
    }
  }
}
```

---

## 常用开发命令

### Swift Package Manager

#### 包管理基础命令

```bash
# 初始化新的库包
swift package init --type library

# 构建当前包
swift build

# 运行包内测试
swift test

# 清理构建产物
swift package clean

# 解析和更新依赖
swift package resolve
swift package update

# 查看包信息
swift package describe
```

### Xcode 构建与调试

#### 主应用工程操作

在 Xcode 中：
- 打开 `ReLearnSwiftUI/ReLearnSwiftUI.xcodeproj`
- 选择 `ReLearnSwiftUI` scheme
- 使用 `Cmd+B` 构建，`Cmd+R` 运行

命令行构建主应用：

```bash
# iOS 模拟器构建
xcodebuild -project ReLearnSwiftUI/ReLearnSwiftUI.xcodeproj -scheme ReLearnSwiftUI -destination 'platform=iOS Simulator,name=iPhone 16' build

# macOS 构建
xcodebuild -project ReLearnSwiftUI/ReLearnSwiftUI.xcodeproj -scheme ReLearnSwiftUI -destination 'platform=macOS' build
```

#### 独立包调试

对于单独的组件包：
- 直接用 Xcode 打开包目录
- 选择一个示例视图文件
- 使用 Canvas 进行预览和调试

### 预览与调试

#### SwiftUI 预览

- 在示例视图中右键选择 "Show Preview"
- 使用 Xcode Canvas 进行实时预览
- 利用 `#Preview` 宏创建预览内容

#### 日志调试

```swift
import os.log

// 使用结构化日志记录
let logger = Logger(subsystem: "com.example.app", category: "UI")
logger.info("示例视图已加载")

// 开发阶段可使用 print，提交前需清理
print("调试信息：当前状态为 \(state)")
```

---

## 包开发工作流

### 1. 规划与分解

#### 创建实现计划

在开始开发前，创建 `IMPLEMENTATION_PLAN.md` 文件，将工作分解为 3-5 个阶段：

```markdown
## Stage 1: 基础包结构搭建
**Goal**: 创建包基础结构和依赖配置
**Success Criteria**: 包可编译通过，依赖 ShareComponent 正常工作
**Tests**: swift build 成功执行

## Stage 2: 示例视图实现
**Goal**: 实现 4 个渐进式示例视图
**Success Criteria**: 每个示例都有完整功能和中文注释
**Tests**: 所有示例视图在预览中正常显示

...
```

### 2. 初始化包

```bash
# 在项目根目录执行
cd /path/to/ReLearnSwiftUI
swift package init --type library

# 重命名为符合约定的包名
mv Sources/ReLearnSwiftUI Sources/LinkExample
```

**命名规范**: `ComponentNameExample`，如 `LinkExample`、`ToggleExample`

### 3. 配置 Package.swift

```swift
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "LinkExample",
  platforms: [.iOS(.v18), .macOS(.v15)],
  products: [
    .library(name: "LinkExample", targets: ["LinkExample"])
  ],
  dependencies: [
    .package(path: "../ShareComponent")
  ],
  targets: [
    .target(name: "LinkExample", dependencies: ["ShareComponent"])
  ]
)
```

### 4. 编写入口视图与示例视图

#### 包入口视图 (Sources/LinkExample/LinkExample.swift)

```swift
import SwiftUI
import ShareComponent

public struct LinkExample: View {
  public init() {}
  
  public var body: some View {
    ComponentExample(componentTitle: "Link") {
      NavigationLink("基础用法") { LinkExampleView01() }
      NavigationLink("样式与修饰符") { LinkExampleView02() }
      NavigationLink("容器与交互") { LinkExampleView03() }
      NavigationLink("实际场景") { LinkExampleView04() }
    }
  }
}
```

#### 示例视图结构

每个示例视图使用 ExampleContainerView 和 ExampleSection 组织内容：

```swift
struct LinkExampleView01: View {
  var body: some View {
    ExampleContainerView("基础用法") {
      ExampleSection("创建链接") {
        // 具体示例代码
      }
      
      ExampleSection("链接样式") {
        // 具体示例代码
      }
    } footer: {
      Text("学习要点：掌握 Link 组件的基本创建方法和样式设置")
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }
}
```

### 5. 文档编写规范

每个包必须包含以下文档：

#### README.md 或 ComponentName.md
- 包的技术详细说明
- API 参考和使用示例  
- 平台兼容性说明
- 最佳实践和常见问题

#### CLAUDE.md
- 示例功能概述
- 学习路径建议
- 技术特色说明

#### Task.md
- 开发任务分解
- 完成状态跟踪
- 技术决策记录

### 6. 平台与条件编译

对于平台特定功能，使用条件编译：

```swift
#if os(iOS)
  .navigationBarTitleDisplayMode(.large)
  .toolbarBackground(Color.blue, for: .navigationBar)
#elseif os(macOS)
  .navigationTitle("macOS 专用标题")
#endif

// 平台可用性检查
if #available(iOS 17.0, macOS 14.0, *) {
  // 使用新版本 API
} else {
  // 降级处理
}
```

在文档中明确标注平台限制：

```markdown
## 平台支持

- ✅ iOS 18.0+: 完整功能支持
- ✅ macOS 15.0+: 完整功能支持  
- ⚠️ HelpLink 仅支持 macOS 14.0+
```

### 7. 集成到主应用

#### 添加包依赖

1. 在 Xcode 中打开主应用工程
2. 选择项目 → Package Dependencies
3. 点击 "+" 添加本地包
4. 选择新创建的包目录

#### 更新 ContentView

```swift
import SwiftUI
import TextExample
import ButtonExample 
import LinkExample  // 新添加

struct ContentView: View {
  let components = [
    ComponentInfo(
      name: "Text",
      description: "文本显示组件",
      icon: "textformat", 
      view: AnyView(TextExample())
    ),
    ComponentInfo(
      name: "Link", 
      description: "超链接组件",
      icon: "link",
      view: AnyView(LinkExample())  // 新添加
    )
  ]
  // ... 其余代码
}
```

### 8. 测试与验收

#### 编译测试

```bash
# 测试包编译
cd LinkExample
swift build

# 测试主应用编译
xcodebuild -project ReLearnSwiftUI/ReLearnSwiftUI.xcodeproj -scheme ReLearnSwiftUI build
```

#### 功能验收

- 运行主应用，确认新组件出现在列表中
- 点击进入包入口页，检查导航和布局
- 逐个测试示例页功能
- 验证在不同平台上的表现

#### 完成工作

- 更新 IMPLEMENTATION_PLAN.md 状态为 Complete
- 提交代码并移除计划文件
- 更新仓库组件清单

### 提交规范

- **提交信息格式**: `feat: 添加 LinkExample 包 - 实现基础链接功能`
- **包含链接**: 引用相关的 IMPLEMENTATION_PLAN.md
- **小步提交**: 每个阶段完成后及时提交，确保代码始终可编译

---

## 项目约定与模式

### 命名规范

#### 包和文件命名

- **包名**: `ComponentNameExample`，如 `TextExample`、`ButtonExample`
- **示例文件**: `PackageNameView01.swift` 到 `PackageNameView0N.swift`
- **入口文件**: `Sources/PackageName/PackageName.swift`
- **文档文件**: `README.md`（或 `PackageName.md`）、`CLAUDE.md`、`Task.md`

#### 示例编号意义

编号从 01 开始，体现学习层次：
- **01**: 基础概念和最简单用法
- **02**: 样式定制和修饰符
- **03**: 容器集成和布局
- **04**: 高级功能和复杂场景
- **05-06**: 特殊用法和实际应用

### UI 复用模式

#### 统一组件使用

- **入口页**: 使用 `ComponentExample` 提供统一列表和标题样式
- **示例页**: 使用 `ExampleContainerView` 和 `ExampleSection` 组织布局
- **主应用**: 使用 `ComponentRowView` 渲染统一的列表行样式

#### 导航模式

- 主应用统一使用 `NavigationStack` 和 `List`
- 包内示例使用 `NavigationLink` 进行页面跳转
- 保持导航层次清晰，避免深层嵌套

### 平台适配策略

#### 条件编译处理

```swift
#if os(iOS)
  // iOS 专属功能
  .onTapGesture { 
    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
  }
#endif

#if canImport(UIKit)
  import UIKit
#elseif canImport(AppKit) 
  import AppKit
#endif
```

#### 版本兼容性

- 在 Package.swift 中明确声明最低支持版本
- 使用 `@available` 处理 API 版本差异
- 在文档中清晰标注平台限制

### 代码质量标准

#### 注释规范

- 使用详尽的中文注释解释概念、意图和技术选择
- 每个示例前添加学习目标说明
- 复杂逻辑需要步骤分解注释

```swift
// MARK: - 基础链接创建
/// 展示三种不同的链接创建方式
/// 学习目标：掌握 Link 组件的基本初始化方法
ExampleSection("创建方式") {
  VStack(spacing: 16) {
    // 方式一：字符串标签 + URL 目标
    Link("访问 Apple 官网", destination: URL(string: "https://apple.com")!)
    
    // 方式二：自定义视图标签
    Link(destination: URL(string: "https://developer.apple.com")!) {
      HStack {
        Image(systemName: "swift")
        Text("Swift 文档")
      }
    }
  }
}
```

#### 错误处理

- 优雅处理可能的失败情况
- 提供用户友好的错误反馈
- 避免静默失败

```swift
Button("打开链接") {
  guard let url = URL(string: urlString) else {
    showError("无效的 URL 格式")
    return
  }
  
  UIApplication.shared.open(url)
}
```

### 质量门禁

#### 开发准则

遵循项目 Development Guidelines：

1. **渐进式实现**: 每个功能分步实现，避免大块提交
2. **3 次规则**: 同一问题尝试 3 次后停下来重新分析
3. **测试驱动**: 先写测试用例，再实现功能
4. **持续集成**: 每次提交都要编译通过

#### 提交检查清单

- [ ] 代码编译通过，无警告
- [ ] 所有示例在预览中正常显示  
- [ ] 平台适配代码经过测试
- [ ] 文档完整，包含使用示例
- [ ] 注释清晰，解释技术选择
- [ ] 遵循项目命名和结构约定

### 文档约定

#### 技术文档结构

```markdown
# ComponentName 组件详解

## 概述
- 组件作用和适用场景
- 主要功能特性

## 基础用法
- 最简单的使用示例
- 核心 API 介绍

## 高级功能
- 复杂用法和配置选项
- 性能优化建议

## 平台差异
- 不同平台的行为差异
- 版本兼容性说明

## 最佳实践
- 推荐用法模式
- 常见陷阱和解决方案

## 常见问题
- FAQ 和故障排除
```

#### 示例文档规范

每个示例前明确说明：
- **学习目标**: 这个示例要学习什么
- **适用场景**: 什么时候使用这种模式
- **技术要点**: 涉及的关键概念
- **注意事项**: 可能的陷阱和最佳实践

---

## 组件清单与平台说明

### 已完成的组件包

#### 基础文本和图像组件

- **TextExample** ✅
  - 5 个渐进式示例视图
  - 平台支持: iOS 18+, macOS 15+
  - 特色: 完整的文本样式、格式化和国际化演示

- **ImageExample** ✅  
  - 多个示例视图
  - 平台支持: iOS 18+, macOS 15+
  - 特色: 图片加载、缩放、样式处理

#### 交互控件组件

- **ButtonExample** ✅
  - 4 个渐进式示例视图
  - 平台支持: 跨平台兼容
  - 特色: 完整的按钮样式系统、自定义 ButtonStyle、交互反馈

- **LabelExample** ✅
  - 4 个渐进式示例视图  
  - 平台支持: 跨平台兼容
  - 特色: 自定义 LabelStyle、可访问性支持

- **SliderExample** ✅
  - 渐进式示例设计
  - 平台支持: 跨平台兼容
  - 特色: 数值控制和样式定制

- **StepperExample** ✅
  - 渐进式示例设计
  - 平台支持: 跨平台兼容  
  - 特色: 步进控制和自定义样式

- **ToggleExample** ✅
  - 渐进式示例设计
  - 平台支持: 跨平台兼容
  - 特色: 开关控制和样式定制

#### 文本输入组件

- **TextFieldExample** ✅
  - 4 个示例视图
  - 平台支持: 跨平台，部分功能有平台差异
  - 特色: 输入验证、格式化、条件编译处理

- **TextEditorExample** ✅  
  - 4 个渐进式示例视图
  - 平台支持: iOS 15+, macOS 15+
  - 特色: 多行文本编辑、实际应用场景演示

#### 选择器组件

- **PickerExample** ✅
  - 渐进式示例设计
  - 平台支持: 跨平台兼容
  - 特色: 多种选择器样式和用法

- **DatePickerExample** ✅
  - 渐进式示例设计  
  - 平台支持: 跨平台兼容
  - 特色: 日期时间选择和格式化

- **MultiDatePickerExample** ✅
  - 渐进式示例设计
  - 平台支持: 跨平台兼容
  - 特色: 多日期选择功能

#### 按钮和操作组件

- **EditButtonExample** ✅
  - 2 个完整示例视图
  - 平台支持: iOS 16.0+ 专用
  - 特色: 编辑模式完整演示

- **PasteButtonExample** ✅
  - 4 个渐进式示例视图  
  - 平台支持: 跨平台，剪贴板处理
  - 特色: 剪贴板数据处理和平台适配

- **RenameButtonExample** 🔄
  - 开发中
  - 平台支持: 待确认

#### 菜单和导航组件

- **MenuExample** ✅
  - 6 个渐进式示例视图
  - 平台支持: iOS 17.0+, macOS 14.0+, tvOS 17.0+, visionOS 1.0+
  - 特色: 嵌套菜单、上下文菜单、动态菜单内容

- **CommandMenuExample** ✅
  - 渐进式示例设计
  - 平台支持: 跨平台兼容
  - 特色: 命令菜单实现和交互

- **LinkExample** 🔄  
  - 开发中
  - 平台支持: 待确认

#### 分享和预览组件

- **ShareLinkExample** 🔄
  - 开发中
  - 平台支持: 待确认

- **SharePreviewExample** 🔄
  - 开发中  
  - 平台支持: 待确认

#### 平台特定组件

- **HelpLinkExample** ✅
  - 4 个渐进式示例视图
  - 平台支持: **仅 macOS 14.0+**
  - 特色: 自动定位机制、实际应用场景
  - ⚠️ **待办**: 尚未集成到主应用 ContentView 中

### 平台兼容性注意事项

#### macOS 专用组件

- **HelpLinkExample**: 由于 `HelpLink` 是 macOS 独有组件，仅在 macOS 14.0+ 可用
- 在 iOS 构建时会被条件编译排除

#### 版本要求统计

- **最低 iOS 版本**: iOS 15.0+ (大部分组件)，iOS 18.0+ (最新组件)
- **最低 macOS 版本**: macOS 14.0+ (大部分组件)，macOS 15.0+ (最新组件)  
- **Swift 版本**: 6.1+

#### 跨平台差异处理

项目中大量使用条件编译处理平台差异：

```swift
#if os(iOS)
  .navigationBarTitleDisplayMode(.large)
#endif

#if canImport(UIKit)
  // iOS/tvOS 特定实现
#elseif canImport(AppKit)
  // macOS 特定实现  
#endif
```

---

## 维护与版本管理

### 组件包生命周期管理

#### 新增组件包后的维护任务

1. **更新 ContentView**: 在主应用的 components 数组中添加新组件入口
2. **更新本文档**: 在组件清单中添加新包的信息和平台说明
3. **版本兼容性**: 确保新包的平台要求不会破坏现有构建
4. **文档同步**: 更新各级 README 和学习路径说明

#### 待办事项跟踪

- [ ] **HelpLinkExample 集成**: 将已完成的 HelpLinkExample 集成到主应用 ContentView 中
- [ ] **LinkExample 完成**: 完成 LinkExample 包的开发和集成
- [ ] **RenameButtonExample 完成**: 完成 RenameButtonExample 包的开发
- [ ] **ShareLinkExample 完成**: 完成 ShareLinkExample 包的开发
- [ ] **SharePreviewExample 完成**: 完成 SharePreviewExample 包的开发

### 版本更新策略

#### Swift 和 Xcode 版本升级

- 定期评估 Swift 工具链版本要求
- 更新 Package.swift 中的工具链版本声明
- 测试所有包在新版本下的兼容性
- 更新文档中的版本要求说明

#### 平台 SDK 升级

- 关注每年 WWDC 的新 API 和组件
- 评估是否需要创建新的示例包
- 更新现有包以使用新的最佳实践
- 保持向后兼容性或明确标注破坏性变更

### 质量保证流程

#### 定期检查清单

- [ ] 所有包都能在支持的平台上编译通过
- [ ] 主应用能成功集成所有完成的包
- [ ] 文档信息与实际代码状态保持一致  
- [ ] 新增功能都有对应的示例和说明
- [ ] 遵循项目的命名和结构约定

#### 性能监控

- 监控主应用启动时间，避免包过多影响性能
- 检查示例的内存使用，确保演示代码不会泄漏
- 定期审查代码复杂度，保持示例的简洁性

---

## 附录：模板与代码片段

### Package.swift 模板

```swift
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "ComponentNameExample",
  platforms: [.iOS(.v18), .macOS(.v15)],
  products: [
    .library(name: "ComponentNameExample", targets: ["ComponentNameExample"])
  ],
  dependencies: [
    .package(path: "../ShareComponent")
  ],
  targets: [
    .target(name: "ComponentNameExample", dependencies: ["ShareComponent"])
  ]
)
```

### 包入口视图模板

```swift
import SwiftUI
import ShareComponent

public struct ComponentNameExample: View {
  public init() {}
  
  public var body: some View {
    ComponentExample(componentTitle: "ComponentName") {
      NavigationLink("基础用法") { ComponentNameExampleView01() }
      NavigationLink("样式定制") { ComponentNameExampleView02() }
      NavigationLink("高级功能") { ComponentNameExampleView03() }
      NavigationLink("实际应用") { ComponentNameExampleView04() }
    }
  }
}

#Preview {
  NavigationStack {
    ComponentNameExample()
  }
}
```

### 示例视图模板

```swift
import SwiftUI
import ShareComponent

struct ComponentNameExampleView01: View {
  var body: some View {
    ExampleContainerView("基础用法") {
      ExampleSection("创建组件") {
        VStack(spacing: 16) {
          // 示例代码
        }
      }
      
      ExampleSection("基础配置") {
        VStack(spacing: 16) {
          // 示例代码  
        }
      }
    } footer: {
      Text("学习要点：掌握 ComponentName 的基本创建和配置方法")
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }
}

#Preview {
  NavigationStack {
    ComponentNameExampleView01()
  }
}
```

### 条件编译代码片段

```swift
// 平台特定导入
#if canImport(UIKit)
  import UIKit
#elseif canImport(AppKit)
  import AppKit  
#endif

// 平台特定功能
#if os(iOS)
  .navigationBarTitleDisplayMode(.large)
  .toolbarBackground(Color.blue, for: .navigationBar)
#elseif os(macOS)
  .navigationTitle("macOS 标题")
#endif

// API 可用性检查
if #available(iOS 17.0, macOS 14.0, *) {
  // 使用新 API
} else {
  // 降级处理
}

// 平台特定类型处理
#if os(iOS)
  typealias PlatformColor = UIColor
#elseif os(macOS)
  typealias PlatformColor = NSColor
#endif
```

### ContentView 集成片段

```swift
// 在 ContentView.swift 顶部添加导入
import ComponentNameExample

// 在 components 数组中添加新项
ComponentInfo(
  name: "ComponentName",
  description: "组件描述",
  icon: "sf.symbol.name",
  view: AnyView(ComponentNameExample())
)
```

### 文档模板片段

#### README.md 结构

```markdown
# ComponentNameExample - SwiftUI ComponentName 组件示例包

## 📦 包信息

- **包名**: ComponentNameExample
- **平台支持**: iOS 18.0+, macOS 15.0+
- **Swift 版本**: 6.1+
- **示例数量**: X 个渐进式示例

## 🎯 功能特性

### ✅ 基础功能
- 功能点 1
- 功能点 2

### ✅ 高级功能  
- 高级功能 1
- 高级功能 2

## 📖 示例说明

### ComponentNameExampleView01 - 基础用法
学习目标和主要内容描述

### ComponentNameExampleView02 - 样式定制
学习目标和主要内容描述

## 🌟 平台兼容性

- ✅ **iOS 18.0+** - 完整功能支持
- ✅ **macOS 15.0+** - 完整功能支持
```

---

*本文档会随着项目发展持续更新。如有疑问或建议，请参考项目的 Development Guidelines 或提交 Issue。*
