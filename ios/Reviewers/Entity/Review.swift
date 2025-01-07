import Foundation

struct Review: Identifiable, Hashable {
    let id: String
    let uid: String
    let deleted: Bool
    let code: String
    let codeType: CodeType
    let comment: String
    let images: [String]
    let rate: Int
    let createdAt: Date
    let updatedAt: Date
    let storageEndpoint: String

    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: createdAt)
    }

    var imageUrls: [URL] {
        return images.compactMap { URL(string: "\(storageEndpoint)/image/user/\(uid)/\($0)") }
    }

    var profileImageUrlString: String {
        return "\(storageEndpoint)/image/user/\(uid)/profile.png"
    }
}
