import SwiftUI
import VisionKit

struct ReviewSearchView: View {
    @StateObject var viewState: ReviewSearchViewState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack(alignment: .bottomTrailing) {
                    List(viewState.merchandise) { mesechandise in
                        Button {
                            viewState.xxx(merchandise: mesechandise)
                        } label: {
                            ReviewSearchRow(merchandise: mesechandise)
                        }
                    }
                    
                    Button {
                        viewState.barcodeButtonTapped()
                    } label: {
                        VStack {
                            Image(systemName: "barcode.viewfinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 48, height: 48)
                        .background(Color(.appGreenBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(12)
                    }
                    
                }
                
                if viewState.loading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                        .tint(Color.white)
                        .background(Color.gray)
                        .cornerRadius(8)
                        .scaleEffect(1.2)
                }
            }
            .onAppear {
                viewState.onAppear()
            }
            .alert(
                "",
                isPresented: $viewState.showingErrorAlert,
                presenting: viewState.showingErrorAlertPresenting,
                actions: { _ in
                    Button("とじる", role: .none) {}
                }, message: { message in
                    Text(message)
                }
            )
            .alert("エラー", isPresented: $viewState.showingNotFoundMerchandiseAlert, actions: {
                
            }, message: {
                // TODO: もし良かったら登録してクレメンス
                Text("申し訳ございません。商品が見つかりませんでした。")
            })
            .navigationDestination(item: $viewState.navigationDestination) { item in
                switch item {
                case .reviewSearchDetail(merchandise: let merchandise):
                    ReviewSearchDetailView(viewState: ReviewSearchDetailViewState(merchandise: merchandise))
                }
            }
            .sheet(
                isPresented: $viewState.showingBarcodeView,
                onDismiss: {
                    viewState.dismissBarcodeView()
                }) {
                    CommonBarcodeScannerView(
                        code: $viewState.code,
                        codeType: $viewState.codeType)
                }
                .background(Color.white)
                .tint(Color(.appMainText))
                .listStyle(.inset)
                .scrollIndicators(.hidden)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("レビュー検索")
                            .font(.system(size: 16).bold())
                            .foregroundStyle(Color.white)
                    }
                }
                .toolbarBackground(Color(.appMain), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            
        }
    }
}
