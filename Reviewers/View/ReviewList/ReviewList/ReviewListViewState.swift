import Foundation

class ReviewListViewState: ObservableObject {
    @Published var favoriteColor = 0
    @Published var path: [ReviewListViewPath] = []

    @Published var reviews: [Review] = []

    @Published var showingPostCover = false

    @Published var showingSignInAlert = false
    @Published var showingSignUpFullScreen = false

    private let authRepository = AuthRepository()

    private let repository = Repository()
    private let firestoreRepository = FirestoreRepository()

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

    func tapped(review: Review) {
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
            showingPostCover = true
            return
        }

        // メール認証が終わっていない場合
        Task { @MainActor in
            do {
                try await authRepository.reloadUser()
                guard let user = authRepository.getUser() else {
                    throw ReviewersError.temp
                }
                if user.isEmailVerified {
                    // メール認証が終わっているため投稿画面を表示
                    showingPostCover = true
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
        showingSignUpFullScreen = true
    }

    func matigaeta() {
        showingPostCover = true
    }

    func check() {
        showingPostCover = true
    }

    @MainActor
    private func updatePosts() async throws {
        let newReviews: [Review] = try await firestoreRepository.fetchReviews()
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }

}
