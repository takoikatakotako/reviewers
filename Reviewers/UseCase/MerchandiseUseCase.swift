import Foundation

struct MerchandiseUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchMerchandise(code: String) async throws -> Merchandise {
        let firestoreMerchandise = try await firestoreRepository.fetchMerchandise(code: code)
        return Merchandise(id: firestoreMerchandise.id, name: firestoreMerchandise.name)
    }

    func createMerchandise(code: String, status: String, name: String) async throws {
        try await firestoreRepository.createMerchandise(code: code, status: status, name: name)
    }
}
