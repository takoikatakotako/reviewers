import SwiftUI

struct ProfileUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchProfile(uid: String) async throws -> Profile {
        let firestoreProfile: FirestoreProfile = try await firestoreRepository.fetchProfile(uid: uid)
        let profileImageURL =  URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(firestoreProfile.id)/profile.png")
        return Profile(
            id: firestoreProfile.id,
            nickname: firestoreProfile.nickname,
            profile: firestoreProfile.profile,
            profileImageURL: profileImageURL)
    }

    func setProfile(uid: String, nickname: String? = nil, profile: String? = nil) async throws {
        try await firestoreRepository.setProfile(uid: uid, nickname: nickname, profile: profile)
    }
}
