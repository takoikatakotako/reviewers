import Foundation

enum StudyViewCover: Identifiable, Hashable {
    var id: Int {
        return self.hashValue
    }
    
    case image(imageName: String)
}
