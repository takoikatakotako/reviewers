import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ReviewListView(viewState: ReviewListViewState())
                .tabItem {
                    Label("レビュー一覧", systemImage: "pencil.and.scribble")
                }
                .tag(1)

            ReviewSearchView(viewState: ReviewSearchViewState())
                .tabItem {
                    Label("レビュー検索", systemImage: "barcode.viewfinder")
                }
                .tag(2)

            MyAccountView(viewState: MyAccountViewState())
                .tabItem {
                    Label("アカウント", systemImage: "person.crop.circle")
                }
                .tag(3)
        }
        .tint(Color(.appMain))
    }
}

#Preview {
    MainView()
}
