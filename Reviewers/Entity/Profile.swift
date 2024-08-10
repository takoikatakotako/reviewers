import Foundation

struct Profile: Identifiable, Hashable {
    let id: String
    let nickname: String

    static func initialValue(uid: String) -> Profile {
        return Profile(id: uid, nickname: Self.initialNickname)
    }
    static let initialNickname = "ななしさん"
}
