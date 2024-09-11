import Foundation

struct BlockedUser: Identifiable, Hashable {
    let id: String
    let blockedUserId: String
    let blockedUserProfile: Profile
}
