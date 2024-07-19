import SwiftUI

@available(*, deprecated, renamed: "StudyView", message: "??")
struct StudyDescriptionView: View {
    @StateObject var viewState: StudyDescriptionViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    CommonText(text: "P, Q, Rはいずれも命題である。命題Pの真理値は真であり,命題（not P）or Q 及び命題（not Q）or R のいずれの真理値はどれか。ここで, X or Y は X と Y の論理和, not X は X の否定を表す。", font: .mPlus2Regular(size: 14), lineHeight: 28)
                        .foregroundStyle(Color(.appMainText))
                        .padding(.top, 16)

                    Button {
                        // viewState.imageTapped()
                    } label: {
                        Image(.studySample)
                            .resizable()
                            .padding(.top, 16)
                    }
                    .disabled(viewState.showingResult)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top, spacing: 4) {
                            CommonText(text: "ア:", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                            CommonText(text: "16進数表記 00 ビット列と排他的論理和をとる。", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                        }
                        HStack(alignment: .top, spacing: 4) {
                            CommonText(text: "イ:", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                            CommonText(text: "16進数表記 00 ビット列と排他的論理和をとる。16進数表記 00 ビット列と排他的論理和をとる。", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                        }
                        HStack(alignment: .top, spacing: 4) {
                            CommonText(text: "ウ:", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                            CommonText(text: "16進数表記 00 ビット列と排他的論理和をとる。", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                        }
                        HStack(alignment: .top, spacing: 4) {
                            CommonText(text: "エ:", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                            CommonText(text: "16進数表記 00 ビット列と排他的論理和をとる。16進数表記 00 ビット列と排他的論理和をとる。", font: .mPlus2Regular(size: 14), lineHeight: 28)
                                .foregroundStyle(Color(.appMainText))
                        }
                    }
                    .padding(.top, 16)

                    HStack {
                        Spacer()
                        CommonText(text: "出典: 平成31年度春季本試験 問1", font: .mPlus2Regular(size: 14), lineHeight: 28)
                            .foregroundStyle(Color(.appMainText))
                    }
                    .padding(.top, 12)

                    HStack {
                        CommonText(text: "正解", font: .mPlus2Regular(size: 14), lineHeight: 28)
                            .foregroundStyle(Color.white)
                            .frame(width: 52, height: 32)
                            .background(Color(.appGreenBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        CommonText(text: "イ", font: .mPlus2Regular(size: 14), lineHeight: 28)
                            .foregroundStyle(Color(.appMainText))

                        Spacer()
                    }
                    .padding(.top, 16)

                    VStack(alignment: .leading, spacing: 8) {
                        CommonText(text: "解説", font: .mPlus2Regular(size: 14), lineHeight: 28)
                            .foregroundStyle(Color.white)
                            .frame(width: 52, height: 32)
                            .background(Color(.appGreenBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        CommonText(text: "イまずは表の情報から、コーディング所要工数を求める。プログラムの本数にそれぞれの所要工数をかけて足し合わせると\n20 x 74 + 23 + 34\nより、コーディングに95人日かかることがわかる。\nそしてなんとかかんとか感とか。\nアはなんとかのかんとかの説明をしているため不正解。\nイは。。。", font: .mPlus2Regular(size: 14), lineHeight: 28)
                            .foregroundStyle(Color(.appMainText))
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .padding(.top, 16)

                }
                .padding(.horizontal, 16)
                .padding(.bottom, 100)
            }

            Button {

            } label: {
                HStack {
                    Spacer()

                    CommonText(text: "次へ", font: .mPlus2Medium(size: 18), lineHeight: 18)
                        .foregroundStyle(Color.white)
                        .frame(height: 48)

                    Spacer()
                }
                .background(Color(.appGreenBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 16)
            }

        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                }
                .disabled(viewState.showingResult)
            }

            ToolbarItem(placement: .principal) {
                CommonText(text: "基本情報技術者", font: .mPlus2Bold(size: 16), lineHeight: 16)
                    .font(.system(size: 16).bold())
                    .foregroundStyle(Color.white)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {

                } label: {
                    CommonText(text: "答え", font: .mPlus2Medium(size: 16), lineHeight: 16)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 8)
                        .padding(.leading, 8)
                }
                .disabled(viewState.showingResult)
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .fullScreenCover(isPresented: $viewState.showingImageCover) {
            StudyImageViewer()
        }
        .navigationDestination(isPresented: $viewState.result) {
            StudyResultView()
        }
    }
}

#Preview {
    StudyDescriptionView(viewState: StudyDescriptionViewState())
}
