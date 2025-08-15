import SwiftUI

/// RenameButton 实际应用场景示例
/// 演示在真实应用中如何使用 RenameButton，包括文件管理器、笔记应用等场景
public struct RenameButtonExampleView04: View {
  // MARK: - 状态属性

  /// 应用场景枚举
  enum AppScenario: String, CaseIterable {
    case fileManager = "文件管理器"
    case noteApp = "笔记应用"
    case photoLibrary = "照片库"
    case playlistManager = "播放列表"

    var icon: String {
      switch self {
      case .fileManager: return "folder"
      case .noteApp: return "note.text"
      case .photoLibrary: return "photo.on.rectangle"
      case .playlistManager: return "music.note.list"
      }
    }
  }

  /// 当前选中的场景
  @State private var selectedScenario: AppScenario = .fileManager

  public init() {}

  public var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        // MARK: - 场景选择器
        Picker("应用场景", selection: $selectedScenario) {
          ForEach(AppScenario.allCases, id: \.self) { scenario in
            Label(scenario.rawValue, systemImage: scenario.icon)
              .tag(scenario)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()

        // MARK: - 场景内容
        Group {
          switch selectedScenario {
          case .fileManager:
            FileManagerScenario()
          case .noteApp:
            NoteAppScenario()
          case .photoLibrary:
            PhotoLibraryScenario()
          case .playlistManager:
            PlaylistManagerScenario()
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .navigationTitle("实际应用场景")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

// MARK: - 文件管理器场景
struct FileManagerScenario: View {
  /// 文件系统项目
  struct FileSystemItem: Identifiable {
    let id = UUID()
    var name: String
    let type: ItemType
    var size: String
    var dateModified: Date
    var isDirectory: Bool

    enum ItemType {
      case folder, document, image, video, audio, archive

      var icon: String {
        switch self {
        case .folder: return "folder.fill"
        case .document: return "doc.fill"
        case .image: return "photo.fill"
        case .video: return "video.fill"
        case .audio: return "music.note"
        case .archive: return "archivebox.fill"
        }
      }

      var color: Color {
        switch self {
        case .folder: return .blue
        case .document: return .red
        case .image: return .green
        case .video: return .purple
        case .audio: return .orange
        case .archive: return .gray
        }
      }
    }
  }

  @State private var items: [FileSystemItem] = [
    FileSystemItem(
      name: "文档", type: .folder, size: "—", dateModified: Date().addingTimeInterval(-86400),
      isDirectory: true),
    FileSystemItem(
      name: "图片", type: .folder, size: "—", dateModified: Date().addingTimeInterval(-172800),
      isDirectory: true),
    FileSystemItem(
      name: "下载", type: .folder, size: "—", dateModified: Date().addingTimeInterval(-259200),
      isDirectory: true),
    FileSystemItem(
      name: "年度报告.pdf", type: .document, size: "2.5 MB",
      dateModified: Date().addingTimeInterval(-3600), isDirectory: false),
    FileSystemItem(
      name: "假期照片.jpg", type: .image, size: "4.2 MB",
      dateModified: Date().addingTimeInterval(-7200), isDirectory: false),
    FileSystemItem(
      name: "演示视频.mp4", type: .video, size: "125 MB",
      dateModified: Date().addingTimeInterval(-10800), isDirectory: false),
    FileSystemItem(
      name: "背景音乐.mp3", type: .audio, size: "8.5 MB",
      dateModified: Date().addingTimeInterval(-14400), isDirectory: false),
    FileSystemItem(
      name: "项目备份.zip", type: .archive, size: "45 MB",
      dateModified: Date().addingTimeInterval(-18000), isDirectory: false),
  ]

  @State private var editingIndex: Int?
  @State private var editingName: String = ""
  @FocusState private var isNameFieldFocused: Bool
  @State private var showingAlert = false
  @State private var alertMessage = ""

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      // 场景说明
      VStack(alignment: .leading, spacing: 8) {
        Text("文件管理器场景")
          .font(.headline)

        Text("模拟文件管理器中的重命名功能，支持文件夹和各种文件类型的重命名操作。")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding(.horizontal)

      // 文件列表
      List {
        ForEach(items.indices, id: \.self) { index in
          FileItemRow(
            item: items[index],
            isEditing: editingIndex == index,
            editingName: $editingName,
            isFocused: $isNameFieldFocused
          )
          .contextMenu {
            RenameButton()

            Divider()

            if items[index].isDirectory {
              Button("打开", systemImage: "folder.badge.plus") {
                openFolder(at: index)
              }
            } else {
              Button("打开", systemImage: "doc.badge.plus") {
                openFile(at: index)
              }
            }

            Button("复制", systemImage: "doc.on.doc") {
              copyItem(at: index)
            }

            Button("移动", systemImage: "folder") {
              moveItem(at: index)
            }

            Divider()

            Button("删除", systemImage: "trash", role: .destructive) {
              deleteItem(at: index)
            }
          }
          .renameAction {
            startRenaming(at: index)
          }
        }
      }
      .listStyle(PlainListStyle())
    }
    .alert("操作完成", isPresented: $showingAlert) {
      Button("确定") {}
    } message: {
      Text(alertMessage)
    }
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
    { _ in
      if editingIndex != nil {
        completeRenaming()
      }
    }
  }

  private func startRenaming(at index: Int) {
    editingIndex = index
    editingName = items[index].name

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isNameFieldFocused = true
    }
  }

  private func completeRenaming() {
    guard let index = editingIndex else { return }

    let trimmedName = editingName.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedName.isEmpty && trimmedName != items[index].name {
      items[index].name = trimmedName
      items[index].dateModified = Date()

      alertMessage = "文件已重命名为 '\(trimmedName)'"
      showingAlert = true
    }

    editingIndex = nil
    editingName = ""
    isNameFieldFocused = false
  }

  private func openFolder(at index: Int) {
    alertMessage = "打开文件夹: \(items[index].name)"
    showingAlert = true
  }

  private func openFile(at index: Int) {
    alertMessage = "打开文件: \(items[index].name)"
    showingAlert = true
  }

  private func copyItem(at index: Int) {
    let original = items[index]
    let copy = FileSystemItem(
      name: "\(original.name) 副本",
      type: original.type,
      size: original.size,
      dateModified: Date(),
      isDirectory: original.isDirectory
    )
    items.insert(copy, at: index + 1)

    alertMessage = "已复制 '\(original.name)'"
    showingAlert = true
  }

  private func moveItem(at index: Int) {
    alertMessage = "移动文件: \(items[index].name)"
    showingAlert = true
  }

  private func deleteItem(at index: Int) {
    let itemName = items[index].name
    items.remove(at: index)

    alertMessage = "已删除 '\(itemName)'"
    showingAlert = true
  }
}

// MARK: - 文件项目行
struct FileItemRow: View {
  let item: FileManagerScenario.FileSystemItem
  let isEditing: Bool
  @Binding var editingName: String
  @FocusState.Binding var isFocused: Bool

  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: item.type.icon)
        .font(.title2)
        .foregroundColor(item.type.color)
        .frame(width: 30)

      VStack(alignment: .leading, spacing: 2) {
        if isEditing {
          TextField("文件名", text: $editingName)
            .focused($isFocused)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
              isFocused = false
            }
        } else {
          Text(item.name)
            .font(.body)
            .fontWeight(.medium)
        }

        HStack {
          Text(item.size)
            .font(.caption)
            .foregroundColor(.secondary)

          Spacer()

          Text(formatDate(item.dateModified))
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
    }
    .padding(.vertical, 2)
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.string(from: date)
  }
}

// MARK: - 笔记应用场景
struct NoteAppScenario: View {
  struct Note: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var dateCreated: Date
    var dateModified: Date
    var category: String
    var isPinned: Bool
  }

