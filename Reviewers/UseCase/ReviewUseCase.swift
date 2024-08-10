import Foundation

struct ReviewUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchNewReviews() async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchReviews(limit: 20)

        var reviews: [Review] = []
        for firestoreReview in firestoreReviews {
            if let firestoreProfile: FirestoreProfile = try? await firestoreRepository.fetchProfile(uid: firestoreReview.uid) {
                // プロフィールがある場合
                let review = Review(
                    id: firestoreReview.id,
                    uid: firestoreReview.uid,
                    userName: firestoreProfile.nickname,
                    code: firestoreReview.code,
                    rate: firestoreReview.rate,
                    comment: firestoreReview.comment,
                    images: firestoreReview.images,
                    createdAt: firestoreReview.createdAt,
                    updatedAt: firestoreReview.updatedAt
                )
                reviews.append(review)
            } else {
                // プロフィールがない場合
                let review = Review(
                    id: firestoreReview.id,
                    uid: firestoreReview.uid,
                    userName: Profile.initialNickname,
                    code: firestoreReview.code,
                    rate: firestoreReview.rate,
                    comment: firestoreReview.comment,
                    images: firestoreReview.images,
                    createdAt: firestoreReview.createdAt,
                    updatedAt: firestoreReview.updatedAt
                )
                reviews.append(review)
            }
        }
        return reviews
    }
}
