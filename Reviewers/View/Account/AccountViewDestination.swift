import Foundation

enum AccountViewDestination: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case account(profile: Profile)
    case reviewDetail(review: Review)
}
