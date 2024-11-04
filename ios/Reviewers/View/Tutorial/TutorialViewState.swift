import SwiftUI

class TutorialViewState: ObservableObject {
    @Published var page: TutorialPage = .first
    @Published var didOpenTeams = false
    @Published var didOpenPrivacy = false
    
    private let authUseCase = AuthUseCase()
    
    var nextButtonEnable: Bool {
        switch page {
        case .first:
            return true
        case .second:
            return true
        case .third:
            return true
        case .guideline:
            return didOpenTeams && didOpenPrivacy
        }
    }
    
    func onAppear() {
        ここでぷらぽりと利用規約を取得しておく
    }

    func openTeams() {
        didOpenTeams = true
    }
    
    func openPrivacy() {
        didOpenPrivacy = true
    }
    
    func tapped() {
        guard page != .guideline else {
            Task { @MainActor in
                do {
                    // ユーザー作成 & 初期設定
                    try await authUseCase.signInAnonymouslyWithInitialSetting()
                    NotificationCenter.default.post(name: NSNotification.doneTutorial, object: self, userInfo: nil)
                } catch {
                    // TODO: エラーハンドリング
                    print(error)
                }
            }
            return
        }

        withAnimation(.linear(duration: 0.3)) {
            switch page {
            case .first:
                page = .second
            case .second:
                page = .third
            case .third:
                page = .guideline
            case .guideline:
                return
            }
        }
    }
}
