import SwiftUI

struct TutorialView: View {
    @StateObject var viewState: TutorialViewState
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            switch viewState.page {
            case .first:
                TutorialContentView(
                    screenImage: Image(.tutorialFirst),
                    title: "レビューを読む",
                    description: "たくさんのレビューを読んで、\n自分にぴったりの食べ物を見つけよう！")
                .padding(.top, 24)
                .padding(.horizontal, 16)
            case .second:
                TutorialContentView(
                    screenImage: Image(.tutorialSecond),
                    title: "レビューを探す",
                    description: "バーコードから気になる食べ物の\nレビューを簡単に探してみましょう！")
                .padding(.top, 24)
                .padding(.horizontal, 16)
            case .third:
                TutorialContentView(
                    screenImage: Image(.tutorialThird),
                    title: "レビューを書く",
                    description: "美味しい食べ物のレビューを書いてみよう！\nあなたのレビューが次のヒット商品を生むかも？")
                .padding(.top, 24)
                .padding(.horizontal, 16)
            case .guideline:
                TutorialGuidelineContentView(
                    didOpenTeams: viewState.didOpenTeams,
                    didOpenPrivacy: viewState.didOpenPrivacy,
                    openTeams: {
                        viewState.openTeams()
                    },
                    openPrivacy: {
                        viewState.openPrivacy()
                    }
                )
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
            }
            
            
            // Indicator
            TutorialIndicatorView(page: viewState.page)
                .padding(.top, 24)
            
            // Next
            Button {
                viewState.tapped()
            } label: {
                HStack {
                    Spacer()
                    
                    CommonText(
                        text: viewState.page == .guideline ? "同意してはじめる" : "つぎへ",
                        font: .mPlus2SemiBold(size: 18),
                        lineHeight: 24
                    )
                    .foregroundStyle(Color.white)
                    
                    Spacer()
                }
                .frame(height: 48)
                .disabled(!viewState.nextButtonEnable)
                .background(viewState.nextButtonEnable ? Color(.appGreenBackground) : Color(.appBackground))
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
