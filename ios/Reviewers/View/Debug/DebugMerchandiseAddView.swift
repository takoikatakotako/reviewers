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
                        CommonText(text: viewState.code ?? "", font: .mPlus2Regular(size: 16), lineHeight: 18)
                    }
                }
                
                
                // MARK: - 写真
                VStack(alignment: .leading) {
                    CommonText(text: "写真", font: .mPlus2SemiBold(size: 16), lineHeight: 18)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            if let image = viewState.image {
                                Button {
                                    viewState.imageTapped()
                                } label: {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 56)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            } else {
                                Button {
                                    viewState.addImageByPhoto()
                                } label: {
                                    VStack(spacing: 0) {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 36, height: 36)
                                            .foregroundStyle(Color.white)
                                    }
                                    .frame(width: 80, height: 56)
                                    .background(Color(.appGreenBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                
//                                Button {
//                                    // viewState.addImageByCamera()
//                                } label: {
//                                    VStack(spacing: 0) {
//                                        Image(systemName: "camera")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 36, height: 36)
//                                            .foregroundStyle(Color.white)
//                                    }
//                                    .frame(width: 80, height: 56)
//                                    .background(Color(.appGreenBackground))
//                                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                                }
                            }
                        }
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
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewState.showingSheet) {
            CommonBarcodeScannerView(
                code: $viewState.code,
                codeType: $viewState.codeType
            )
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
                dismiss()
            } label: {
                Text("とじる")
            }
        }
        .alert("すでに登録された商品です", isPresented: $viewState.showingAlreadyRegisterdAlert) {
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
        .sheet(item: $viewState.sheet, onDismiss: {

        }, content: { item in
            switch item {
            case .showImagePickerSheet:
                DebugImagePicker(image: $viewState.image)
            case .showImageViewerSheet:
                DebugImageViewer(image: $viewState.image)
            }
        })
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
