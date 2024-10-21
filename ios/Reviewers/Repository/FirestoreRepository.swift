import FirebaseFirestore

struct FirestoreRepository {
    // MARK: - Review Collection
    func addReview(uid: String, code: String, codeType: CodeType, comment: String, images: [String], rate: Int) async throws {
        let db = Firestore.firestore()
        try await db.collection(FirestoreReview.collectionName).addDocument(data: [
            FirestoreReview.uidField: uid,
            FirestoreReview.deletedField: false,
            FirestoreReview.codeField: code,
            FirestoreReview.codeTypeField: codeType.rawValue,
            FirestoreReview.commentField: comment,
            FirestoreReview.imagesField: images,
            FirestoreReview.rateField: rate,
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

    func fetchMerchandiseReviews(merchandise: Merchandise, limit: Int = 20) async throws -> [FirestoreReview] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreReview.collectionName)
            .whereField(FirestoreReview.codeField, isEqualTo: merchandise.id)
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

    func createProfile(uid: String, nickname: String, profile: String) async throws {
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreProfile.collectionName)
            .document(uid)
            .setData(
                [
                    FirestoreProfile.nicknameField: nickname,
                    FirestoreProfile.profileField: profile,
                    FirestoreProfile.createdAtField: FieldValue.serverTimestamp(),
                    FirestoreProfile.updatedAtField: FieldValue.serverTimestamp()
                ]
            )
    }

    func profileDocumentExists(uid: String) async throws -> Bool {
        let db = Firestore.firestore()
        let querySnapshot = try? await db
            .collection(FirestoreProfile.collectionName)
            .document(uid)
            .getDocument()
        guard let document = querySnapshot else {
            throw ReviewersError.temp
        }
        return document.exists
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
                , merge: true
            )
    }

    func setProfile(uid: String, nickname: String? = nil, profile: String? = nil) async throws {
        if nickname == nil && profile == nil {
            throw ReviewersError.temp
        }

        var data: [String: Any] = [:]

        if let nickname = nickname {
            data[FirestoreProfile.nicknameField] = nickname
        }

        if let profile = profile {
            data[FirestoreProfile.profileField] = profile
        }

        let db = Firestore.firestore()
        try await db
            .collection(FirestoreProfile.collectionName)
            .document(uid)
            .setData(data, merge: true)
    }

    // MARK: - Blocks Collection
    func fetchBlockedUsers(uid: String) async throws -> [FirestoreBlockedUser] {
        let db = Firestore.firestore()
        let querySnapshot = try? await db
            .collection(FirestoreBlockedUser.collectionName)
            .whereField(FirestoreBlockedUser.uidField, isEqualTo: uid)
            .limit(to: 20)
            .getDocuments()
        guard let querySnapshot = querySnapshot else {
            throw ReviewersError.temp
        }

        var firestoreBlockedUsers: [FirestoreBlockedUser] = []
        for document in querySnapshot.documents {
            let firestoreBlockedUser = try FirestoreBlockedUser(document: document)
            firestoreBlockedUsers.append(firestoreBlockedUser)
        }
        return firestoreBlockedUsers
    }

    func createBlockedUser(uid: String, blockedUserId: String) async throws {
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreBlockedUser.collectionName)
            .addDocument(data: [
                FirestoreBlockedUser.enableField: true,
                FirestoreBlockedUser.uidField: uid,
                FirestoreBlockedUser.blockedUserIdField: blockedUserId,
                FirestoreProfile.createdAtField: FieldValue.serverTimestamp(),
                FirestoreProfile.updatedAtField: FieldValue.serverTimestamp()
            ])
    }

    // MARK: - Merchandise Collection
    func fetchMerchandises(limit: Int = 20) async throws -> [FirestoreMerchandise] {
        let db = Firestore.firestore()
        let querySnapshot = try await db
            .collection(FirestoreMerchandise.collectionName)
            .limit(to: limit)
            .getDocuments()

        var firestoreMerchandises: [FirestoreMerchandise] = []
        for document in querySnapshot.documents {
            let firestoreMerchandise = try FirestoreMerchandise(document: document)
            firestoreMerchandises.append(firestoreMerchandise)
        }
        return firestoreMerchandises
    }

    func fetchMerchandise(code: String) async throws -> FirestoreMerchandise {
        let db = Firestore.firestore()
        let querySnapshot = try? await db
            .collection(FirestoreMerchandise.collectionName)
            .document(code)
            .getDocument()

        guard let querySnapshot = querySnapshot else {
            throw ReviewersError.temp
        }
        return try FirestoreMerchandise(document: querySnapshot)
    }

    func createMerchandise(uid: String, code: String, codeType: CodeType, name: String) async throws {
        let db = Firestore.firestore()
        try await db
            .collection(FirestoreMerchandise.collectionName)
            .addDocument(data: [
                FirestoreMerchandise.enableField: true,
                FirestoreMerchandise.statusField: FirestoreMerchandiseStatus.waitingForReview.rawValue,
                FirestoreMerchandise.nameField: name,
                FirestoreMerchandise.codeField: code,
                FirestoreMerchandise.codeTypeField: codeType.rawValue,
                FirestoreMerchandise.imageField: "",
                FirestoreMerchandise.imageRefarenceReviewIdField: "",
                FirestoreMerchandise.createdAtField: FieldValue.serverTimestamp(),
                FirestoreMerchandise.createdUid: uid,
                FirestoreMerchandise.updatedAtField: FieldValue.serverTimestamp(),
                FirestoreMerchandise.updatedUid: uid
            ]
        )
    }
}