  @State private var notes: [Note] = [
    Note(
      title: "会议记录", content: "今天的团队会议讨论了项目进度...", dateCreated: Date().addingTimeInterval(-86400),
      dateModified: Date().addingTimeInterval(-3600), category: "工作", isPinned: true),
    Note(
      title: "购物清单", content: "牛奶、面包、鸡蛋、苹果...", dateCreated: Date().addingTimeInterval(-172800),
      dateModified: Date().addingTimeInterval(-7200), category: "生活", isPinned: false),
    Note(
      title: "读书笔记", content: "《Swift编程指南》第三章要点...",
      dateCreated: Date().addingTimeInterval(-259200),
      dateModified: Date().addingTimeInterval(-10800), category: "学习", isPinned: true),
    Note(
      title: "旅行计划", content: "下个月的日本之行安排...", dateCreated: Date().addingTimeInterval(-345600),
      dateModified: Date().addingTimeInterval(-14400), category: "旅行", isPinned: false),
  ]

  @State private var editingIndex: Int?
  @State private var editingTitle: String = ""
  @FocusState private var isTitleFieldFocused: Bool
  @State private var selectedNote: Note?

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      // 场景说明
      VStack(alignment: .leading, spacing: 8) {
        Text("笔记应用场景")
          .font(.headline)

        Text("模拟笔记应用中的标题重命名功能，支持快速编辑笔记标题。")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding(.horizontal)

      // 笔记列表
      List {
        ForEach(notes.indices, id: \.self) { index in
          NoteRow(
            note: notes[index],
            isEditing: editingIndex == index,
            editingTitle: $editingTitle,
            isFocused: $isTitleFieldFocused
          )
          .onTapGesture {
            selectedNote = notes[index]
          }
          .contextMenu {
            RenameButton()

            Divider()

            Button(
              notes[index].isPinned ? "取消置顶" : "置顶",
              systemImage: notes[index].isPinned ? "pin.slash" : "pin"
            ) {
              notes[index].isPinned.toggle()
            }

            Button("分享", systemImage: "square.and.arrow.up") {
              shareNote(at: index)
            }

            Button("复制", systemImage: "doc.on.doc") {
              copyNote(at: index)
            }

            Divider()

            Button("删除", systemImage: "trash", role: .destructive) {
              deleteNote(at: index)
            }
          }
          .renameAction {
            startRenamingNote(at: index)
          }
        }
      }
      .listStyle(PlainListStyle())
    }
    .sheet(item: $selectedNote) { note in
      NoteDetailView(note: note)
    }
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
    { _ in
      if editingIndex != nil {
        completeNoteRenaming()
      }
    }
  }

  private func startRenamingNote(at index: Int) {
    editingIndex = index
    editingTitle = notes[index].title

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isTitleFieldFocused = true
    }
  }

  private func completeNoteRenaming() {
    guard let index = editingIndex else { return }

    let trimmedTitle = editingTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedTitle.isEmpty && trimmedTitle != notes[index].title {
      notes[index].title = trimmedTitle
      notes[index].dateModified = Date()
    }

    editingIndex = nil
    editingTitle = ""
    isTitleFieldFocused = false
  }

  private func shareNote(at index: Int) {
    print("分享笔记: \(notes[index].title)")
  }

  private func copyNote(at index: Int) {
    let original = notes[index]
    let copy = Note(
      title: "\(original.title) 副本",
      content: original.content,
      dateCreated: Date(),
      dateModified: Date(),
      category: original.category,
      isPinned: false
    )
    notes.insert(copy, at: index + 1)
  }

  private func deleteNote(at index: Int) {
    notes.remove(at: index)
  }
}

