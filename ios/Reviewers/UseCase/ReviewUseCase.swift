import Foundation

struct ReviewUseCase {
    private let firestoreRepository = FirestoreRepository()
    private let environmentRepository = EnvironmentRepository()
    private let convert = ConvertUseCaseUtils()

    func fetchNewReviews(offsetDate: Date = Date.now, limit: Int = 10) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchReviews(offsetDate: offsetDate, limit: limit)
        let baseImageUrlString = environmentRepository.getImageBaseUrlString()
        return firestoreReviews.map { firestoreReview in
            return convert.review(
                firestoreReview: firestoreReview,
                baseImageUrlString: baseImageUrlString
            )
        }
    }

    func fetchNewUserReviews(uid: String) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchNewUserReviews(uid: uid, limit: 20)
        let baseImageUrlString = environmentRepository.getImageBaseUrlString()
        return firestoreReviews.map { firestoreReview in
            return convert.review(
                firestoreReview: firestoreReview,
                baseImageUrlString: baseImageUrlString
            )
        }
    }

    func fetchMerchandiseReviews(merchandiseCode: String) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchMerchandiseReviews(merchandiseCode: merchandiseCode)
        let baseImageUrlString = environmentRepository.getImageBaseUrlString()
        return firestoreReviews.map { firestoreReview in
            return convert.review(
                firestoreReview: firestoreReview,
                baseImageUrlString: baseImageUrlString
            )
        }
    }

    func deleteReview(reviewId: String) async throws {
        try await firestoreRepository.deleteReview(reviewId: reviewId)
    }
}
