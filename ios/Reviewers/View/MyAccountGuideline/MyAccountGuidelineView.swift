import SwiftUI

struct MyAccountGuidelineView: View {
    @StateObject var viewState: MyAccountGuidelineViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            if let markdown = viewState.markdown {
                ScrollView {
                    Text(markdown)
                        .padding()
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.appMain)))
                    .scaleEffect(1.2)
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
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
        }
    }
}

#Preview {
    ReviewListView(viewState: ReviewListViewState())
}
