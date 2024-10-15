struct ConvertUseCaseUtils {
    func firestoreMerchandiseToMerchandise(firestoreMerchandise: FirestoreMerchandise) -> Merchandise {
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

        return Merchandise(
            id: firestoreMerchandise.id,
            enable: firestoreMerchandise.enable,
            status: status,
            name: firestoreMerchandise.name,
            code: firestoreMerchandise.code,
            codeType: codeType,
            image: firestoreMerchandise.image,
            imageReferenceReviewId: firestoreMerchandise.imageReferenceReviewId,
            createdAt: firestoreMerchandise.createdAt,
            updatedAt: firestoreMerchandise.updatedAt
        )
    }
}
