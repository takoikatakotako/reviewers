import SwiftUI

struct TutorialGuidelineContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            CommonText(
                text: "ご利用にあたって",
                font: .mPlus2SemiBold(size: 24),
                lineHeight: 32,
                alignment: .leading
            )
                .foregroundStyle(Color(.appMainText))
            
            
            CommonText(
                text: "利用規約、プライバシーポリシーをご確認いただき、同意の上、利用を開始してください。",
                font: .mPlus2Regular(size: 16),
                lineHeight: 24,
                alignment: .leading
            )
                .foregroundStyle(Color(.appMainText))
            
            Image(systemName: "text.document")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120)
            
            Button {
                
            } label: {
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(true ? Color(.appMain) : Color(.appBackground))
                    
                    CommonText(
                        text: "利用規約を確認する",
                        font: .mPlus2Regular(size: 18),
                        lineHeight: 24,
                        alignment: .leading
                    )
                        .foregroundStyle(Color(.appMainText))
                    
                    Spacer()
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(false ? Color(.appMain) : Color(.appBackground))
                    
                    CommonText(
                        text: "プライバシーポリシーを確認する",
                        font: .mPlus2Regular(size: 18),
                        lineHeight: 24,
                        alignment: .leading
                    )
                        .foregroundStyle(Color(.appMainText))
                    
                    Spacer()
                }
            }
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
    }
}
