import SwiftUI
import FirebaseAuth

class MyAccountGuidelineViewState: ObservableObject {
    @Published var markdown: String?

    private let type: MyAccountGuidelineType
    private let storageRepository = StorageRepository()

    init(type: MyAccountGuidelineType) {
        self.type = type
    }

    func onAppear() {
        Task { @MainActor in
            do {
                switch type {
                case .teams:
                    self.markdown = try await storageRepository.fetchTeams()
                case .privacy:
                    self.markdown = try await storageRepository.fetchPrivacy()
                }
            } catch {
                print(error)
            }
        }
    }
//    @Published var profile: Profile?
//
//    // Navigation Destination
//    @Published var navigationDestination: MyAccountNavigationDestination?
//
//    @Published var isAnonymousUser = true
//
//    // Fullscreen Cover
//    @Published var showingFullscreenCover = false
//
//    // Alert
//    @Published var showingErrorAlert = false
//    @Published var showingErrorAlertPresenting = ""
//    
//    private let profileUseCase = ProfileUseCase()
//    private let authUseCase = AuthUseCase()
//
////    var profileImageUrl: URL? {
////        guard let uid = try? authUseCase.getUserId() else {
////            return nil
////        }
////        return URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png")
////    }
//
//    func onAppear() {
//        isAnonymousUser = (try? authUseCase.isAnonymousUser()) ?? true
//        Task { @MainActor in
//            do {
//                try await authUseCase.reloadUser()
//                isAnonymousUser = try authUseCase.isAnonymousUser()
//            } catch {
//                print(error)
//                showingErrorAlert = false
//                showingErrorAlertPresenting = error.localizedDescription
//            }
//        }
//    }
//
//    func signIn() {
//        showingFullscreenCover = true
//    }
//
//    func signOut() {
//        Task { @MainActor in
//            do {
//                try await authUseCase.signOut()
//                NotificationCenter.default.post(name: NSNotification.signOut, object: self, userInfo: nil)
//            } catch {
//                print(error)
//                showingErrorAlert = false
//                showingErrorAlertPresenting = error.localizedDescription
//            }
//        }
//    }
}
