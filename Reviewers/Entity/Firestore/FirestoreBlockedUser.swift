import FirebaseFirestore

struct FirestoreBlockedUser: Hashable {
    static let collectionName = "blocked_users"

    static let enableField = "enable"
    static let uidField = "uid"
    static let blockedUserIdField = "blockedUserId"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"

    let id: String
    let enable: Bool
    let uid: String
    let blockedUserId: String
    let createdAt: Date
    let updatedAt: Date

    init(document: DocumentSnapshot) throws {
        guard
            let data = document.data(),
            let enable = data[Self.enableField] as? Bool,
            let uid = data[Self.uidField] as? String,
            let blockedUserId = data[Self.blockedUserIdField] as? String,
            let createdAt = (data[Self.createdAtField] as? Timestamp)?.dateValue(),
            let updatedAt = (data[Self.updatedAtField] as? Timestamp)?.dateValue() else {
            throw ReviewersError.temp
        }
        self.id = document.documentID
        self.enable = enable
        self.uid = uid
        self.blockedUserId = blockedUserId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(id: String, enable: Bool, uid: String, blockedUserId: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.enable = enable
        self.uid = uid
        self.blockedUserId = blockedUserId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
