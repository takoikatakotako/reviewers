import Foundation

enum ReviewDetailFullScreenCover: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case image(urlString: String)
    case signUp
}
