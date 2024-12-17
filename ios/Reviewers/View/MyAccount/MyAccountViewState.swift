import SwiftUI
import FirebaseAuth

class MyAccountViewState: ObservableObject {
//    @Published var uid: String = ""
//    @Published var profile: Profile?
//
//    // Navigation Destination
//    @Published var navigationDestination: MyAccountNavigationDestination?

    @Published var isAnonymousUser = true
    @Published var versionTapCount = 0

    // Fullscreen Cover
    @Published var showingFullscreenCover = false

    // Alert
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting = ""

    private let profileUseCase = ProfileUseCase()
    private let authUseCase = AuthUseCase()

//    var profileImageUrl: URL? {
//        guard let uid = try? authUseCase.getUserId() else {
//            return nil
//        }
//        return URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png")
//    }

    func onAppear() {
        isAnonymousUser = (try? authUseCase.isAnonymousUser()) ?? true
        Task { @MainActor in
            do {
                try await authUseCase.reloadUser()
                isAnonymousUser = try authUseCase.isAnonymousUser()
            } catch {
                print(error)
                showingErrorAlert = false
                showingErrorAlertPresenting = error.localizedDescription
            }
        }
    }

    func signIn() {
        showingFullscreenCover = true
    }

    func signOut() {
        Task { @MainActor in
            do {
                try await authUseCase.signOut()
                NotificationCenter.default.post(name: NSNotification.signOut, object: self, userInfo: nil)
            } catch {
                print(error)
                showingErrorAlert = false
                showingErrorAlertPresenting = error.localizedDescription
            }
        }
    }
    
    func versionTapped() {
        versionTapCount += 1
    }
}
