import Foundation
import FirebaseAuth

struct AuthUseCase {
    private let authRepository = AuthRepository()
    private let firestoreRepository = FirestoreRepository()

    // 匿名ログイン
    func signInAnonymously() async throws {
        try await Auth.auth().signInAnonymously()
    }

    // 匿名ログインを行い、初期設定を行う。チュートリアル完了直後の利用を想定
    func signInAnonymouslyWithInitialSetting() async throws {
        try await Auth.auth().signInAnonymously()
        guard let uid = Auth.auth().currentUser?.uid else {
            throw ReviewersError.temp
        }

        // プロフィールが存在しないことを確認
        if try await firestoreRepository.profileDocumentExists(uid: uid) {
            // すでにプロフィールが存在
            throw ReviewersError.temp
        }

        // プロフィールを作成
        try await firestoreRepository.createProfile(uid: uid, nickname: "ななしさん", profile: "")
    }

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

    func signUp(email: String, password: String) async throws {
        // ユーザーを取得
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }

        // EmailAuthProvider とリンクさせる
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await user.link(with: credential)

        // SignInを試みる
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    // SignIn
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func isEmailVerified() throws -> Bool {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
        return user.isEmailVerified
    }

    func sendEmailVerification() async throws {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
        try await user.sendEmailVerification()
    }

    func reloadUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw ReviewersError.clientError
        }
        try await user.reload()
    }
}
