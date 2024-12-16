import SwiftUI
import FirebaseAuth

class ContactViewState: ObservableObject {
    @Published var uid: String = ""
    @Published var email: String = ""
    @Published var message: String = ""

    // Indicator
    @Published var indicator = false

    // Alert
    @Published var showingCompleteAlert = false
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting = ""

    private let authUseCase = AuthUseCase()
    private let contactUseCase = ContactUseCase()

    func onAppear() {
        do {
            uid = try authUseCase.getUserId()
        } catch {
            indicator = false
            showingErrorAlertPresenting = "ユーザーIDの取得に失敗しました"
            showingErrorAlert = true
        }
    }

    func sendMessage() {
        indicator = true
        guard uid.isNotEmpty else {
            indicator = false
            showingErrorAlertPresenting = "ユーザーIDの取得に失敗しました"
            showingErrorAlert = true
            return
        }

        guard message.isNotEmpty else {
            indicator = false
            showingErrorAlertPresenting = "メッセージが入力されていません"
            showingErrorAlert = true
            return
        }

        Task { @MainActor in
            do {
                try await contactUseCase.createContact(uid: uid, email: email, message: message)
                indicator = false
                showingCompleteAlert = true
            } catch {
                showingErrorAlertPresenting = "お問い合わせの送信に失敗しました。"
                showingErrorAlert = true
                indicator = false
            }
        }
    }
}
