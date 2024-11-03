import SwiftUI

class TutorialViewState: ObservableObject {
    @Published var index: Int = 0
    @Published var page: TutorialPage = .first

    private let authUseCase = AuthUseCase()


    var buttonTitle: String {
        if index == 0 {
            return "つぎへ"
        } else if index == 1 {
            return "つぎへ"
        } else if index == 2 {
            return "はじめよう！"
        } else {
            return "error"
        }
    }

    func tapped() {
        guard page == .guideline else {
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
