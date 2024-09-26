import Foundation

struct ReviewUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchNewReviews() async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchReviews(limit: 20)
        return firestoreReviews.map { firestoreReview in
            let imageUrls = firestoreReview.images.map { URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(firestoreReview.uid)/\($0)") }
            return Review(
                id: firestoreReview.id,
                uid: firestoreReview.uid,
                code: firestoreReview.code,
                rate: firestoreReview.rate,
                comment: firestoreReview.comment,
                imageUrls: imageUrls,
                createdAt: firestoreReview.createdAt,
                updatedAt: firestoreReview.updatedAt)
        }
    }
}
