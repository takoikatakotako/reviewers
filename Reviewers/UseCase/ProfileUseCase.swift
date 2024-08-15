import SwiftUI

struct ProfileUseCase {
    private let firestoreRepository = FirestoreRepository()

    func fetchProfile(uid: String) async throws -> Profile {
        let firestoreProfile: FirestoreProfile = try await firestoreRepository.fetchProfile(uid: uid)
        return Profile(id: firestoreProfile.id, nickname: firestoreProfile.nickname, profile: firestoreProfile.profile)
    }

    func setProfile(uid: String, nickname: String? = nil, profile: String? = nil) async throws {
        try await firestoreRepository.setProfile(uid: uid, nickname: nickname, profile: profile)
    }
}
