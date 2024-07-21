import Foundation
import FirebaseAuth

struct AuthRepository {
    
//    func isValidUser() async throws -> Bool {
//        guard let user = Auth.auth().currentUser else {
//            throw ReviewersError.clientError
//        }
//        
//        // アノニマスユーザーはNG
//        guard user.isAnonymous == false {
//            return false
//        }
//        
//        // メール認証が終わっていること
//        guard user.isEmailVerified {
//            return false
//        }
//        
//    
//    }
    
    func getUser() -> User? {
        return  Auth.auth().currentUser
    }
    
    func reloadUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
        try await user.reload()
    }
    
    func signInAnonymously() async throws {
        try await Auth.auth().signInAnonymously()
    }
    
    func linkEmailProvider(email: String, password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await user.link(with: credential)
    }
    
    func sendEmailVerification() async throws {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
        try await user.sendEmailVerification()
    }
    
    func signOut() async throws {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
    }
}
