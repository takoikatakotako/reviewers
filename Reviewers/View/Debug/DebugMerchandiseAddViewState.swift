import Foundation

class DebugMerchandiseAddViewState: ObservableObject {
    @Published var name: String = ""
    @Published var code: String = ""

    @Published var indicator = false

    // Alert
    @Published var showingNameAlert = false
    @Published var showingSuccessAlert = false
    @Published var showingAlreadyRegisterdAlert = false
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
                // すでに登録されているか調べる
                do {
                    _ = try await merchandiseUseCase.fetchMerchandise(code: code)
                    // すでに登録されている
                    showingAlreadyRegisterdAlert = true
                    indicator = false
                    return
                } catch {
                    print(error)
                }
                
                // 登録する
                try await merchandiseUseCase.createMerchandise(code: code, name: name)
                showingSuccessAlert = true
            } catch {
                print(error)
                showingErrorAlert = true
            }

            indicator = false
        }
    }
}
