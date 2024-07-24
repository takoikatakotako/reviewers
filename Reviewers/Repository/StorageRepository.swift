import FirebaseStorage
import SwiftUI

struct StorageRepository {

    func uploadImage(uid: String, image: UIImage, fileName: String) async throws {
        // どちらかが 1000 以上であればリサイズ
        let originWidth = image.size.width
        let originHeight = image.size.height

        // リサイズ後
        let data: Data

        if 1000 < originWidth || 1000 < originHeight {
            // リサイズを行う
            let resizedSize: CGSize
            if originWidth < originHeight {
                // 縦長の場合
                resizedSize = CGSize(width: 1000 * originWidth / originHeight, height: 1000)
            } else {
                // 横長の場合
                resizedSize = CGSize(width: 1000, height: 1000 * originHeight / originWidth)
            }
            UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: resizedSize))
            let resizedImageData = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            guard let resizedData = resizedImageData?.pngData() else {
                throw ReviewersError.temp
            }
            data = resizedData
        } else {
            // リサイズしない場合
            guard let imageData = image.pngData() else {
                throw ReviewersError.temp
            }
            data = imageData
        }

        // アップロード
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("image/user/\(uid)/\(fileName)")
        _ = try await imageRef.putDataAsync(data)
    }
}
