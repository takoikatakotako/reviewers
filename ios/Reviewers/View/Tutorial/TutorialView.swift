import SwiftUI

struct TutorialView: View {
    @StateObject var viewState: TutorialViewState

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(.tutorialFirst)
                .resizable()
                .scaledToFit()
                .frame(width: 220)

            Divider()
                .padding(.top, 36)

            VStack(alignment: .leading, spacing: 12) {
                CommonText(text: viewState.title, font: .mPlus2SemiBold(size: 24), lineHeight: 32)
                    .foregroundStyle(Color(.appMainText))

                CommonText(text: viewState.description, font: .mPlus2Regular(size: 16), lineHeight: 24, alignment: .leading)
                    .foregroundStyle(Color(.appMainText))
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
            .padding(.top, 24)
            .padding(.horizontal, 16)

            //
            HStack(spacing: 24) {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(viewState.index == 0 ? Color(.appSubText) : Color(.appBackground))

                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(viewState.index == 1 ? Color(.appSubText) : Color(.appBackground))

                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(viewState.index == 2 ? Color(.appSubText) : Color(.appBackground))
            }
            .padding(.top, 24)

            Button {
                viewState.tapped()
            } label: {
                HStack {
                    Spacer()

                    CommonText(text: viewState.buttonTitle, font: .mPlus2SemiBold(size: 18), lineHeight: 24)
                        .foregroundStyle(Color.white)

                    Spacer()
                }
                .frame(height: 48)
                .background(Color(.appGreenBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    TutorialView(viewState: TutorialViewState())
}
