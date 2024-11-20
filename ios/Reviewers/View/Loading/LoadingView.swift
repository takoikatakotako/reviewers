import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 300)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .ignoresSafeArea(.all)
        .background(Color(.appGreenBackground))
    }
}

#Preview {
    LoadingView()
}
