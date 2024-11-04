import FirebaseStorage
import SwiftUI

struct StorageRepository {
    // MARK: - Image
    func uploadImage(uid: String, image: UIImage, fileName: String) async throws {
        // リサイズ
        let resizedImageData = try resizeImage(image: image)

        // アップロード
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("image/user/\(uid)/\(fileName)")
        _ = try await imageRef.putDataAsync(resizedImageData)
    }

    func fetchImage(uid: String, fileName: String) async throws -> UIImage? {
        // アップロード
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("image/user/\(uid)/\(fileName)")
        let url = try await imageRef.downloadURL()
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return UIImage(data: data)
    }

    // MARK: - Profile Image
    func fetchProfileImage(uid: String) async throws -> UIImage? {
        // アップロード
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("image/user/\(uid)/profile.png")
        let url = try await imageRef.downloadURL()
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return UIImage(data: data)
    }

    func uploadProfileImage(uid: String, image: UIImage) async throws {
        // リサイズ
        let resizedImageData = try resizeImage(image: image)

        // アップロード
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("image/user/\(uid)/profile.png")
        _ = try await imageRef.putDataAsync(resizedImageData)
    }

    // MARK: - Private Method
    private func resizeImage(image: UIImage) throws -> Data {
        // どちらかが 1000 以上であればリサイズ
        let originWidth = image.size.width
        let originHeight = image.size.height

        // リサイズ後のデータ
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
        return data
    }
    
    
    // MARK: - Guideline
    func fetchTeams() async throws -> String {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let teamsRef = storageRef.child("guideline/teams.md")
        let data = try await teamsRef.getData(maxSize: 100000)
        guard let text =  String(data: data, encoding: .utf8) else {
            throw ReviewersError.temp
        }
        return text
    }
    
    func fetchPrivacy() async throws -> String {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let privacyRef = storageRef.child("guideline/privacy.md")
        let data = try await privacyRef.getData(maxSize: 100000)
        guard let text =  String(data: data, encoding: .utf8) else {
            throw ReviewersError.temp
        }
        return text
    }
}

extension StorageReference {
    func getData(maxSize: Int64) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            self.getData(maxSize: maxSize) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
