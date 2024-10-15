import SwiftUI

struct AuthView: View {
    @StateObject var viewState: AuthViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                switch viewState.type {
                case .signUp:
                    SignUpView2(
                        mail: $viewState.mail,
                        password: $viewState.password,
                        disabled: false,
                        signUp: {
                            viewState.signUp()
                        },
                        selectSignIn: {
                            viewState.selectViewType(viewType: .signIn)
                        }
                    )
                case .signIn:
                    SignInView2(
                        mail: $viewState.mail,
                        password: $viewState.password,
                        disabled: false,
                        signIn: {
                            viewState.signIn()
                        },
                        selectResetPassword: {
                            viewState.selectViewType(viewType: .resetPassword)
                        })
                case .resetPassword:
                    ResetPassworeView2(
                        mail: $viewState.mail,
                        disabled: false,
                        resetPassowrd: {

                        }
                    )
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
                        Image(systemName: "multiply")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                    }
                }

                ToolbarItem(placement: .principal) {
                    CommonText(text: "アカウント作成", font: .mPlus2Bold(size: 14), lineHeight: 20)
                        .foregroundStyle(Color(.white))
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// #Preview {
//    SignInView(viewState: SignInViewState())
// }
