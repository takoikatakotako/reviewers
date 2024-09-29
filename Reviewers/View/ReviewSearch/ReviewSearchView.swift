import SwiftUI
import VisionKit

struct ReviewSearchView: View {
    @StateObject var viewState: ReviewSearchViewState
    @Environment(\.dismiss) var dismiss
    
    @State var isShowingScanner = true
    @State private var scannedText = ""
    
    @State var text = ""
    
    //    @FocusState private var keyboardFocused: Bool
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        TextField("商品名を入力 または バーコードをスキャン", text: $text, onEditingChanged: {isEditing in
                            viewState.onEditingChanged(isEditing: isEditing)
                        })
                        Spacer()
                        Image(systemName: "barcode.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color(.appSubText))
                    }
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 16)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
                    
                    //
                    //                    if keyboardFocused {
                    //                        Button {
                    //
                    //                        } label: {
                    
                    //                        }
                    //                    } else {
                    //
                    //                    }
                    
                    ZStack {
                        List(viewState.merchandise) { mesechandise in
                            Button {
                                print("xxx")
                            } label: {
                                ReviewSearchRow(merchandise: mesechandise)
                            }
                        }

                        if viewState.isEditing {
                            Button {
                                print("xx")
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
            .background(Color(.appBackground))
            .tint(Color(.appMainText))
            .onAppear {
                viewState.onAppear()
            }
            //            .navigationDestination(item: $viewState.navigationDestination) { item in
            //                switch item {
            //                case .account(profile: let profile):
            //                    AccountView(viewState: AccountViewState(profile: profile))
            //                }
            //            }
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
