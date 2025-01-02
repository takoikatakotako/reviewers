import SwiftUI
import FirebaseAuth

class MyReviewListViewState: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var uid: String = ""

    //    @Published var uid: String = ""
    //    @Published var profile: Profile?
    //
    //    // Navigation Destination
    //    @Published var navigationDestination: MyAccountNavigationDestination?

    
    
    // Alert Delete Confirm
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: Review?
    
    // Alert Delete Complete
    @Published var showingReviewDeleteCompleteAlert = false
    
    // Alert Error
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting: String?

    // FullScreenCover
    @Published var fullScreenCover: MyReviewListViewFullScreenCover?

    private let authUseCase = AuthUseCase()
    private let firestoreRepository = FirestoreRepository()
    private let reviewUseCase = ReviewUseCase()

    func onAppear() {
        Task { @MainActor in
            do {
                uid = try authUseCase.getUserId()
                try await updateReviews(uid: uid)
            } catch {
                print(error)
            }
        }
    }

    func refresh() async {
        do {
//            uid = try authUseCase.getUserId()
//            try await updateReviews(uid: uid)
            let duration = UInt64(3 * 1_000_000_000)
            try await Task.sleep(nanoseconds: duration)
        } catch {

        }
    }

    func reviewTapped(review: Review) {
        // path.append(.reviewDetail(review: review))
    }

    func imageTapped(imageURL: URL?) {
        fullScreenCover = .image(imageURL: imageURL)
    }

    // MARK: - DeleteReview
    func deleteReviewTapped(review: Review) {
        showingReviewDeleteConfirmAlertPresenting = review
        showingReviewDeleteConfirmAlert = true
    }

    func deleteReview(review: Review) {
        Task { @MainActor in
            do {
                try await reviewUseCase.deleteReview(reviewId: review.id)

                // 削除完了
                NotificationCenter.default.post(
                    name: NSNotification.reviewDeleted,
                    object: self,
                    userInfo: ["reviewId": review.id]
                )
                showingReviewDeleteCompleteAlert = true
            } catch {
                showingErrorAlertPresenting = "レビューの削除に失敗しました"
                showingErrorAlert = true
            }
        }
    }
    
    @MainActor
    private func updateReviews(uid: String) async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewUserReviews(uid: uid)
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
