import SwiftUI
import VisionKit

struct ReviewSearchView: View {
    @StateObject var viewState: ReviewSearchViewState
    @Environment(\.dismiss) var dismiss
    
    @State var isShowingScanner = true
    @State private var scannedText = ""
    
    @State var text = ""
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        TextField("商品名を入力 または バーコードをスキャン", text: $text) {isEditing in
                            viewState.onEditingChanged(isEditing: isEditing)
                        }
                        .focused($keyboardFocused)
                        
                        Spacer()
                        
                        Button {
                            viewState.barcodeButtonTapped()
                        } label: {
                            Image(systemName: "barcode.viewfinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color(.appSubText))
                        }

                    }
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .stroke(Color(.appBackground), lineWidth: 1)
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
                    
                    Divider()
                    
                    ZStack {
                        List(viewState.merchandise) { mesechandise in
                            Button {
                                viewState.xxx(merchandise: mesechandise)
                            } label: {
                                ReviewSearchRow(merchandise: mesechandise)
                            }
                        }
                        
                        if viewState.isEditing {
                            Button {
                                keyboardFocused = false
                            } label: {
                                Color.black
                                    .opacity(0.1)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                        }
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
            .sheet(isPresented: $viewState.showingBarcodeView) {
                BarcodeScannerView { code in
                    viewState.codeSccaned(code: code)
                    dismiss()
                }
            }
            .navigationDestination(item: $viewState.navigationDestination) { item in
                switch item {
                case .reviewSearchDetail(merchandise: let merchandise):
                    ReviewSearchDetailView(viewState: ReviewSearchDetailViewState(merchandise: merchandise))
                }
            }
            .background(Color.white)
            .tint(Color(.appMainText))
            .listStyle(.inset)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("商品検索")
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
        }
    }
}
