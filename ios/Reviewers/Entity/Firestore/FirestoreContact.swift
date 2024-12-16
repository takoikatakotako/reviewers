import FirebaseFirestore

struct FirestoreContact: Hashable {
    static let collectionName = "contact"
    
    static let statusField = "status"
    static let uidField = "uid"
    static let emailField = "email"
    static let messageField = "message"
    static let memoField = "memo"
    static let createdAtField = "createdAt"
    static let updatedAtField = "updatedAt"

}

enum FirestoreContactStatus: String {
    case waitingForReview = "WaitingForReview"
    case reviewComplete = "ReviewCompleted"
}
