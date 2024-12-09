import Foundation

struct ConvertUseCaseUtils {

    func review(firestoreReview: FirestoreReview, baseImageUrlString: String) -> Review {
        let imageUrls = firestoreReview.images.compactMap { URL(string: "\(baseImageUrlString)/image/user/\(firestoreReview.uid)/\($0)") }
        return Review(
            id: firestoreReview.id,
            uid: firestoreReview.uid,
            deleted: firestoreReview.deleted,
            code: firestoreReview.code,
            codeType: .ean13,
            comment: firestoreReview.comment,
            imageUrls: imageUrls,
            rate: firestoreReview.rate,
            createdAt: firestoreReview.createdAt,
            updatedAt: firestoreReview.updatedAt
        )
    }

    func firestoreMerchandiseToMerchandise(firestoreMerchandise: FirestoreMerchandise, baseImageUrlString: String) -> Merchandise {
        let status: MerchandiseStatus
        switch firestoreMerchandise.status {
        case .waitingForReview:
            status = .waitingForReview
        case .reviewComplete:
            status = .reviewComplete
        }

        let codeType: CodeType
        switch firestoreMerchandise.codeType {
        case .ean13:
            codeType = .ean13
        case .ean8:
            codeType = .ean8
        }

        let imageURL: URL?
        if firestoreMerchandise.image.isNotEmpty {
            imageURL = URL(string: baseImageUrlString + "image/merchandise/" + firestoreMerchandise.image)
        } else {
            imageURL = nil
        }

        return Merchandise(
            id: firestoreMerchandise.id,
            deleted: firestoreMerchandise.deleted,
            status: status,
            name: firestoreMerchandise.name,
            code: firestoreMerchandise.code,
            codeType: codeType,
            image: firestoreMerchandise.image,
            imageURL: imageURL,
            imageReferenceReviewId: firestoreMerchandise.imageReferenceReviewId,
            createdAt: firestoreMerchandise.createdAt,
            updatedAt: firestoreMerchandise.updatedAt
        )
    }

}
