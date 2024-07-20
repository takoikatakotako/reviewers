import SwiftUI

enum StudyChoiceViewStatus {
    case normal
    case correct
    case incorrect
}

struct StudyChoiceView: View {
    let text: String
    let status: StudyChoiceViewStatus
    
    var backgroundColor: Color {
        switch status {
        case .normal:
            return Color(.appGreenBackground)
        case .correct:
            return Color(.appRedBackground)
        case .incorrect:
            return Color(.appBlueBackground)
        }
    }
    
    var body: some View {
        CommonText(text: text, font: .mPlus2Medium(size: 18), lineHeight: 18)
            .foregroundStyle(Color.white)
            .frame(width: 60, height: 48)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
