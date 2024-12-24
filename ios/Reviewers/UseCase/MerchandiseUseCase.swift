import Foundation

struct MerchandiseUseCase {
    private let firestoreRepository = FirestoreRepository()
    private let environmentRepository = EnvironmentRepository()
    private let convertUseCaseUtils = ConvertUseCaseUtils()

    func fetchMerchandises() async throws -> [Merchandise] {
        let firestoreMerchandises = try await firestoreRepository.fetchMerchandises()
        let storageEndpoint = environmentRepository.getStorageEndpoint()
        return firestoreMerchandises.map { firestoreMerchandise in
            return convertUseCaseUtils.firestoreMerchandiseToMerchandise(firestoreMerchandise: firestoreMerchandise, storageEndpoint: storageEndpoint)
        }
    }

    func fetchMerchandise(code: String) async throws -> Merchandise {
        let firestoreMerchandise = try await firestoreRepository.fetchMerchandise(code: code)
        let storageEndpoint = environmentRepository.getStorageEndpoint()
        return convertUseCaseUtils.firestoreMerchandiseToMerchandise(firestoreMerchandise: firestoreMerchandise, storageEndpoint: storageEndpoint)
    }

    func createMerchandise(uid: String, code: String, codeType: CodeType, name: String) async throws {
        try await firestoreRepository.createMerchandise(uid: uid, code: code, codeType: codeType, name: name)
    }
}
