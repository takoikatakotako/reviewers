import SwiftUI

struct PostInputTextView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var text: String
    
    
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        VStack {
            TextField("レビューを入力", text: $text, axis: .vertical)
                .focused($keyboardFocused)
                .font(.mPlus2Regular(size: 16))
                .foregroundStyle(Color(.appMainText))
                .padding(.top, 16)
                .padding(.horizontal, 12)
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                keyboardFocused = true
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(Color.white)
                        .padding(.top, 8)
                        .padding(.leading, 4)
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    CommonText(text: "完了", font: .mPlus2SemiBold(size: 16), lineHeight: 20)
                        .foregroundStyle(Color.white)
                        .padding(.top, 8)
                        .padding(.leading, 8)
                        .padding(.trailing, 4)
                        .padding(.bottom, 8)
                }
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    PostInputTextView(text: .constant(""))
}
