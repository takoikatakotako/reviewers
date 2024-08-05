import SwiftUI
import SDWebImageSwiftUI

struct ReviewDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: ReviewDetailViewState
    @FocusState var keyboardFocused: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 12) {
                        WebImage(url: URL(string: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(viewState.review.uid)/profile.png")) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle().foregroundColor(Color(.appBackground))
                        }
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading, spacing: 4) {
                            CommonText(text: "かびごん小野", font: .mPlus2Medium(size: 14), lineHeight: 18)
                                .foregroundStyle(Color(.appMainText))
                            CommonText(text: viewState.review.createdAtString, font: .mPlus2Regular(size: 14), lineHeight: 18)
                                .foregroundStyle(Color(.appMainText))
                        }

                        Spacer()

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.appMain)

                            Image(systemName: viewState.review.rate > 1 ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.appMain)
                            
                            Image(systemName: viewState.review.rate > 2 ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.appMain)
                            
                            Image(systemName: viewState.review.rate > 3 ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.appMain)
                            
                            Image(systemName: viewState.review.rate > 4 ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.appMain)
                        }
                    }
                    
                    if viewState.review.comment.isNotEmpty {
                        CommonText(
                            text: viewState.review.comment,
                            font: .mPlus2Regular(size: 14),
                            lineHeight: 20,
                            alignment: .leading
                        )
                        .foregroundStyle(Color(.appMainText))
                        .padding(.top, 12)
                    }

                    // 画像
                    if viewState.review.images.count == 4 {
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Button {
                                    print("xxx")
                                } label: {
                                    ReviewListRowImage(urlString: viewState.review.imageUrlStrings[0])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }

                                
                                Button {
                                    print("yyy")
                                } label: {
                                    ReviewListRowImage(urlString: viewState.review.imageUrlStrings[1])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }
                            }
                            
                            HStack(spacing: 4) {
                                Button {
                                    print("zzz")
                                } label: {
                                    ReviewListRowImage(urlString: viewState.review.imageUrlStrings[2])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }

                                Button {
                                    print("xyz")
                                } label: {
                                    ReviewListRowImage(urlString: viewState.review.imageUrlStrings[3])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }
                            }
                        }
                        .padding(.top, 12)
                    } else if viewState.review.images.count == 3 {
                        HStack(spacing: 4) {
                            
                            Button {
                                print("xxx")
                            } label: {
                                ReviewListRowImage(urlString: viewState.review.imageUrlStrings[0])
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 204)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .clipped()
                            }

                            
                            VStack(spacing: 4) {
                                Button {
                                    print("yyy")
                                } label: {
                                    ReviewListRowImage(urlString: viewState.review.imageUrlStrings[1])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }

                                Button {
                                    print("zzz")
                                } label: {
                                    ReviewListRowImage(urlString: viewState.review.imageUrlStrings[2])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }
                            }
                        }
                        .padding(.top, 12)
                    } else if viewState.review.images.count == 2 {
                        HStack(spacing: 4) {
                            Button {
                                print("zzz")
                            } label: {
                                ReviewListRowImage(urlString: viewState.review.imageUrlStrings[0])
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .clipped()
                            }

                            
                            Button {
                                print("xyz")
                            } label: {
                                ReviewListRowImage(urlString: viewState.review.imageUrlStrings[1])
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .clipped()
                            }
                        }
                        .padding(.top, 12)
                    } else if viewState.review.images.count == 1 {
                        Button {
                            print("xyz")
                        } label: {
                            ReviewListRowImage(urlString: viewState.review.imageUrlStrings[0])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }
                        .padding(.top, 12)
                    }

                    // XXX
                    HStack(spacing: 0) {
                        Spacer()

                        HStack(spacing: 8) {
                            Button {

                            } label: {
                                Image(systemName: "bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color(.appMainText))
                                    .padding(8)
                            }

                            Button {

                            } label: {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color(.appMainText))
                                    .padding(8)
                            }
                        }
                    }
                    .padding(.top, 12)

                    // アフリアエイト
                    HStack(spacing: 8) {
                        // Amazon
                        Button {

                        } label: {
                            VStack(spacing: 0) {
                                CommonText(text: "Amazon", font: .mPlus2Medium(size: 18), lineHeight: 20)
                                    .foregroundStyle(Color(.appMainText))
                                CommonText(text: "アフリエイト広告", font: .mPlus2Medium(size: 14), lineHeight: 20)
                                    .foregroundStyle(Color(.appSubText))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 60)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .fill(Color(.appBackground))
                            }
                            .mask {
                                RoundedRectangle(cornerRadius: 8)
                            }
                        }

                        // 楽天市場
                        Button {

                        } label: {
                            VStack(spacing: 0) {
                                CommonText(text: "楽天市場", font: .mPlus2Medium(size: 18), lineHeight: 20)
                                    .foregroundStyle(Color(.appMainText))
                                CommonText(text: "アフリエイト広告", font: .mPlus2Medium(size: 14), lineHeight: 20)
                                    .foregroundStyle(Color(.appSubText))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 60)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .fill(Color(.appBackground))
                            }
                            .mask {
                                RoundedRectangle(cornerRadius: 8)
                            }
                        }
                    }
                    .padding(.top, 12)

                    Divider()
                        .padding(.top, 12)

                    ForEach(viewState.comments) { comment in

                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 12) {
                                Image(.icon)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))

                                VStack(alignment: .leading, spacing: 4) {
                                    CommonText(text: comment.uid, font: .mPlus2Medium(size: 14), lineHeight: 18)
                                        .foregroundStyle(Color(.appMainText))
                                    CommonText(text: "2024/12/23 23:12", font: .mPlus2Regular(size: 14), lineHeight: 18)
                                        .foregroundStyle(Color(.appMainText))
                                }

                                Spacer()

                                Button {

                                } label: {
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(Color(.appMainText))
                                        .padding(8)
                                }
                            }
                            .padding(.top, 12)

                            CommonText(
                                text: comment.comment,
                                font: .mPlus2Regular(size: 14),
                                lineHeight: 20,
                                alignment: .leading
                            )
                            .foregroundStyle(Color(.appMainText))
                            .padding(.top, 12)

                            Divider()
                                .padding(.top, 12)
                        }
                    }

                }
                .padding(.top, 12)
                .padding(.leading, 12)
                .padding(.trailing, 12)
                .padding(.bottom, 72)
            }

            //            VStack(spacing: 8) {
            //                HStack(spacing: 8) {
            //                    Button {
            //
            //                    } label: {
            //                        Text("間違えた問題")
            //                            .font(.system(size: 18).bold())
            //                            .foregroundStyle(Color.white)
            //                            .frame(height: 48)
            //                            .frame(minWidth: 0, maxWidth: .infinity)
            //                            .background(Color(.appBlueBackground))
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                    }
            //
            //                    Button {
            //
            //                    } label: {
            //                        Text("チェックから出題")
            //                            .font(.system(size: 18).bold())
            //                            .foregroundStyle(Color.white)
            //                            .frame(height: 48)
            //                            .frame(minWidth: 0, maxWidth: .infinity)
            //                            .background(Color(.appRedBackground))
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                    }
            //                }
            //                .padding(.horizontal, 16)
            //
            //                Button {
            //
            //                } label: {
            //                    Text("ランダムに出題")
            //                        .font(.system(size: 18).bold())
            //                        .foregroundStyle(Color.white)
            //                        .frame(height: 48)
            //                        .frame(minWidth: 0, maxWidth: .infinity)
            //                        .background(Color(.appGreenBackground))
            //                        .clipShape(RoundedRectangle(cornerRadius: 8))
            //                        .padding(.horizontal, 16)
            //                        .padding(.bottom, 8)
            //                }
            //            }
            //            .clipped()

            if keyboardFocused {
                Button {
                    withAnimation {
                        keyboardFocused = false
                    }
                } label: {
                    VStack {
                        Rectangle()
                            .foregroundStyle(Color.black.opacity(0.2))
                            .frame(minWidth: 0, maxWidth: .infinity)
                        Spacer()
                    }
                }
            }

            VStack(alignment: .trailing, spacing: 12) {
                TextField("投稿にコメント", text: $viewState.comment, axis: .vertical)
                    .focused($keyboardFocused)
                    .textFieldStyle(.roundedBorder)

                if keyboardFocused {
                    Button {
                        viewState.postComment()
                    } label: {
                        CommonText(text: "コメント", font: .mPlus2SemiBold(size: 16), lineHeight: 20)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 36)
                            .background(Color(.appGreenBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                    }
                }

            }
            .padding(.top, 12)
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
            .background(Color.white)
        }
        .onAppear {
            viewState.onAppear()
        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
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
            //
            //            ToolbarItem(placement: .principal) {
            //                Text(viewState.title)
            //                    .font(.system(size: 16).bold())
            //                    .foregroundStyle(Color.white)
            //            }

        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

// #Preview {
//    NavigationStack {
//        ReviewDetailView(viewState: ReviewDetailViewState(review: Review))
//    }
// }
