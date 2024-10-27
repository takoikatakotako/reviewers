import SwiftUI
import FirebaseAuth

class MyAccountSettingChangeEmailViewState: ObservableObject {
//    @Published var uid: String = ""
//    @Published var profile: Profile?
//
//    // Navigation Destination
//    @Published var navigationDestination: MyAccountNavigationDestination?

    
    @Published var email = ""
    @Published var password = ""
    
    @Published var disabled = false
    
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
//        Task { @MainActor in
//            do {
//                isAnonymousUser = try authUseCase.isAnonymousUser()
//            } catch {
//                print(error)
//            }
//        }
//    }
//
    
    // Alert
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting = ""
    
    private var authUseCase = AuthUseCase()
    
    
    func reAuth() {
        
    }
    
    func changeEmail() {
        Task { @MainActor in
            do {
                try await authUseCase.signIn(email: email, password: password)
                try await authUseCase.changeEmail(email: email)
            } catch {
                print(error)
                showingErrorAlertPresenting = error.localizedDescription
                showingErrorAlert = true
            }
        }
    }
    
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
//            }
//        }
//    }
}
