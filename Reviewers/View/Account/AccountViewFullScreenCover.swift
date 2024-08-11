import Foundation

import Foundation

enum AccountViewFullScreenCover: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case image(urlString: String)
}
