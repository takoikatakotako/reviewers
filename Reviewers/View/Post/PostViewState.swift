import SwiftUI

class PostViewState: ObservableObject {
    @Published var text = ""
    @Published var code = ""
    @Published var rate = 5
    @Published var images: [UIImage] = []

    @Published var sheet: PostViewSheetItem?

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

}
