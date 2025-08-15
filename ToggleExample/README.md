# ToggleExample - SwiftUI Toggle 组件完整示例

这是一个完整的 SwiftUI Toggle 组件示例包，展示了 Toggle 在各种场景下的使用方法和最佳实践。

## 项目结构

```
ToggleExample/
├── Package.swift                    # Swift Package 配置
├── Sources/
│   └── ToggleExample/
│       ├── ToggleExample.swift      # 主入口文件
│       ├── ToggleExampleView01.swift # 基础用法示例
│       ├── ToggleExampleView02.swift # 初始化方法示例
│       ├── ToggleExampleView03.swift # Toggle 样式示例
│       ├── ToggleExampleView04.swift # 高级用法示例
│       └── ToggleExampleView05.swift # 集合操作示例
├── Task.md                          # 任务详细文档
├── Toggle.md                        # Toggle 组件详解文档
├── CLAUDE.md                        # 示例功能说明
└── README.md                        # 项目说明文档
```

## 功能特性

### 📱 平台支持

- ✅ iOS 15.0+
- ✅ macOS 12.0+
- ✅ watchOS 8.0+
- ✅ tvOS 15.0+

### 🎯 示例内容

#### 1. 基础用法 (ToggleExampleView01)

- Toggle 的基本创建和使用
- 状态绑定和数据管理
- 动画效果演示
- 条件控制和依赖关系

#### 2. 初始化方法 (ToggleExampleView02)

- 系统图标 Toggle
- 自定义标签 Toggle
- 多行标签 Toggle
- 自定义图片 Toggle

#### 3. Toggle 样式 (ToggleExampleView03)

- 内置样式演示 (.automatic, .switch, .button, .checkbox)
- 自定义 ToggleStyle 实现
- 批量样式应用
- 样式对比展示

#### 4. 高级用法 (ToggleExampleView04)

- 设置页面场景
- 权限管理界面
- 网络设置控制
- 表单验证应用
- 动画效果演示

#### 5. 集合操作 (ToggleExampleView05)

- 批量 Toggle 管理
- 全选/取消全选功能
- 状态统计和进度显示
- 复杂数据绑定

## 🚀 快速开始

### 1. 导入到项目

在你的 Swift Package Manager 项目中添加依赖：

```swift
dependencies: [
    .package(path: "path/to/ToggleExample")
]
```

### 2. 使用示例

```swift
import SwiftUI
import ToggleExample

struct ContentView: View {
    var body: some View {
        ToggleExample()
    }
}
```

### 3. 编译测试

```bash
# iOS 平台编译
xcodebuild -scheme ToggleExample -destination 'platform=iOS Simulator,name=iPhone 16' build

# macOS 平台编译
xcodebuild -scheme ToggleExample -destination 'platform=macOS' build
```

## 📚 学习资源

- **Toggle.md** - Toggle 组件的完整技术文档
- **CLAUDE.md** - 各个示例的功能说明
- **Task.md** - 项目开发任务和技术要点

## 🎨 代码特色

### 详细注释

所有代码都包含详细的中文注释，解释每个功能的实现原理和使用场景。

### 最佳实践

- 遵循 SwiftUI 设计模式
- 合理的状态管理
- 平台兼容性处理
- 性能优化考虑

### 实用示例

- 真实应用场景模拟
- 完整的用户交互流程
- 错误处理和边界情况

## 🔧 技术要点

### 状态管理

- `@State` 和 `@Binding` 的正确使用
- 复杂数据结构的状态绑定
- 状态变化的监听和响应

### 样式定制

- 内置 ToggleStyle 的使用
- 自定义 ToggleStyle 的实现
- 动画效果的添加

### 平台适配

- 条件编译处理平台差异
- 响应式布局设计
- 无障碍功能支持

## 📖 相关文档

- [Apple 官方 Toggle 文档](https://developer.apple.com/documentation/swiftui/toggle)
- [SwiftUI 官方指南](https://developer.apple.com/documentation/swiftui)
- [Swift Package Manager 文档](https://swift.org/package-manager/)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个示例项目。

## 📄 许可证

本项目仅用于学习和参考目的。

---

**注意**: 这是一个教学示例项目，展示了 SwiftUI Toggle 组件的各种用法。在实际项目中使用时，请根据具体需求进行调整和优化。
