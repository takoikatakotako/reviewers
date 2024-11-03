import SwiftUI

struct TutorialIndicatorView: View {
    let index: Int
    
    var body: some View {
        HStack(spacing: 24) {
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(index == 0 ? Color(.appSubText) : Color(.appBackground))

            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(index == 1 ? Color(.appSubText) : Color(.appBackground))

            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(index == 2 ? Color(.appSubText) : Color(.appBackground))
            
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(index == 3 ? Color(.appSubText) : Color(.appBackground))
        }
    }
}
