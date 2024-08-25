import SwiftUI

class ReviewSearchViewState: ObservableObject {
    @Published var code: String?
    @Published var merchandise: Merchandise?
    @Published var reviews: [Review] = []
    @Published var loading: Bool = false

    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let authRepository = AuthRepository()
    private let merchandiseUseCase = MerchandiseUseCase()

    func xxxxx() {
//        Task { @MainActor in
//            do {
//                self.reviews = try await reviewUseCase.fetchNewReviews()
//            } catch {
//                print(error)
//            }
////            loading = false
//        }
    }

    func codeSccaned(code: String) {
        self.loading = true
        self.code = code

        Task { @MainActor in
            do {
                // 商品を取得
                let merchandise = try await merchandiseUseCase.fetchMerchandise(code: code)
                let reviews = try await reviewUseCase.fetchMerchandiseReviews(merchandise: merchandise)
                self.merchandise = merchandise
            } catch {
                // 商品が見つかりませんでした
                print("error")
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
