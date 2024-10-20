import SwiftUI
import FirebaseAuth
import SDWebImage

class MyAccountSettingViewState: ObservableObject {
    @Published var uid: String = ""
    @Published var isAnonymousUser = true
    @Published var email: String = ""
    @Published var nickname: String = ""
    @Published var newNickname: String = ""
    @Published var profile: String = ""
    @Published var profileImage: UIImage?

    // Flug
    @Published var isFirstOnAppear = true
    @Published var showingIndicator = false

    // Navigation Destination
    @Published var changeProfileNaviagtionDestination: Bool = false

    // Alert
    @Published var nicknameAlert = false
    @Published var errorAlert = false

    // Sheet
    @Published var imagePickerSheet = false

    private let storageRepository = StorageRepository()
    private let profileUseCase = ProfileUseCase()
    private let authUseCase = AuthUseCase()

    func onAppear() {
        guard isFirstOnAppear else {
            return
        }

        Task { @MainActor in
            do {
                let uid = try authUseCase.getUserId()
                self.uid = uid
                self.isAnonymousUser = try authUseCase.isAnonymousUser()
                self.email = authUseCase.getEmail() ?? "unknown"
//                let profile: Profile = try await profileUseCase.fetchProfile(uid: uid)
//                self.nickname = profile.nickname
//                self.profile = profile.profile
//                let image = try? await storageRepository.fetchProfileImage(uid: uid)
//                self.profileImage = image
            } catch {
                print(error)
                errorAlert = true
            }

            self.isFirstOnAppear = false
        }
    }

    // MARK: - Nickname
    func nicknameTapped() {
        newNickname = nickname
        nicknameAlert = true
    }

    func updateNickname() {
        nickname = newNickname
    }

    // MARK: - Profile
    func profileTapped() {
        changeProfileNaviagtionDestination = true
    }

    // MARK: - Profile Image
    func updateProfileImage() {
        imagePickerSheet = true
    }

    // MARK: - Email
    func emailTapped() {
        // newNickname = nickname
        // nicknameAlert = true
    }

    func updateEmail() {
        // nickname = newNickname
    }

    // MARK: - Password
    func passwordTapped() {
        // newNickname = nickname
        // nicknameAlert = true
    }

    func updatePassword() {
        // nickname = newNickname
    }

    func selectProfileImageComplete() {
        Task { @MainActor in
            do {
                guard let image = profileImage else {
                    return
                }
                let uid = try authUseCase.getUserId()
                try await storageRepository.uploadProfileImage(uid: uid, image: image)
            } catch {
                print(error)
                errorAlert = true
            }
        }
    }

    // MARK: - XXX
    func update() {
        Task { @MainActor in
            showingIndicator = true

            do {
                let uid = try authUseCase.getUserId()
                try await profileUseCase.setProfile(uid: uid, nickname: nickname, profile: profile)

                if let image = profileImage {
                    try await storageRepository.uploadProfileImage(uid: uid, image: image)

                    // キャッシュ削除
                    let key = Profile.profileImageURL(uid: uid).description
                    SDImageCache.shared.removeImageFromDisk(forKey: key)
                    SDImageCache.shared.removeImageFromMemory(forKey: key)
                }
            } catch {
                print(error)
            }

            showingIndicator = false
        }
    }
}
