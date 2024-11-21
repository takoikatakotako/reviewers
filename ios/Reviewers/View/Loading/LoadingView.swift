import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 170)  // スプラッシュ画像の半分のサイズにする
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
