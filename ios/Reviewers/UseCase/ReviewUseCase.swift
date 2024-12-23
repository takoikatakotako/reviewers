import Foundation

struct ReviewUseCase {
    private let firestoreRepository = FirestoreRepository()
    private let environmentRepository = EnvironmentRepository()
    private let convert = ConvertUseCaseUtils()

    func fetchNewReviews(offsetDate: Date = Date.now, limit: Int = 10) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchReviews(offsetDate: offsetDate, limit: limit)
        let storageEndpoint = environmentRepository.getStorageEndpoint()
        return firestoreReviews.map { firestoreReview in
            return convert.review(
                firestoreReview: firestoreReview,
                storageEndpoint: storageEndpoint
            )
        }
    }

    func fetchNewUserReviews(uid: String) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchNewUserReviews(uid: uid, limit: 20)
        let storageEndpoint = environmentRepository.getStorageEndpoint()
        return firestoreReviews.map { firestoreReview in
            return convert.review(
                firestoreReview: firestoreReview,
                storageEndpoint: storageEndpoint
            )
        }
    }

    func fetchMerchandiseReviews(merchandiseCode: String) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchMerchandiseReviews(merchandiseCode: merchandiseCode)
        let storageEndpoint = environmentRepository.getStorageEndpoint()
        return firestoreReviews.map { firestoreReview in
            return convert.review(
                firestoreReview: firestoreReview,
                storageEndpoint: storageEndpoint
            )
        }
    }

    func deleteReview(reviewId: String) async throws {
        try await firestoreRepository.deleteReview(reviewId: reviewId)
    }
}
