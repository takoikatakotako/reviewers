import SwiftUI

struct DebugMerchandiseAddView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: DebugMerchandiseAddViewState

    var body: some View {
        ZStack {
            List {
                Button {
                    viewState.nameTapped()
                } label: {
                    VStack(alignment: .leading) {
                        CommonText(text: "商品名", font: .mPlus2SemiBold(size: 16), lineHeight: 18)
                        CommonText(text: viewState.name, font: .mPlus2Regular(size: 16), lineHeight: 18)
                    }
                }

                Button {
                    viewState.codeTapped()
                } label: {
                    VStack(alignment: .leading) {
                        CommonText(text: "商品コード", font: .mPlus2SemiBold(size: 16), lineHeight: 18)
                        CommonText(text: viewState.code, font: .mPlus2Regular(size: 16), lineHeight: 18)
                    }
                }
            }
            .listStyle(.inset)
            .scrollIndicators(.hidden)

            if viewState.indicator {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .scaleEffect(1.2)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $viewState.navigationDestination) {
            CommonBarcodeScannerView(code: $viewState.code)
        }
        .alert("商品名入力", isPresented: $viewState.showingNameAlert) {
            TextField("商品名", text: $viewState.name)

            Button {
            } label: {
                Text("とじる")
            }
        }
        .alert("登録完了", isPresented: $viewState.showingSuccessAlert) {
            Button {
            } label: {
                Text("とじる")
            }
        }
        .alert("エラー", isPresented: $viewState.showingErrorAlert) {
            Button {
            } label: {
                Text("とじる")
            }
        }
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
                Text("商品登録")
                    .font(.system(size: 16).bold())
                    .foregroundStyle(Color.white)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewState.register()
                }, label: {
                    Text("登録")
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                })
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        DebugMerchandiseAddView(viewState: DebugMerchandiseAddViewState())
    }
}
