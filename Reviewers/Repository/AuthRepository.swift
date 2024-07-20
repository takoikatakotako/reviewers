import Foundation
import FirebaseAuth

struct AuthRepository {
    
    func getUserID() -> User? {
        return  Auth.auth().currentUser
    }
}
