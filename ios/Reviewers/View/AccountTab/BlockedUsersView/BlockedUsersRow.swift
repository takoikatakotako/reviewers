import SwiftUI
import SDWebImageSwiftUI

struct BlockedUsersRow: View {
    let profile: Profile

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                WebImage(url: profile.profileImageURL) { image in
                    image.resizable()
                } placeholder: {
                    CommonAccountImageHolder()
                }
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 0) {
                    CommonText(text: profile.nickname, font: .mPlus2SemiBold(size: 20), lineHeight: 28, alignment: .leading)
                        .foregroundStyle(.appMainText)
                    CommonText(text: "ID: \(profile.id)", font: .mPlus2SemiBold(size: 14), lineHeight: 20, alignment: .leading)
                        .foregroundStyle(.appSubText)
                        .lineLimit(1)
                }

                Spacer()

                Button {
                    // viewState.accountMenuTapped()
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(.appSubText))
                }
            }

            if profile.profile.isNotEmpty {
                CommonText(text: profile.profile, font: .mPlus2Regular(size: 14), lineHeight: 20, alignment: .leading)
                    .foregroundStyle(.appMainText)
            }
        }
        .listRowInsets(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
    }
}

// #Preview {
//    BlockedUsersRow(profile: Profile.mo)
// }
