import SwiftUI

struct CommonBarcodeScannerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var code: String?
    @Binding var codeType: CodeType?
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BarcodeScannerViewRepresentable { code, codeType  in
                        if codeType == .unknown {
                            showingAlert = true
                            return
                        }
                        self.code = code
                        self.codeType = codeType
                        dismiss()
                    }
                }
                .ignoresSafeArea(.all)
            }
            .alert("", isPresented: $showingAlert, actions: {
                Button("とじる", role: .none, action: {})
            }, message: {
                Text("非対応のバーコードです。")
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 0)
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
