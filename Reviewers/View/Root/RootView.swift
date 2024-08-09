import SwiftUI

struct RootView: View {
    @StateObject var viewState: RootViewState

    var body: some View {
        ZStack {
            if viewState.type == .loading {
                LoadingView()
            } else if viewState.type == .maintenance {
                MaintenanceView()
            } else if viewState.type == .updateRequire {
                UpdateRequiredView()
            } else if viewState.type == .tutorial {
                TutorialView(viewState: TutorialViewState())
            } else if viewState.type == .main {
                MainView()
            } else if viewState.type == .error {
                ErrorView()
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.doneTutorial)) { _ in
            viewState.doneTutorial()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.signOut)) { _ in
            viewState.signOut()
        }
    }
}

#Preview {
    RootView(viewState: RootViewState())
}
