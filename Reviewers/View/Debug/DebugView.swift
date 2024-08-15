import SwiftUI

struct DebugView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: DebugViewState

    var body: some View {
        List {
            Section("Merchandise") {
                NavigationLink {
                    DebugMerchandiseAddView(viewState: DebugMerchandiseAddViewState())
                } label: {
                    Text("Add Merchandise")
                }
            }
        }
        .onAppear {
            viewState.onAppear()
        }
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
            }

            ToolbarItem(placement: .principal) {
                CommonText(text: "デバッグ", font: .mPlus2Bold(size: 16), lineHeight: 16)
                    .font(.system(size: 16).bold())
                    .foregroundStyle(Color.white)
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    DebugView(viewState: DebugViewState())
}
