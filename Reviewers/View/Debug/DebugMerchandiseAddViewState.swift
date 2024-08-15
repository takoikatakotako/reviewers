import Foundation

class DebugMerchandiseAddViewState: ObservableObject {
    @Published var name: String = ""
    @Published var code: String = ""

    @Published var indicator = false

    // Alert
    @Published var showingNameAlert = false
    @Published var showingSuccessAlert = false
    @Published var showingErrorAlert = false

    // Navigation Destination
    @Published var navigationDestination = false

    private let merchandiseUseCase = MerchandiseUseCase()

    func nameTapped() {
        showingNameAlert = true
    }

    func codeTapped() {
        navigationDestination = true
    }

    func register() {
        Task { @MainActor in
            indicator = true

            do {
                try await merchandiseUseCase.createMerchandise(code: code, status: "needReview", name: name)
                showingSuccessAlert = true
            } catch {
                print(error)
                showingErrorAlert = true
            }

            indicator = false
        }
    }
}
