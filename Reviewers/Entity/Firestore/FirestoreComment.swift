import FirebaseFirestore

struct FirestoreComment: Hashable {
    static let collectionName = "comments"
    let id: String
    let uid: String
    let comment: String
    let createdAt: Date
    let updatedAt: Date

    init(document: QueryDocumentSnapshot) throws {
        let data = document.data()
        guard
            let uid = data["uid"] as? String,
            let comment = data["comment"] as? String,
            let createdAt = data["createdAt"] as? Timestamp,
            let updatedAt = data["updatedAt"] as? Timestamp
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
