import SwiftUI

class TutorialViewState: ObservableObject {
    @Published var index = 0

    private let authUseCase = AuthUseCase()


    var title: String {
        if index == 0 {
            return "レビューを読む"
        } else if index == 1 {
            return "レビューを探す"
        } else if index == 2 {
            return "レビューを書く"
        } else {
            return "error"
        }
    }

    var description: String {
        if index == 0 {
            return "たくさんのレビューを読んで、\n自分にぴったりの食べ物を見つけよう！"
        } else if index == 1 {
            return "バーコードから気になる食べ物の\nレビューを簡単に探してみましょう！"
        } else if index == 2 {
            return "美味しい食べ物のレビューを書いてみよう！\nあなたのレビューが次のヒット商品を生むかも？"
        } else {
            return "error"
        }
    }

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
        guard index < 2 else {
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
            index += 1
        }
    }
}
