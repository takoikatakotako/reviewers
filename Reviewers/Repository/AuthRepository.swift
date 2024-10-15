import Foundation
import FirebaseAuth

struct AuthRepository {

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

    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func sendEmailVerification() async throws {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
        try await user.sendEmailVerification()
    }

    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func signOut() async throws {
        try Auth.auth().signOut()
    }
}
