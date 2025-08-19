# MenuExample - SwiftUI Menu 组件示例包

这是一个完整的 SwiftUI Menu 组件示例包，展示了从基础用法到高级功能的各种使用场景。

## 📦 包信息

- **包名**: MenuExample
- **平台支持**: iOS 17.0+, macOS 14.0+, tvOS 17.0+, visionOS 1.0+
- **Swift 版本**: 6.1+
- **示例数量**: 6 个主要示例视图

## 🎯 功能特性

### ✅ 基础功能

- 文本和图标标签
- 基本菜单项创建
- 菜单分隔符使用
- 按钮角色设置

### ✅ 高级功能

- 嵌套子菜单（多层级）
- 主要操作设置（primaryAction）
- 上下文菜单（contextMenu）
- 带预览的上下文菜单
- 动态菜单内容
- 条件菜单项

### ✅ 样式和修饰符

- `.menuStyle()` - 菜单样式
- `.menuOrder()` - 菜单顺序
- `.menuIndicator()` - 指示器控制
- `.menuActionDismissBehavior()` - 关闭行为（iOS 专用）
- 环境值设置

### ✅ 交互功能

- 点击和长按交互
- 多选和批量操作
- 状态管理和反馈
- 个性化设置

## 📁 文件结构

```
MenuExample/
├── Package.swift                    # 包配置文件
├── Sources/
│   └── MenuExample/
│       ├── MenuExample.swift        # 主入口文件
│       ├── MenuExampleView01.swift  # 基础 Menu 示例
│       ├── MenuExampleView02.swift  # 嵌套菜单示例
│       ├── MenuExampleView03.swift  # 主要操作菜单示例
│       ├── MenuExampleView04.swift  # 菜单样式和修饰符示例
│       ├── MenuExampleView05.swift  # 上下文菜单示例
│       └── MenuExampleView06.swift  # 高级菜单功能示例
├── Task.md                          # 任务详细文档
├── Menu.md                          # Menu 组件详细文档
├── CLAUDE.md                        # 示例功能说明
└── README.md                        # 本文件

```

## 🚀 使用方法

### 1. 导入包

在你的 SwiftUI 项目中导入 MenuExample：

```swift
import MenuExample
```

### 2. 使用示例

```swift
import SwiftUI
import MenuExample

struct ContentView: View {
    var body: some View {
        MenuExample()
    }
}
```

### 3. 查看特定示例

```swift
import SwiftUI
import MenuExample

struct ContentView: View {
    var body: some View {
        NavigationView {
            MenuExampleView01() // 基础 Menu 示例
        }
    }
}
```

## 📖 示例说明

### MenuExampleView01 - 基础 Menu

展示 Menu 组件的基本用法，包括：

- 最简单的文本菜单
- 带图标的菜单标签
- 自定义菜单标签样式
- 带分隔符的菜单

### MenuExampleView02 - 嵌套菜单

展示多层级嵌套菜单的创建，包括：

- 基本的嵌套菜单（导出/导入子菜单）
- 复杂的多层嵌套菜单（编辑/格式/工具）
- 带图标的嵌套菜单（分享/打印）

### MenuExampleView03 - 主要操作菜单

展示 primaryAction 参数的使用，包括：

- 书签菜单（点击添加书签，长按显示选项）
- 点赞菜单（点击点赞，长按显示更多互动）
- 分享菜单（点击快速分享，长按显示分享选项）
- 下载菜单（点击直接下载，长按显示下载选项）

### MenuExampleView04 - 菜单样式和修饰符

展示各种菜单修饰符的使用，包括：

- 不同的菜单样式
- 菜单顺序控制
- 菜单指示器控制
- 菜单关闭行为控制（iOS 专用）

### MenuExampleView05 - 上下文菜单

展示 contextMenu 修饰符的使用，包括：

- 基础上下文菜单
- 图片上下文菜单
- 列表项上下文菜单
- 带预览的上下文菜单

### MenuExampleView06 - 高级菜单功能

展示动态菜单和高级功能，包括：

- 动态菜单内容
- 条件菜单项
- 多选菜单
- 自定义菜单项
- 收藏夹菜单

## 🔧 编译和测试

### iOS 模拟器

```bash
xcodebuild -scheme MenuExample -destination 'platform=iOS Simulator,name=iPhone 16' build
```

### macOS

```bash
xcodebuild -scheme MenuExample -destination 'platform=macOS' build
```

## 🌟 平台兼容性

该示例包已经过测试，确保在以下平台上正常工作：

- ✅ **iOS 17.0+** - 完整功能支持
- ✅ **macOS 14.0+** - 完整功能支持（部分 iOS 专用功能通过条件编译处理）
- ✅ **tvOS 17.0+** - 基础功能支持
- ✅ **visionOS 1.0+** - 基础功能支持

## 📚 学习建议

1. **按顺序学习**: 建议按照 01 → 06 的顺序学习，从基础到高级
2. **实际应用**: 可以根据具体需求选择合适的示例进行参考
3. **自定义扩展**: 示例代码可以作为基础，根据项目需求进行扩展
4. **最佳实践**: 参考 Menu.md 文档了解详细的使用指南和最佳实践

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个示例包！

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 LICENSE 文件。
