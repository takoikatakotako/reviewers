import SwiftUI
import FirebaseFirestore

class ReviewDetailViewState: ObservableObject {
    let review: Review
    @Published var comment = ""

    init(review: Review) {
        self.review = review
    }

    func postComment() {
        Task { @MainActor in
            do {
                let db = Firestore.firestore()
                try await db.collection(FirestoreReview.collectionName).document(review.id).collection("comments").addDocument(data: ["text": "hello"])
            } catch {
                print(error)
            }
        }
    }
}
