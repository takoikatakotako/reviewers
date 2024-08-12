import Foundation

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AccountViewState: ObservableObject {
    let uid: String
    let isMe: Bool
    @Published var nickname = ""
    @Published var reviews: [Review] = []
    @Published var loading = true
    @Published var showingAccountAlert = false
    // TODO: Stringだとわかりづらいので profile とかにする
    @Published var showingAccountAlertPresenting: (String)?
    @Published var showingReviewAlert = false
    @Published var showingReviewAlertPresenting: (review: Review, isMyReview: Bool)?
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: Review?
    @Published var navigationDestination: AccountViewDestination?
    @Published var fullScreenCover: AccountViewFullScreenCover?

    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let authRepository = AuthRepository()

    var profileImageUrlString: String {
        return "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png"
    }

    init(uid: String) {
        self.uid = uid
        self.isMe = (self.uid == authRepository.getUser()?.uid ?? "")
    }

    func onAppear() {
        Task { @MainActor in
            let profile = await profileUseCase.fetchProfile(uid: self.uid)
            nickname = profile.nickname
            do {
                try await updateUserReviews(uid: uid)
            } catch {
                print(error)
            }
            loading = false
        }
    }

    func pullToRefresh() async {
        do {
            try await updateUserReviews(uid: uid)
        } catch {
            print(error)
        }
    }

    func accountTap(uid: String) {
        navigationDestination = .account(uid: uid)
    }

    func reviewTapped(review: Review) {
        navigationDestination = .reviewDetail(review: review)
    }

    func imageTapped(urlString: String) {
        fullScreenCover = .image(urlString: urlString)
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
    
    func accountMenuTapped(uid: String) {
        showingAccountAlertPresenting = uid
        showingAccountAlert = true
    }
    
    func blockUser(uid: String) {
        
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
