import Foundation

enum ReviewListFullScreenCover: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case signUp
    case newPost
    case image(urlString: String)
}
