import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ReviewDetailViewState: ObservableObject {
    let review: Review

    @Published var merchandise: Merchandise?
    @Published var uid: String = ""
    @Published var comments: [Comment] = []
    @Published var comment = ""
    @Published var loading = true

    // Alert Delete Confirm
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: Review?
    
    // Alert Delete Complete
    @Published var showingReviewDeleteCompleteAlert = false
    
    // Alert Error
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting: String?

    // FullScreen
    @Published var fullScreenCover: ReviewDetailFullScreenCover?

    // Navigation Destination
    @Published var navigationDestination: ReviewDetailViewDestination?

    private let authUseCase = AuthUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let merchandiseUseCase = MerchandiseUseCase()

    var isMyReview: Bool {
        return review.uid == uid
    }
    
    init(review: Review) {
        self.review = review
    }

    func onAppear() {
        Task { @MainActor in
            self.merchandise = try? await merchandiseUseCase.fetchMerchandise(code: review.code)
            
            do {
                self.uid = try authUseCase.getUserId()
            } catch {
                showingErrorAlertPresenting = "ユーザーIDの取得に失敗しました"
                showingErrorAlert = true
            }
        }
    }

    func accounTapped(profile: Profile) {
        navigationDestination = .account(profile: profile)
    }

    func imageTapped(imageURL: URL?) {
        fullScreenCover = .image(imageUrl: imageURL)
    }

    func signInTapped() {
        fullScreenCover = .signUp
    }

    // メニュー
    func commentMenuTapped() {

    }

    // MARK: - DeleteReview
    func deleteReviewTapped() {
        showingReviewDeleteConfirmAlertPresenting = review
        showingReviewDeleteConfirmAlert = true
    }

    func deleteReview() {
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

    // MARK: - ReportReview
    func reportReview() {
        fullScreenCover = .report(review: review)
    }
}
