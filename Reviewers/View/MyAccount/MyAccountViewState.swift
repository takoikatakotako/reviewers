import SwiftUI
import FirebaseAuth

class MyAccountViewState: ObservableObject {
    @Published var uid: String = ""
    @Published var profile: Profile?

    // Navigation Destination
    @Published var navigationDestination: MyAccountNavigationDestination?
    
    // Fullscreen Cover
    @Published var showingFullscreenCover = false

    private let authRepository = AuthRepository()
    private let profileUseCase = ProfileUseCase()
    private let authUseCase = AuthUseCase()

    var profileImageUrl: URL? {
        guard let uid = try? authUseCase.getUserId() else {
            return nil
        }
        return URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png")
    }

    func onAppear() {
        Task { @MainActor in
            do {
                let uid = try authUseCase.getUserId()
                self.uid = uid
                let profile = try await profileUseCase.fetchProfile(uid: uid)
                self.profile = profile
            } catch {
                print(error)
            }
        }
    }

    func accountTapped() {
        guard let profile = profile else {
            return
        }
        navigationDestination = .account(profile: profile)
    }
    
    func signIn() {
        Task { @MainActor in
            do {
                if try authUseCase.isAnonymousUser() {
                    showingFullscreenCover = true
                } else {
                    print("error")
                }
            } catch {
                print(error)
            }
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
