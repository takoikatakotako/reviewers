import SwiftUI

class PostReviewViewState: ObservableObject {
    @Published var comment = ""
    @Published var code = ""
    @Published var codeType: CodeType?
    @Published var rate = 5
    @Published var images: [UIImage] = []

    @Published var merchandiseName = ""

    // Indicator
    @Published var indicator = false

    // Alert
    @Published var showingPostCompleteAlert: Bool = false
    @Published var showingMessageAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showingRegisterMerchandiseAlert: Bool = false
    @Published var showingRegisterMerchandiseCompleteAlert: Bool = false

    // Sheet
    @Published var sheet: PostViewSheetItem?

    // Repository
    private let firestoreRepository = FirestoreRepository()
    private let authUseCase = AuthUseCase()
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

    func addImageByPhoto() {
        sheet = .showImagePickerSheet
    }

    func addImageByCamera() {
        sheet = .showCameraSheet
    }

    func post() {
        guard let user = authUseCase.getUser() else {
            return
        }

        // コードが空の場合はアラート
        if code.isEmpty {
            alertMessage = "バーコードをスキャンしてください"
            showingMessageAlert = true
            return
        }

        // コードタイプが空の場合はアラート
        guard let codeType = codeType else {
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
        if 200 < comment.count {
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
                try await firestoreRepository.addReview(
                    uid: user.uid,
                    code: code,
                    codeType: codeType,
                    comment: comment,
                    images: fileNames,
                    rate: rate
                )

                // すでに商品があるか調査
                let merchandise = try? await merchandiseUseCase.fetchMerchandise(code: code)
                if merchandise != nil {
                    showingPostCompleteAlert = true
                } else {
                    showingRegisterMerchandiseAlert = true
                }
            } catch {
                print(error, "\(Self.self)")
                alertMessage = "エラー: \(error.localizedDescription)"
                showingMessageAlert = true
                return
            }

            indicator = false
        }
    }

    func registerMerchandise() {
        guard let codeType = codeType else {
            return
        }

        Task { @MainActor in
            do {
                let uid = try authUseCase.getUserId()
                try await merchandiseUseCase.createMerchandise(uid: uid, code: code, codeType: codeType, name: merchandiseName)
                showingRegisterMerchandiseCompleteAlert = true
            } catch {
                print(error)
            }
        }
    }
}
