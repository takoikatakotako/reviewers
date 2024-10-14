import Foundation

struct Merchandise: Identifiable, Hashable {
    let id: String
    let enable: Bool
    let status: MerchandiseStatus
    let name: String
    let code: String
    let codeType: CodeType
    let image: String
    let imageReferenceReviewId: String
    let createdAt: Date
    let updatedAt: Date
}


enum MerchandiseStatus: String {
    case waitingForReview = "WaitingForReview"
    case reviewComplete = "ReviewCompleted"
}
