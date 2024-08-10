import FirebaseFirestore

struct FirestoreRepository {
    // MARK: - Review Collection
    func addReview(uid: String, code: String, rate: Int, comment: String, images: [String]) async throws {
        let db = Firestore.firestore()
        try await db.collection(FirestoreReview.collectionName).addDocument(data: [
            "uid": uid,
            "deleted": false,
            "code": code,
            "rate": rate,
            "comment": comment,
            "images": images,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
        ]
        )
    }

    func addReviewComments(reviewId: String, uid: String, comment: String) async throws {
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreReview.collectionName)
            .document(reviewId)
            .collection("comments")
            .addDocument(
                data: [
                    "uid": uid,
                    "comment": comment,
                    "createdAt": FieldValue.serverTimestamp(),
                    "updatedAt": FieldValue.serverTimestamp()
                ]
            )
    }

    func fetchReviews() async throws -> [Review] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreReview.collectionName)
            .whereField("deleted", isEqualTo: false)
            .order(by: "createdAt")
            .limit(to: 30)
            .getDocuments()

        var reviews: [Review] = []
        for document in querySnapshot.documents {
            let firestoreReview = try FirestoreReview(document: document)
            let post = Review(
                id: firestoreReview.id,
                uid: firestoreReview.uid,
                userName: firestoreReview.uid,
                code: firestoreReview.code,
                rate: firestoreReview.rate,
                comment: firestoreReview.comment,
                images: firestoreReview.images,
                createdAt: firestoreReview.createdAt,
                updatedAt: firestoreReview.updatedAt
            )
            reviews.append(post)
        }
        return reviews
    }

    func fetchReviews(limit: Int = 20) async throws -> [FirestoreReview] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreReview.collectionName)
            .whereField("deleted", isEqualTo: false)
            .order(by: "createdAt")
            .limit(to: limit)
            .getDocuments()

        var firestoreReviews: [FirestoreReview] = []
        for document in querySnapshot.documents {
            let firestoreReview = try FirestoreReview(document: document)
            firestoreReviews.append(firestoreReview)
        }
        return firestoreReviews
    }

    func fetchComments(reviewId: String) async throws -> [Comment] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreReview.collectionName)
            .document(reviewId)
            .collection("comments")
            .limit(to: 30)
            .getDocuments()

        var comments: [Comment] = []
        for document in querySnapshot.documents {
            let firestoreComment = try FirestoreComment(document: document)
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
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreReview.collectionName)
            .document(reviewId)
            .setData([
                "deleted": true,
                "updatedAt": FieldValue.serverTimestamp()
            ], merge: true)
    }

    // MARK: - Profile Collection
//    func fetchProfile(uid: String) async -> Profile? {
//        let db = Firestore.firestore()
//        let querySnapshot = try? await db
//            .collection(FirestoreProfile.collectionName)
//            .document(uid)
//            .getDocument()
//        
//        guard let querySnapshot = querySnapshot else {
//            return nil
//        }
//        
//        if let firestoreProfile = try? FirestoreProfile(document: querySnapshot) {
//            return Profile(id: firestoreProfile.id, nickname: firestoreProfile.nickname)
//        }
//        return nil
//    }

    func fetchProfile(uid: String) async throws -> FirestoreProfile {
        let db = Firestore.firestore()
        let querySnapshot = try? await db
            .collection(FirestoreProfile.collectionName)
            .document(uid)
            .getDocument()

        guard let querySnapshot = querySnapshot else {
            throw ReviewersError.temp
        }
        return try FirestoreProfile(document: querySnapshot)
    }

    func setNickname(uid: String, nickname: String) async throws {
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreProfile.collectionName)
            .document(uid)
            .setData(
                [
                    "nickname": nickname,
                    "updatedAt": FieldValue.serverTimestamp()
                ]
                , merge: true)
    }
}
