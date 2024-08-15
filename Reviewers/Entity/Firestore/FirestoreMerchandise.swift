import FirebaseFirestore

struct FirestoreMerchandise: Hashable {
    static let collectionName = "merchandises"

    let id: String
    let status: String
    let name: String
    let createdAt: Date
    let updatedAt: Date

    init(document: DocumentSnapshot) throws {
        guard
            let data = document.data(),
            let status = data[FirestoreProfile.nicknameField] as? String,
            let name = data[FirestoreProfile.profileField] as? String,
            let createdAt = (data[FirestoreProfile.createdAtField] as? Timestamp)?.dateValue(),
            let updatedAt = (data[FirestoreProfile.updatedAtField] as? Timestamp)?.dateValue() else {
            throw ReviewersError.temp
        }
        self.id = document.documentID
        self.status = status
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(id: String, status: String, name: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.status = status
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum FirestoreMerchandiseStatus: String {
    case pendingReview = "PendingReview"
}
