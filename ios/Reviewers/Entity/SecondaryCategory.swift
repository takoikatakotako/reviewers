import Foundation

struct SecondaryCategory: Decodable, Hashable {
    let title: String
    let tertiaryCategories: [TertiaryCategory]
}
