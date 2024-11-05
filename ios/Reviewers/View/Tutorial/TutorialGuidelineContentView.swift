import SwiftUI

struct TutorialGuidelineContentView: View {
    let didOpenTeams: Bool
    let didOpenPrivacy: Bool
    let openTeams: () -> Void
    let openPrivacy: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            CommonText(
                text: "ご利用にあたって",
                font: .mPlus2SemiBold(size: 24),
                lineHeight: 32,
                alignment: .leading
            )
            .foregroundStyle(Color(.appMainText))

            CommonText(
                text: "利用規約、プライバシーポリシーをご確認いただき、同意の上、利用を開始してください。",
                font: .mPlus2Regular(size: 16),
                lineHeight: 24,
                alignment: .leading
            )
            .foregroundStyle(Color(.appMainText))
            .padding(.top, 24)

            Image(systemName: "text.document")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 88)
                .foregroundStyle(Color(.appMainText))
                .padding(.top, 64)

            Button {
                openTeams()
            } label: {
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(didOpenTeams ? Color(.appGreenBackground) : Color(.appBackground))

                    CommonText(
                        text: "利用規約を確認する",
                        font: .mPlus2Regular(size: 18),
                        lineHeight: 24,
                        alignment: .leading
                    )
                    .foregroundStyle(Color(.appMainText))

                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color(.appMainText))

                    Spacer()
                }
            }
            .padding(.top, 64)

            Button {
                openPrivacy()
            } label: {
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(didOpenPrivacy ? Color(.appGreenBackground) : Color(.appBackground))

                    CommonText(
                        text: "プライバシーポリシーを確認する",
                        font: .mPlus2Regular(size: 18),
                        lineHeight: 24,
                        alignment: .leading
                    )
                    .foregroundStyle(Color(.appMainText))

                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color(.appMainText))

                    Spacer()
                }
            }
            .padding(.top, 12)
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
    }
}
