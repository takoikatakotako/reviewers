import SwiftUI

class ReviewSearchViewState: ObservableObject {
    @Published var code: String?
    @Published var merchandise: [Merchandise] = []
    @Published var reviews: [ReviewProfile] = []
    @Published var loading: Bool = false
    @Published var isEditing: Bool = false
    
    
    @Published var navigationDestination: ReviewSearchNavigationDestination?
    
    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewProfileUseCase()
    private let authRepository = AuthRepository()
    private let merchandiseUseCase = MerchandiseUseCase()
    
    func onAppear() {
        Task { @MainActor in
            do {
                // 商品を取得
                let merchandises = try await merchandiseUseCase.fetchMerchandises()
                self.merchandise = merchandises
            } catch {
                // 商品が見つかりませんでした
                print("error")
            }
        }
    }
    
    //    func xxxxx() {
    ////        Task { @MainActor in
    ////            do {
    ////                self.reviews = try await reviewUseCase.fetchNewReviews()
    ////            } catch {
    ////                print(error)
    ////            }
    //////            loading = false
    ////        }
    //    }
    
    func onEditingChanged(isEditing: Bool) {
        self.isEditing = isEditing
    }
    
    func codeSccaned(code: String) {
        //        self.loading = true
        //        self.code = code
        //
        //        Task { @MainActor in
        //            do {
        //                // 商品を取得
        //                let merchandise = try await merchandiseUseCase.fetchMerchandise(code: code)
        //                //let reviews = try await reviewUseCase.fetchMerchandiseReviews(merchandise: merchandise)
        //                self.merchandise = merchandise
        //            } catch {
        //                // 商品が見つかりませんでした
        //                print("error")
        //            }
        //        }
    }
    
    func xxx(merchandise: Merchandise) {
        navigationDestination = .reviewSearchDetail(merchandise: merchandise)
    }
    
    
    
    @MainActor
    private func updateUserReviews(uid: String) async throws {
        let newReviews: [ReviewProfile] = try await reviewUseCase.fetchNewUserReviews(uid: uid)
        let margedReviews: [ReviewProfile] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
