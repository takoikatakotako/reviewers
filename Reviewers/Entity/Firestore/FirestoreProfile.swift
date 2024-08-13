import FirebaseFirestore

struct FirestoreProfile: Hashable {
    static let collectionName = "profiles"
    static let nicknameField = "nickname"
    static let profileField = "profile"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"

    let id: String
    let nickname: String
    let profile: String
    let createdAt: Date
    let updatedAt: Date

    init(document: DocumentSnapshot) throws {
        guard
            let data = document.data(),
            let nickname = data[FirestoreProfile.nicknameField] as? String,
            let profile = data[FirestoreProfile.profileField] as? String,
            let createdAt = (data[FirestoreProfile.createdAtField] as? Timestamp)?.dateValue(),
            let updatedAt = (data[FirestoreProfile.updatedAtField] as? Timestamp)?.dateValue() else {
            throw ReviewersError.temp
        }
        self.id = document.documentID
        self.nickname = nickname
        self.profile = profile
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(id: String, nickname: String, profile: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.nickname = nickname
        self.profile = profile
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
