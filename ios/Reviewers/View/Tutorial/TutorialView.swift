import SwiftUI

struct TutorialView: View {
    @StateObject var viewState: TutorialViewState

    var body: some View {
        ZStack {
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
                    .background(viewState.nextButtonEnable ? Color(.appGreenBackground) : Color(.appBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(!viewState.nextButtonEnable)
                .padding(.top, 24)
                .padding(.horizontal, 16)
            }

            if viewState.indicator {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.appMain)))
                    .scaleEffect(1.2)
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .alert(
            "",
            isPresented: $viewState.showingErrorAlert,
            presenting: viewState.showingErrorAlertPresenting,
            actions: { _ in
                Button("とじる", role: .none) {}
            }, message: { message in
                Text(message)
            }
        )
        .sheet(item: $viewState.sheet) { item in
            switch item {
            case .teams(let text):
                CommonGuidelineView(markdown: text)
            case .privacy(let text):
                CommonGuidelineView(markdown: text)
            }
        }
    }

}

#Preview {
    TutorialView(viewState: TutorialViewState())
}
