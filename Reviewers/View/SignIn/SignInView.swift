import SwiftUI

struct SignInView: View {
    @StateObject var viewState: SignInViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 12) {
                        CommonText(text: "メールアドレス", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                            .foregroundStyle(Color(.appMainText))

                        TextField("", text: $viewState.mail)
                            .textFieldStyle(.roundedBorder)
                            .font(.mPlus2Regular(size: 16))
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        CommonText(text: "パスワード", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                            .foregroundStyle(Color(.appMainText))

                        SecureField("", text: $viewState.password)
                            .textFieldStyle(.roundedBorder)
                            .font(.mPlus2Regular(size: 16))
                    }
                    .padding(.top, 12)

                    Button {
                        viewState.signIn()
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

                }
                .padding(16)

                Spacer()
            }

            if viewState.inprogress {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .scaleEffect(1.2)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                }
            }

            ToolbarItem(placement: .principal) {
                CommonText(text: "ログイン", font: .mPlus2Bold(size: 14), lineHeight: 20)
                    .foregroundStyle(Color(.white))
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    SignInView(viewState: SignInViewState())
}
