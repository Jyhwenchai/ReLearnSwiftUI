import SwiftUI

/// MultiDatePicker 示例主文件
/// 
/// MultiDatePicker 是 SwiftUI 中用于选择多个日期的控件，支持：
/// - 基础多日期选择
/// - 日期范围限制
/// - 环境值定制（locale、calendar、timeZone）
/// - 选中日期的管理和显示
///
/// 平台支持：iOS 16.0+, iPadOS 16.0+, Mac Catalyst 16.0+, visionOS 1.0+

// 导出所有示例视图
public struct MultiDatePickerExample: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {
                NavigationLink("基础多日期选择器", destination: MultiDatePickerExampleView01())
                NavigationLink("日期范围限制", destination: MultiDatePickerExampleView02())
                NavigationLink("环境值定制", destination: MultiDatePickerExampleView03())
                NavigationLink("高级用法和样式", destination: MultiDatePickerExampleView04())
            }
            .navigationTitle("MultiDatePicker 示例")
        }
    }
}
