import SwiftUI

struct ResetPassworeView2: View {
    @Binding var mail: String
    let disabled: Bool
    var resetPassowrd: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                CommonText(text: "メールアドレス", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                    .foregroundStyle(Color(.appMainText))

                TextField("", text: $mail)
                    .textFieldStyle(.roundedBorder)
                    .font(.mPlus2Regular(size: 16))
                    .disabled(disabled)
            }

            Button {
                resetPassowrd()
            } label: {
                HStack {
                    Spacer()
                    CommonText(text: "パスワードをリセット", font: .mPlus2Bold(size: 14), lineHeight: 20)
                        .foregroundStyle(Color(.white))

                    Spacer()
                }
                .frame(height: 48)
                .background(Color(.appGreenBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .disabled(disabled)
            .padding(.top, 24)
        }
        .padding(16)
    }
}
