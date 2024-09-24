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
                        VStack(alignment: .leading, spacing: 4) {
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
                            CommonText(text: viewState.review.createdAtString, font: .mPlus2Regular(size: 14), lineHeight: 18)
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
                    if viewState.review.imageUrls.count == 4 {
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Button {
                                    viewState.imageTapped(imageURL: viewState.review.imageUrls[0])
                                } label: {
                                    ReviewListRowImage(url: viewState.review.imageUrls[0])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }

                                Button {
                                    viewState.imageTapped(imageURL: viewState.review.imageUrls[1])
                                } label: {
                                    ReviewListRowImage(url: viewState.review.imageUrls[1])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }
                            }

                            HStack(spacing: 4) {
                                Button {
                                    viewState.imageTapped(imageURL: viewState.review.imageUrls[2])
                                } label: {
                                    ReviewListRowImage(url: viewState.review.imageUrls[2])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }

                                Button {
                                    viewState.imageTapped(imageURL: viewState.review.imageUrls[3])
                                } label: {
                                    ReviewListRowImage(url: viewState.review.imageUrls[3])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }
                            }
                        }
                        .padding(.top, 12)
                    } else if viewState.review.imageUrls.count == 3 {
                        HStack(spacing: 4) {

                            Button {
                                viewState.imageTapped(imageURL: viewState.review.imageUrls[0])
                            } label: {
                                ReviewListRowImage(url: viewState.review.imageUrls[0])
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 204)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .clipped()
                            }

                            VStack(spacing: 4) {
                                Button {
                                    viewState.imageTapped(imageURL: viewState.review.imageUrls[1])
                                } label: {
                                    ReviewListRowImage(url: viewState.review.imageUrls[1])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }

                                Button {
                                    viewState.imageTapped(imageURL: viewState.review.imageUrls[2])
                                } label: {
                                    ReviewListRowImage(url: viewState.review.imageUrls[2])
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                }
                            }
                        }
                        .padding(.top, 12)
                    } else if viewState.review.imageUrls.count == 2 {
                        HStack(spacing: 4) {
                            Button {
                                viewState.imageTapped(imageURL: viewState.review.imageUrls[0])
                            } label: {
                                ReviewListRowImage(url: viewState.review.imageUrls[0])
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .clipped()
                            }

                            Button {
                                viewState.imageTapped(imageURL: viewState.review.imageUrls[1])
                            } label: {
                                ReviewListRowImage(url: viewState.review.imageUrls[1])
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .clipped()
                            }
                        }
                        .padding(.top, 12)
                    } else if viewState.review.imageUrls.count == 1 {
                        Button {
                            viewState.imageTapped(imageURL: viewState.review.imageUrls[0])
                        } label: {
                            ReviewListRowImage(url: viewState.review.imageUrls[0])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }
                        .padding(.top, 12)
                    }

                    if let merchandise = viewState.review.merchandise {
                        CommonText(
                            text: "商品名: \(merchandise.name)",
                            font: .mPlus2Regular(size: 14),
                            lineHeight: 20,
                            alignment: .leading
                        )
                        .foregroundStyle(Color(.appMainText))
                        .padding(.top, 12)
                    } else {
                        CommonText(
                            text: "JANコード: \(viewState.review.code)",
                            font: .mPlus2Regular(size: 14),
                            lineHeight: 20,
                            alignment: .leading
                        )
                        .foregroundStyle(Color(.appMainText))
                        .padding(.top, 12)
                    }


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

                    // 
                    if viewState.loading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(.appMain)))
                                .scaleEffect(1.2)
                            Spacer()
                        }
                        .frame(height: 44)
                    }
                }
                .padding(.top, 12)
                .padding(.leading, 12)
                .padding(.trailing, 12)
                .padding(.bottom, 72)
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .alert("", isPresented: $viewState.showingSignInAlert, actions: {
            Button("とじる") {}
            Button("ログイン") {
                viewState.signInTapped()
            }
        }, message: {
            Text("コメントを投稿するにはログイン、アカウント作成が必要です。")
        })
        .navigationDestination(item: $viewState.navigationDestination) { item in
            switch item {
            case .account(profile: let profile):
                // AccountView(viewState: AccountViewState(profile: profile))
                Text("SSSS")
            case .reviewDetail(review: let review):
                ReviewDetailView(viewState: ReviewDetailViewState(review: review))
            }
        }
        .fullScreenCover(item: $viewState.fullScreenCover) { item in
            switch item {
            case .image(imageUrl: let url):
                CommonImageViewer(url: url)
            case .signUp:
                SignUpView(viewState: SignUpViewState())
            }
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
        .toolbar(.hidden, for: .tabBar)
    }
}

// #Preview {
//    NavigationStack {
//        ReviewDetailView(viewState: ReviewDetailViewState(review: Review))
//    }
// }
