import SwiftUI

class ReviewSearchViewState: ObservableObject {
    @Published var code: String?
    @Published var merchandise: [Merchandise] = []
    @Published var reviews: [ReviewProfile] = []
    @Published var loading: Bool = false
    @Published var isEditing: Bool = false

    @Published var text = ""

    @Published var showingBarcodeView: Bool = false
    @Published var navigationDestination: ReviewSearchNavigationDestination?
    @Published var showingNotFoundMerchandiseAlert = false

    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewProfileUseCase()
    private let merchandiseUseCase = MerchandiseUseCase()

    func onAppear() {
        Task { @MainActor in
            do {
                // 商品を取得
                let merchandises = try await merchandiseUseCase.fetchMerchandises()
                self.merchandise = merchandises
            } catch {
                // 商品が見つかりませんでした
                print(error)
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
        if isEditing {
            // 開始の場合
        } else {
            // 終了の場合
        }

        // 更新
        self.isEditing = isEditing
    }

    func barcodeButtonTapped() {
        withAnimation {
            showingBarcodeView = true
        }
    }

    func barodeHideButtonTapped() {
        withAnimation {
            showingBarcodeView = false
        }
    }

    func codeSccaned(code: String) {
        // 今までのコードと同じか確認、同じなら何もしない
        print(code)

        Task { @MainActor in
            loading = true
            do {
               let merchandise = try await searchByCode(code: code)
                navigationDestination = .reviewSearchDetail(merchandise: merchandise)
                showingBarcodeView = false
                loading = false
            } catch {
                print(error)
                loading = false
                showingNotFoundMerchandiseAlert = true
            }
        }
    }

    func xxx(merchandise: Merchandise) {
        navigationDestination = .reviewSearchDetail(merchandise: merchandise)
    }

    @MainActor
    private func searchByCode(code: String) async throws -> Merchandise {
        return try await merchandiseUseCase.fetchMerchandise(code: code)
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
