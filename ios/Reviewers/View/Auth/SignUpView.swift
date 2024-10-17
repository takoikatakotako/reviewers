import SwiftUI

struct SignUpView: View {
    @Binding var mail: String
    @Binding var password: String
    let disabled: Bool
    var signUp: () -> Void
    var selectSignIn: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                CommonText(text: "メールアドレス", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                    .foregroundStyle(Color(.appMainText))
                    .disabled(disabled)

                TextField("", text: $mail)
                    .textFieldStyle(.roundedBorder)
                    .font(.mPlus2Regular(size: 16))
            }

            VStack(alignment: .leading, spacing: 12) {
                CommonText(text: "パスワード", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                    .foregroundStyle(Color(.appMainText))
                    .disabled(disabled)

                SecureField("", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .font(.mPlus2Regular(size: 16))
            }
            .padding(.top, 12)

            Button {
                signUp()
            } label: {
                HStack {
                    Spacer()
                    CommonText(text: "アカウント作成", font: .mPlus2Bold(size: 14), lineHeight: 20)
                        .foregroundStyle(Color(.white))

                    Spacer()
                }
                .frame(height: 48)
                .background(Color(.appGreenBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .disabled(disabled)
            .padding(.top, 24)

            Text("[利用規約](https://apple.com) と [プライバシーポリシー](https://apple.com) に同意してアカウントを作成してみましょう。")
                .foregroundStyle(Color(.appMainText))
                .tint(Color(.appMain))
                .font(.mPlus2Regular(size: 16))
                .lineSpacing(4)
                .padding(.vertical, 4)
                .multilineTextAlignment(.leading)
                .padding(.top, 12)

            Button {
                selectSignIn()
            } label: {
                HStack {
                    Spacer()
                    CommonText(text: "アカウントをお持ちの方", font: .mPlus2SemiBold(size: 16), lineHeight: 24)
                        .foregroundStyle(Color(.appMain))

                    Spacer()
                }
            }
            .disabled(disabled)
            .padding(.top, 16)
        }
        .padding(16)
    }
}

// #Preview {
//    SignUpView(viewState: SignUpViewState())
// }
