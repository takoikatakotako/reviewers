import SwiftUI
import SDWebImageSwiftUI

struct ReviewSearchRow: View {
    let merchandise: Merchandise

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                CommonText(text: merchandise.name, font: .mPlus2SemiBold(size: 16), lineHeight: 24, alignment: .leading)
                    .foregroundStyle(.appMainText)

                Spacer()

                CommonText(text: "4.2", font: .mPlus2Regular(size: 14), lineHeight: 18)
                    .foregroundStyle(.appMainText)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.appMain)

                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.appMain)

                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.appMain)

                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.appMain)

                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.appMain)
                }
            }

//            CommonText(text: "ブランド: 江崎グリコ", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
//                .foregroundStyle(.appMainText)

            if let imageURL = merchandise.imageURL {
                ReviewListRowImage(url: imageURL)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()
            }
            
            CommonText(text: "JANコード: \(merchandise.code)", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
                .foregroundStyle(.appMainText)
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 12, bottom: 12, trailing: 12))
    }
}
