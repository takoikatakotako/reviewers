import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AccountViewState: ObservableObject {
    let profile: Profile
    let isMe: Bool
    @Published var nickname = ""
    @Published var reviews: [ReviewProfile] = []
    @Published var loading = true

    // Alert Account
    @Published var showingAccountAlert = false
    @Published var showingAccountAlertPresenting: (Profile)?

    // Alert Review
    @Published var showingReviewAlert = false
    @Published var showingReviewAlertPresenting: (review: ReviewProfile, isMyReview: Bool)?

    // Alert Review Delete Confirm
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: ReviewProfile?

    // Alert Error
    @Published var showingErrorAlert = false

    // Navigation Destination
    @Published var navigationDestination: AccountViewDestination?

    // FullScreenCover
    @Published var fullScreenCover: AccountViewFullScreenCover?

    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewProfileUseCase()
    private let authRepository = AuthRepository()
    private let authUseCase = AuthUseCase()
    private let blockedUserUseCase = BlockedUserUseCase()

    init(profile: Profile) {
        print(profile)
        self.profile = profile
        self.isMe = (profile.id == authUseCase.getUser()?.uid ?? "")
    }

    func onAppear() {
        Task { @MainActor in
            do {
                try await updateUserReviews(uid: profile.id)
            } catch {
                print(error)
            }
            loading = false
        }
    }

    func pullToRefresh() async {
        do {
            try await updateUserReviews(uid: profile.id)
        } catch {
            print(error)
        }
    }

    // アカウントの…がタップされた時
    func accountMenuTapped() {
        showingAccountAlertPresenting = profile
        showingAccountAlert = true
    }

    // アイコンや名前がタップされた時
    func accountTapped(profile: Profile) {
        navigationDestination = .account(profile: profile)
    }

    func reviewTapped(review: ReviewProfile) {
        navigationDestination = .reviewDetail(review: review)
    }

    func imageTapped(imageURL: URL?) {
        fullScreenCover = .image(url: imageURL)
    }

    func menuTapped(review: ReviewProfile) {
        // sheet = .myReview
        guard let user = authUseCase.getUser() else {
            // TODO: 未ログイン時の処理
            return
        }

        showingReviewAlertPresenting = (review: review, review.uid == user.uid)
        showingReviewAlert = true
    }

    func deleteReviewTapped(review: ReviewProfile) {
        showingReviewDeleteConfirmAlertPresenting = review
        showingReviewDeleteConfirmAlert = true
    }

    func deleteReview(review: ReviewProfile) {
        Task { @MainActor in
            do {
                try await reviewUseCase.deleteReview(reviewId: review.id)
                if let index = reviews.firstIndex(of: review) {
                    reviews.remove(at: index)
                }
            } catch {
                print(error)
            }
        }
    }

    func blockUser(blockUserId: String) {
        Task { @MainActor in
            do {
                let uid = try authUseCase.getUserId()
                try await blockedUserUseCase.createBlockedUser(uid: uid, blockedUserId: blockUserId)
            } catch {
                showingErrorAlert = true
            }
        }
    }

    @MainActor
    private func updateUserReviews(uid: String) async throws {
        let newReviews: [ReviewProfile] = try await reviewUseCase.fetchNewUserReviews(uid: uid)
        let margedReviews: [ReviewProfile] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
