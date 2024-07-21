import Foundation
import FirebaseAuth

struct AuthRepository {
    
    func getUser() -> User? {
        return  Auth.auth().currentUser
    }
    
    func signInAnonymously() async throws {
        try await Auth.auth().signInAnonymously()
    }
    
    func createUser(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
}