// MARK: - 笔记行视图
struct NoteRow: View {
  let note: NoteAppScenario.Note
  let isEditing: Bool
  @Binding var editingTitle: String
  @FocusState.Binding var isFocused: Bool

  var body: some View {
    HStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 4) {
        HStack {
          if isEditing {
            TextField("笔记标题", text: $editingTitle)
              .focused($isFocused)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .onSubmit {
                isFocused = false
              }
          } else {
            Text(note.title)
              .font(.headline)
              .lineLimit(1)
          }

          if note.isPinned {
            Image(systemName: "pin.fill")
              .font(.caption)
              .foregroundColor(.orange)
          }
        }

        Text(note.content)
          .font(.body)
          .foregroundColor(.secondary)
          .lineLimit(2)

        HStack {
          Text(note.category)
            .font(.caption)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .cornerRadius(4)

          Spacer()

          Text(formatDate(note.dateModified))
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }

      Spacer()
    }
    .padding(.vertical, 4)
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.localizedString(for: date, relativeTo: Date())
  }
}

// MARK: - 笔记详情视图
struct NoteDetailView: View {
  let note: NoteAppScenario.Note
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          Text(note.content)
            .font(.body)
            .padding()

          Spacer()
        }
      }
      .navigationTitle(note.title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("完成") {
            dismiss()
          }
        }
      }
    }
  }
}

// MARK: - 照片库场景
struct PhotoLibraryScenario: View {
  struct Photo: Identifiable {
    let id = UUID()
    var name: String
    let imageName: String
    var dateCreated: Date
    var location: String
    var size: String
  }

