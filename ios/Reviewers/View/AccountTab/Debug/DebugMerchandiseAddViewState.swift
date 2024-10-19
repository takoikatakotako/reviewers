import Foundation

class DebugMerchandiseAddViewState: ObservableObject {
    @Published var name: String = ""
    @Published var code: String = ""
    @Published var codeType: CodeType?

    @Published var indicator = false

    // Alert
    @Published var showingNameAlert = false
    @Published var showingSuccessAlert = false
    @Published var showingAlreadyRegisterdAlert = false
    @Published var showingErrorAlert = false

    // Navigation Destination
    @Published var navigationDestination = false

    private let authUseCase = AuthUseCase()
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
                if let merchandise = try? await merchandiseUseCase.fetchMerchandise(code: code) {
                    // すでに登録されている
                    showingAlreadyRegisterdAlert = true
                    indicator = false
                    return
                }

                guard let codeType = codeType else {
                    return
                }

                let uid = try authUseCase.getUserId()
                
                // 登録する
                try await merchandiseUseCase.createMerchandise(uid: uid, code: code, codeType: codeType, name: name)
                showingSuccessAlert = true
            } catch {
                print(error)
                showingErrorAlert = true
            }

            indicator = false
        }
    }
}
