import SwiftUI

class PostViewState: ObservableObject {
    @Published var text = ""
    @Published var code = ""
    @Published var rate = 5
    @Published var images: [UIImage] = []
    
    @Published var merchandiseName = ""
    
    @Published var indicator = true
    
    
    

    // Alert
    @Published var showingPostCompleteAlert: Bool = false
    @Published var showingMessageAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showingRegisterMerchandiseAlert: Bool = false
    @Published var showingRegisterMerchandiseCompleteAlert: Bool = false
    
    // Sheet
    @Published var sheet: PostViewSheetItem?

    private let firestoreRepository = FirestoreRepository()
    private let authRepository = AuthRepository()
    private let storageRepository = StorageRepository()
    private let merchandiseUseCase = MerchandiseUseCase()

    
    func barcodeTapped() {
        sheet = .showBarcodeScannerSheet
    }

    func updateRate(rate: Int) {
        self.rate = rate
    }

    func imageTapped(image: UIImage) {
        sheet = .showImageViewerSheet(image)
    }

    func addImage() {
        sheet = .showImagePickerSheet
    }

    func post() {
        guard let user = authRepository.getUser() else {
            return
        }

        // コードが空の場合はアラート
        if code.isEmpty {
            alertMessage = "バーコードをスキャンしてください"
            showingMessageAlert = true
            return
        }

        // レートを検証
        guard 1 <= rate && rate <= 5 else {
            alertMessage = "バーコードをスキャンしてください"
            showingMessageAlert = true
            return
        }

        // コメントを検証
        if 200 < text.count {
            alertMessage = "200文字以内で入力してください"
            showingMessageAlert = true
            return
        }

        Task { @MainActor in
            indicator = true
            
            do {
                // 画像の処理
                var fileNames: [String] = []
                for image in images {
                    let fileName = "\(UUID().uuidString).png"
                    try await storageRepository.uploadImage(uid: user.uid, image: image, fileName: fileName)
                    fileNames.append(fileName)
                }
                try await firestoreRepository.addReview(uid: user.uid, code: code, rate: rate, comment: text, images: fileNames)
                
                // すでに商品があるか調査
                let merchandise = try? await merchandiseUseCase.fetchMerchandise(code: code)
                if merchandise != nil {
                    showingPostCompleteAlert = true
                } else {
                    showingRegisterMerchandiseAlert = true
                }
            } catch {
                print(error)
                alertMessage = "エラー: \(error.localizedDescription)"
                showingMessageAlert = true
                return
            }
            
            indicator = false
        }
    }
    
    
    func registerMerchandise() {
        Task { @MainActor in
            do {
                try await merchandiseUseCase.createMerchandise(code: code, status: "xxx", name: merchandiseName)
            } catch {
                print(error)
            }
        }
    }
}
