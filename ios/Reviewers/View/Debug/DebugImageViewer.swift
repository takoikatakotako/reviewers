import SwiftUI

struct DebugImageViewer: View {
    @Environment(\.dismiss) var dismiss

    @Binding var image: UIImage?

    var body: some View {
        NavigationStack {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        image = nil
                        dismiss()
                    } label: {
                        CommonText(text: "削除", font: .mPlus2SemiBold(size: 16), lineHeight: 20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 8)
                            .padding(.trailing, 4)
                            .padding(.bottom, 8)
                    }
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

        }
    }
}

// #Preview {
//    PostImageViewer()
// }
