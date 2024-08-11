import Foundation

struct ReviewUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchNewReviews() async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchReviews(limit: 20)

        var reviews: [Review] = []
        for firestoreReview in firestoreReviews {
            let firestoreProfile: FirestoreProfile? = try? await firestoreRepository.fetchProfile(uid: firestoreReview.uid)
            let review = convertReview(firestoreReview: firestoreReview, firestoreProfile: firestoreProfile)
            reviews.append(review)
        }
        return reviews
    }
    
    func fetchNewUserReviews(uid: String) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchNewUserReviews(uid: uid, limit: 20)
        var reviews: [Review] = []
        for firestoreReview in firestoreReviews {
            let firestoreProfile: FirestoreProfile? = try? await firestoreRepository.fetchProfile(uid: firestoreReview.uid)
            let review = convertReview(firestoreReview: firestoreReview, firestoreProfile: firestoreProfile)
            reviews.append(review)
        }
        return reviews
    }
    
    func fetchReviewComments(reviewId: String) async throws -> [Comment] {
        let firestoreComments: [FirestoreComment] = try await firestoreRepository.fetchComments(reviewId: reviewId)

        var comments: [Comment] = []
        for firestoreComment in firestoreComments {
            let comment = Comment(
                id: firestoreComment.id,
                uid: firestoreComment.uid,
                comment: firestoreComment.comment
            )
            comments.append(comment)
        }
        return comments
    }
    
    func deleteReview(reviewId: String) async throws {
        try await firestoreRepository.deleteReview(reviewId: reviewId)
    }

    private func convertReview(firestoreReview: FirestoreReview, firestoreProfile: FirestoreProfile?) -> Review {
        if let firestoreProfile: FirestoreProfile = firestoreProfile {
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
            return review
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
            return review
        }
    }
}
