import Foundation

struct Comment: Identifiable, Hashable {
    let id: String
    let uid: String
    let comment: String
    let createdAt: Date
    let profile: Profile

    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: createdAt)
    }
}
