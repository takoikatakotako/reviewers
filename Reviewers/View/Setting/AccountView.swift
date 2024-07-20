import SwiftUI
import LicenseList

struct AccountView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("") {
                    Button {
                        
                    } label: {
                        HStack(spacing: 12) {
                            Image(.icon)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                            VStack(alignment: .leading, spacing: 4) {
                                CommonText(text: "かびごん小野", font: .mPlus2Medium(size: 14), lineHeight: 18)
                                    .foregroundStyle(Color(.appMainText))
                                CommonText(text: "2024/12/23 23:12", font: .mPlus2Regular(size: 14), lineHeight: 18)
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

                    } label: {
                        Text("ユーザー情報")
                            .foregroundStyle(Color(.appMainText))
                    }

                    NavigationLink {

                    } label: {
                        Text("プレミアムプランについて")
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
    AccountView()
}
