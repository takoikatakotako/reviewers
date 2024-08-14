import Foundation

enum ReviewListViewPath: Hashable {
    case account(profile: Profile)
    case reviewDetail(review: Review)
}
