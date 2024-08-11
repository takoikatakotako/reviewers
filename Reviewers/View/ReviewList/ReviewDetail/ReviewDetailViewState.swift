import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ReviewDetailViewState: ObservableObject {
    let review: Review
    @Published var comments: [Comment] = []
    @Published var comment = ""
    @Published var loading = true
    @Published var showingSignInAlert = false
    @Published var navigationDestination: ReviewDetailViewDestination?
    @Published var fullScreenCover: ReviewDetailFullScreenCover?

    private let authUseCase = AuthUseCase()
    private let repository = FirestoreRepository()
    private let reviewUseCase = ReviewUseCase()

    var profileImageURL: URL {
        return Profile.profileImageURL(uid: review.uid)
    }

    init(review: Review) {
        self.review = review
    }

    func onAppear() {
        Task { @MainActor in
            do {
                let comments = try await reviewUseCase.fetchReviewComments(reviewId: review.id)
                self.comments = comments
            } catch {
                print(error)
            }
            self.loading = false
        }
    }

    func postComment() {
        // 匿名ユーザーの場合はログインアラートを表示
        do {
            let isAnonymous = try authUseCase.isAnonymousUser()
            if isAnonymous {
                // ログインアラートを表示
                self.showingSignInAlert = true
                return
            }
        } catch {
            print(error)
            return
        }

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

    func accounTapped(uid: String) {
        navigationDestination = .account(uid: uid)
    }

    func imageTapped(imageUrlString: String) {
        fullScreenCover = .image(urlString: imageUrlString)
    }

    func signInTapped() {
        fullScreenCover = .signUp
    }

}
