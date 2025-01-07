import SwiftUI

enum DebugMerchandiseAddSheet: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }

    case showImagePickerSheet
    case showImageViewerSheet
}
