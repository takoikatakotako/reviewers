import SwiftUI
import FirebaseAuth

class MyReviewListViewState: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var uid: String = ""

    //    @Published var uid: String = ""
    //    @Published var profile: Profile?
    //
    //    // Navigation Destination
    //    @Published var navigationDestination: MyAccountNavigationDestination?

    // Fullscreen Cover
    @Published var showingFullscreenCover = false

    // FullScreenCover
    @Published var fullScreenCover: MyReviewListViewFullScreenCover?

    private let profileUseCase = ProfileUseCase()
    private let authUseCase = AuthUseCase()
    private let firestoreRepository = FirestoreRepository()
    private let reviewProfileUseCase = ReviewProfileUseCase()
    private let reviewUseCase = ReviewUseCase()

    func onAppear() {
        Task { @MainActor in
            do {
                uid = try authUseCase.getUserId()
                try await updateReviews(uid: uid)
            } catch {
                print(error)
            }
        }
    }

    func refresh() async {
        do {
//            uid = try authUseCase.getUserId()
//            try await updateReviews(uid: uid)
            let duration = UInt64(3 * 1_000_000_000)
            try await Task.sleep(nanoseconds: duration)
        } catch {

        }
    }

    func reviewTapped(review: Review) {
        // path.append(.reviewDetail(review: review))
    }

    func imageTapped(imageURL: URL?) {
        fullScreenCover = .image(imageURL: imageURL)
    }

    //    func accountTapped() {
    //        guard let profile = profile else {
    //            return
    //        }
    //        navigationDestination = .account(profile: profile)
    //    }

    func menuTapped(review: Review) {
//        guard let user = authRepository.getUser() else {
//            // TODO: 未ログイン時の処理
//            return
//        }
//        let myUid = authRepository.getUser()?.uid ?? ""
//
//        showingReviewAlertPresenting = (review: review, review.uid == myUid)
//        showingReviewAlert = true
    }

    func signIn() {
        Task { @MainActor in
            do {
                if try authUseCase.isAnonymousUser() {
                    showingFullscreenCover = true
                } else {
                    print("error")
                }
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    private func updateReviews(uid: String) async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewUserReviews(uid: uid)
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
