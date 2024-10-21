import Foundation

struct ReviewUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchNewReviews() async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchReviews(limit: 20)
        return firestoreReviews.map { firestoreReview in
            let imageUrls = firestoreReview.images.compactMap { URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(firestoreReview.uid)/\($0)") }
            return Review(
                id: firestoreReview.id,
                uid: firestoreReview.uid,
                deleted: firestoreReview.deleted,
                code: firestoreReview.code,
                codeType: .ean13,
                comment: firestoreReview.comment,
                imageUrls: imageUrls,
                rate: firestoreReview.rate,
                createdAt: firestoreReview.createdAt,
                updatedAt: firestoreReview.updatedAt
            )
        }
    }

    func fetchNewUserReviews(uid: String) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchNewUserReviews(uid: uid, limit: 20)
        return firestoreReviews.map { firestoreReview in
            let imageUrls = firestoreReview.images.compactMap { URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(firestoreReview.uid)/\($0)") }
            return Review(
                id: firestoreReview.id,
                uid: firestoreReview.uid,
                deleted: firestoreReview.deleted,
                code: firestoreReview.code,
                codeType: .ean13,
                comment: firestoreReview.comment,
                imageUrls: imageUrls,
                rate: firestoreReview.rate,
                createdAt: firestoreReview.createdAt,
                updatedAt: firestoreReview.updatedAt
            )
        }
    }
}
