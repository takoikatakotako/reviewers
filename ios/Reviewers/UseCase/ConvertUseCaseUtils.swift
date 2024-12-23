import Foundation

struct ConvertUseCaseUtils {
    func review(firestoreReview: FirestoreReview, storageEndpoint: String) -> Review {
        return Review(
            id: firestoreReview.id,
            uid: firestoreReview.uid,
            deleted: firestoreReview.deleted,
            code: firestoreReview.code,
            codeType: .ean13,
            comment: firestoreReview.comment,
            images: firestoreReview.images,
            rate: firestoreReview.rate,
            createdAt: firestoreReview.createdAt,
            updatedAt: firestoreReview.updatedAt,
            storageEndpoint: storageEndpoint
        )
    }

    func firestoreMerchandiseToMerchandise(firestoreMerchandise: FirestoreMerchandise, storageEndpoint: String) -> Merchandise {
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
            imageURL = URL(string: storageEndpoint + "/image/merchandise/" + firestoreMerchandise.image)
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
