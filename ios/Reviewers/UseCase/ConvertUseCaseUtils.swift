import Foundation

struct ConvertUseCaseUtils {
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
            enable: firestoreMerchandise.enable,
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
