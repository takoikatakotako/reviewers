import SwiftUI

class ReviewDetailViewState: ObservableObject {
    let review: Review
    @Published var comment = ""

    init(review: Review) {
        self.review = review
    }

    func postComment() {

    }
}
