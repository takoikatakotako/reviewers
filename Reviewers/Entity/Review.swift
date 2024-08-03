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
}
