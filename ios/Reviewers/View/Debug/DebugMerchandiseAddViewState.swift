import UIKit

class DebugMerchandiseAddViewState: ObservableObject {
    @Published var name: String = ""
    @Published var code: String?
    @Published var codeType: CodeType?
    @Published var image: UIImage?

    @Published var indicator = false

    // Alert
    @Published var showingNameAlert = false
    @Published var showingSuccessAlert = false
    @Published var showingAlreadyRegisterdAlert = false
    @Published var showingErrorAlert = false

    // Navigation Destination
    @Published var showingSheet = false

    // Sheet
    @Published var sheet: DebugMerchandiseAddSheet?
    
    private let authUseCase = AuthUseCase()
    private let merchandiseUseCase = MerchandiseUseCase()
    private let storageRepository = StorageRepository()

    func nameTapped() {
        showingNameAlert = true
    }

    func codeTapped() {
        showingSheet = true
    }
    
    func addImageByPhoto() {
        sheet = .showImagePickerSheet
    }
    
    func imageTapped() {
        sheet = .showImageViewerSheet
    }

    func register() {
        guard let code = code else {
            // TODO: エラーハンドリング
            return
        }

        Task { @MainActor in
            indicator = true

            do {
                // すでに登録されているか調べる
                if let _ = try? await merchandiseUseCase.fetchMerchandise(code: code) {
                    // すでに登録されている
                    showingAlreadyRegisterdAlert = true
                    indicator = false
                    return
                }

                guard let codeType = codeType else {
                    return
                }

                let uid = try authUseCase.getUserId()
                
                if let image = image {
                    // 画像がある場合
                    let fileName = "\(UUID().uuidString).png"
                    try await storageRepository.uploadImageForMerchandise(image: image, fileName: fileName)
                    try await merchandiseUseCase.createMerchandise(uid: uid, code: code, codeType: codeType, name: name, image: fileName)
                } else {
                    // 画像がない場合
                    try await merchandiseUseCase.createMerchandise(uid: uid, code: code, codeType: codeType, name: name, image: "")
                }

                showingSuccessAlert = true
            } catch {
                print(error)
                showingErrorAlert = true
            }

            indicator = false
        }
    }
}
