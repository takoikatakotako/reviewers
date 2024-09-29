import Foundation

enum ReviewSearchNavigationDestination: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case reviewSearchDetail(merchandise: Merchandise)
}
