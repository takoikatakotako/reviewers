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
                TutorialView()
            } else if viewState.type == .main {
                MainView()
            } else if viewState.type == .error {
                ErrorView()
            }
        }
        .onAppear {
            viewState.onAppear()
        }
    }
}

#Preview {
    RootView(viewState: RootViewState())
}
