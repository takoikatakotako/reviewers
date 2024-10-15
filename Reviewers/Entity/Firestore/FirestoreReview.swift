import FirebaseFirestore

struct FirestoreReview: Hashable {
    static let collectionName = "reviews"

    static let uidField = "uid"
    static let deletedField = "deleted"
    static let codeField = "code"
    static let codeTypeField = "codeType"
    static let commentField = "comment"
    static let imagesField = "images"
    static let rateField = "rate"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"

    let id: String
    let uid: String
    let deleted: Bool
    let code: String
    let codeType: String
    let comment: String
    let images: [String]
    let rate: Int
    let createdAt: Date
    let updatedAt: Date

    init(document: QueryDocumentSnapshot) throws {
        let data = document.data()
        guard
            let uid = data[Self.uidField] as? String,
            let deleted = data[Self.deletedField] as? Bool,
            let code = data[Self.codeField] as? String,
            let codeType = data[Self.codeTypeField] as? String,
            let comment = data[Self.commentField] as? String,
            let images = data[Self.imagesField] as? [String],
            let rate = data[Self.rateField] as? Int,
            let createdAt = data[Self.createdAtField] as? Timestamp,
            let updatedAt = data[Self.updatedAtField] as? Timestamp
        else {
            throw ReviewersError.temp
        }

        self.id = document.documentID
        self.uid = uid
        self.deleted = deleted
        self.code = code
        self.codeType = codeType
        self.comment = comment
        self.images = images
        self.rate = rate
        self.createdAt = createdAt.dateValue()
        self.updatedAt = updatedAt.dateValue()
    }

    init(id: String, uid: String, deleted: Bool, code: String, codeType: String, comment: String, images: [String], rate: Int, createdAd: Date, updatedAt: Date) {
        self.id = id
        self.uid = uid
        self.deleted = deleted
        self.code = code
        self.codeType = codeType
        self.comment = comment
        self.images = images
        self.rate = rate
        self.createdAt = createdAd
        self.updatedAt = updatedAt
    }
}
