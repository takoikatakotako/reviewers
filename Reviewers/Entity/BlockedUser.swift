import Foundation

struct BlockedUser: Identifiable {
    let id: String
    let blockedUserId: String
    let blockedUserProfile: Profile
}
