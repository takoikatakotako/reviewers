import Foundation

enum AccountViewDestination: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case account(uid: String)
    case reviewDetail(review: Review)
}
