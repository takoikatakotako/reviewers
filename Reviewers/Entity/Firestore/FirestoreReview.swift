import FirebaseFirestore

struct FirestoreReview: Hashable {
    static let collectionName = "reviews"
    static let uidField = "uid"
    static let codeField = "code"
    static let rateField = "rate"
    static let deletedField = "deleted"
    static let commentField = "comment"
    static let imagesField = "images"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"

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
            let uid = data[Self.uidField] as? String,
            let code = data[Self.codeField] as? String,
            let rate = data[Self.rateField] as? Int,
            let comment = data[Self.commentField] as? String,
            let images = data[Self.imagesField] as? [String],
            let createdAt = data[Self.createdAtField] as? Timestamp,
            let updatedAt = data[Self.updatedAtField] as? Timestamp
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
