import FirebaseFirestore

struct FirestoreProfile: Hashable {
    static let collectionName = "profiles"
    let id: String
    let nickname: String
    let createdAt: Date
    let updatedAt: Date

    init(document: DocumentSnapshot) {
        let data = document.data()
        self.id = document.documentID
        self.nickname = data?["nickname"] as? String ?? "ななしさん"
        self.createdAt = (data?["createdAt"] as? Timestamp)?.dateValue() ?? Date.now
        self.updatedAt = (data?["updatedAt"] as? Timestamp)?.dateValue() ?? Date.now
    }

    init(id: String, nickname: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.nickname = nickname
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
