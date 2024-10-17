import SwiftUI

struct QuestionSimpleNoChoicesView: View {
    let question: QuestionSimpleNoChoices
    let disabled: Bool
    let imageSelected: (_ imageName: String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CommonText(text: question.text, font: .mPlus2Regular(size: 14), lineHeight: 28, alignment: .leading)
                .foregroundStyle(Color(.appMainText))

            // 画像が設定されている場合は表示する
            if let image = question.image {
                Button {
                    imageSelected(image)
                } label: {
                    AsyncImage(url: URL(string: "https://rikako-question-sandbox.s3-ap-northeast-1.amazonaws.com/image/\(image)")) { image in
                        image
                            .resizable()
                            .scaledToFit()

                    } placeholder: {
                        Text("Loading")
                    }
                        .padding(.top, 16)
                }
                .disabled(disabled)
            }

            if let refer = question.refer {
                HStack {
                    Spacer()
                    CommonText(text: "出典: \(refer)", font: .mPlus2Regular(size: 14), lineHeight: 28)
                        .foregroundStyle(Color(.appMainText))
                }
                .padding(.top, 12)
            }

        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
