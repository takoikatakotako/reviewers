import SwiftUI

struct AccountSettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: AccountSettingViewState

    var body: some View {
        ZStack {
            List {
                Section("アカウントID") {
                    Text("ユーザー情報変更")
                        .foregroundStyle(Color(.appMainText))
                }

                Section("アカウント名") {
                    NavigationLink {
                        Text("XXX")
                    } label: {
                        Text("カビゴン小野")
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("プロフィール画像") {
                    NavigationLink {
                        Text("XXX")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color(.appBlueBackground))
                                .frame(width: 64, height: 64)

                            Image(systemName: "person.fill")
                                .resizable()
                                .foregroundStyle(Color.white)
                                .frame(width: 52, height: 52)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }

                Section("メールアドレス") {
                    NavigationLink {

                    } label: {
                        Text("カビゴン小野")
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("パスワード") {
                    NavigationLink {

                    } label: {
                        Text("**********")
                            .foregroundStyle(Color(.appMainText))
                    }
                }
            }
            .onAppear {
                viewState.onAppear()
            }
            .navigationDestination(item: $viewState.xx) { s in
                Text(s.description)
            }
            .listStyle(.grouped)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 8)
                            .padding(.trailing, 8)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("ユーザー情報変更")
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
    NavigationStack {
        AccountSettingView(viewState: AccountSettingViewState())
    }
}
