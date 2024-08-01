import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ReviewDetailViewState: ObservableObject {
    let review: Review
    @Published var comment = ""

    private let repository = FirestoreRepository()
    
    init(review: Review) {
        self.review = review
    }

    func postComment() {
        Task { @MainActor in
            do {
                guard let uid = Auth.auth().currentUser?.uid else {
                    throw ReviewersError.temp
                }
                try await repository.addReviewComments(reviewId: review.id, uid: uid, comment: comment)
            } catch {
                print(error)
            }
        }
    }
}
