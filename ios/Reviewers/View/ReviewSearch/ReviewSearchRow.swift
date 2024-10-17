import SwiftUI
import SDWebImageSwiftUI

struct ReviewSearchRow: View {
    let merchandise: Merchandise

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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

            CommonText(text: "ブランド: 江崎グリコ", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
                .foregroundStyle(.appMainText)

            ReviewListRowImage(url: URL(string: "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/mf-649509-pocky-hero-amazon-new-1ec72242df10b2fbc24617e702b8bd97.jpg"))
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .clipped()
                .padding(.top, 12)

            CommonText(text: "JANコード: 123445", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
                .foregroundStyle(.appMainText)
                .padding(.top, 12)
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 12, bottom: 12, trailing: 12))
    }
}
