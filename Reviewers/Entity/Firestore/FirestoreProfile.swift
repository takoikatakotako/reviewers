import FirebaseFirestore

struct FirestoreProfile: Hashable {
    static let collectionName = "profiles"
    static let nicknameField = "nickname"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"

    let id: String
    let nickname: String
    let updatedAt: Date

    init(document: DocumentSnapshot) throws {
        guard
            let data = document.data(),
            let nickname = data[FirestoreProfile.nicknameField] as? String,
            let updatedAt = (data[FirestoreProfile.updatedAtField] as? Timestamp)?.dateValue() else {
            throw ReviewersError.temp
        }
        self.id = document.documentID
        self.nickname = nickname
        self.updatedAt = updatedAt
    }

    init(id: String, nickname: String, updatedAt: Date) {
        self.id = id
        self.nickname = nickname
        self.updatedAt = updatedAt
    }
}
