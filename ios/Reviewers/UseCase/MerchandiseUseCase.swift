import Foundation

struct MerchandiseUseCase {
    private let firestoreRepository = FirestoreRepository()
    private let convertUseCaseUtils = ConvertUseCaseUtils()

    func fetchMerchandises() async throws -> [Merchandise] {
        let firestoreMerchandises = try await firestoreRepository.fetchMerchandises()
        return firestoreMerchandises.map { firestoreMerchandise in
            return convertUseCaseUtils.firestoreMerchandiseToMerchandise(firestoreMerchandise: firestoreMerchandise)
        }
    }

    func fetchMerchandise(code: String) async throws -> Merchandise {
        let firestoreMerchandise = try await firestoreRepository.fetchMerchandise(code: code)
        return convertUseCaseUtils.firestoreMerchandiseToMerchandise(firestoreMerchandise: firestoreMerchandise)
    }

    func createMerchandise(code: String, codeType: CodeType, name: String) async throws {
        try await firestoreRepository.createMerchandise(code: code, codeType: codeType, name: name)
    }

}
