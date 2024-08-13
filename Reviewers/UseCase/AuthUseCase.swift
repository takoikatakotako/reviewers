import Foundation
import FirebaseAuth

struct AuthUseCase {
    private let authRepository = AuthRepository()

    // ユーザーIDを取得
    func getUserId() throws -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw ReviewersError.temp
        }
        return uid
    }
    
    // Eメールを取得
    func getEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
    
    // 匿名ユーザーであるか判別
    func isAnonymousUser() throws -> Bool {
        guard let isAnonymous = Auth.auth().currentUser?.isAnonymous else {
            throw ReviewersError.temp
        }
        return isAnonymous
    }
}
