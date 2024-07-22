import SwiftUI

struct DebugQuestionExplanationView: View {
    let text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CommonText(text: "解説", font: .mPlus2Regular(size: 14), lineHeight: 28)
                .foregroundStyle(Color.white)
                .frame(width: 52, height: 32)
                .background(Color(.appGreenBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            CommonText(text: text, font: .mPlus2Regular(size: 14), lineHeight: 28, alignment: .leading)
                .foregroundStyle(Color(.appMainText))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
    }
}

// #Preview {
//    DebugQuestionExplanationView()
// }
