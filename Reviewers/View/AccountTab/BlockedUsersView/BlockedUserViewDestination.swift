import Foundation

enum BlockedUserViewDestination: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case account(profile: Profile)
}
