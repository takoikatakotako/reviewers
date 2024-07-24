import FirebaseFirestore

struct FirestoreRepository {
    func addReview(uid: String, code: String, rate: Int, comment: String, images: [String]) async throws {
        let db = Firestore.firestore()
        try await db.collection(FirestoreReview.collectionName).addDocument(data: [
            "uid": uid,
            "code": code,
            "rate": rate,
            "comment": comment,
            "images": images
            ]
        )
    }

    func fetchPosts() async throws -> [Review] {
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection(FirestoreReview.collectionName).getDocuments()

        var reviews: [Review] = []
        for document in querySnapshot.documents {
            let firestorePost = try FirestoreReview(document: document)
            let post = Review(
                id: firestorePost.id,
                userName: firestorePost.uid,
                rate: firestorePost.rate,
                comment: firestorePost.comment
            )
            reviews.append(post)
        }
        return reviews
    }
}
