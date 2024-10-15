// import Foundation
//
// class ResetPasswordViewState: ObservableObject {
//    @Published var mail = ""
//    @Published var inprogress = false
//
//    private let authRepository = AuthRepository()
//
//    func resetPassowrd() {
//        Task { @MainActor in
//            do {
//                try await authRepository.sendPasswordReset(email: "snorlax.chemist.and.jazz@gmail.com")
//            } catch {
//                print(error)
//            }
//            
//        }
//    }
//    
// }
