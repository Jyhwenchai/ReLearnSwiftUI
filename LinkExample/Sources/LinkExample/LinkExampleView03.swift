import SwiftUI

#if os(iOS)
  import UIKit
#elseif os(macOS)
  import AppKit
#endif

/// LinkExampleView03 - 不同类型的链接
///
/// 本示例演示了各种类型的链接：
/// - 网页链接 (HTTP/HTTPS)
/// - 邮件链接 (mailto)
/// - 电话链接 (tel)
/// - 短信链接 (sms)
/// - 应用内链接和深度链接
public struct LinkExampleView03: View {
  public init() {}

  // 状态管理
  @State private var showAlert = false
  @State private var alertMessage = ""

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          // MARK: - 网页链接
          GroupBox("网页链接 (HTTP/HTTPS)") {
            VStack(alignment: .leading, spacing: 15) {
              // HTTPS 链接
              Link("Apple 官网 (HTTPS)", destination: URL(string: "https://www.apple.com")!)

              // 带参数的链接
              Link(
                "Google 搜索 SwiftUI",
                destination: URL(string: "https://www.google.com/search?q=SwiftUI")!)

              // 深度链接到特定页面
              Link(
                "SwiftUI 教程",
                destination: URL(string: "https://developer.apple.com/tutorials/swiftui")!)

              // 本地化链接示例
              Link("Apple 中国官网", destination: URL(string: "https://www.apple.com.cn")!)
            }
            .padding()
          }

          // MARK: - 邮件链接
          GroupBox("邮件链接 (mailto)") {
            VStack(alignment: .leading, spacing: 15) {
              // 基础邮件链接
              Link(destination: URL(string: "mailto:support@example.com")!) {
                HStack {
                  Image(systemName: "envelope")
                  Text("发送邮件")
                }
              }

              // 带主题的邮件
              Link(destination: URL(string: "mailto:feedback@example.com?subject=App反馈")!) {
                HStack {
                  Image(systemName: "envelope.badge")
                  Text("发送反馈邮件")
                }
              }

              // 带主题和内容的邮件
              let emailBody = "您好，\n\n我想咨询关于..."
              let encodedBody =
                emailBody.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
              Link(
                destination: URL(string: "mailto:info@example.com?subject=咨询&body=\(encodedBody)")!
              ) {
                HStack {
                  Image(systemName: "envelope.fill")
                  VStack(alignment: .leading) {
                    Text("发送咨询邮件")
                    Text("包含预设主题和内容")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }
                }
              }

              // 多收件人邮件
              Link(
                destination: URL(
                  string:
                    "mailto:user1@example.com,user2@example.com?cc=manager@example.com&subject=团队通知"
                )!
              ) {
                HStack {
                  Image(systemName: "person.2")
                  Text("发送团队邮件")
                }
              }
            }
            .padding()
          }

          // MARK: - 电话链接
          GroupBox("电话链接 (tel)") {
            VStack(alignment: .leading, spacing: 15) {
              // 基础电话链接
              Link(destination: URL(string: "tel:+1234567890")!) {
                HStack {
                  Image(systemName: "phone")
                  Text("拨打电话: +1 (234) 567-890")
                }
              }

              // 客服电话
              Link(destination: URL(string: "tel:400-123-4567")!) {
                HStack {
                  Image(systemName: "phone.fill")
                    .foregroundColor(.green)
                  VStack(alignment: .leading) {
                    Text("客服热线")
                    Text("400-123-4567")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }
                }
              }

              // 紧急电话
              Link(destination: URL(string: "tel:911")!) {
                HStack {
                  Image(systemName: "phone.badge.plus")
                    .foregroundColor(.red)
                  Text("紧急电话: 911")
                    .foregroundColor(.red)
                }
              }
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(Color.red.opacity(0.1))
              .cornerRadius(8)
            }
            .padding()
          }

          // MARK: - 短信链接
          GroupBox("短信链接 (sms)") {
            VStack(alignment: .leading, spacing: 15) {
              // 基础短信链接
              Link(destination: URL(string: "sms:+1234567890")!) {
                HStack {
                  Image(systemName: "message")
                  Text("发送短信")
                }
              }

              // 带预设内容的短信
              let smsBody = "您好，我想了解更多信息。"
              let encodedSMS =
                smsBody.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
              Link(destination: URL(string: "sms:+1234567890&body=\(encodedSMS)")!) {
                HStack {
                  Image(systemName: "message.fill")
                  VStack(alignment: .leading) {
                    Text("发送预设短信")
                    Text("包含预设内容")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }
                }
              }
            }
            .padding()
          }

