import Foundation
import FirebaseAuth

struct GuidelineUseCase {
    private let storageRepository = StorageRepository()

    func fetchTeams() async throws -> String {
        return try await storageRepository.fetchTeams()
    }
    
    func fetchPrivacy() async throws -> String {
        return try await storageRepository.fetchPrivacy()
    }
}
