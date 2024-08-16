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
        return firestoreBlockedUsers.map { BlockedUser(id: $0.id, blockedUserId: $0.blockedUserId) }
    }
}
