import FirebaseFirestore

struct FirestoreComment: Hashable {
    static let collectionName = "comments"
    static let uidField = "uid"
    static let commentField = "comment"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"
    
    let id: String
    let uid: String
    let comment: String
    let createdAt: Date
    let updatedAt: Date

    init(document: QueryDocumentSnapshot) throws {
        let data = document.data()
        guard
            let uid = data[Self.uidField] as? String,
            let comment = data[Self.commentField] as? String,
            let createdAt = data[Self.createdAtField] as? Timestamp,
            let updatedAt = data[Self.updatedAtField] as? Timestamp
        else {
            throw ReviewersError.temp
        }

        self.id = document.documentID
        self.uid = uid
        self.comment = comment
        self.createdAt = createdAt.dateValue()
        self.updatedAt = updatedAt.dateValue()
    }

    init(id: String, uid: String, comment: String, createdAd: Date, updatedAt: Date) {
        self.id = id
        self.uid = uid
        self.comment = comment
        self.createdAt = createdAd
        self.updatedAt = updatedAt
    }
}
