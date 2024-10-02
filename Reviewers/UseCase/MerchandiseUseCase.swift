import Foundation

struct MerchandiseUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchMerchandises() async throws -> [Merchandise] {
        let firestoreMerchandises = try await firestoreRepository.fetchMerchandises()
        return firestoreMerchandises.map { firestoreMerchandise in
            return Merchandise(id: firestoreMerchandise.id, name: firestoreMerchandise.name)
        }
    }

    func fetchMerchandise(code: String) async throws -> Merchandise {
        let firestoreMerchandise = try await firestoreRepository.fetchMerchandise(code: code)
        return Merchandise(id: firestoreMerchandise.id, name: firestoreMerchandise.name)
    }

    func createMerchandise(code: String, name: String) async throws {
        try await firestoreRepository.createMerchandise(code: code, name: name)
    }
}
