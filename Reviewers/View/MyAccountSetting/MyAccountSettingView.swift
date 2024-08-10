import SwiftUI

struct MyAccountSettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: MyAccountSettingViewState

    var body: some View {
        ZStack {
            List {
                Section("アカウントID") {
                    Text(viewState.accoundID)
                        .foregroundStyle(Color(.appMainText))
                }

                Section("ニックネーム") {
                    Button {
                        viewState.nicknameAlert = true

                    } label: {
                        Text(viewState.nickname)
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("プロフィール画像") {
                    Button {
                        viewState.updateProfileImage()
                    } label: {
                        if let image = viewState.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
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
                }

                Section("メールアドレス") {
                    NavigationLink {

                    } label: {
                        Text(viewState.email)
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
            .alert("アラート", isPresented: $viewState.nicknameAlert) {
                TextField("テキストフィールド", text: $viewState.nickname)

                Button {
                } label: {
                    Text("とじる")
                }

                Button {
                    viewState.updateNickname()
                } label: {
                    Text("更新")
                }
            }
            .sheet(isPresented: $viewState.imagePickerSheet) {
                viewState.selectProfileImageComplete()
            } content: {
                ImagePicker(image: $viewState.profileImage)
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
        MyAccountSettingView(viewState: MyAccountSettingViewState())
    }
}
