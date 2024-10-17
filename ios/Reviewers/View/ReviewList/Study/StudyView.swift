import SwiftUI

struct StudyView: View {
    @StateObject var viewState: StudyViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    switch viewState.question {
                    case .questionSimple(let question):
                        QuestionSimpleView(question: question, disabled: viewState.disabled) { imageName in
                            viewState.imageTapped(imageName: imageName)
                        }
                    case .questionSimpleNoChoices(let question):
                        QuestionSimpleNoChoicesView(question: question, disabled: viewState.disabled) { imageName in
                            viewState.imageTapped(imageName: imageName)
                        }
                    }

                    if viewState.status == .kaisetu {
                        // なんとか
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

                            CommonText(text: "イまずは表の情報から、コーディング所要工数を求める。プログラムの本数にそれぞれの所要工数をかけて足し合わせると\n20 x 74 + 23 + 34\nより、コーディングに95人日かかることがわかる。\nそしてなんとかかんとか感とか。\nアはなんとかのかんとかの説明をしているため不正解。\nイは。。。", font: .mPlus2Regular(size: 14), lineHeight: 28, alignment: .leading)
                                .foregroundStyle(Color(.appMainText))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.top, 16)
                    }

                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                .padding(.bottom, 100)
            }

            // 解いてる, 正解時、不正解時
            if [.toiteru, .answerCorrect, .answerIncorrect].contains(where: { $0 == viewState.status }) {
                // 選択肢
                HStack(spacing: 12) {
                    Button {

                    } label: {
                        HStack {
                            Image(systemName: "pencil.line")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 60, height: 48)
                        .background(Color(.appGreenBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    switch viewState.question {
                    case .questionSimple(let question):
                        ForEach(0 ..< question.choices.count, id: \.self) {index in
                            Button {
                                viewState.choiceTapped(choiceIndex: index)
                            } label: {
                                if viewState.status == .toiteru {
                                    StudyChoiceView(text: index.katakana, status: .normal)
                                } else if viewState.status == .answerCorrect {
                                    if index == question.answer {
                                        StudyChoiceView(text: index.katakana, status: .correct)
                                    } else {
                                        StudyChoiceView(text: index.katakana, status: .normal)
                                    }
                                } else if viewState.status == .answerIncorrect, let choiceIndex = viewState.choiceIndex {
                                    if index == question.answer {
                                        StudyChoiceView(text: index.katakana, status: .correct)
                                    } else if index == choiceIndex {
                                        StudyChoiceView(text: index.katakana, status: .incorrect)
                                    } else {
                                        StudyChoiceView(text: index.katakana, status: .normal)
                                    }
                                }
                            }
                            .disabled(viewState.showingResult)
                        }
                    case .questionSimpleNoChoices:
                        Text("questionSimpleNoChoices")
                    }
                }
                // else viewState.status ==

                //

            }

            // 正解
            if viewState.status == .answerCorrect {
                VStack {
                    Spacer()
                    Circle()
                        .stroke(
                            Color(.appRedBackground),
                            style: StrokeStyle(lineWidth: 64)
                        )
                        .opacity(0.8)
                        .frame(width: 300, height: 300)
                    Spacer()
                }
            }

            // 不正解
            if viewState.status == .answerIncorrect {
                VStack {
                    Spacer()

                    Image(systemName: "multiply")
                        .resizable()
                        .foregroundColor(.appBlueBackground)
                        .opacity(0.8)
                        .frame(width: 300, height: 300)
                    Spacer()
                }
            }

            // 次へ
            if viewState.status == .kaisetu {
                Button {
                    viewState.next()
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
                }
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
                CommonText(text: viewState.title, font: .mPlus2Bold(size: 16), lineHeight: 16)
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
        .fullScreenCover(item: $viewState.cover) { item in
            switch item {
            case .image(let imageName):
                ImageView(imageName: imageName)
            }
        }
        .navigationDestination(isPresented: $viewState.finish) {
            Text("結果画面に")
        }
    }
}

#Preview {
    NavigationStack {
        StudyView(viewState: StudyViewState(title: "title", questions: [], results: []))
    }
}
