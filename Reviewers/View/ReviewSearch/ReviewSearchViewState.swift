import SwiftUI

class ReviewSearchViewState: ObservableObject {

    @Published var code: String?
    @Published var loading: Bool = false
    @Published var reviews: [Review] = []

    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let authRepository = AuthRepository()

//    func onAppear() {
//        Task { @MainActor in
//            do {
//                try await updateUserReviews(uid: profile.id)
//            } catch {
//                print(error)
//            }
//            loading = false
//        }
//    }
//    

    func xxxxx() {
        Task { @MainActor in
            do {
                self.reviews = try await reviewUseCase.fetchNewReviews()
            } catch {
                print(error)
            }
//            loading = false
        }
    }

    func codeSccaned(code: String) {
        self.loading = true
        self.code = code

        Task { @MainActor in
            do {
                // 商品を取得

            } catch {

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
