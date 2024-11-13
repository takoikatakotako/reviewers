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
                let message = getMessage()
                let userId = try authUseCase.getUserId()
                try await reportUseCase.createReport(userId: userId, reviewId: review.id, message: message)
                showingCompleteAlert = true
            } catch {
                showingErrorAlertPresenting = "不明なエラーです。時間を空けてお試しください。"
                showingErrorAlert = true
            }
        }
    }

    private func getMessage() -> String {
        if spamActive {
            return "商品と関係ない投稿、詐欺、偽のアカウント、悪意のある投稿"
        }
        if aggressiveActive {
            return "商品に対する侮辱的発言、望ましくない閲覧注意コンテンツや刺激の強いコンテンツ"
        }
        if privacyActive {
            return "個人情報を共有している、個人を特定できる情報が投稿に含まれている"
        }
        if otherActive {
            return other
        }
        return ""
    }
}
