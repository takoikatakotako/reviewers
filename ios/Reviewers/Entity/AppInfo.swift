import Foundation

struct AppInfo: Decodable {
    let isMaintenance: Bool
    let requiredVersion: String
}
