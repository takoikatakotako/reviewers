import FirebaseFirestore

struct FirestoreReview: Hashable {
    static let collectionName = "reviews"
    static let uid = "uid"

    let id: String
    let uid: String
    let code: String
    let rate: Int
    let comment: String
    let images: [String]
    let createdAt: Date
    let updatedAt: Date

    init(document: QueryDocumentSnapshot) throws {
        let data = document.data()
        guard
            let uid = data["uid"] as? String,
            let code = data["code"] as? String,
            let rate = data["rate"] as? Int,
            let comment = data["comment"] as? String,
            let images = data["images"] as? [String],
            let createdAt = data["createdAt"] as? Timestamp,
            let updatedAt = data["updatedAt"] as? Timestamp
        else {
            throw ReviewersError.temp
        }

        self.id = document.documentID
        self.uid = uid
        self.code = code
        self.rate = rate
        self.comment = comment
        self.images = images
        self.createdAt = createdAt.dateValue()
        self.updatedAt = updatedAt.dateValue()
    }

    init(id: String, uid: String, code: String, rate: Int, comment: String, images: [String], createdAd: Date, updatedAt: Date) {
        self.id = id
        self.uid = uid
        self.code = code
        self.rate = rate
        self.comment = comment
        self.images = images
        self.createdAt = createdAd
        self.updatedAt = updatedAt
    }
}
