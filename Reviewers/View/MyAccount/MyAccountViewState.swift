import SwiftUI
import FirebaseAuth

class MyAccountViewState: ObservableObject {
    @Published var user: User?
    @Published var nickname: String = ""
    @Published var xx: Bool?

    private let authRepository = AuthRepository()
    private let firestoreRepository = FirestoreRepository()
    private let profileUseCase = ProfileUseCase()

    var profileImageUrl: URL? {
        guard let uid = user?.uid else {
            return nil
        }
        return URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png")
    }

    func onAppear() {
        guard let user = authRepository.getUser() else {
            return
        }
        self.user = user

        Task { @MainActor in
            let profile = await profileUseCase.fetchProfile(uid: user.uid)
            nickname = profile.nickname
        }
    }

    func signOut() {
        Task { @MainActor in
            do {
                try await authRepository.signOut()
                NotificationCenter.default.post(name: NSNotification.signOut, object: self, userInfo: nil)
            } catch {
                print(error)
            }
        }
    }
}