  @State private var photos: [Photo] = [
    Photo(
      name: "日落海滩", imageName: "sunset.fill", dateCreated: Date().addingTimeInterval(-86400),
      location: "三亚", size: "3.2 MB"),
    Photo(
      name: "城市夜景", imageName: "building.2.fill", dateCreated: Date().addingTimeInterval(-172800),
      location: "上海", size: "4.1 MB"),
    Photo(
      name: "山间小径", imageName: "mountain.2.fill", dateCreated: Date().addingTimeInterval(-259200),
      location: "黄山", size: "2.8 MB"),
    Photo(
      name: "花园春色", imageName: "leaf.fill", dateCreated: Date().addingTimeInterval(-345600),
      location: "苏州", size: "3.5 MB"),
  ]

  @State private var editingIndex: Int?
  @State private var editingName: String = ""
  @FocusState private var isNameFieldFocused: Bool

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      // 场景说明
      VStack(alignment: .leading, spacing: 8) {
        Text("照片库场景")
          .font(.headline)

        Text("模拟照片库应用中的照片重命名功能，支持为照片添加有意义的名称。")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding(.horizontal)

      // 照片网格
      LazyVGrid(
        columns: [
          GridItem(.flexible()),
          GridItem(.flexible()),
        ], spacing: 16
      ) {
        ForEach(photos.indices, id: \.self) { index in
          PhotoCard(
            photo: photos[index],
            isEditing: editingIndex == index,
            editingName: $editingName,
            isFocused: $isNameFieldFocused
          )
          .contextMenu {
            RenameButton()

            Divider()

            Button("分享", systemImage: "square.and.arrow.up") {
              sharePhoto(at: index)
            }

            Button("添加到相册", systemImage: "plus.rectangle.on.folder") {
              addToAlbum(at: index)
            }

            Button("设为壁纸", systemImage: "photo") {
              setAsWallpaper(at: index)
            }

            Divider()

            Button("删除", systemImage: "trash", role: .destructive) {
              deletePhoto(at: index)
            }
          }
          .renameAction {
            startRenamingPhoto(at: index)
          }
        }
      }
      .padding(.horizontal)

      Spacer()
    }
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
    { _ in
      if editingIndex != nil {
        completePhotoRenaming()
      }
    }
  }

  private func startRenamingPhoto(at index: Int) {
    editingIndex = index
    editingName = photos[index].name

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isNameFieldFocused = true
    }
  }

  private func completePhotoRenaming() {
    guard let index = editingIndex else { return }

    let trimmedName = editingName.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedName.isEmpty && trimmedName != photos[index].name {
      photos[index].name = trimmedName
    }

    editingIndex = nil
    editingName = ""
    isNameFieldFocused = false
  }

  private func sharePhoto(at index: Int) {
    print("分享照片: \(photos[index].name)")
  }

  private func addToAlbum(at index: Int) {
    print("添加到相册: \(photos[index].name)")
  }

  private func setAsWallpaper(at index: Int) {
    print("设为壁纸: \(photos[index].name)")
  }

  private func deletePhoto(at index: Int) {
    photos.remove(at: index)
  }
}

// MARK: - 照片卡片
struct PhotoCard: View {
  let photo: PhotoLibraryScenario.Photo
  let isEditing: Bool
  @Binding var editingName: String
  @FocusState.Binding var isFocused: Bool

