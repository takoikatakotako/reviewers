import SwiftUI

class PostViewState: ObservableObject {
    @Published var text = ""
    @Published var barcode = ""
    @Published var rate = 5
    @Published var images: [UIImage] = []
    
    @Published var sheet: PostViewSheetItem?
    
    func barcodeTapped() {
        
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
