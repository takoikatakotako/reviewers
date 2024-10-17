import Foundation

enum MyReviewListViewFullScreenCover: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case image(imageURL: URL?)
}
