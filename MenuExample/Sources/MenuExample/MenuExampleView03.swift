import SwiftUI

/// MenuExampleView03 - 带主要操作的菜单示例
/// 展示如何使用 primaryAction 参数创建具有主要操作的菜单
public struct MenuExampleView03: View {
  @State private var selectedAction = "未选择任何操作"
  @State private var bookmarkCount = 5
  @State private var likeCount = 42
  @State private var shareCount = 8
  @State private var isBookmarked = false
  @State private var isLiked = false

  public init() {}

  public var body: some View {
    VStack(spacing: 30) {
      Text("带主要操作的菜单")
        .font(.largeTitle)
        .fontWeight(.bold)

      Text("当前状态: \(selectedAction)")
        .foregroundColor(.secondary)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)

      VStack(spacing: 20) {
        // 示例1: 书签菜单 - 点击直接添加书签，长按显示更多选项
        Menu {
          Button(action: addToReadingList) {
            Label("添加到阅读列表", systemImage: "eyeglasses")
          }
          Button(action: bookmarkAllTabs) {
            Label("为所有标签页添加书签", systemImage: "book")
          }
          Button(action: showAllBookmarks) {
            Label("显示所有书签", systemImage: "books.vertical")
          }

          Divider()

          Button(action: organizeBookmarks) {
            Label("整理书签", systemImage: "folder")
          }
        } label: {
          HStack {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
              .foregroundColor(isBookmarked ? .yellow : .primary)
            Text("书签 (\(bookmarkCount))")
            Image(systemName: "chevron.down")
              .font(.caption)
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(8)
        } primaryAction: {
          // 主要操作：直接添加/移除书签
          toggleBookmark()
        }

        // 示例2: 点赞菜单 - 点击直接点赞，长按显示更多互动选项
        Menu {
          Button(action: addToFavorites) {
            Label("添加到收藏", systemImage: "heart.circle")
          }
          Button(action: sharePost) {
            Label("分享帖子", systemImage: "square.and.arrow.up")
          }
          Button(action: reportPost) {
            Label("举报帖子", systemImage: "flag")
          }

          Divider()

          Button(action: hidePost) {
            Label("隐藏帖子", systemImage: "eye.slash")
          }
          Button(action: blockUser) {
            Label("屏蔽用户", systemImage: "person.slash")
          }
        } label: {
          HStack {
            Image(systemName: isLiked ? "heart.fill" : "heart")
              .foregroundColor(isLiked ? .red : .primary)
            Text("\(likeCount)")
            Image(systemName: "ellipsis")
              .font(.caption)
          }
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .background(Color.red.opacity(0.1))
          .cornerRadius(20)
        } primaryAction: {
          // 主要操作：直接点赞/取消点赞
          toggleLike()
        }

        // 示例3: 分享菜单 - 点击快速分享，长按显示分享选项
        Menu {
          Button(action: shareViaEmail) {
            Label("通过邮件分享", systemImage: "envelope")
          }
          Button(action: shareViaMessage) {
            Label("通过信息分享", systemImage: "message")
          }
          Button(action: shareViaAirdrop) {
            Label("通过 AirDrop 分享", systemImage: "airplayaudio")
          }

          Divider()

          Button(action: copyLink) {
            Label("复制链接", systemImage: "link")
          }
          Button(action: generateQRCode) {
            Label("生成二维码", systemImage: "qrcode")
          }
        } label: {
          Label("分享 (\(shareCount))", systemImage: "square.and.arrow.up")
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)
        } primaryAction: {
          // 主要操作：快速分享
          quickShare()
        }

        // 示例4: 下载菜单 - 点击直接下载，长按显示下载选项
        Menu {
          Button(action: downloadOriginal) {
            Label("下载原图", systemImage: "photo")
          }
          Button(action: downloadCompressed) {
            Label("下载压缩版", systemImage: "photo.badge.plus")
          }
          Button(action: downloadPDF) {
            Label("下载为 PDF", systemImage: "doc.fill")
          }

          Divider()

          Button(action: scheduleDownload) {
            Label("定时下载", systemImage: "clock")
          }
          Button(action: downloadToFolder) {
            Label("下载到指定文件夹", systemImage: "folder")
          }
        } label: {
          HStack {
            Image(systemName: "arrow.down.circle")
            Text("下载")
            Image(systemName: "chevron.down")
              .font(.caption2)
          }
          .foregroundColor(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 12)
          .background(Color.blue)
          .cornerRadius(8)
        } primaryAction: {
          // 主要操作：直接下载
          quickDownload()
        }

        // 示例5: 自定义样式的主要操作菜单
        Menu {
          Button("新建文档", action: newDocument)
          Button("新建文件夹", action: newFolder)
          Button("新建快捷方式", action: newShortcut)

          Divider()

          Button("从模板创建", action: createFromTemplate)
          Button("导入文件", action: importFile)
        } label: {
          HStack {
            Image(systemName: "plus.circle.fill")
              .font(.title2)
            VStack(alignment: .leading, spacing: 2) {
              Text("创建")
                .fontWeight(.semibold)
              Text("点击快速创建")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.down")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          .padding()
          .background(Color.orange.opacity(0.1))
          .cornerRadius(12)
        } primaryAction: {
          // 主要操作：快速创建新文档
          quickCreateDocument()
        }
      }

      // 说明文本
      VStack(alignment: .leading, spacing: 8) {
        Text("使用说明:")
          .fontWeight(.semibold)
        Text("• 点击菜单按钮执行主要操作")
        Text("• 长按菜单按钮显示更多选项")
        Text("• 在 macOS 上，点击箭头图标显示菜单")
      }
      .font(.caption)
      .foregroundColor(.secondary)
      .padding()
      .background(Color.blue.opacity(0.05))
      .cornerRadius(8)

      Spacer()
    }
    .padding()
    .navigationTitle("主要操作菜单")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  // MARK: - 书签相关操作

  /// 切换书签状态
  private func toggleBookmark() {
    isBookmarked.toggle()
    if isBookmarked {
      bookmarkCount += 1
      selectedAction = "添加书签"
    } else {
      bookmarkCount -= 1
      selectedAction = "移除书签"
    }
  }

  private func addToReadingList() { selectedAction = "添加到阅读列表" }
  private func bookmarkAllTabs() { selectedAction = "为所有标签页添加书签" }
  private func showAllBookmarks() { selectedAction = "显示所有书签" }
  private func organizeBookmarks() { selectedAction = "整理书签" }

  // MARK: - 点赞相关操作

  /// 切换点赞状态
  private func toggleLike() {
    isLiked.toggle()
    if isLiked {
      likeCount += 1
      selectedAction = "点赞"
    } else {
      likeCount -= 1
      selectedAction = "取消点赞"
    }
  }

  private func addToFavorites() { selectedAction = "添加到收藏" }
  private func sharePost() { selectedAction = "分享帖子" }
  private func reportPost() { selectedAction = "举报帖子" }
  private func hidePost() { selectedAction = "隐藏帖子" }
  private func blockUser() { selectedAction = "屏蔽用户" }

  // MARK: - 分享相关操作

  /// 快速分享
  private func quickShare() {
    shareCount += 1
    selectedAction = "快速分享"
  }

  private func shareViaEmail() { selectedAction = "通过邮件分享" }
  private func shareViaMessage() { selectedAction = "通过信息分享" }
  private func shareViaAirdrop() { selectedAction = "通过 AirDrop 分享" }
  private func copyLink() { selectedAction = "复制链接" }
  private func generateQRCode() { selectedAction = "生成二维码" }

  // MARK: - 下载相关操作

  /// 快速下载
  private func quickDownload() {
    selectedAction = "开始下载"
  }

  private func downloadOriginal() { selectedAction = "下载原图" }
  private func downloadCompressed() { selectedAction = "下载压缩版" }
  private func downloadPDF() { selectedAction = "下载为 PDF" }
  private func scheduleDownload() { selectedAction = "定时下载" }
  private func downloadToFolder() { selectedAction = "下载到指定文件夹" }

  // MARK: - 创建相关操作

  /// 快速创建文档
  private func quickCreateDocument() {
    selectedAction = "快速创建新文档"
  }

  private func newDocument() { selectedAction = "新建文档" }
  private func newFolder() { selectedAction = "新建文件夹" }
  private func newShortcut() { selectedAction = "新建快捷方式" }
  private func createFromTemplate() { selectedAction = "从模板创建" }
  private func importFile() { selectedAction = "导入文件" }
}

#Preview {
  NavigationView {
    MenuExampleView03()
  }
}
