import Foundation

enum ReviewListSheet: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case myReview
//    case newPost
//    case image(urlString: String)
}
