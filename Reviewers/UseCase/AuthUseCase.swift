import Foundation
import FirebaseAuth

struct AuthUseCase {
    private let authRepository = AuthRepository()

    // 匿名ユーザーであるか判別
    func isAnonymousUser() throws -> Bool {
        guard let isAnonymous = Auth.auth().currentUser?.isAnonymous else {
            throw ReviewersError.temp
        }
        return isAnonymous
    }
}
