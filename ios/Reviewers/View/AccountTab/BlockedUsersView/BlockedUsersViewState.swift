import Foundation

class BlockedUsersViewState: ObservableObject {
    @Published var blockedUsers: [BlockedUser] = []
    @Published var loading = true

    // Navigation Destination
    @Published var navigationDestination: BlockedUserViewDestination?

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

    func xxx(profile: Profile) {
        navigationDestination = .account(profile: profile)
    }
}
