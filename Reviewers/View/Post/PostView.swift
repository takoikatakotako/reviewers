import SwiftUI

struct PostView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: PostViewState

    @State var text = ""
    @State var destinationTextInputView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // テキスト
                    Button {
                        destinationTextInputView = true
                    } label: {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 12) {
                                CommonText(text: "テキスト", font: .mPlus2SemiBold(size: 14), lineHeight: 18)
                                    .foregroundStyle(Color(.appMainText))
                                
                                if viewState.text.isEmpty {
                                    CommonText(text: "レビューを入力してください", font: .mPlus2Regular(size: 16), lineHeight: 20, alignment: .leading)
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
                    
                    
                    // バーコード
                    Button {
                        viewState.barcodeTapped()
                    } label: {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 12) {
                                CommonText(text: "バーコード", font: .mPlus2SemiBold(size: 14), lineHeight: 18)
                                    .foregroundStyle(Color(.appMainText))
                                
                                if viewState.barcode.isEmpty {
                                    CommonText(text: "バーコードを読み込んでください", font: .mPlus2Regular(size: 16), lineHeight: 20, alignment: .leading)
                                        .foregroundStyle(Color(.appSubText))
                                } else {
                                    CommonText(text: viewState.barcode, font: .mPlus2Regular(size: 16), lineHeight: 20)
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
                        .padding(.top, 12)
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
                    
                    
                    
                    // 写真
                    VStack(alignment: .leading, spacing: 12) {
                        CommonText(text: "写真", font: .mPlus2SemiBold(size: 14), lineHeight: 18)
                            .foregroundStyle(Color(.appMainText))
                        
                        HStack(spacing: 8) {
                            
                            Button {
                                
                            } label: {
                                Image(.samplePockey)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 56)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }

                            
                            Button {
                                
                            } label: {
                                Image(.samplePockey)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 56)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            
                            Button {
                                
                            } label: {
                                Image(.samplePockey)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 56)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            
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
                                .frame(width: 84, height: 56)
                                .background(Color(.appGreenBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                    
                    Divider()

                }
            }
            .navigationDestination(isPresented: $destinationTextInputView) {
                PostInputTextView(text: $viewState.text)
            }
            .onAppear {
                // viewState.onAppear()
            }
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
                        dismiss()
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
    PostView(viewState: PostViewState())
}
