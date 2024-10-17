import SwiftUI

struct SignInView: View {
    @Binding var mail: String
    @Binding var password: String
    let disabled: Bool
    var signIn: () -> Void
    var selectResetPassword: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                CommonText(text: "メールアドレス", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                    .foregroundStyle(Color(.appMainText))

                TextField("", text: $mail)
                    .textFieldStyle(.roundedBorder)
                    .font(.mPlus2Regular(size: 16))
            }

            VStack(alignment: .leading, spacing: 12) {
                CommonText(text: "パスワード", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                    .foregroundStyle(Color(.appMainText))

                SecureField("", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .font(.mPlus2Regular(size: 16))
            }
            .padding(.top, 12)

            Button {
                signIn()
            } label: {
                HStack {
                    Spacer()
                    CommonText(text: "ログイン", font: .mPlus2Bold(size: 14), lineHeight: 20)
                        .foregroundStyle(Color(.white))

                    Spacer()
                }
                .frame(height: 48)
                .background(Color(.appGreenBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.top, 24)

            Button {
                selectResetPassword()
            } label: {
                HStack {
                    Spacer()
                    CommonText(text: "パスワードを忘れた方", font: .mPlus2SemiBold(size: 16), lineHeight: 24)
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
