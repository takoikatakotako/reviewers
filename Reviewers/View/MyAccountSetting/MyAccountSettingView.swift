import SwiftUI

struct MyAccountSettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: MyAccountSettingViewState

    var body: some View {
        ZStack {
            List {
                Section("アカウントID") {
                    Text(viewState.uid)
                        .foregroundStyle(Color(.appMainText))
                }

                Section("ニックネーム") {
                    Button {
                        viewState.nicknameTapped()
                    } label: {
                        Text(viewState.nickname)
                            .foregroundStyle(Color(.appMainText))
                    }
                }

                Section("プロフィール") {
                    Button {
                        viewState.profileTapped()
                    } label: {
                        if viewState.profile.isNotEmpty {
                            CommonText(text: viewState.profile, font: .mPlus2Regular(size: 16), lineHeight: 24, alignment: .leading)
                                .foregroundStyle(Color(.appMainText))
                        } else {
                            CommonText(text: "プロフィールを入力", font: .mPlus2Regular(size: 16), lineHeight: 24, alignment: .leading)
                                .foregroundStyle(Color(.appBackground))
                        }
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
            }

            if viewState.showingIndicator {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .scaleEffect(1.2)
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .navigationDestination(isPresented: $viewState.changeProfileNaviagtionDestination) {
             MyAccountSettingProfileInputView(text: $viewState.profile)
        }
        .alert("アラート", isPresented: $viewState.nicknameAlert) {
            TextField("テキストフィールド", text: $viewState.newNickname)

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
        .alert("", isPresented: $viewState.errorAlert, actions: {
            Button("とじる", role: .cancel, action: {})
        }, message: {
            Text("不明なエラーが発生しました。")
        })
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

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewState.update()
                } label: {
                    CommonText(text: "更新", font: .mPlus2SemiBold(size: 16), lineHeight: 18)
                        .foregroundStyle(Color.white)
                }
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        MyAccountSettingView(viewState: MyAccountSettingViewState())
    }
}
