import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 300)
        }
    }
}

#Preview {
    LoadingView()
}
