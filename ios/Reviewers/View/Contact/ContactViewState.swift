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
            showingErrorAlertPresenting = "ユーザーIDの取得に失敗しました"
            showingErrorAlert = true
        }
    }
    
    func sendMessage() {
        indicator = true
        guard uid.isNotEmpty else {
            showingErrorAlertPresenting = "ユーザーIDの取得に失敗しました"
            showingErrorAlert = true
            indicator = false
            return
        }
        
        guard message.isNotEmpty else {
            showingErrorAlertPresenting = "メッセージが入力されていません"
            showingErrorAlert = true
            indicator = false
            return
        }
        
        Task { @MainActor in
            do {
                try await contactUseCase.createContact(uid: uid, email: email, message: message)
                indicator = false
            } catch {
                showingErrorAlertPresenting = "お問い合わせの送信に失敗しました。"
                showingErrorAlert = true
                indicator = false
            }
        }
    }
}
