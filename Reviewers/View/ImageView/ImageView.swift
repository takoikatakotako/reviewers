import SwiftUI

struct ImageView: View {
    let imageName: String

    @State var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "https://rikako-question-sandbox.s3-ap-northeast-1.amazonaws.com/image/\(imageName)")) { image in
                image
                    .resizable()
                    .scaledToFit()

            } placeholder: {
                Text("Loading")
            }
        }
        .scaleEffect(scale)
        .gesture(MagnificationGesture()
            .onChanged { value in
                scale = value.magnitude
            }
        )
        .presentationBackground(.black.opacity(0.5))
    }
}

#Preview {
    ImageView(imageName: "33.png")
}
