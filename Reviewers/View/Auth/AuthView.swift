import SwiftUI

struct AuthView: View {
    @StateObject var viewState: AuthViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    switch viewState.type {
                    case .signUp:
                        SignUpView(
                            mail: $viewState.email,
                            password: $viewState.password,
                            disabled: viewState.inprogress,
                            signUp: {
                                viewState.signUp()
                            },
                            selectSignIn: {
                                viewState.selectViewType(viewType: .signIn)
                            }
                        )
                    case .signIn:
                        SignInView(
                            mail: $viewState.email,
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
                            mail: $viewState.email,
                            disabled: false,
                            resetPassowrd: {
                                viewState.resetPassowrd()
                            }
                        )
                    }
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
            .alert(
                Text("エラー"),
                isPresented: $viewState.showingErrorAlert,
                presenting: viewState.errorAlertMessage,
                actions: { _ in },
                message: { message in Text(message)}
            )
            .alert(
                Text("仮登録完了"),
                   isPresented: $viewState.showingRegistrationCompleteAlert,
                actions: {
                    Button("ログイン") {
                        viewState.selectViewType(viewType: .signIn)
                    }
                    Button("とじる") {}
                }, message: {
                    Text("仮登録が完了しました。認証メールが送られましたのでご確認できたらログインしてください。")
                }
            )
            .alert(
                Text("ログイン完了"),
                   isPresented: $viewState.showingSignInCompleteAlert,
                actions: {
                    Button("とじる") {
                        dismiss()
                    }
                }, message: {
                    Text("ログイン完了しました。")
                }
            )
            .alert(
                Text("パスワードリセット完了"),
                   isPresented: $viewState.showingPasswordResetCompleteAlert,
                actions: {
                    Button("ログイン") {
                        viewState.selectViewType(viewType: .signIn)
                    }
                    Button("とじる") {}
                }, message: {
                    Text("パスワードリセットが完了しました。パスワード変更メールが送られましたのでご確認できたらログインしてください。")
                }
            )
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
                    CommonText(text: viewState.title, font: .mPlus2Bold(size: 14), lineHeight: 20)
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
