import FirebaseFirestore

struct FirestoreMerchandise: Hashable {
    static let collectionName = "merchandises"

    static let enableField = "enable"
    static let statusField = "status"
    static let nameField = "name"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"

    let id: String
    let status: FirestoreMerchandiseStatus
    let name: String
    let createdAt: Date
    let updatedAt: Date

    init(document: DocumentSnapshot) throws {
        guard
            let data = document.data(),
            let statusString = data[Self.statusField] as? String,
            let status = FirestoreMerchandiseStatus(rawValue: statusString),
            let name = data[Self.nameField] as? String,
            let createdAt = (data[Self.createdAtField] as? Timestamp)?.dateValue(),
            let updatedAt = (data[Self.updatedAtField] as? Timestamp)?.dateValue() else {
            throw ReviewersError.temp
        }
        self.id = document.documentID
        self.status = status
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(id: String, status: FirestoreMerchandiseStatus, name: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.status = status
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum FirestoreMerchandiseStatus: String {
    case pendingReview = "PendingReview"
    case reviewComplete = "ReviewComplete"
}
