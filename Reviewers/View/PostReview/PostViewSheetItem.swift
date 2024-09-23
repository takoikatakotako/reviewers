import SwiftUI

enum PostViewSheetItem: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }

    case showImagePickerSheet
    case showImageViewerSheet(UIImage)
    case showBarcodeScannerSheet
    case showCameraSheet
}
