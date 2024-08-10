import FirebaseFirestore

struct FirestoreProfile: Hashable {
    static let collectionName = "profiles"
    let id: String
    let nickname: String
    let createdAt: Date
    let updatedAt: Date

//    init(document: DocumentSnapshot) {
//        let data = document.data()
//        self.id = document.documentID
//        self.nickname = data?["nickname"] as? String ?? "ななしさん"
//        self.createdAt = (data?["createdAt"] as? Timestamp)?.dateValue() ?? Date.now
//        self.updatedAt = (data?["updatedAt"] as? Timestamp)?.dateValue() ?? Date.now
//    }

    init(document: DocumentSnapshot) throws {
        guard
            let data = document.data(),
            let nickname = data["nickname"] as? String,
            let createdAt = (data["createdAt"] as? Timestamp)?.dateValue(),
            let updatedAt = (data["updatedAt"] as? Timestamp)?.dateValue() else {
            throw ReviewersError.temp
        }
        self.id = document.documentID
        self.nickname = nickname
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(id: String, nickname: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.nickname = nickname
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
