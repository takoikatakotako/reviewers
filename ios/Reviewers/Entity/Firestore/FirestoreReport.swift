import FirebaseFirestore

struct FirestoreReport: Hashable {
    static let collectionName = "reports"

    static let statusField = "status"
    static let uidField = "uid"
    static let reviewIdField = "reviewId"
    static let messageField = "message"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"
}

enum FirestoreReportStatus: String {
    case waitingForReview = "WaitingForReview"
    case reviewComplete = "ReviewCompleted"
}
