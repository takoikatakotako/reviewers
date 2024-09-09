import Foundation

class BlockedUsersViewState: ObservableObject {
    @Published var blockedUsers: [BlockedUser] = []
    @Published var loading = true
    
    private let authUseCase = AuthUseCase()
    private let blockedUserUseCase = BlockedUserUseCase()

    func onAppear() {
        Task { @MainActor in
            do {
                let uid = try authUseCase.getUserId()
                let blockedUsers = try await blockedUserUseCase.fetchBlockedUsers(uid: uid)
                self.blockedUsers = blockedUsers
            } catch {
                print(error)
            }
            loading = false
        }
    }
}
