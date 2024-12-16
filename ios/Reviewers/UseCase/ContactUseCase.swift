import Foundation

struct ContactUseCase {
    private let firestoreRepository = FirestoreRepository()
    private let environmentRepository = EnvironmentRepository()
    private let convert = ConvertUseCaseUtils()
        
    func createContact(uid: String, email: String, message: String) async throws {
        try await firestoreRepository.createContact(
            uid: uid,
            email: email,
            message: message
        )
    }
}
