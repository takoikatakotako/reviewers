import Foundation

class PostViewState: ObservableObject {
    @Published var text = ""
    @Published var barcode = ""
    @Published var rate = 5
    
    func barcodeTapped() {
        
    }
    
    func updateRate(rate: Int) {
        self.rate = rate
    }
    
    func addImage() {
        
    }
    
}
