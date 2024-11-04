import SwiftUI

class TutorialViewState: ObservableObject {
    @Published var page: TutorialPage = .first
    @Published var didOpenTeams = false
    @Published var didOpenPrivacy = false
    
    @Published var indicator = false
    
    // Alert
    @Published var showingErrorAlert = false
    @Published var showingErrorAlertPresenting: String?
    
    // Sheet
    @Published var sheet: TutorialGuidelineSheet?
    
    private var teams: String? = nil
    private var privacy: String? = nil
    
    private let authUseCase = AuthUseCase()
    private let guidelineUseCase = GuidelineUseCase()
    
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
        Task {
            do {
                teams = try await guidelineUseCase.fetchTeams()
                privacy = try await guidelineUseCase.fetchPrivacy()
            } catch {
                print(error)
            }
        }
    }

    func openTeams() {
        if let teams = teams {
            sheet = .teams(teams)
            didOpenTeams = true
            return
        }
        
        Task { @MainActor in
            do {
                let teams = try await guidelineUseCase.fetchTeams()
                sheet = .teams(teams)
                didOpenTeams = true
            } catch {
                showingErrorAlertPresenting = "開けませんでした、時間を空けてお試し食おださい"
                showingErrorAlert = true
            }
        }
    }
    
    func openPrivacy() {
        if let privacy = privacy {
            sheet = .privacy(privacy)
            didOpenPrivacy = true
            return
        }

        Task { @MainActor in
            do {
                let privacy = try await guidelineUseCase.fetchPrivacy()
                sheet = .privacy(privacy)
                didOpenPrivacy = true
            } catch {
                showingErrorAlertPresenting = "開けませんでした、時間を空けてお試し食おださい"
                showingErrorAlert = true
            }
        }
    }
    
    func tapped() {
        guard page != .guideline else {
            if indicator {
                return
            }
            
            Task { @MainActor in
                do {
                    indicator = true
                    
                    // ユーザー作成 & 初期設定
                    try await authUseCase.signInAnonymouslyWithInitialSetting()
                    indicator = false

                    NotificationCenter.default.post(name: NSNotification.doneTutorial, object: self, userInfo: nil)
                } catch {
                    indicator = false

                    
                    print(error)
                    // TODO: エラーハンドリング
                    showingErrorAlertPresenting = "あれが無理だった"
                    showingErrorAlert = true
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
