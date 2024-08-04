import Foundation

struct Review: Identifiable, Hashable {
    let id: String
    let uid: String
    let userName: String
    let code: String
    let rate: Int
    let comment: String
    let images: [String]
    let createdAt: Date
    let updatedAt: Date
    
    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: createdAt)
    }
    
    var imageUrlStrings: [String] {
        return images.map { "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/\($0)" }
    }
}
