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
                try await authRepository.createUser(email: mail, password: password)
                inprogress = false
            } catch {
                inprogress = false
            }
        }
    }
}
