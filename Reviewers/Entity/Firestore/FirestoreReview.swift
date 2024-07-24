import FirebaseFirestore

struct FirestoreReview: Hashable {
    static let collectionName = "reviews"
    let id: String
    let uid: String
    let code: String
    let rate: Int
    let comment: String
    let images: [String]

    init(document: QueryDocumentSnapshot) throws {
        let data = document.data()
        guard
            let uid = data["uid"] as? String,
            let code = data["code"] as? String,
            let rate = data["rate"] as? Int,
            let comment = data["comment"] as? String,
            let images = data["images"] as? [String] else {
            throw ReviewersError.temp
        }
        
        

//        
//        guard
//            let uid = data["uid"] as? String,
//            let code = data["code"] as? String,
//            let rate = data["rate"] as? Int,
//            let comment = data["comment"] as? String else {
//            throw ReviewersError.temp
//        }
//        
//        let images = data["images"]
//        print(type(of: images))
//
        self.id = document.documentID
        self.uid = uid
        self.code = code
        self.rate = rate
        self.comment = comment
        self.images = []
    }

    init(id: String, uid: String, code: String, rate: Int, comment: String, images: [String]) {
        self.id = id
        self.uid = uid
        self.code = code
        self.rate = rate
        self.comment = comment
        self.images = images
    }
}
