import SwiftUI

struct ReviewSearchView: View {
    @StateObject var viewState: ListenViewState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("XXX")
            }
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CommonText(text: "聞いて勉強", font: .mPlus2Bold(size: 16), lineHeight: 16)
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar(.visible, for: .tabBar)
        }
    }
}

//#Preview {
//    ListenView()
//}
