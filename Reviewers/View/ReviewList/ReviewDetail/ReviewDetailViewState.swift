import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ReviewDetailViewState: ObservableObject {
    let review: Review
    @Published var comments: [Comment] = []
    @Published var comment = ""

    private let repository = FirestoreRepository()

    init(review: Review) {
        self.review = review
    }

    func onAppear() {
        Task { @MainActor in
            do {
                let comments = try await repository.fetchComments(reviewId: review.id)
                self.comments = comments
            } catch {
                print(error)
            }
        }
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
