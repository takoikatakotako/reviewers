import SwiftUI
import FirebaseAuth

class AuthViewState: ObservableObject {
    @Published var type: AuthViewType = .signUp
    @Published var email = ""
    @Published var password = ""
    @Published var inprogress = false

    // 仮登録完了
    @Published var showingRegistrationCompleteAlert = false

    // SignIn完了
    @Published var showingSignInCompleteAlert = false

    // パスワードリセット完了
    @Published var showingPasswordResetCompleteAlert = false

    // エラーアラート
    @Published var showingErrorAlert = false
    @Published var errorAlertMessage = ""

    private let authRepository = AuthRepository()
    private let authUseCase = AuthUseCase()

    var title: String {
        switch type {
        case .signUp:
            return "アカウント作成"
        case .signIn:
            return "ログイン"
        case .resetPassword:
            return "パスワードリセット"
        }
    }

    func selectViewType(viewType: AuthViewType) {
        withAnimation(.linear(duration: 0.3)) {
            type = viewType
        }
    }

    func signUp() {
        inprogress = true

        // メールアドレスのバリデーション
        guard isValidMail(mail: email) else {
            inprogress = false
            errorAlertMessage = "正しいメールアドレスを入力してください。"
            showingErrorAlert = true
            return
        }

        // パスワードのバリデーション
        guard isValidPassword(password: password) else {
            inprogress = false
            errorAlertMessage = "パスワードを8文字以上入力してください。"
            showingErrorAlert = true
            return
        }

        Task { @MainActor in
            do {
                // SignUpを行う
                try await authUseCase.signUp(email: email, password: password)
                try await authUseCase.reloadUser()

                // すでに認証されているか確認する
                if try authUseCase.isEmailVerified() {
                    // すでに登録されているユーザー
                    errorAlertMessage = "すでにアカウントがありました。「アカウントをお持ちの方」からログインしてみてください。"
                    showingErrorAlert = true
                    return
                }

                // メール認証を行う
                try await authUseCase.sendEmailVerification()
                errorAlertMessage = "メール認証おなしゃす。認証がおわりましたら「アカウントをお持ちの方」からログインしてみてください。"
                showingErrorAlert = true

                // SignInひとまず完了
                inprogress = false
            } catch {
                let authError = AuthErrorCode(_nsError: error as NSError)
                switch authError.code {
                case .emailAlreadyInUse:
                    errorAlertMessage = "すでに使用されたメールアドレスです。「アカウントをお持ちの方」からログインしてみてください。"
                    showingErrorAlert = true
                default:
                    errorAlertMessage = "不明なエラーが発生しました。時間を空けてお試しください。"
                    showingErrorAlert = true
                }

                inprogress = false
            }
        }
    }

    func signIn() {
        inprogress = true
        Task { @MainActor in
            do {
                // SignIn を行う
                try await authUseCase.signIn(email: email, password: password)
                try await authUseCase.reloadUser()

                // すでに認証されているか確認する
                if try authUseCase.isEmailVerified() {
                    // メールアドレス認証済みのユーザー
                } else {
                    // メールアドレス認証されていないユーザー

                    // メール認証を行う
                    try await authRepository.sendEmailVerification()

                    errorAlertMessage = "メール認証おなしゃす。認証がおわりましたら「アカウントをお持ちの方」からログインしてみてください。"
                    showingErrorAlert = true
                }

                // SignIn完了
                inprogress = false
                showingSignInCompleteAlert = true
            } catch {
                inprogress = false
                errorAlertMessage = "不明なエラーが発生しました。時間を空けてお試しください。"
                showingErrorAlert = true
            }
        }

    }

    func resetPassowrd() {
        inprogress = true

        // メールアドレスのバリデーション
        guard isValidMail(mail: email) else {
            inprogress = false
            errorAlertMessage = "正しいメールアドレスを入力してください。"
            showingErrorAlert = true
            return
        }

        Task { @MainActor in
            do {
                try await authRepository.sendPasswordReset(email: email)

                // パスワードリセット完了
                showingPasswordResetCompleteAlert = true
            } catch {
                inprogress = false
                errorAlertMessage = "不明なエラーが発生しました。時間を空けてお試しください。"
                showingErrorAlert = true
            }
        }
    }

    // メールアドレスのバリデーション
    private func isValidMail(mail: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: mail)
    }

    // パスワードのバリデーション
    private func isValidPassword(password: String) -> Bool {
        return password.count >= 8
    }
}
