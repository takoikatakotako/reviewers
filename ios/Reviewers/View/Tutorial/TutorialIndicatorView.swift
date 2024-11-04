import SwiftUI

struct TutorialIndicatorView: View {
    let page: TutorialPage
    
    var body: some View {
        HStack(spacing: 24) {
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(page == .first ? Color(.appSubText) : Color(.appBackground))

            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(page == .second ? Color(.appSubText) : Color(.appBackground))

            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(page == .third ? Color(.appSubText) : Color(.appBackground))
            
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(page == .guideline ? Color(.appSubText) : Color(.appBackground))
        }
    }
}
