import Foundation

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AccountViewState: ObservableObject {
    let uid: String
    @Published var nickname = ""
    @Published var reviews: [Review] = []
    @Published var loading = true
    @Published var navigationDestination: AccountViewDestination?
    
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
                try await updateUserReviews(uid: uid)
            } catch {
                print(error)
            }
            loading = true
        }
    }
    
    func reviewTapped(review: Review) {
        navigationDestination = .reviewDetail(review: review)
    }
    
    
    @MainActor
    private func updateUserReviews(uid: String) async throws {
        let newReviews: [Review] = try await reviewUseCase.fetchNewUserReviews(uid: uid)
        let margedReviews: [Review] = newReviews + self.reviews
        let uniqueReviews = Set(margedReviews)
        let sortedReviews = Array(uniqueReviews).sorted(by: { $0.createdAt > $1.createdAt })
        self.reviews = sortedReviews
    }
}
