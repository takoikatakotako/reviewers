import SwiftUI

struct PostReviewView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: PostViewState

    @State var destinationTextInputView = false

    var body: some View {
        NavigationStack {

            ZStack {

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {

                        // バーコード
                        Button {
                            viewState.barcodeTapped()
                        } label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 12) {
                                    CommonText(text: "バーコード", font: .mPlus2SemiBold(size: 14), lineHeight: 18)
                                        .foregroundStyle(Color(.appMainText))

                                    if viewState.code.isEmpty {
                                        CommonText(text: "バーコードをスキャンしてください", font: .mPlus2Regular(size: 16), lineHeight: 20, alignment: .leading)
                                            .foregroundStyle(Color(.appSubText))
                                    } else {
                                        CommonText(text: viewState.code, font: .mPlus2Regular(size: 16), lineHeight: 20)
                                            .foregroundStyle(Color(.appMainText))
                                    }
                                }

                                Spacer()

                                Image(systemName: "barcode.viewfinder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color(.appSubText))
                            }
                            .padding(.top, 16)
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        }

                        Divider()

                        // レビュー
                        VStack(alignment: .leading, spacing: 12) {
                            CommonText(text: "レビュー", font: .mPlus2SemiBold(size: 14), lineHeight: 18)
                                .foregroundStyle(Color(.appMainText))

                            HStack(spacing: 8) {

                                Button {
                                    viewState.updateRate(rate: 1)
                                } label: {
                                    Image(systemName: viewState.rate >= 1 ? "star.fill" : "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .foregroundStyle(Color(.appMain))
                                }

                                Button {
                                    viewState.updateRate(rate: 2)
                                } label: {
                                    Image(systemName: viewState.rate >= 2 ? "star.fill" : "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .foregroundStyle(Color(.appMain))
                                }

                                Button {
                                    viewState.updateRate(rate: 3)
                                } label: {
                                    Image(systemName: viewState.rate >= 3 ? "star.fill" : "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .foregroundStyle(Color(.appMain))
                                }

                                Button {
                                    viewState.updateRate(rate: 4)
                                } label: {
                                    Image(systemName: viewState.rate >= 4 ? "star.fill" : "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .foregroundStyle(Color(.appMain))
                                }

                                Button {
                                    viewState.updateRate(rate: 5)
                                } label: {
                                    Image(systemName: viewState.rate >= 5 ? "star.fill" : "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .foregroundStyle(Color(.appMain))
                                }

                                Spacer()
                            }
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 12)

                        Divider()

                        // テキスト
                        Button {
                            destinationTextInputView = true
                        } label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 12) {
                                    CommonText(text: "コメント", font: .mPlus2SemiBold(size: 14), lineHeight: 18)
                                        .foregroundStyle(Color(.appMainText))

                                    if viewState.text.isEmpty {
                                        CommonText(text: "コメントを入力してください", font: .mPlus2Regular(size: 16), lineHeight: 20, alignment: .leading)
                                            .foregroundStyle(Color(.appSubText))
                                    } else {
                                        CommonText(text: viewState.text, font: .mPlus2Regular(size: 16), lineHeight: 20, alignment: .leading)
                                            .foregroundStyle(Color(.appMainText))
                                    }
                                }

                                Spacer()
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        }

                        Divider()

                        // 写真
                        VStack(alignment: .leading, spacing: 8) {
                            CommonText(text: "写真", font: .mPlus2SemiBold(size: 14), lineHeight: 18)
                                .foregroundStyle(Color(.appMainText))

                            HStack(spacing: 8) {

                                ForEach(viewState.images, id: \.self) { image in
                                    Button {
                                        viewState.imageTapped(image: image)
                                    } label: {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 56)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }

                                if viewState.images.count < 4 {
                                    Button {
                                        viewState.addImage()
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
                                }

                                Spacer()
                            }
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 12)

                        Divider()
                    }

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
            }
            .onAppear {
                // viewState.onAppear()
            }
            .alert("", isPresented: $viewState.showingRegisterMerchandiseAlert, actions: {
                TextField("商品名", text: $viewState.merchandiseName)

                Button {
                    dismiss()
                } label: {
                    Text("とじる")
                }
                
                Button {
                    viewState.registerMerchandise()
                } label: {
                    Text("登録")
                }
            }, message: {
                Text("レビューの投稿が完了しました。ただ登録されていない商品でした。商品名をよかったら教えてください。")
            })
            .alert("", isPresented: $viewState.showingRegisterMerchandiseCompleteAlert, actions: {
                Button {
                    dismiss()
                } label: {
                    Text("とじる")
                }

            }, message: {
                Text("レビューの投稿が完了しました。ありがとうございました！")
            })
            .alert("", isPresented: $viewState.showingMessageAlert, actions: {
                Button("とじる", action: {})
            }, message: {
                Text(viewState.alertMessage)
            })
            .alert("", isPresented: $viewState.showingPostCompleteAlert, actions: {
                Button("とじる", action: {
                    dismiss()
                })
            }, message: {
                Text("投稿完了！")
            })
            .navigationDestination(isPresented: $destinationTextInputView) {
                ReviewInputView(text: $viewState.text)
            }
            .sheet(item: $viewState.sheet, onDismiss: {

            }, content: { item in
                switch item {
                case .showImagePickerSheet:
                    PostImagePicker(images: $viewState.images)
                case .showImageViewerSheet(let image):
                    PostImageViewer(image: image, images: $viewState.images)
                case .showBarcodeScannerSheet:
                    PostBarcodeScannerView(code: $viewState.code)
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        CommonText(text: "キャンセル", font: .mPlus2Regular(size: 16), lineHeight: 20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewState.post()
                    } label: {
                        CommonText(text: "ポスト", font: .mPlus2SemiBold(size: 16), lineHeight: 20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 8)
                            .padding(.trailing, 4)
                            .padding(.bottom, 8)
                    }
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    PostReviewView(viewState: PostViewState())
}
