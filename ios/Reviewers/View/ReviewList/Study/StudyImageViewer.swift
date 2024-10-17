import SwiftUI

struct StudyImageViewer: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {

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
                    Text("基本情報技術者")
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }

            }
        }
    }
}

#Preview {
    StudyImageViewer()
}
