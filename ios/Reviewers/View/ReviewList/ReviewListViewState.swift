import Foundation

class ReviewListViewState: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var uid: String = ""

    // Alert
    @Published var showingReviewAlert = false
    @Published var showingReviewAlertPresenting: (review: Review, isMyReview: Bool)?
    @Published var showingReviewDeleteConfirmAlert = false
    @Published var showingReviewDeleteConfirmAlertPresenting: Review?
    @Published var showingSignInAlert = false

    // FullScreenCover
    @Published var fullScreenCover: ReviewListFullScreenCover?

    // NavigationPath
    @Published var path: [ReviewListViewPath] = []

    private let firestoreRepository = FirestoreRepository()
    private let reviewProfileUseCase = ReviewProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let authUseCase = AuthUseCase()

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

    func menuTapped(review: Review) {
        guard let user = authUseCase.getUser() else {
            // TODO: 未ログイン時の処理
            return
        }
        let myUid = authUseCase.getUser()?.uid ?? ""

        showingReviewAlertPresenting = (review: review, review.uid == myUid)
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
            try await updateReviews()
            print("finish1")
        } catch {
            print(error)
        }
        print("finish")
    }

    @MainActor
    private func updateReviews() async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewReviews()
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
