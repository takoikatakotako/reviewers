import FirebaseFirestore

struct FirestoreMerchandise: Hashable {
    static let collectionName = "merchandises"

    static let enableField = "enable"
    static let statusField = "status"
    static let nameField = "name"
    static let codeField = "code"
    static let codeTypeField = "codeType"
    static let imageField = "image"
    static let imageRefarenceReviewIdField = "imageRefarenceReviewId"
    static let createdAtField = "createdAt"
    static let createdUid = "createdUid"
    static let updatedAtField = "updatedAt"
    static let updatedUid = "updatedUid"

    let id: String
    let enable: Bool
    let status: FirestoreMerchandiseStatus
    let name: String
    let code: String
    let codeType: FirestoreCodeType
    let image: String
    let imageReferenceReviewId: String
    let createdAt: Date
    let createdUid: String
    let updatedAt: Date
    let updatedUid: String

    init(document: DocumentSnapshot) throws {
        guard
            let data = document.data(),
            let enable = data[Self.enableField] as? Bool,
            let statusString = data[Self.statusField] as? String,
            let status = FirestoreMerchandiseStatus(rawValue: statusString),
            let name = data[Self.nameField] as? String,
            let code = data[Self.codeField] as? String,
            let codeTypeString = data[Self.codeTypeField] as? String,
            let codeType = FirestoreCodeType(rawValue: codeTypeString),
            let image = data[Self.imageField] as? String,
            let imageReferenceReviewId = data[Self.imageRefarenceReviewIdField] as? String,
            let createdAt = (data[Self.createdAtField] as? Timestamp)?.dateValue(),
            let createdUid = data[Self.createdUid] as? String,
            let updatedAt = (data[Self.updatedAtField] as? Timestamp)?.dateValue(),
            let updatedUid = data[Self.updatedUid] as? String else {
            throw ReviewersError.temp
        }
        self.id = document.documentID
        self.enable = enable
        self.status = status
        self.name = name
        self.code = code
        self.codeType = codeType
        self.image = image
        self.imageReferenceReviewId = imageReferenceReviewId
        self.createdAt = createdAt
        self.createdUid = createdUid
        self.updatedAt = updatedAt
        self.updatedUid = updatedUid
    }

    init(
        id: String,
        enable: Bool,
        status: FirestoreMerchandiseStatus,
        name: String,
        code: String,
        codeType: FirestoreCodeType,
        image: String, imageReferenceReviewId: String,
        createdAt: Date,
        createdUid: String,
        updatedAt: Date,
        updatedUid: String
    ) {
        self.id = id
        self.enable = enable
        self.status = status
        self.name = name
        self.code = code
        self.codeType = codeType
        self.image = image
        self.imageReferenceReviewId = imageReferenceReviewId
        self.createdAt = createdAt
        self.createdUid = createdUid
        self.updatedAt = updatedAt
        self.updatedUid = updatedUid
    }
}

enum FirestoreMerchandiseStatus: String {
    case waitingForReview = "WaitingForReview"
    case reviewComplete = "ReviewCompleted"
}
