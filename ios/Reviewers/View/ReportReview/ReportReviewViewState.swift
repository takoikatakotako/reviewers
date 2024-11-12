import SwiftUI
import FirebaseAuth

class ReportReviewViewState: ObservableObject {
    @Published var spamActive = false
    @Published var aggressiveActive = false
    @Published var privacyActive = false
    @Published var otherActive = false
    @Published var other = ""

    // Alert
    @Published var showingCompleteAlert = false
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting: String?

    private let review: Review

    private let authUseCase = AuthUseCase()
    private let reportUseCase = ReportUseCase()

    var reportButtonDisabled: Bool {
        if spamActive || aggressiveActive || privacyActive || otherActive {
            return false
        } else {
            return true
        }
    }

    init(review: Review) {
        self.review = review
    }

    func spamTapped() {
        spamActive = true
        aggressiveActive = false
        privacyActive = false
        otherActive = false
    }

    func aggressiveTapped() {
        spamActive = false
        aggressiveActive = true
        privacyActive = false
        otherActive = false
    }

    func privacyTapped() {
        spamActive = false
        aggressiveActive = false
        privacyActive = true
        otherActive = false
    }

    func otherTapped() {
        spamActive = false
        aggressiveActive = false
        privacyActive = false
        otherActive = true
    }

    func reportButtonTapped() {
        Task { @MainActor in
            do {
                let userId = try authUseCase.getUserId()
                try await reportUseCase.createReport(userId: userId, reviewId: review.id)
                showingCompleteAlert = true
            } catch {
                showingErrorAlertPresenting = "不明なエラーです。時間を空けてお試しください。"
                showingErrorAlert = true
            }
        }
    }
}
