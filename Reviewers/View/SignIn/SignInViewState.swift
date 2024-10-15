// import Foundation
//
// class SignInViewState: ObservableObject {
//    @Published var mail = ""
//    @Published var password = ""
//    @Published var inprogress = false
//
//    private let authRepository = AuthRepository()
//
//    func signIn() {
//        inprogress = true
//        Task { @MainActor in
//            do {
//                try await authRepository.signIn(email: mail, password: password)
//                try await authRepository.reloadUser()
//
//                guard let user = authRepository.getUser() else {
//                    throw ReviewersError.temp
//                }
//
//                if user.isEmailVerified == true {
//                    // メールアドレス認証済みのユーザー
//                } else {
//                    // メールアドレス認証されていないユーザー
//                    // メール送ったよ
//
//                    //
//                    try await authRepository.sendEmailVerification()
//                }
//
//                inprogress = false
//            } catch {
//                print(error)
//                inprogress = false
//            }
//        }
//
//    }
// }
