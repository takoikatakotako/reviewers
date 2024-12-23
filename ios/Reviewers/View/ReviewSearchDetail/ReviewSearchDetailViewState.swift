import SwiftUI

class ReviewSearchDetailViewState: ObservableObject {
    @Published var uid: String = ""
    @Published var code: String?
    @Published var merchandise: Merchandise
    @Published var reviews: [Review] = []
    @Published var loading: Bool = false

//    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    private let merchandiseUseCase = MerchandiseUseCase()

    // Alert
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting = ""

    init(merchandise: Merchandise) {
        self.merchandise = merchandise
    }

    func onAppear() {
        Task { @MainActor in
            do {
                self.reviews = try await reviewUseCase.fetchMerchandiseReviews(merchandiseCode: merchandise.code)
            } catch {
                self.showingErrorAlertPresenting = ""
                self.showingErrorAlert = true
            }
        }
    }
}
