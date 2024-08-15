import Foundation

struct FirestoreBlock: Hashable {
    static let collectionName = "blocks"

    let id: String
    let uid: String
    let blockUserId: String
    let createdAt: Date
    let updatedAt: Date
}
