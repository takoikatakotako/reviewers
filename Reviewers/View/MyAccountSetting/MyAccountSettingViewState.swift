import SwiftUI
import FirebaseAuth

class MyAccountSettingViewState: ObservableObject {
    @Published var uid: String = ""
    @Published var isAnonymousUser = true
    @Published var nickname: String = ""
    @Published var newNickname: String = ""
    @Published var profile: String = ""
    @Published var profileImage: UIImage?

    // Navigation Destination
    @Published var changeProfileNaviagtionDestination: Bool = false

    // Alert
    @Published var nicknameAlert = false
    @Published var errorAlert = false

    // Sheet
    @Published var imagePickerSheet = false
    
    private let authRepository = AuthRepository()
    private let storageRepository = StorageRepository()
    private let profileUseCase = ProfileUseCase()
    private let authUseCase = AuthUseCase()

    func onAppear() {
        Task { @MainActor in
            do {
                let uid = try authUseCase.getUserId()
                self.uid = uid
                self.isAnonymousUser = try authUseCase.isAnonymousUser()
                let profile: Profile = await profileUseCase.fetchProfile(uid: uid)
                self.nickname = profile.nickname
                self.profile = profile.profile
                let image = try await storageRepository.fetchProfileImage(uid: uid)
                self.profileImage = image
            } catch {
                print(error)
                errorAlert = true
            }
        }
    }
    
    // MARK - Nickname
    func nicknameTapped() {
        newNickname = nickname
        nicknameAlert = true
    }

    func updateNickname() {
        nickname = newNickname
    }
    
    // MARK - Profile
    func profileTapped() {
        changeProfileNaviagtionDestination = true
    }

    // MARK - Profile Image
    func updateProfileImage() {
        imagePickerSheet = true
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
    
    
    // MARK - XXX
    func update() {
        Task { @MainActor in
            do {
                let uid = try authUseCase.getUserId()
                try await profileUseCase.setProfile(uid:uid, nickname: nickname, profile: profile)

                if let image = profileImage {
                    try await storageRepository.uploadProfileImage(uid: uid, image: image)
                }
            } catch {
                print(error)
            }
        }
    }
}
