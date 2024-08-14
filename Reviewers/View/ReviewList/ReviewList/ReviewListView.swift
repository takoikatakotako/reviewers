import SwiftUI

struct ReviewListView: View {
    @StateObject var viewState: ReviewListViewState

    var body: some View {
        NavigationStack(path: $viewState.path) {
            ZStack(alignment: .bottomTrailing) {
                List(viewState.reviews) {review in
                    Button {
                        viewState.reviewTapped(review: review)
                    } label: {
                        CommonReviewRow(review: review, accountTapAction: {profile in
                            viewState.accountTapped(profile: profile)
                        }, imageTapAction: {imageUrlString in
                            viewState.fullScreenCover = .image(urlString: imageUrlString)
                        }, menuTapAction: { review in
                            viewState.menuTapped(review: review)
                        })
                    }
                    .listRowInsets(EdgeInsets())
                }
                .refreshable {
                    await viewState.pullToRefresh()
                }
                .listStyle(.inset)

                Button {
                    viewState.postButtonTapped()
                } label: {
                    VStack {
                        Image(systemName: "plus")
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
            .onAppear {
                viewState.onAppear()
            }
            .navigationDestination(for: ReviewListViewPath.self) { pathValue in
                switch pathValue {
                case .account(profile: let profile):
                    AccountView(viewState: AccountViewState(profile: profile))
                case .reviewDetail(review: let review):
                    ReviewDetailView(viewState: ReviewDetailViewState(review: review))
                }
            }
            .fullScreenCover(item: $viewState.fullScreenCover, onDismiss: {
                viewState.onDismissPostSheet()
            }, content: { item in
                switch item {
                case .newPost:
                    PostView(viewState: PostViewState())
                case .image(urlString: let urlString):
                    CommonImageViewer(urlString: urlString)
                case .signUp:
                    SignUpView(viewState: SignUpViewState())
                }
            })
            .alert("", isPresented: $viewState.showingSignInAlert, actions: {
                Button("とじる") {}
                Button("ログイン") {
                    viewState.signInTapped()
                }
            }, message: {
                Text("レビューを投稿するにはログイン、アカウント作成が必要です。")
            })
            .alert("", isPresented: $viewState.showingReviewAlert, presenting: viewState.showingReviewAlertPresenting, actions: { presenting in
                if presenting.isMyReview {
                    Button("投稿を削除", role: .destructive) {
                        viewState.deleteReviewTapped(review: presenting.review)
                    }
                }
                Button("投稿を報告") {}
                Button("とじる", role: .cancel) {}
            }, message: { presenting in
                Text("\(presenting.review.comment)")
            })
            .alert("", isPresented: $viewState.showingReviewDeleteConfirmAlert, presenting: viewState.showingReviewDeleteConfirmAlertPresenting, actions: { review in
                Button("投稿を削除", role: .destructive) {
                    viewState.deleteReview(review: review)
                }
                Button("キャンセル", role: .cancel) {}
            }, message: { review in
                Text("投稿「\(review.comment)」を削除してもよろしいですか？")
            })
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.listTitleLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    ReviewListView(viewState: ReviewListViewState())
}

//            ZStack(alignment: .bottom) {
//                ScrollView {
//                    if let primariCategory = viewState.primariCategory {
//                        VStack {
//                            Picker("", selection: $viewState.favoriteColor) {
//                                ForEach(Array(primariCategory.secondaryCategories.enumerated()), id: \.element.hashValue) { index, secondaryCategory in
//                                    Text(secondaryCategory.title).tag(index)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                            .padding(.top, 16)
//                            .padding(.horizontal, 16)
//                            .padding(.bottom, 16)
//
//                            ForEach(primariCategory.secondaryCategories[viewState.favoriteColor].tertiaryCategories, id: \.hashValue) { tertiaryCategory in
//                                NavigationLink {
//                                    StudyCategoryDetailView(viewState: StudyCategoryDetailViewState(category: tertiaryCategory))
//                                } label: {
//                                    StudyCategoryListViewRow(title: tertiaryCategory.title)
//                                }
//                            }
//
//                            Spacer()
//                                .frame(height: 160)
//                        }
//
//                    } else {
//                        Text("Loading")
//                    }
//                }

//                VStack(spacing: 8) {
//                    HStack(spacing: 8) {
//                            Button {
//                                viewState.matigaeta()
//                            } label: {
//                                Text("間違えた問題")
//                                    .font(.system(size: 18).bold())
//                                    .foregroundStyle(Color.white)
//                                    .frame(height: 48)
//                                    .frame(minWidth: 0, maxWidth: .infinity)
//                                    .background(Color(.appBlueBackground))
//                                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                            }
//
//                        Button {
//                            viewState.check()
//                        } label: {
//                            Text("チェックから出題")
//                                .font(.system(size: 18).bold())
//                                .foregroundStyle(Color.white)
//                                .frame(height: 48)
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .background(Color(.appRedBackground))
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
//                    }
//                    .padding(.horizontal, 16)
//
//                    Button {
//                        viewState.random()
//                    } label: {
//                        Text("ランダムに出題")
//                            .font(.system(size: 18).bold())
//                            .foregroundStyle(Color.white)
//                            .frame(height: 48)
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .background(Color(.appGreenBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .padding(.horizontal, 16)
//                            .padding(.bottom, 8)
//                    }
//
//                }
//                .clipped()

//                if viewState.showingCover {
//                    VStack(spacing: 24) {
//                        CommonText(text: "問題を取得しています", font: .mPlus2Medium(size: 18), lineHeight: 18)
//                            .foregroundStyle(Color.white)
//
//                        ProgressView()
//                            .scaleEffect(1.8)
//                    }
//                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                    .background(
//                        Color.black
//                            .opacity(0.3)
//                            .ignoresSafeArea(.all)
//                    )
//                }
