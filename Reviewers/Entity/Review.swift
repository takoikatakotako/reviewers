import Foundation

struct Review: Identifiable, Hashable {
    let id: String
    let userName: String
    let code: String
    let rate: Int
    let comment: String
    let images: [String]
}
