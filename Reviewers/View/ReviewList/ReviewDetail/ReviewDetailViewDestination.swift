import Foundation

enum ReviewDetailViewDestination: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case account(uid: String)
    case reviewDetail(review: Review)
}
