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
                        Button {
                            viewState.accounTapped(profile: viewState.review.profile)
                        } label: {
                            WebImage(url: viewState.profileImageURL) { image in
                                image.resizable()
                            } placeholder: {
                                CommonAccountImageHolder()
                            }
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Button {
                                viewState.accounTapped(profile: viewState.review.profile)
                            } label: {
                                CommonText(text: viewState.review.profile.nickname, font: .mPlus2Medium(size: 14), lineHeight: 18)
                                    .foregroundStyle(Color(.appMainText))
                            }

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

                    // XXX
                    HStack(spacing: 0) {
                        Spacer()

                        HStack(spacing: 8) {
//                            Button {
//
//                            } label: {
//                                Image(systemName: "bookmark")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 24, height: 24)
//                                    .foregroundStyle(Color(.appMainText))
//                                    .padding(8)
//                            }

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

                    // コメント
                    ForEach(viewState.comments) { comment in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 12) {
                                Button {
                                    viewState.accounTapped(profile: comment.profile)
                                } label: {
                                    WebImage(url: comment.profile.profileImageURL) { image in
                                        image.resizable()
                                    } placeholder: {
                                        CommonAccountImageHolder()
                                    }
                                    .transition(.fade(duration: 0.5))
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Button {
                                        viewState.accounTapped(profile: comment.profile)
                                    } label: {
                                        CommonText(text: comment.profile.nickname, font: .mPlus2Medium(size: 14), lineHeight: 18)
                                            .foregroundStyle(Color(.appMainText))
                                    }
                                    CommonText(text: comment.createdAtString, font: .mPlus2Regular(size: 14), lineHeight: 18)
                                        .foregroundStyle(Color(.appMainText))
                                }

                                Spacer()

                                Button {
                                    viewState.commentMenuTapped()
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
                AccountView(viewState: AccountViewState(profile: profile))
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
