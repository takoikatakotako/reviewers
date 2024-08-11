import Foundation

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AccountViewState: ObservableObject {
    let uid: String
    @Published var nickname = ""
    @Published var reviews: [Review] = []
    
    private let profileUseCase = ProfileUseCase()
    private let reviewUseCase = ReviewUseCase()
    
    var profileImageUrlString: String {
        return "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(uid)/profile.png"
    }
    
    init(uid: String) {
        self.uid = uid
    }
        
    func onAppear() {
        Task { @MainActor in
            let profile = await profileUseCase.fetchProfile(uid: self.uid)
            nickname = profile.nickname
            do {
                try await updatePosts()
            } catch {
                print(error)
            }
        }
    }
    
    
    @MainActor
    private func updatePosts() async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewReviews()
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