          // MARK: - 其他协议链接
          GroupBox("其他协议链接") {
            VStack(alignment: .leading, spacing: 15) {
              // FaceTime 链接
              Link(destination: URL(string: "facetime:user@example.com")!) {
                HStack {
                  Image(systemName: "video")
                  Text("FaceTime 通话")
                }
              }

              // FaceTime 音频
              Link(destination: URL(string: "facetime-audio:+1234567890")!) {
                HStack {
                  Image(systemName: "phone.arrow.up.right")
                  Text("FaceTime 音频")
                }
              }

              // 地图链接
              Link(destination: URL(string: "maps:?q=Apple+Park,+Cupertino,+CA")!) {
                HStack {
                  Image(systemName: "map")
                  Text("在地图中查看 Apple Park")
                }
              }

              // App Store 链接
              Link(destination: URL(string: "https://apps.apple.com/app/id1234567890")!) {
                HStack {
                  Image(systemName: "app.badge")
                  Text("在 App Store 中查看")
                }
              }
            }
            .padding()
          }

          // MARK: - 自定义 URL Scheme
          GroupBox("自定义 URL Scheme") {
            VStack(alignment: .leading, spacing: 15) {
              Text("应用间跳转示例：")
                .font(.headline)

              // 微信分享（示例）
              Button("微信分享 (示例)") {
                if let url = URL(string: "weixin://") {
                  #if os(iOS)
                    if UIApplication.shared.canOpenURL(url) {
                      UIApplication.shared.open(url)
                    } else {
                      alertMessage = "未安装微信应用"
                      showAlert = true
                    }
                  #elseif os(macOS)
                    NSWorkspace.shared.open(url)
                  #endif
                }
              }

              // 支付宝（示例）
              Button("支付宝 (示例)") {
                if let url = URL(string: "alipay://") {
                  #if os(iOS)
                    if UIApplication.shared.canOpenURL(url) {
                      UIApplication.shared.open(url)
                    } else {
                      alertMessage = "未安装支付宝应用"
                      showAlert = true
                    }
                  #elseif os(macOS)
                    NSWorkspace.shared.open(url)
                  #endif
                }
              }

              Text("注意：自定义 URL Scheme 需要在 Info.plist 中声明")
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding()
          }

          // MARK: - 链接验证
          GroupBox("链接验证和错误处理") {
            VStack(alignment: .leading, spacing: 15) {
              Text("安全的链接处理：")
                .font(.headline)

              // 安全链接示例
              SafeLinkView(
                title: "安全链接示例",
                urlString: "https://www.apple.com",
                description: "验证后的安全链接"
              )

              SafeLinkView(
                title: "无效链接示例",
                urlString: "invalid-url",
                description: "这个链接无效，会显示错误"
              )

              Text("最佳实践：")
                .font(.subheadline)
                .fontWeight(.medium)

              VStack(alignment: .leading, spacing: 5) {
                Text("• 始终验证 URL 的有效性")
                Text("• 提供用户友好的错误信息")
                Text("• 考虑网络连接状态")
                Text("• 避免硬编码敏感信息")
              }
              .font(.caption)
              .foregroundColor(.secondary)
            }
            .padding()
          }
        }
        .padding()
      }
      .navigationTitle("Link 类型大全")
      #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
      #endif
    }
    .alert("提示", isPresented: $showAlert) {
      Button("确定") {}
    } message: {
      Text(alertMessage)
    }
  }
}

// MARK: - 安全链接组件
struct SafeLinkView: View {
  let title: String
  let urlString: String
  let description: String

  @State private var showError = false

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if let url = URL(string: urlString) {
        #if os(iOS)
          if UIApplication.shared.canOpenURL(url) {
            Link(destination: url) {
              HStack {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(.green)
                VStack(alignment: .leading) {
                  Text(title)
                    .foregroundColor(.primary)
                  Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "arrow.up.right.square")
                  .foregroundColor(.blue)
              }
            }
          } else {
            HStack {
              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
              VStack(alignment: .leading) {
                Text(title)
                  .foregroundColor(.secondary)
                Text("链接无效或无法打开")
                  .font(.caption)
                  .foregroundColor(.red)
              }
              Spacer()
            }
            .onTapGesture {
              showError = true
            }
          }
        #elseif os(macOS)
          Link(destination: url) {
            HStack {
              Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
              VStack(alignment: .leading) {
                Text(title)
                  .foregroundColor(.primary)
                Text(description)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
              Spacer()
              Image(systemName: "arrow.up.right.square")
                .foregroundColor(.blue)
            }
          }
        #endif
      } else {
        HStack {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.red)
          VStack(alignment: .leading) {
            Text(title)
              .foregroundColor(.secondary)
            Text("链接无效或无法打开")
              .font(.caption)
              .foregroundColor(.red)
          }
          Spacer()
        }
        .onTapGesture {
          showError = true
        }
        .alert("链接错误", isPresented: $showError) {
          Button("确定") {}
        } message: {
          Text("无法打开链接：\(urlString)")
        }
      }
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
    .background(Color.gray.opacity(0.1))
    .cornerRadius(8)
  }
}

// MARK: - 预览
#Preview {
  LinkExampleView03()
}
