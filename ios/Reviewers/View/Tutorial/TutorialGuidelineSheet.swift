import Foundation

enum TutorialGuidelineSheet: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case teams(String)
    case privacy(String)
}
