import Foundation

struct ReviewUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchNewReviews() async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchReviews(limit: 20)

        var reviews: [Review] = []
        for firestoreReview in firestoreReviews {
            let firestoreProfile: FirestoreProfile = try await firestoreRepository.fetchProfile(uid: firestoreReview.uid)
            let firestoreMerchandise = try? await firestoreRepository.fetchMerchandise(code: firestoreReview.code)
            let review = convertReview(firestoreReview: firestoreReview, firestoreProfile: firestoreProfile, firestoreMerchindise: firestoreMerchandise)
            reviews.append(review)
        }
        return reviews
    }

    func fetchNewUserReviews(uid: String) async throws -> [Review] {
        let firestoreReviews = try await firestoreRepository.fetchNewUserReviews(uid: uid, limit: 20)
        var reviews: [Review] = []
        for firestoreReview in firestoreReviews {
            let firestoreProfile: FirestoreProfile = try await firestoreRepository.fetchProfile(uid: firestoreReview.uid)
            let firestoreMerchandise = try? await firestoreRepository.fetchMerchandise(code: firestoreReview.code)
            let review = convertReview(firestoreReview: firestoreReview, firestoreProfile: firestoreProfile, firestoreMerchindise: firestoreMerchandise)
            reviews.append(review)
        }
        return reviews
    }

    func fetchReviewComments(reviewId: String) async throws -> [Comment] {
        let firestoreComments: [FirestoreComment] = try await firestoreRepository.fetchComments(reviewId: reviewId)

        var comments: [Comment] = []
        for firestoreComment in firestoreComments {
            let firestoreProfile: FirestoreProfile = try await firestoreRepository.fetchProfile(uid: firestoreComment.uid)
            let comment = convertReviewComment(firestoreComment: firestoreComment, firestoreProfile: firestoreProfile)
            comments.append(comment)
        }
        return comments
    }

    func deleteReview(reviewId: String) async throws {
        try await firestoreRepository.deleteReview(reviewId: reviewId)
    }

    private func convertReview(firestoreReview: FirestoreReview, firestoreProfile: FirestoreProfile, firestoreMerchindise: FirestoreMerchandise?) -> Review {
        let profile = convertProfile(firestoreProfile: firestoreProfile)

        let imageUrls = firestoreReview.images.map { URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(firestoreReview.uid)/\($0)") }
        let review = Review(
            id: firestoreReview.id,
            uid: firestoreReview.uid,
            profile: profile,
            code: firestoreReview.code,
            rate: firestoreReview.rate,
            comment: firestoreReview.comment,
            imageUrls: imageUrls,
            merchandise: nil,
            createdAt: firestoreReview.createdAt,
            updatedAt: firestoreReview.updatedAt
        )
        return review
    }

    private func convertReviewComment(firestoreComment: FirestoreComment, firestoreProfile: FirestoreProfile) -> Comment {
        let profile = convertProfile(firestoreProfile: firestoreProfile)

        // プロフィールがある場合
        let comment = Comment(
            id: firestoreComment.id,
            uid: firestoreComment.uid,
            comment: firestoreComment.comment,
            createdAt: firestoreComment.createdAt,
            profile: profile
        )
        return comment
    }

    private func convertProfile(firestoreProfile: FirestoreProfile) -> Profile {
        let profileImageURL =  URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(firestoreProfile.id)/profile.png")
        return Profile(
            id: firestoreProfile.id,
            nickname: firestoreProfile.nickname,
            profile: firestoreProfile.profile,
            profileImageURL: profileImageURL)
    }

    private func convertMerchindise(firestoreMerchandise: FirestoreMerchandise?) -> Merchandise? {
        guard let firestoreMerchandise = firestoreMerchandise else {
            return nil
        }
        return Merchandise(id: firestoreMerchandise.id, name: firestoreMerchandise.name)
    }
}
