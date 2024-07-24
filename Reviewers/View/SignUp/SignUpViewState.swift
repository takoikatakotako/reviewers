import Foundation
import FirebaseAuth

class SignUpViewState: ObservableObject {
    @Published var mail = ""
    @Published var password = ""
    @Published var inprogress = false

    let authRepository = AuthRepository()

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
}
