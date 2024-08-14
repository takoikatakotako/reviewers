import SwiftUI
import SDWebImageSwiftUI
import LicenseList

struct MyAccountView: View {
    @StateObject var viewState: MyAccountViewState

    var body: some View {
        NavigationStack {
            List {
                Section("") {
                    Button {
                        viewState.xx = true
                    } label: {
                        HStack(spacing: 12) {
                            WebImage(url: viewState.profileImageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                CommonAccountImageHolder()
                            }
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack(alignment: .leading, spacing: 4) {
                                CommonText(text: viewState.nickname, font: .mPlus2Medium(size: 14), lineHeight: 18)
                                    .foregroundStyle(Color(.appMainText))
                                CommonText(text: "ID: \(viewState.user?.uid ?? "")", font: .mPlus2Regular(size: 14), lineHeight: 18)
                                    .foregroundStyle(Color(.appMainText))
                            }

                            Spacer()
                        }
                        .padding(.top, 8)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                    }
                    .listRowInsets(EdgeInsets())
                }

                Section("ユーザー情報") {
                    NavigationLink {
                        MyAccountSettingView(viewState: MyAccountSettingViewState())
                    } label: {
                        Text("ユーザー情報変更")
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("お問い合わせ") {
                    NavigationLink {

                    } label: {
                        Text("お問い合わせ")
                    }
                }

                Section("開発者情報") {
                    Button {

                    } label: {
                        Text("公式Discord")
                            .foregroundStyle(Color(.appMainText))
                    }

                    Button {

                    } label: {
                        Text("開発者のXアカウント")
                            .foregroundStyle(Color(.appMainText))
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
                        print("TODO: サインイン")
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
                        // DebugView(viewState: DebugViewState())
                    } label: {
                        Text("Debug")
                    }
                }
            }
            .tint(Color(.appMainText))
            .onAppear {
                viewState.onAppear()
            }
            .navigationDestination(item: $viewState.xx) { s in
                Text(s.description)
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
