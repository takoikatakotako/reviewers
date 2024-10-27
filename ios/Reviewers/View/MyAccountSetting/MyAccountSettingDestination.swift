import Foundation

enum MyAccountSettingDestination: Hashable, Identifiable {
    var id: Int {
        return self.hashValue
    }
    case changeEmail(email: String)
    case changePassword(email: String)
}

