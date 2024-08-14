import Foundation

enum MyAccountNavigationDestination: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case account(profile: Profile)
}
