import SwiftUI

/// EditButton 自定义编辑行为示例
/// 
/// 本示例展示了如何自定义编辑行为：
/// 1. 手动控制编辑模式状态
/// 2. 自定义编辑按钮样式
/// 3. 条件性启用/禁用编辑功能
/// 4. 编辑模式的生命周期管理
public struct EditButtonExampleView03: View {
    // MARK: - 状态属性
    
    /// 从环境中读取编辑模式状态
    @Environment(\.editMode) private var editMode
    
    /// 任务列表数据
    @State private var tasks = [
        SimpleTask(title: "学习 SwiftUI", isCompleted: false),
        SimpleTask(title: "写项目文档", isCompleted: true),
        SimpleTask(title: "代码审查", isCompleted: false),
        SimpleTask(title: "团队会议", isCompleted: false),
        SimpleTask(title: "修复 Bug", isCompleted: true)
    ]
    
    /// 是否有未保存的更改
    @State private var hasUnsavedChanges = false
    
    /// 显示确认对话框
    @State private var showingDiscardAlert = false
    
    /// 备份数据（用于取消编辑时恢复）
    @State private var backupTasks: [SimpleTask] = []
    
    /// 是否允许编辑（可以根据业务逻辑控制）
    @State private var isEditingAllowed = true
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack {
                // MARK: - 编辑状态信息栏
                
                if editMode?.wrappedValue.isEditing == true {
                    editingStatusBar
                }
                
                // MARK: - 任务列表
                
                List {
                    ForEach($tasks) { $task in
                        SimpleTaskRowView(
                            task: $task,
                            isEditing: editMode?.wrappedValue.isEditing == true,
                            onTaskChanged: {
                                hasUnsavedChanges = true
                            }
                        )
                    }
                    .onDelete(perform: deleteTasks)
                    .onMove(perform: moveTasks)
                }
                .listStyle(PlainListStyle())
                
                // MARK: - 编辑模式下的操作区域
                
                if editMode?.wrappedValue.isEditing == true {
                    editingActionsView
                }
            }
            .navigationTitle("任务管理")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // 自定义编辑按钮组
                    customEditButtonGroup
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    // 编辑权限控制开关
                    if editMode?.wrappedValue.isEditing != true {
                        Button(action: { isEditingAllowed.toggle() }) {
                            Image(systemName: isEditingAllowed ? "lock.open" : "lock")
                                .foregroundColor(isEditingAllowed ? .green : .red)
                        }
                    }
                }
            })
            .alert("放弃更改", isPresented: $showingDiscardAlert) {
                Button("放弃", role: .destructive) {
                    discardChanges()
                }
                Button("取消", role: .cancel) {}
            } message: {
                Text("您有未保存的更改，确定要放弃吗？")
            }
            .animation(.easeInOut(duration: 0.3), value: editMode?.wrappedValue)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - 子视图组件
    
    /// 编辑状态信息栏
    private var editingStatusBar: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("编辑模式")
                    .font(.caption)
                    .bold()
                
                if hasUnsavedChanges {
                    Text("有未保存的更改")
                        .font(.caption)
                        .foregroundColor(.orange)
                } else {
                    Text("无更改")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.orange.opacity(0.1))
    }
    
    /// 自定义编辑按钮组
    private var customEditButtonGroup: some View {
        HStack(spacing: 8) {
            if editMode?.wrappedValue.isEditing == true {
                // 编辑模式下的按钮
                Button("取消") {
                    cancelEditing()
                }
                .foregroundColor(.red)
                
                Button("保存") {
                    saveChanges()
                }
                .foregroundColor(.blue)
                .bold()
                .disabled(!hasUnsavedChanges)
            } else {
                // 非编辑模式下的按钮
                Button("编辑") {
                    startEditing()
                }
                .disabled(!isEditingAllowed)
                .foregroundColor(isEditingAllowed ? .blue : .gray)
            }
        }
    }
    
    /// 编辑模式下的操作视图
    private var editingActionsView: some View {
        VStack(spacing: 12) {
            Divider()
            
            HStack(spacing: 20) {
                Button(action: addNewTask) {
                    Label("添加任务", systemImage: "plus.circle")
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                Button(action: markAllCompleted) {
                    Label("全部完成", systemImage: "checkmark.circle")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button(action: clearCompleted) {
                    Label("清除已完成", systemImage: "trash.circle")
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .background(Color.gray.opacity(0.05))
    }
    
    // MARK: - 编辑控制方法
    
    /// 开始编辑
    private func startEditing() {
        guard isEditingAllowed else { return }
        
        // 备份当前数据
        backupTasks = tasks
        hasUnsavedChanges = false
        
        // 激活编辑模式
        withAnimation {
            editMode?.wrappedValue = .active
        }
    }
    
    /// 取消编辑
    private func cancelEditing() {
        if hasUnsavedChanges {
            showingDiscardAlert = true
        } else {
            exitEditingMode()
        }
    }
    
    /// 保存更改
    private func saveChanges() {
        // 这里可以添加保存到数据库的逻辑
        hasUnsavedChanges = false
        
        withAnimation {
            editMode?.wrappedValue = .inactive
        }
    }
    
    /// 放弃更改
    private func discardChanges() {
        // 恢复备份数据
        tasks = backupTasks
        hasUnsavedChanges = false
        exitEditingMode()
    }
    
    /// 退出编辑模式
    private func exitEditingMode() {
        withAnimation {
            editMode?.wrappedValue = .inactive
        }
    }
    
    // MARK: - 数据操作方法
    
    /// 删除任务
    private func deleteTasks(at offsets: IndexSet) {
        withAnimation {
            tasks.remove(atOffsets: offsets)
            hasUnsavedChanges = true
        }
    }
    
    /// 移动任务
    private func moveTasks(from source: IndexSet, to destination: Int) {
        withAnimation {
            tasks.move(fromOffsets: source, toOffset: destination)
            hasUnsavedChanges = true
        }
    }
    
    /// 添加新任务
    private func addNewTask() {
        let newTask = SimpleTask(
            title: "新任务 \(tasks.count + 1)",
            isCompleted: false
        )
        
        withAnimation {
            tasks.append(newTask)
            hasUnsavedChanges = true
        }
    }
    
    /// 标记所有任务为已完成
    private func markAllCompleted() {
        withAnimation {
            for index in tasks.indices {
                tasks[index].isCompleted = true
            }
            hasUnsavedChanges = true
        }
    }
    
    /// 清除已完成的任务
    private func clearCompleted() {
        withAnimation {
            tasks.removeAll { $0.isCompleted }
            hasUnsavedChanges = true
        }
    }
}

// MARK: - 支持数据结构

/// 简化的任务数据模型
struct SimpleTask: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

/// 简化的任务行视图
struct SimpleTaskRowView: View {
    @Binding var task: SimpleTask
    let isEditing: Bool
    let onTaskChanged: () -> Void
    
    var body: some View {
        HStack {
            // 完成状态切换
            Button(action: {
                task.isCompleted.toggle()
                onTaskChanged()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            
            // 任务标题
            if isEditing {
                TextField("任务标题", text: $task.title)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onChange(of: task.title) { _ in
                        onTaskChanged()
                    }
            } else {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .secondary : .primary)
            }
            
            Spacer()
            
            // 编辑模式下显示拖拽指示器
            if isEditing {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .contentShape(Rectangle())
    }
}

// MARK: - 预览

#Preview {
    EditButtonExampleView03()
}

#Preview("编辑模式") {
    EditButtonExampleView03()
        .environment(\.editMode, .constant(.active))
}