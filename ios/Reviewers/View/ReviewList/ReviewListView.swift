import SwiftUI

struct ReviewListView: View {
    @StateObject var viewState: ReviewListViewState

    var body: some View {
        NavigationStack(path: $viewState.path) {
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    List {
                        ForEach(viewState.reviews) { review in
                            Button {
                                viewState.reviewTapped(review: review)
                            } label: {
                                CommonSimpleReviewRow(
                                    uid: viewState.uid,
                                    review: review,
                                    imageTapAction: { imageUrl in
                                        viewState.imageTapped(imageURL: imageUrl)
                                    },
                                    deleteReviewAction: { review in
                                        viewState.deleteReviewTapped(review: review)
                                    },
                                    reportReviewAction: { _ in

                                    })
                            }
                            .onAppear {
                                if viewState.reviews.last == review {
                                    viewState.xxxx()
                                }
                            }
                            .listRowInsets(EdgeInsets())
                        }

                        HStack {
                            if viewState.isFetching {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }

                    }
                    .refreshable {
                        await viewState.refresh()
                    }
                    .listStyle(.inset)

                    if viewState.reviews.isEmpty {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding()
                            .tint(Color.white)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .scaleEffect(1.2)
                    }
                }

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
                        .toolbar(.hidden, for: .tabBar)
                }
            }
            .fullScreenCover(item: $viewState.fullScreenCover, onDismiss: {
                viewState.onDismissPostSheet()
            }, content: { item in
                switch item {
                case .newPost:
                    PostReviewView(viewState: PostReviewViewState())
                case .image(imageURL: let imageURL):
                    CommonImageViewer(url: imageURL)
                case .signUp:
                    AuthView(viewState: AuthViewState())
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
            .alert("", isPresented: $viewState.showingReviewDeleteConfirmAlert, presenting: viewState.showingReviewDeleteConfirmAlertPresenting, actions: { review in
                Button("投稿を削除", role: .destructive) {
                    viewState.deleteReview(review: review)
                }
                Button("キャンセル", role: .cancel) {}
            }, message: { review in
                Text("投稿「\(review.comment)」を削除してもよろしいですか？")
            })
            .alert(
                "",
                isPresented: $viewState.showingErrorAlert,
                presenting: viewState.showingErrorAlertPresenting,
                actions: { _ in
                    Button("とじる", role: .none) {}
                }, message: { message in
                    Text(message)
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
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    ReviewListView(viewState: ReviewListViewState())
}
