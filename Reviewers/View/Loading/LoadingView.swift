import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    LoadingView()
}
