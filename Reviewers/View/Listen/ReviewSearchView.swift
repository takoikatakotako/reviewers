import SwiftUI
import VisionKit

struct ReviewSearchView: View {
    @StateObject var viewState: ListenViewState
    @Environment(\.dismiss) var dismiss

    @State var isShowingScanner = true
    @State private var scannedText = ""

    var body: some View {
//        NavigationStack {
//            VStack(alignment: .center) {
//                Text("XXX")
//            }
//            .scrollIndicators(.hidden)
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden()
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    CommonText(text: "聞いて勉強", font: .mPlus2Bold(size: 16), lineHeight: 16)
//                        .font(.system(size: 16).bold())
//                        .foregroundStyle(Color.white)
//                }
//            }
//            .toolbar(.hidden, for: .tabBar)
//            .toolbarBackground(Color(.appMain), for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbar(.visible, for: .tabBar)
//        }

        if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
            ZStack(alignment: .bottom) {
                DataScannerRepresentable(
                    shouldStartScanning: $isShowingScanner,
                    scannedText: $scannedText,
                    dataToScanFor: [.barcode(symbologies: [.ean8, .ean13])]
                )

                Text(scannedText)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
            }
        } else if !DataScannerViewController.isSupported {
            Text("It looks like this device doesn't support the DataScannerViewController")
        } else {
            Text("It appears your camera may not be available")
        }

    }
}

// #Preview {
//    ListenView()
// }
