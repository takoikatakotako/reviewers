import Foundation

struct EnvironmentRepository {
    private let STORAGE_ENDPOINT = "STORAGE_ENDPOINT"

    func getStorageEndpoint() -> String {
        guard let storageEndpoint =  Bundle.main.infoDictionary?[STORAGE_ENDPOINT] as? String else {
            fatalError("\(STORAGE_ENDPOINT) is not found")
        }
        return storageEndpoint
    }
}
