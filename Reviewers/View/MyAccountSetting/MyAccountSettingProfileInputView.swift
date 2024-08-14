import SwiftUI

struct MyAccountSettingProfileInputView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var text: String
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        VStack {
            TextField("プロフィールを入力", text: $text, axis: .vertical)
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
        .listStyle(.grouped)
        .scrollIndicators(.hidden)
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
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

//#Preview {
//    MyAccountSettingProfileInputView()
//}
