import SwiftUI

class AuthViewState: ObservableObject {
    @Published var mail = ""
    @Published var password = ""
    @Published var inprogress = false

    @Published var type: AuthViewType = .signUp

    private let authRepository = AuthRepository()

    func selectViewType(viewType: AuthViewType) {
        withAnimation(.linear(duration: 0.3)) {
            type = viewType
        }
    }

    func selectSignIn() {
        withAnimation(.linear(duration: 0.3)) {
            type = .signIn
        }
    }

    func signUp() {
        inprogress = true
        Task { @MainActor in
            do {
                try await authRepository.linkEmailProvider(email: mail, password: password)
                try await authRepository.signIn(email: mail, password: password)

                guard let user = authRepository.getUser() else {
                    throw ReviewersError.temp
                }

                if user.isEmailVerified == true {
                    // すでに登録されているユーザー
                    return
                }

                //
                try await authRepository.sendEmailVerification()

                inprogress = false
            } catch {
                print(error)
                inprogress = false
            }
        }
    }

    func signIn() {
        inprogress = true
        Task { @MainActor in
            do {
                try await authRepository.signIn(email: mail, password: password)
                try await authRepository.reloadUser()

                guard let user = authRepository.getUser() else {
                    throw ReviewersError.temp
                }

                if user.isEmailVerified == true {
                    // メールアドレス認証済みのユーザー
                } else {
                    // メールアドレス認証されていないユーザー
                    // メール送ったよ

                    //
                    try await authRepository.sendEmailVerification()
                }

                inprogress = false
            } catch {
                print(error)
                inprogress = false
            }
        }

    }

    func resetPassowrd() {
        Task { @MainActor in
            do {
                try await authRepository.sendPasswordReset(email: "snorlax.chemist.and.jazz@gmail.com")
            } catch {
                print(error)
            }

        }
    }
}
