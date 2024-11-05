import SwiftUI

struct TutorialContentView: View {
    let screenImage: Image
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 0) {
            screenImage
                .resizable()
                .scaledToFit()
                .frame(width: 220)

            Divider()
                .padding(.top, 36)

            VStack(alignment: .leading, spacing: 12) {
                CommonText(text: title, font: .mPlus2SemiBold(size: 24), lineHeight: 32)
                    .foregroundStyle(Color(.appMainText))

                CommonText(text: description, font: .mPlus2Regular(size: 16), lineHeight: 24, alignment: .leading)
                    .foregroundStyle(Color(.appMainText))
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
    }
}
