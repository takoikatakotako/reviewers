import SwiftUI
import SDWebImageSwiftUI

struct ReviewListRowImage: View {
    let urlString: String
    var body: some View {
        WebImage(url: URL(string: urlString)) { image in
            image.resizable()
        } placeholder: {
            Rectangle().foregroundColor(Color(.appBackground))
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFill()
    }
}

#Preview {
    ReviewListRowImage(urlString: "https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/full/143.png")
}
