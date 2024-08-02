import SwiftUI
import FirebaseAuth

class AccountSettingViewState: ObservableObject {
    @Published var accoundID: String = ""
    @Published var nickname: String = ""
    @Published var profileImage: UIImage?
    @Published var email: String = ""

    @Published var xx: Bool?

    @Published var nicknameAlert = false
    @Published var imagePickerSheet = false

    private let authRepository = AuthRepository()
    private let firestoreRepository = FirestoreRepository()
    private let storageRepository = StorageRepository()

    func onAppear() {
        guard let user = Auth.auth().currentUser else {
            // TODO: エラーハンドリング
            return
        }
        self.accoundID = user.uid
        self.email = user.email ?? ""

        Task { @MainActor in
            do {
                let profile: Profile = await firestoreRepository.fetchProfile(uid: user.uid) ?? Profile.initialValue(uid: user.uid)
                self.nickname = profile.nickname

                let image = try await storageRepository.fetchProfileImage(uid: user.uid)
                self.profileImage = image
            } catch {
                print(error)
            }
        }
    }

    func updateNickname() {
        guard let uid = Auth.auth().currentUser?.uid else {
            // TODO: エラーハンドリング
            return
        }

        Task { @MainActor in
            do {
                try await firestoreRepository.setNickname(uid: uid, nickname: nickname)
            } catch {
                // TODO: エラーハンドリング
                print(error)
            }
        }
    }

    func updateProfileImage() {
        imagePickerSheet = true
    }

    func selectProfileImageComplete() {
        guard
            let image = profileImage,
            let uid = Auth.auth().currentUser?.uid
        else {
            return
        }

        Task { @MainActor in
            do {
                try await storageRepository.uploadProfileImage(uid: uid, image: image)
            } catch {
                print(error)
            }
        }
    }

    func signOut() {

    }
}
