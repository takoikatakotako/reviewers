import SwiftUI

struct PostBarcodeScannerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var code: String

    var body: some View {
        VStack {
            BarcodeScannerView { code in
                self.code = code
                dismiss()
            }
        }
    }
}
