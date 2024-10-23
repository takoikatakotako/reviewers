import Foundation

class ReviewListViewState: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var uid: String = ""
    @Published var isFetching = false

    // Alert
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: Review?
    @Published var showingSignInAlert = false
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting: String?

    // FullScreenCover
    @Published var fullScreenCover: ReviewListFullScreenCover?

    // NavigationPath
    @Published var path: [ReviewListViewPath] = []

    private let firestoreRepository = FirestoreRepository()
    private let reviewProfileUseCase = ReviewProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let authUseCase = AuthUseCase()

    // MARK: - Action
    func onAppear() {
        Task { @MainActor in
            do {
                uid = try authUseCase.getUserId()
                try await updateReviews()
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    func refresh() async {
        do {
            let duration = UInt64(3 * 1_000_000_000)
            try await Task.sleep(nanoseconds: duration)
            try await updateReviews()
        } catch {
            showingErrorAlertPresenting = "エラーメッセージ"
            showingErrorAlert = true
        }
    }

    @MainActor
    func xxxx() {
        Task { @MainActor in
            do {
                isFetching = true
                let duration = UInt64(3 * 1_000_000_000)
                try await Task.sleep(nanoseconds: duration)
                guard let xx = reviews.last else {
                    throw ReviewersError.clientError
                }

                try await updateReviews(offsetDate: xx.createdAt)
                isFetching = false
            } catch {
                isFetching = false
                showingErrorAlertPresenting = "エラーメッセージ"
                showingErrorAlert = true
            }
        }
    }

    func onDismissPostSheet() {
        Task { @MainActor in
            do {
                try await updateReviews()
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

    func imageTapped(imageURL: URL?) {
        fullScreenCover = .image(imageURL: imageURL)
    }

    func postButtonTapped() {
        guard let user = authUseCase.getUser() else {
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
                try await authUseCase.reloadUser()
                guard let user = authUseCase.getUser() else {
                    throw ReviewersError.temp
                }
                if user.isEmailVerified {
                    // メール認証が終わっているため投稿画面を表示
                    fullScreenCover = .newPost
                    return
                }

            } catch {
                print(error)
            }
        }
    }

    func signInTapped() {
        fullScreenCover = .signUp
    }

    // MARK: - DeleteReview
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

    @MainActor
    private func updateReviews(offsetDate: Date = Date.now, limit: Int = 3) async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewReviews(offsetDate: offsetDate, limit: limit)
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
