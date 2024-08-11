import Foundation

struct Profile: Identifiable, Hashable {
    let id: String
    let nickname: String

    static func initialValue(uid: String) -> Profile {
        return Profile(id: uid, nickname: Self.initialNickname)
    }
    static let initialNickname = "ななしさん"

    static func profileImageURL(uid: String) -> URL {
        return URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png")!
    }

    var profileImageURL: URL {
        return Self.profileImageURL(uid: id)
    }
}
