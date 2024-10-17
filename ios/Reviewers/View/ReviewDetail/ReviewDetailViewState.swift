import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ReviewDetailViewState: ObservableObject {
    let review: Review

    @Published var merchandise: Merchandise?
    @Published var comments: [Comment] = []
    @Published var comment = ""
    @Published var loading = true
    @Published var showingSignInAlert = false

    // FullScreen
    @Published var fullScreenCover: ReviewDetailFullScreenCover?

    // Navigation Destination
    @Published var navigationDestination: ReviewDetailViewDestination?

    private let authUseCase = AuthUseCase()
    private let reviewUseCase = ReviewProfileUseCase()
    private let merchandiseUseCase = MerchandiseUseCase()

//    var profileImageURL: URL {
//        return Profile.profileImageURL(uid: reviewProfile.uid)
//    }

    init(review: Review) {
        self.review = review
    }

    func onAppear() {
        Task { @MainActor in
            self.merchandise = try? await merchandiseUseCase.fetchMerchandise(code: review.code)
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

//        Task { @MainActor in
//            do {
//                guard let uid = Auth.auth().currentUser?.uid else {
//                    throw ReviewersError.temp
//                }
//                try await repository.addReviewComments(reviewId: reviewProfile.id, uid: uid, comment: comment)
//            } catch {
//                print(error)
//            }
//        }
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

}