  var body: some View {
    VStack(spacing: 8) {
      // 照片预览
      Image(systemName: photo.imageName)
        .font(.system(size: 60))
        .foregroundColor(.blue)
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(8)

      // 照片信息
      VStack(alignment: .leading, spacing: 4) {
        if isEditing {
          TextField("照片名称", text: $editingName)
            .focused($isFocused)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
              isFocused = false
            }
        } else {
          Text(photo.name)
            .font(.headline)
            .lineLimit(1)
        }

        Text(photo.location)
          .font(.caption)
          .foregroundColor(.secondary)

        HStack {
          Text(photo.size)
            .font(.caption)
            .foregroundColor(.secondary)

          Spacer()

          Text(formatDate(photo.dateCreated))
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(radius: 2)
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.string(from: date)
  }
}

// MARK: - 播放列表管理场景
struct PlaylistManagerScenario: View {
  struct Playlist: Identifiable {
    let id = UUID()
    var name: String
    var songCount: Int
    var duration: String
    var dateCreated: Date
    var genre: String
  }

  @State private var playlists: [Playlist] = [
    Playlist(
      name: "我的最爱", songCount: 25, duration: "1小时32分",
      dateCreated: Date().addingTimeInterval(-86400), genre: "流行"),
    Playlist(
      name: "工作音乐", songCount: 18, duration: "58分钟",
      dateCreated: Date().addingTimeInterval(-172800), genre: "轻音乐"),
    Playlist(
      name: "运动节拍", songCount: 32, duration: "2小时15分",
      dateCreated: Date().addingTimeInterval(-259200), genre: "电子"),
    Playlist(
      name: "睡前音乐", songCount: 12, duration: "45分钟",
      dateCreated: Date().addingTimeInterval(-345600), genre: "古典"),
  ]

  @State private var editingIndex: Int?
  @State private var editingName: String = ""
  @FocusState private var isNameFieldFocused: Bool

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      // 场景说明
      VStack(alignment: .leading, spacing: 8) {
        Text("播放列表管理场景")
          .font(.headline)

        Text("模拟音乐应用中的播放列表重命名功能，支持个性化播放列表名称。")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding(.horizontal)

      // 播放列表
      List {
        ForEach(playlists.indices, id: \.self) { index in
          PlaylistRow(
            playlist: playlists[index],
            isEditing: editingIndex == index,
            editingName: $editingName,
            isFocused: $isNameFieldFocused
          )
          .contextMenu {
            RenameButton()

            Divider()

            Button("播放", systemImage: "play.fill") {
              playPlaylist(at: index)
            }

            Button("分享", systemImage: "square.and.arrow.up") {
              sharePlaylist(at: index)
            }

            Button("复制", systemImage: "doc.on.doc") {
              copyPlaylist(at: index)
            }

            Divider()

            Button("删除", systemImage: "trash", role: .destructive) {
              deletePlaylist(at: index)
            }
          }
          .renameAction {
            startRenamingPlaylist(at: index)
          }
        }
      }
      .listStyle(PlainListStyle())
    }
    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
    { _ in
      if editingIndex != nil {
        completePlaylistRenaming()
      }
    }
  }

  private func startRenamingPlaylist(at index: Int) {
    editingIndex = index
    editingName = playlists[index].name

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isNameFieldFocused = true
    }
  }

  private func completePlaylistRenaming() {
    guard let index = editingIndex else { return }

    let trimmedName = editingName.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmedName.isEmpty && trimmedName != playlists[index].name {
      playlists[index].name = trimmedName
    }

    editingIndex = nil
    editingName = ""
    isNameFieldFocused = false
  }

  private func playPlaylist(at index: Int) {
    print("播放播放列表: \(playlists[index].name)")
  }

  private func sharePlaylist(at index: Int) {
    print("分享播放列表: \(playlists[index].name)")
  }

  private func copyPlaylist(at index: Int) {
    let original = playlists[index]
    let copy = Playlist(
      name: "\(original.name) 副本",
      songCount: original.songCount,
      duration: original.duration,
      dateCreated: Date(),
      genre: original.genre
    )
    playlists.insert(copy, at: index + 1)
  }

  private func deletePlaylist(at index: Int) {
    playlists.remove(at: index)
  }
}

// MARK: - 播放列表行
struct PlaylistRow: View {
  let playlist: PlaylistManagerScenario.Playlist
  let isEditing: Bool
  @Binding var editingName: String
  @FocusState.Binding var isFocused: Bool

  var body: some View {
    HStack(spacing: 12) {
      // 播放列表图标
      Image(systemName: "music.note.list")
        .font(.title2)
        .foregroundColor(.purple)
        .frame(width: 30)

      VStack(alignment: .leading, spacing: 4) {
        if isEditing {
          TextField("播放列表名称", text: $editingName)
            .focused($isFocused)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
              isFocused = false
            }
        } else {
          Text(playlist.name)
            .font(.headline)
            .lineLimit(1)
        }

        HStack {
          Text("\(playlist.songCount) 首歌曲")
            .font(.caption)
            .foregroundColor(.secondary)

          Text("•")
            .font(.caption)
            .foregroundColor(.secondary)

          Text(playlist.duration)
            .font(.caption)
            .foregroundColor(.secondary)
        }

        Text(playlist.genre)
          .font(.caption)
          .padding(.horizontal, 6)
          .padding(.vertical, 2)
          .background(Color.purple.opacity(0.2))
          .foregroundColor(.purple)
          .cornerRadius(4)
      }

      Spacer()
    }
    .padding(.vertical, 4)
  }
}

// MARK: - 预览
#Preview {
  RenameButtonExampleView04()
}
