import Foundation

struct ReportUseCase {
    private let firestoreRepository = FirestoreRepository()
    private let environmentRepository = EnvironmentRepository()
    private let convert = ConvertUseCaseUtils()

    func createReport(userId: String, reviewId: String, message: String) async throws {
        try await firestoreRepository.createReport(uid: userId, reviewId: reviewId, message: message)
    }
}
