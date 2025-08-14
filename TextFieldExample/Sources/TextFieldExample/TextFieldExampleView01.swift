import SwiftUI

/// TextField 基础示例 - 文本输入和占位符
public struct TextFieldExampleView01: View {
  @State private var normalText = ""
  @State private var username = ""
  @State private var email = ""
  @State private var password = ""
  @State private var numberText = ""

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("TextField 基础示例")
          .font(.largeTitle.weight(.bold))
          .padding(.bottom)

        basicTextInputSection
        usernameInputSection
        emailInputSection
        passwordInputSection
        numberInputSection
        summarySection
      }
      .padding()
    }
    .navigationTitle("基础文本输入")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  private var basicTextInputSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("1. 基础文本输入")
        .font(.headline)
        .foregroundColor(.primary)

      TextField("请输入文本", text: $normalText)
        .textFieldStyle(.roundedBorder)

      if !normalText.isEmpty {
        Text("输入内容：\(normalText)")
          .font(.caption)
          .foregroundColor(.secondary)
      }

      Text("• 使用 @State 变量绑定文本内容")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var usernameInputSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("2. 用户名输入")
        .font(.headline)
        .foregroundColor(.primary)

      TextField("用户名", text: $username)
        .textFieldStyle(.roundedBorder)
        #if os(iOS)
          .autocapitalization(.none)
          .disableAutocorrection(true)
        #endif

      if !username.isEmpty {
        Text("用户名：@\(username)")
          .font(.caption)
          .foregroundColor(.blue)
      }

      Text("• 禁用自动大写和自动纠错")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var emailInputSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("3. 邮箱输入")
        .font(.headline)
        .foregroundColor(.primary)

      TextField("邮箱地址", text: $email)
        .textFieldStyle(.roundedBorder)
        #if os(iOS)
          .keyboardType(.emailAddress)
          .autocapitalization(.none)
          .disableAutocorrection(true)
        #endif

      if !email.isEmpty {
        HStack {
          Image(systemName: email.contains("@") ? "checkmark.circle.fill" : "xmark.circle.fill")
            .foregroundColor(email.contains("@") ? .green : .red)
          Text(email.contains("@") ? "邮箱格式正确" : "请输入有效邮箱")
            .font(.caption)
            .foregroundColor(email.contains("@") ? .green : .red)
        }
      }

      Text("• 使用 .keyboardType(.emailAddress) 显示邮箱键盘")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var passwordInputSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("4. 密码输入")
        .font(.headline)
        .foregroundColor(.primary)

      SecureField("密码", text: $password)
        .textFieldStyle(.roundedBorder)

      if !password.isEmpty {
        HStack {
          Image(systemName: "lock.fill")
            .foregroundColor(.orange)
          Text("密码长度：\(password.count) 字符")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }

      Text("• 使用 SecureField 隐藏输入内容")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var numberInputSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("5. 数字输入")
        .font(.headline)
        .foregroundColor(.primary)

      TextField("请输入数字", text: $numberText)
        .textFieldStyle(.roundedBorder)
        #if os(iOS)
          .keyboardType(.numberPad)
        #endif

      if !numberText.isEmpty {
        if let number = Int(numberText) {
          Text("数字：\(number)")
            .font(.caption)
            .foregroundColor(.blue)
        } else {
          Text("请输入有效数字")
            .font(.caption)
            .foregroundColor(.red)
        }
      }

      Text("• 使用 .keyboardType(.numberPad) 显示数字键盘")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var summarySection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("💡 学习要点")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 4) {
        Text("• TextField 需要绑定到 @State 变量")
        Text("• 第一个参数是占位符文本")
        Text("• 使用不同的 keyboardType 优化输入体验")
        Text("• SecureField 用于敏感信息输入")
        Text("• 可以通过修饰符控制输入行为")
      }
      .font(.caption)
      .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.blue.opacity(0.1))
    .cornerRadius(10)
  }
}

#Preview {
  NavigationView {
    TextFieldExampleView01()
  }
}
