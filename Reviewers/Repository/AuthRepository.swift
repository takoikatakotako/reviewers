import Foundation
import FirebaseAuth

struct AuthRepository {
    
    func getUserID() -> User? {
        return  Auth.auth().currentUser
    }
    
    func signInAnonymously() async throws {
        try await Auth.auth().signInAnonymously()
    }
}
