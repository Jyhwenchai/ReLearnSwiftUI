import SwiftUI

/// EditButton 与 List 结合使用示例
///
/// 本示例展示了 EditButton 与 List 的经典组合：
/// 1. List 的删除功能 (onDelete)
/// 2. List 的移动功能 (onMove)
/// 3. EditButton 控制编辑模式
/// 4. 多选功能在编辑模式下的表现
/// 5. 自定义编辑操作
public struct EditButtonExampleView02: View {
  // MARK: - 状态属性

  /// 从环境中读取编辑模式状态
  @Environment(\.editMode) private var editMode

  /// 水果列表数据
  @State private var fruits = [
    "🍎 苹果",
    "🍌 香蕉",
    "🥭 芒果",
    "🍊 橙子",
    "🍇 葡萄",
    "🍓 草莓",
    "🥝 猕猴桃",
    "🍑 樱桃",
  ]

  /// 选中的项目（用于多选）
  @State private var selectedItems = Set<String>()

  /// 显示添加水果的弹窗
  @State private var showingAddFruit = false
  @State private var newFruitName = ""

  public init() {}

  public var body: some View {
    NavigationView {
      VStack {
        // MARK: - 编辑模式状态栏

        if editMode?.wrappedValue.isEditing == true {
          HStack {
            Image(systemName: "pencil.circle.fill")
              .foregroundColor(.orange)
            Text("编辑模式已激活")
              .font(.caption)
            Spacer()
            Text("选中: \(selectedItems.count) 项")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding(.horizontal)
          .padding(.vertical, 8)
          .background(Color.orange.opacity(0.1))
        }

        // MARK: - 水果列表

        List(selection: $selectedItems) {
          ForEach(fruits, id: \.self) { fruit in
            HStack {
              Text(fruit)
                .font(.body)

              Spacer()

              // 在编辑模式下显示额外信息
              if editMode?.wrappedValue.isEditing == true {
                Image(systemName: "line.3.horizontal")
                  .foregroundColor(.gray)
                  .font(.caption)
              }
            }
            .contentShape(Rectangle())  // 让整行都可以点击
          }
          // MARK: - 删除功能
          .onDelete(perform: deleteFruits)
          // MARK: - 移动功能
          .onMove(perform: moveFruits)
        }
        .listStyle(PlainListStyle())

        // MARK: - 编辑模式下的操作按钮

        if editMode?.wrappedValue.isEditing == true {
          VStack(spacing: 12) {
            Divider()

            HStack(spacing: 20) {
              // 删除选中项按钮
              Button(action: deleteSelectedItems) {
                Label("删除选中", systemImage: "trash")
                  .foregroundColor(.red)
              }
              .disabled(selectedItems.isEmpty)

              Spacer()

              // 添加新项按钮
              Button(action: { showingAddFruit = true }) {
                Label("添加水果", systemImage: "plus.circle")
                  .foregroundColor(.green)
              }
            }
            .padding(.horizontal)
          }
          .background(Color.gray.opacity(0.05))
        }
      }
      .navigationTitle("水果清单")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        // MARK: - 工具栏按钮

        ToolbarItemGroup(placement: .navigationBarTrailing) {
          // 添加按钮（非编辑模式下显示）
          if editMode?.wrappedValue.isEditing != true {
            Button(action: { showingAddFruit = true }) {
              Image(systemName: "plus")
            }
          }

          // EditButton - 核心组件
          EditButton()
        }

        ToolbarItemGroup(placement: .navigationBarLeading) {
          // 在编辑模式下显示全选/取消全选按钮
          if editMode?.wrappedValue.isEditing == true {
            Button(selectedItems.count == fruits.count ? "取消全选" : "全选") {
              if selectedItems.count == fruits.count {
                selectedItems.removeAll()
              } else {
                selectedItems = Set(fruits)
              }
            }
            .font(.caption)
          }
        }
      }
      .sheet(isPresented: $showingAddFruit) {
        // MARK: - 添加水果弹窗
        addFruitSheet
      }
      .animation(.easeInOut(duration: 0.3), value: editMode?.wrappedValue)
      .animation(.easeInOut(duration: 0.2), value: selectedItems.count)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }

  // MARK: - 添加水果弹窗视图

  private var addFruitSheet: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text("添加新水果")
          .font(.headline)
          .padding(.top)

        TextField("请输入水果名称", text: $newFruitName)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.horizontal)

        HStack(spacing: 15) {
          ForEach(["🍎", "🍌", "🥭", "🍊", "🍇", "🍓", "🥝", "🍑"], id: \.self) { emoji in
            Button(action: {
              if !newFruitName.contains(emoji) {
                newFruitName = emoji + " " + newFruitName.trimmingCharacters(in: .whitespaces)
              }
            }) {
              Text(emoji)
                .font(.title2)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
          }
        }
        .padding(.horizontal)

        Spacer()
      }
      .navigationTitle("添加水果")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("取消") {
            showingAddFruit = false
            newFruitName = ""
          }
        }

        ToolbarItem(placement: .navigationBarTrailing) {
          Button("添加") {
            addFruit()
          }
          .disabled(newFruitName.trimmingCharacters(in: .whitespaces).isEmpty)
        }
      }
    }
  }

  // MARK: - 数据操作方法

  /// 删除指定位置的水果
  private func deleteFruits(at offsets: IndexSet) {
    withAnimation {
      fruits.remove(atOffsets: offsets)
      // 清理选中状态
      selectedItems.removeAll()
    }
  }

  /// 移动水果位置
  private func moveFruits(from source: IndexSet, to destination: Int) {
    withAnimation {
      fruits.move(fromOffsets: source, toOffset: destination)
      // 清理选中状态
      selectedItems.removeAll()
    }
  }

  /// 删除选中的水果
  private func deleteSelectedItems() {
    withAnimation {
      fruits.removeAll { selectedItems.contains($0) }
      selectedItems.removeAll()
    }
  }

  /// 添加新水果
  private func addFruit() {
    let trimmedName = newFruitName.trimmingCharacters(in: .whitespaces)
    if !trimmedName.isEmpty && !fruits.contains(trimmedName) {
      withAnimation {
        fruits.append(trimmedName)
      }
    }
    showingAddFruit = false
    newFruitName = ""
  }
}

// MARK: - 预览

#Preview {
  EditButtonExampleView02()
}

#Preview("编辑模式") {
  EditButtonExampleView02()
    .environment(\.editMode, .constant(.active))
}
