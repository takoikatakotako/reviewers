import SwiftUI
import FirebaseAuth

class AccountViewState: ObservableObject {
    private let authRepository = AuthRepository()
    
    @Published var user: User?
    
    func onAppear(){
        guard let user = authRepository.getUser() else {
            return
        }
        
        self.user = user
    }
}
