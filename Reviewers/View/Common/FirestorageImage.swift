import SwiftUI

struct FirestorageImage: View {
    let uid: String
    let fileName: String
    
    @State private var image: UIImage? = nil
    
    private let storageRepository = StorageRepository()

    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                //                .clipShape(RoundedRectangle(cornerRadius: 8))
                //                .clipped()
            } else {
                Image(.samplePockey)
                    .resizable()
                    .scaledToFill()
            }
        }
        .onAppear {
            Task { @MainActor in
                self.image = try await storageRepository.fetchImage(uid: uid, fileName: fileName)
            }
        }
    }
}

#Preview {
    FirestorageImage(uid: "", fileName: "")
}
