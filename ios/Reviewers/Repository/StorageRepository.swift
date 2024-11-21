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
        let resizedImageData = image.resized(maxEdgeLength: 500)
        guard let resizedData = resizedImageData.pngData() else {
            throw ReviewersError.temp
        }
        return resizedData
    }

    // MARK: - Guideline
    func fetchTeams() async throws -> String {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let teamsRef = storageRef.child("guideline/teams.md")
        let data = try await teamsRef.getData(maxSize: 2 * 1024 * 1024)
        guard let text =  String(data: data, encoding: .utf8) else {
            throw ReviewersError.temp
        }
        return text
    }

    func fetchPrivacy() async throws -> String {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let privacyRef = storageRef.child("guideline/privacy.md")
        let data = try await privacyRef.getData(maxSize: 2 * 1024 * 1024)
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
