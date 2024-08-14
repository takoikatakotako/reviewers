import Foundation

class ReviewListViewState: ObservableObject {
    @Published var path: [ReviewListViewPath] = []
    @Published var reviews: [Review] = []

    @Published var fullScreenCover: ReviewListFullScreenCover?
    @Published var showingReviewAlert = false
    @Published var showingReviewAlertPresenting: (review: Review, isMyReview: Bool)?
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: Review?
    @Published var showingSignInAlert = false

    private let authRepository = AuthRepository()
    private let firestoreRepository = FirestoreRepository()
    private let reviewUseCase = ReviewUseCase()

    func onAppear() {
        Task { @MainActor in
            do {
                try await updatePosts()
            } catch {
                print(error)
            }
        }
    }

    func onDismissPostSheet() {
        Task { @MainActor in
            do {
                try await updatePosts()
            } catch {
                print(error)
            }
        }
    }

    func accountTapped(profile: Profile) {
        path.append(.account(profile: profile))
    }

    func reviewTapped(review: Review) {
        path.append(.reviewDetail(review: review))
    }

    func postButtonTapped() {
        guard let user = authRepository.getUser() else {
            return
        }

        // 匿名ユーザーの場合SignIn画面を表示
        if user.isAnonymous {
            showingSignInAlert = true
            return
        }

        // メール認証を確認する
        if user.isEmailVerified {
            // メール認証が終わっているため投稿画面を表示
            fullScreenCover = .newPost
            return
        }

        // メール認証が終わっていない場合、最新情報を取得
        Task { @MainActor in
            do {
                try await authRepository.reloadUser()
                guard let user = authRepository.getUser() else {
                    throw ReviewersError.temp
                }
                if user.isEmailVerified {
                    // メール認証が終わっているため投稿画面を表示
                    fullScreenCover = .newPost
                    return
                }

                // 確認メールを送る
                try await authRepository.sendEmailVerification()
            } catch {
                print(error)
            }
        }
    }

    func signInTapped() {
        fullScreenCover = .signUp
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
                try await firestoreRepository.deleteReview(reviewId: review.id)
                if let index = reviews.firstIndex(of: review) {
                    reviews.remove(at: index)
                }
            } catch {
                print(error)
            }
        }
    }

    func pullToRefresh() async {
        do {
            try await updatePosts()
            print("finish1")
        } catch {
            print(error)
        }
        print("finish")
    }

    @MainActor
    private func updatePosts() async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewReviews()
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }

}
