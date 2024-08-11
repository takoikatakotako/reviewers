import FirebaseFirestore

struct FirestoreRepository {
    // MARK: - Review Collection
    func addReview(uid: String, code: String, rate: Int, comment: String, images: [String]) async throws {
        let db = Firestore.firestore()
        try await db.collection(FirestoreReview.collectionName).addDocument(data: [
            FirestoreReview.uidField: uid,
            FirestoreReview.deletedField: false,
            FirestoreReview.codeField: code,
            FirestoreReview.rateField: rate,
            FirestoreReview.commentField: comment,
            FirestoreReview.imagesField: images,
            FirestoreReview.createdAtField: FieldValue.serverTimestamp(),
            FirestoreReview.updatedAtField: FieldValue.serverTimestamp()
        ]
        )
    }
    
    func addReviewComments(reviewId: String, uid: String, comment: String) async throws {
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreReview.collectionName)
            .document(reviewId)
            .collection(FirestoreComment.collectionName)
            .addDocument(
                data: [
                    FirestoreComment.uidField: uid,
                    FirestoreComment.commentField: comment,
                    FirestoreComment.createdAtField: FieldValue.serverTimestamp(),
                    FirestoreComment.updatedAtField: FieldValue.serverTimestamp()
                ]
            )
    }
    
    func fetchReviews(limit: Int = 20) async throws -> [FirestoreReview] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreReview.collectionName)
            .whereField(FirestoreReview.deletedField, isEqualTo: false)
            .order(by: FirestoreReview.createdAtField)
            .limit(to: limit)
            .getDocuments()
        
        var firestoreReviews: [FirestoreReview] = []
        for document in querySnapshot.documents {
            let firestoreReview = try FirestoreReview(document: document)
            firestoreReviews.append(firestoreReview)
        }
        return firestoreReviews
    }
    
    func fetchNewUserReviews(uid: String, limit: Int = 20) async throws -> [FirestoreReview] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreReview.collectionName)
            .whereField(FirestoreReview.uidField, isEqualTo: uid)
            .whereField(FirestoreReview.deletedField, isEqualTo: false)
            .order(by: FirestoreReview.createdAtField)
            .limit(to: limit)
            .getDocuments()
        
        var firestoreReviews: [FirestoreReview] = []
        for document in querySnapshot.documents {
            let firestoreReview = try FirestoreReview(document: document)
            firestoreReviews.append(firestoreReview)
        }
        return firestoreReviews
    }
    
    func fetchComments(reviewId: String) async throws -> [FirestoreComment] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreReview.collectionName)
            .document(reviewId)
            .collection(FirestoreComment.collectionName)
            .limit(to: 30)
            .getDocuments()
        
        var comments: [FirestoreComment] = []
        for document in querySnapshot.documents {
            let firestoreComment = try FirestoreComment(document: document)
            comments.append(firestoreComment)
        }
        return comments
    }
    
    func deleteReview(reviewId: String) async throws {
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreReview.collectionName)
            .document(reviewId)
            .setData([
                FirestoreReview.deletedField: true,
                FirestoreReview.updatedAtField: FieldValue.serverTimestamp()
            ], merge: true)
    }
    
    // MARK: - Profile Collection
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
                    FirestoreProfile.nicknameField: nickname,
                    FirestoreProfile.updatedAtField: FieldValue.serverTimestamp()
                ]
                , merge: true)
    }
}
