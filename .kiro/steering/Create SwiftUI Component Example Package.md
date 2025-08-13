# Implemente a Swift Component Example

当用户输入 "name:组件名称" 创建对应的 SwiftUI Package，由用户自行导入到项目中。如果 Package 已经存在，检查相关内容是否完善，不完善则补充相关示例或文档

- 将本次任务的计划写入 Task.md 中
- 创建新的 Swift Package

  1.创建目录：在 ReLearnSwiftUI/ 下创建一个新目录(注意不是 `ReLearnSwiftUI/ReLearnSwiftUI/` 目录), 名称为 name + Example

  2.使用 swift package 命令创建 package：进入新建目录执行 swift package init --type library

  3.根据官方文档 [name](https://developer.apple.com/documentation/swiftui/name) 提供适当的示例视图,示例视图结构清晰易于阅读

  4.示例完成后必须在 iOS 和 MacOS 平台编译对应的 package 确保没有任何错误

      > xcodebuild -scheme PackageName -destination 'platform=iOS Simulator,name=iPhone 16' build
      > xcodebuild -scheme PackageName -destination 'platform=macOS' build

  5.补充 `ReLearnSwiftUI` 的 `ContentView` 中的 `components` 属性，完善示例

- 为每个示例添加详细的中文注释，解释每行代码的作用和 SwiftUI 概念
- 编写 name.md 文档，包含组件概述、基本用法、所有 Modifier 详解、 添加常见问题、注意事项和最佳实践说明、包含相关组件的关联说明和使用场景
- 编写 CLAUDE.md 文档，简单描述所有示例实现的功能

**Package 目录结构示例**
假如输入的 name=Text, 则输出目录结构为：

```swift
TextExample/
├── Package.swift
├── Sources
│   ├── TextExample.swift        # 主文件，引用所有相关示例
│   ├── TextExampleView01.swift  # 示例1
│   ├── TextExampleView02.swift  # 示例2，按需创建
│   └── TextExampleView03.swift  # 示例3，按需创建
│   └── ....swift                # 其它示例
├── CLAUDE.md                    # 描述所有示例的功能
└── Text.md                      # Text 的详细文档
```
