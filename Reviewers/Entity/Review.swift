import Foundation

struct Review: Identifiable, Hashable {
    let id: String
    let uid: String
    let deleted: Bool
    let code: String
    let codeType: CodeType
    let comment: String
    let imageUrls: [URL]
    let rate: Int
    let createdAt: Date
    let updatedAt: Date

    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: createdAt)
    }

    var profileImageUrlString: String {
        return "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png"
    }
}
