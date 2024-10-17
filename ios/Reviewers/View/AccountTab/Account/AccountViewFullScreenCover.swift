import Foundation

enum AccountViewFullScreenCover: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case image(url: URL?)
}
