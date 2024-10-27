import SwiftUI
import FirebaseAuth

class MyAccountSettingChangePasswordViewState: ObservableObject {
    //    @Published var uid: String = ""
    //    @Published var profile: Profile?
    //
    //    // Navigation Destination
    //    @Published var navigationDestination: MyAccountNavigationDestination?
    
    
    @Published var email = ""
    
    //    @Published var disabled = false
    
    @Published var indicator = false
    
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
    @Published var showingFinishAlert = false
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting = ""
    
    private var authUseCase = AuthUseCase()
    
    init(email: String) {
        self.email = email
    }
    
    func resetPassword() {
        indicator = true
        
        // TODO: メールアドレスなどのバリデーションを行う
        
        Task { @MainActor in
            do {
                try await authUseCase.sendPasswordReset(email: email)
                try await authUseCase.reloadUser()
                indicator = false
                showingFinishAlert = true
            } catch {
                indicator = false
                print(error)
                showingErrorAlertPresenting = error.localizedDescription
                showingErrorAlert = true
            }
        }
    }
    
    
}
