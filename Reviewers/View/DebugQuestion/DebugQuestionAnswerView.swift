import SwiftUI

struct DebugQuestionAnswerView: View {
    let text: String
    var body: some View {
        HStack {
            CommonText(text: "正解", font: .mPlus2Regular(size: 14), lineHeight: 28)
                .foregroundStyle(Color.white)
                .frame(width: 52, height: 32)
                .background(Color(.appGreenBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            CommonText(text: text, font: .mPlus2Regular(size: 14), lineHeight: 28)
                .foregroundStyle(Color(.appMainText))
            
            Spacer()
        }
    }
}

//#Preview {
//    DebugQuestionAnswerView()
//}
