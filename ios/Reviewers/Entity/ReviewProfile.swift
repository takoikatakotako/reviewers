import Foundation

struct ReviewProfile: Identifiable, Hashable {
    let id: String
    let uid: String
    let profile: Profile
    let code: String
    let rate: Int
    let comment: String

    let imageUrls: [URL?]
    let merchandise: Merchandise?
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
