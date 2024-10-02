import SwiftUI
import VisionKit

struct ReviewSearchView: View {
    @StateObject var viewState: ReviewSearchViewState
    @Environment(\.dismiss) var dismiss

    @State var isShowingScanner = true
    @State private var scannedText = ""
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
//                    HStack {
//                        TextField("商品名を入力 または バーコードをスキャン", text: $viewState.text) {isEditing in
//                            viewState.onEditingChanged(isEditing: isEditing)
//                        }
//                        .focused($keyboardFocused)
//                        .foregroundStyle(Color(.appMainText))
//                        
//                        Spacer()
//                        
//                        Button {
//                            viewState.barcodeButtonTapped()
//                        } label: {
//                            Image(systemName: "barcode.viewfinder")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 24, height: 24)
//                                .foregroundStyle(Color(.appSubText))
//                        }
//
//                    }
//                    .padding(8)
//                    .background {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.white)
//                            .stroke(Color(.appBackground), lineWidth: 1)
//                    }
//                    .padding(.top, 16)
//                    .padding(.horizontal, 8)
//                    .padding(.bottom, 12)

//                    Divider()

                    ZStack(alignment: .bottomTrailing) {
                        List(viewState.merchandise) { mesechandise in
                            Button {
                                viewState.xxx(merchandise: mesechandise)
                            } label: {
                                ReviewSearchRow(merchandise: mesechandise)
                            }
                        }

//                        if viewState.isEditing {
//                            Button {
//                                keyboardFocused = false
//                            } label: {
//                                Color.black
//                                    .opacity(0.1)
//                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                            }
//                        }

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
                }

                if viewState.showingBarcodeView {
                    ZStack(alignment: .topLeading) {
                        BarcodeScannerView { code in
                            viewState.codeSccaned(code: code)
                        }

                        Button {
                            viewState.barodeHideButtonTapped()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .tint(Color.white)
                                .padding(8)
                                .background(Color.gray)
                                .cornerRadius(8)
                                .scaleEffect(1.2)
                                .padding(8)
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
