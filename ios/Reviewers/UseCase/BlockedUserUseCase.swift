import Foundation

struct BlockedUserUseCase {
    private let firestoreRepository = FirestoreRepository()

    func createBlockedUser(uid: String, blockedUserId: String) async throws {
        try await firestoreRepository.createBlockedUser(uid: uid, blockedUserId: blockedUserId)
    }

    func updateBlockedUser(blockedUser: BlockedUser) async throws {
        // try await firestoreRepository.createBlockedUser(uid: uid, blockedUserId: blockedUserId)
    }

    func fetchBlockedUsers(uid: String) async throws -> [BlockedUser] {
        let firestoreBlockedUsers = try await firestoreRepository.fetchBlockedUsers(uid: uid)

        var blockedUsers: [BlockedUser] = []
        for firestoreBlockedUser in firestoreBlockedUsers {
            let firestoreProfile = try await firestoreRepository.fetchProfile(uid: firestoreBlockedUser.blockedUserId)
            let profileImageURL =  URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(firestoreProfile.id)/profile.png")
            let profile = Profile(id: firestoreProfile.id, nickname: firestoreProfile.nickname, profile: firestoreProfile.profile, profileImageURL: profileImageURL)
            let blockedUser = BlockedUser(id: firestoreBlockedUser.id, blockedUserId: firestoreBlockedUser.blockedUserId, blockedUserProfile: profile)
            blockedUsers.append(blockedUser)
        }
        return blockedUsers
    }
}
