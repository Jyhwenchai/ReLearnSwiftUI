import SwiftUI

/// TextField 验证示例 - 输入验证和格式化
public struct TextFieldExampleView03: View {
  @State private var emailText = ""
  @State private var phoneText = ""
  @State private var passwordText = ""
  @State private var priceText = ""

  // 验证状态
  @State private var isEmailValid = false
  @State private var isPasswordValid = false

  public init() {}

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("TextField 验证示例")
          .font(.largeTitle.weight(.bold))
          .padding(.bottom)

        emailValidationSection
        phoneFormattingSection
        passwordValidationSection
        priceFormattingSection
        summarySection
      }
      .padding()
    }
    .navigationTitle("输入验证和格式化")
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }

  private var emailValidationSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("1. 邮箱验证")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Image(systemName: "envelope")
            .foregroundColor(.gray)
            .frame(width: 20)

          TextField("请输入邮箱地址", text: $emailText)
            .textFieldStyle(.plain)
            #if os(iOS)
              .keyboardType(.emailAddress)
              .autocapitalization(.none)
              .disableAutocorrection(true)
            #endif
            .onChange(of: emailText) { newValue in
              isEmailValid = isValidEmail(newValue)
            }

          if !emailText.isEmpty {
            Image(systemName: isEmailValid ? "checkmark.circle.fill" : "xmark.circle.fill")
              .foregroundColor(isEmailValid ? .green : .red)
          }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(
              emailText.isEmpty ? Color.gray.opacity(0.3) : isEmailValid ? Color.green : Color.red,
              lineWidth: 1
            )
        )

        if !emailText.isEmpty && !isEmailValid {
          Text("请输入有效的邮箱地址")
            .font(.caption)
            .foregroundColor(.red)
        }
      }

      Text("• 实时验证邮箱格式")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var phoneFormattingSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("2. 手机号格式化")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Image(systemName: "phone")
            .foregroundColor(.gray)
            .frame(width: 20)

          TextField("手机号", text: $phoneText)
            .textFieldStyle(.plain)
            #if os(iOS)
              .keyboardType(.phonePad)
            #endif
            .onChange(of: phoneText) { newValue in
              phoneText = formatPhoneNumber(newValue)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.blue.opacity(0.5), lineWidth: 1)
        )

        if !phoneText.isEmpty {
          Text("格式化后：\(phoneText)")
            .font(.caption)
            .foregroundColor(.blue)
        }
      }

      Text("• 自动格式化为 XXX-XXXX-XXXX")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var passwordValidationSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("3. 密码强度验证")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Image(systemName: "lock")
            .foregroundColor(.gray)
            .frame(width: 20)

          SecureField("密码", text: $passwordText)
            .textFieldStyle(.plain)
            .onChange(of: passwordText) { newValue in
              isPasswordValid = isValidPassword(newValue)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(
              passwordText.isEmpty
                ? Color.gray.opacity(0.3) : isPasswordValid ? Color.green : Color.red,
              lineWidth: 1
            )
        )

        if !passwordText.isEmpty {
          VStack(alignment: .leading, spacing: 4) {
            HStack {
              Text("密码强度：")
                .font(.caption)
              Text(passwordStrength(passwordText))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(passwordStrengthColor(passwordText))
            }

            ProgressView(value: passwordStrengthValue(passwordText), total: 1.0)
              .progressViewStyle(LinearProgressViewStyle(tint: passwordStrengthColor(passwordText)))
              .scaleEffect(x: 1, y: 0.5)
          }
        }
      }

      Text("• 实时密码强度检测")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var priceFormattingSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("4. 价格输入格式化")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Text("¥")
            .font(.title2)
            .fontWeight(.medium)
            .foregroundColor(.green)

          TextField("0.00", text: $priceText)
            .textFieldStyle(.plain)
            #if os(iOS)
              .keyboardType(.decimalPad)
            #endif
            .onChange(of: priceText) { newValue in
              priceText = formatPrice(newValue)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.green.opacity(0.5), lineWidth: 1)
        )
      }

      Text("• 自动添加千分位分隔符")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
  }

  private var summarySection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("✅ 验证和格式化要点")
        .font(.headline)
        .foregroundColor(.primary)

      VStack(alignment: .leading, spacing: 4) {
        Text("• 使用 onChange 监听输入变化")
        Text("• 实时验证并提供视觉反馈")
        Text("• 格式化输入内容提升用户体验")
        Text("• 过滤非法字符防止错误输入")
        Text("• 提供清晰的错误提示信息")
      }
      .font(.caption)
      .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.orange.opacity(0.1))
    .cornerRadius(10)
  }

  // MARK: - 验证和格式化函数

  private func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
  }

  private func formatPhoneNumber(_ input: String) -> String {
    let digits = input.filter { $0.isNumber }
    let maxLength = 11
    let truncated = String(digits.prefix(maxLength))

    var formatted = ""
    for (index, char) in truncated.enumerated() {
      if index == 3 || index == 7 {
        formatted += "-"
      }
      formatted += String(char)
    }
    return formatted
  }

  private func isValidPassword(_ password: String) -> Bool {
    return password.count >= 8 && password.contains(where: { $0.isUppercase })
      && password.contains(where: { $0.isLowercase }) && password.contains(where: { $0.isNumber })
  }

  private func passwordStrength(_ password: String) -> String {
    let score = passwordStrengthValue(password)
    if score < 0.3 { return "弱" }
    if score < 0.7 { return "中等" }
    return "强"
  }

  private func passwordStrengthValue(_ password: String) -> Double {
    var score = 0.0
    if password.count >= 8 { score += 0.25 }
    if password.contains(where: { $0.isUppercase }) { score += 0.25 }
    if password.contains(where: { $0.isLowercase }) { score += 0.25 }
    if password.contains(where: { $0.isNumber }) { score += 0.25 }
    return score
  }

  private func passwordStrengthColor(_ password: String) -> Color {
    let score = passwordStrengthValue(password)
    if score < 0.3 { return .red }
    if score < 0.7 { return .orange }
    return .green
  }

  private func formatPrice(_ input: String) -> String {
    let filtered = input.filter { $0.isNumber || $0 == "." }
    let components = filtered.components(separatedBy: ".")

    if components.count > 2 {
      return String(filtered.dropLast())
    }

    if let integerPart = components.first, !integerPart.isEmpty {
      let number = Int(integerPart) ?? 0
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      let formattedInteger = formatter.string(from: NSNumber(value: number)) ?? integerPart

      if components.count == 2 {
        let decimalPart = String(components[1].prefix(2))
        return "\(formattedInteger).\(decimalPart)"
      } else if filtered.hasSuffix(".") {
        return "\(formattedInteger)."
      } else {
        return formattedInteger
      }
    }

    return filtered
  }
}

#Preview {
  NavigationView {
    TextFieldExampleView03()
  }
}
