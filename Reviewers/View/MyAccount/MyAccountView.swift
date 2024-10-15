import SwiftUI
import SDWebImageSwiftUI
import LicenseList

struct MyAccountView: View {
    @StateObject var viewState: MyAccountViewState

    var body: some View {
        NavigationStack {
            List {
                Section("ユーザー情報") {
                    NavigationLink {
                        MyAccountSettingView(viewState: MyAccountSettingViewState())
                    } label: {
                        Text("ユーザー情報変更")
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("レビュー") {
                    NavigationLink {
                        MyReviewListView(viewState: MyReviewListViewState())
                    } label: {
                        Text("マイレビュー")
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("お問い合わせ") {
                    NavigationLink {

                    } label: {
                        Text("お問い合わせ")
                    }
                }

                Section("アプリケーション情報") {
                    HStack {
                        Text("バージョン情報")
                        Spacer()
                        Text("1.0.0(3)")
                    }
                    NavigationLink {
                        LicenseListView()
                    } label: {
                        Text("ライセンス")
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("アカウント") {
                    Button {
                        viewState.signIn()
                    } label: {
                        Text("サインイン")
                    }

                    Button {
                        viewState.signOut()
                    } label: {
                        Text("サインアウト")
                    }
                }

                Section("Debug") {
                    NavigationLink {
                        DebugView(viewState: DebugViewState())
                    } label: {
                        Text("Debug")
                    }
                }
            }
            .tint(Color(.appMainText))
            .onAppear {
                viewState.onAppear()
            }
//            .navigationDestination(item: $viewState.navigationDestination) { item in
//                switch item {
//                case .account(profile: let profile):
//                    // AccountView(viewState: AccountViewState(profile: profile))
//                    Text("temp")
//                }
//            }
            .fullScreenCover(isPresented: $viewState.showingFullscreenCover) {
                // SignUpView(viewState: SignUpViewState())
                AuthView(viewState: AuthViewState())
            }
            .listStyle(.grouped)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("設定")
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    MyAccountView(viewState: MyAccountViewState())
}
