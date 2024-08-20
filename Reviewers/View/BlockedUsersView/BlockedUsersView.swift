import SwiftUI

struct BlockedUsersView: View {
    @StateObject var viewState: BlockedUsersViewState

    var body: some View {
        List(viewState.blockedUsers) { blockedUser in
            Text(blockedUser.blockedUserId)
        }
        .onAppear {
            viewState.onAppear()
        }
    }
}

#Preview {
    BlockedUsersView(viewState: BlockedUsersViewState())
}
