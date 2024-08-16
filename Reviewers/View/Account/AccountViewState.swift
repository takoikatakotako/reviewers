import Foundation

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AccountViewState: ObservableObject {
    let profile: Profile
    let isMe: Bool
    @Published var nickname = ""
    @Published var reviews: [Review] = []
    @Published var loading = true

    // Alert
    @Published var showingAccountAlert = false
    @Published var showingAccountAlertPresenting: (Profile)?

    @Published var showingReviewAlert = false
    @Published var showingReviewAlertPresenting: (review: Review, isMyReview: Bool)?
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: Review?
    @Published var navigationDestination: AccountViewDestination?
    @Published var fullScreenCover: AccountViewFullScreenCover?

    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let authRepository = AuthRepository()
    private let authUseCase = AuthUseCase()
    private let blockedUserUseCase = BlockedUserUseCase()

    var profileImageUrlString: String {
        return "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(profile.id)/profile.png"
    }

    init(profile: Profile) {
        self.profile = profile
        self.isMe = (profile.id == authRepository.getUser()?.uid ?? "")
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

    func reviewTapped(review: Review) {
        navigationDestination = .reviewDetail(review: review)
    }

    func imageTapped(imageURL: URL?) {
        fullScreenCover = .image(url: imageURL)
    }

    func menuTapped(review: Review) {
        // sheet = .myReview
        guard let user = authRepository.getUser() else {
            // TODO: 未ログイン時の処理
            return
        }

        showingReviewAlertPresenting = (review: review, review.uid == user.uid)
        showingReviewAlert = true
    }

    func deleteReviewTapped(review: Review) {
        showingReviewDeleteConfirmAlertPresenting = review
        showingReviewDeleteConfirmAlert = true
    }

    func deleteReview(review: Review) {
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
                print(error)
            }
        }
    }

    @MainActor
    private func updateUserReviews(uid: String) async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewUserReviews(uid: uid)
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
