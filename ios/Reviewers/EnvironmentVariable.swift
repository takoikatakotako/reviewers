import Foundation

struct EnvironmentVariable {
    static let shared = EnvironmentVariable()

    private init() {}

    var GoogleStorageBaseUrl: String = "https://storage.googleapis.com/reviewers-develop.appspot.com"
}
