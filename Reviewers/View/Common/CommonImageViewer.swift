import SwiftUI
import SDWebImageSwiftUI

struct CommonImageViewer: View {
    @Environment(\.dismiss) var dismiss

    let urlString: String
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                WebImage(url: URL(string: urlString)) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().foregroundColor(Color(.appBackground))
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
            }
            .ignoresSafeArea(.all)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 8)
                            .padding(.trailing, 8)
                    }
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    CommonImageViewer(urlString: "")
}
