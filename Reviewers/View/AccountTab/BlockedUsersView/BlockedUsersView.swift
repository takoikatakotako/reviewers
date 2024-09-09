import SwiftUI
import SDWebImageSwiftUI

struct BlockedUsersView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: BlockedUsersViewState
    
    var body: some View {
        ZStack {
            List(viewState.blockedUsers) { blockedUser in
                NavigationLink {
                    AccountView(viewState: AccountViewState(profile: blockedUser.blockedUserProfile))
                } label: {
                    HStack {
                            WebImage(url: blockedUser.blockedUserProfile.profileImageURL) { image in
                                image.resizable()
                            } placeholder: {
                                Rectangle().foregroundColor(Color(.appBackground))
                            }
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            CommonText(
                                text: blockedUser.blockedUserProfile.nickname,
                                font: Font.mPlus2Regular(size: 16),
                                lineHeight: 18)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                }

            }
            
            if viewState.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.appMain)))
                    .scaleEffect(1.2)
            }
            
            if viewState.loading == false && viewState.blockedUsers.isEmpty {
                Text("ブロックしているユーザーはいません")
            }
        }
        .onAppear {
            viewState.onAppear()
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
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    BlockedUsersView(viewState: BlockedUsersViewState())
}

// .toolbar {

//    ToolbarItem(placement: .principal) {
//        Text("ユーザー情報変更")
//            .font(.system(size: 16).bold())
//            .foregroundStyle(Color.white)
//    }
//
//    ToolbarItem(placement: .topBarTrailing) {
//        Button {
//            viewState.update()
//        } label: {
//            CommonText(text: "更新", font: .mPlus2SemiBold(size: 16), lineHeight: 18)
//                .foregroundStyle(Color.white)
//        }
//    }
// }
//
