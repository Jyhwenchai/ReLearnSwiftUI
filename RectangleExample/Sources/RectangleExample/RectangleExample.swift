import SwiftUI

/// Rectangle 示例主页面
/// 展示 SwiftUI 中 Rectangle 视图的各种用法和功能
public struct RectangleExample: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {
                Section("Rectangle 基础") {
                    NavigationLink("基础用法", destination: RectangleExampleView01())
                }
                
                Section("Rectangle 样式") {
                    NavigationLink("高级样式", destination: RectangleExampleView02())
                }
                
                Section("Rectangle 交互") {
                    NavigationLink("复杂交互", destination: RectangleExampleView03())
                }
                
                Section("Rectangle 应用") {
                    NavigationLink("特殊用法", destination: RectangleExampleView04())
                }
            }
            .navigationTitle("Rectangle 示例")
        }
    }
}

#Preview {
    RectangleExample()
}
