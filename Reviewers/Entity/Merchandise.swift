import Foundation

struct Merchandise: Identifiable, Hashable {
    let id: String
    let status: String
    let name: String

    var code: String {
        return id
    }
}
