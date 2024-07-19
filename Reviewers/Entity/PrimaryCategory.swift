import Foundation

struct PrimaryCategory: Decodable {
    let id: Int
    let title: String
    let secondaryCategories: [SecondaryCategory]
}
