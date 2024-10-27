import SwiftUI
import SDWebImageSwiftUI
import LicenseList

struct MyAccountSettingChangeEmailView: View {
    @StateObject var viewState: MyAccountSettingChangeEmailViewState

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    CommonText(text: "メールアドレス", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                        .foregroundStyle(Color(.appMainText))
                        // .disabled(disabled)

                    TextField("", text: $viewState.email)
                        .textFieldStyle(.roundedBorder)
                        .font(.mPlus2Regular(size: 16))
                }

                VStack(alignment: .leading, spacing: 12) {
                    CommonText(text: "パスワード", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                        .foregroundStyle(Color(.appMainText))
                        // .disabled(disabled)

                    SecureField("", text: $viewState.password)
                        .textFieldStyle(.roundedBorder)
                        .font(.mPlus2Regular(size: 16))
                }
                .padding(.top, 12)
                
                Button {
                    viewState.changeEmail()
                } label: {
                    HStack {
                        Spacer()
                        CommonText(text: "再ログインしてメールアドレスを変更", font: .mPlus2Bold(size: 14), lineHeight: 20)
                            .foregroundStyle(Color(.white))

                        Spacer()
                    }
                    .frame(height: 48)
                    .background(Color(.appGreenBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                //.disabled(disabled)
                .padding(.top, 24)
            }
            .padding(16)
            //.tint(Color(.appMainText))
//            .onAppear {
//                viewState.onAppear()
//            }
//            .navigationDestination(item: $viewState.navigationDestination) { item in
//                switch item {
//                case .account(profile: let profile):
//                    // AccountView(viewState: AccountViewState(profile: profile))
//                    Text("temp")
//                }
//            }
//            .fullScreenCover(isPresented: $viewState.showingFullscreenCover) {
//                // SignUpView(viewState: SignUpViewState())
//                AuthView(viewState: AuthViewState())
//            }
            .listStyle(.grouped)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("メールアドレス変更")
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        
    }
}

#Preview {
    NavigationStack {
        MyAccountSettingChangeEmailView(viewState: MyAccountSettingChangeEmailViewState())
    }
}
