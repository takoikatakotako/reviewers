import SwiftUI

class RootViewState: ObservableObject {
    @Published var type: RootViewType = .loading

    private let authUseCase = AuthUseCase()

    func onAppear() {
        Task { @MainActor in
            do {
                // ローディング中（初回起動）のみ先に進む
                guard type == .loading else {
                    return
                }

                // アプリ情報取得
                let s3Repository = S3Repository()
                let appInfo = try await s3Repository.fetchAppInfo()

                // メンテナンス中か確認
                if appInfo.isMaintenance {
                    withAnimation(.linear(duration: 1)) {
                        type = .maintenance
                    }
                    return
                }

                // アップグレードが必要か確認
                if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                   appVersion < appInfo.requiredVersion {
                    withAnimation(.linear(duration: 1)) {
                        type = .updateRequire
                    }
                }

                // アカウントは存在するかチェック
                if let user = authUseCase.getUser() {
                    // ログインしている
                    withAnimation(.linear(duration: 1)) {
                        type = .main
                    }
                    return
                }

               // 未ログイン
                withAnimation(.linear(duration: 1)) {
                    type = .tutorial
                }
            } catch {
                withAnimation(.linear(duration: 1)) {
                    type = .error
                }
            }
        }
    }

    func doneTutorial() {
        // アカウントは存在するかチェック
        if let user = authUseCase.getUser() {
            // ログインしている
            withAnimation(.linear(duration: 1)) {
                type = .main
            }
        } else {
            withAnimation(.linear(duration: 1)) {
                type = .error
            }
        }
    }

    func signOut() {
        // 未ログイン
         withAnimation(.linear(duration: 1)) {
             type = .tutorial
         }
    }
}
