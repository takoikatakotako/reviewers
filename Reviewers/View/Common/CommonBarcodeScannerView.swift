import SwiftUI

struct CommonBarcodeScannerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var code: String
    @Binding var codeType: CodeType?

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    BarcodeScannerView { code, codeType  in
                        self.code = code
                        self.codeType = codeType
                        dismiss()
                    }
                }
            }
            .ignoresSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                    }
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
