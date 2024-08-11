import Foundation

enum ReviewListViewPath: Hashable {
    case account(uid: String)
    case reviewDetail(review: Review)
}
