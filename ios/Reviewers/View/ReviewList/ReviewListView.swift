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
                                    enableReportReview: true,
                                    imageTapAction: { imageUrl in
                                        viewState.imageTapped(imageURL: imageUrl)
                                    },
                                    deleteReviewAction: { review in
                                        viewState.deleteReviewTapped(review: review)
                                    },
                                    reportReviewAction: { review in
                                        viewState.reportReview(review: review)
                                    })
                            }
                            .onAppear {
                                if viewState.reviews.last == review {
                                    viewState.fetchNewReview()
                                }
                            }
                            .listRowInsets(EdgeInsets())
                        }

                        if viewState.reviews.isNotEmpty {
                            HStack {
                                if viewState.isFetching {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                }
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
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.reviewDeleted)) { output in
                guard let reviewId = output.userInfo?["reviewId"] as? String else {
                    return
                }
                viewState.recieveDeleteReview(reviewId: reviewId)
            }
            .navigationDestination(for: ReviewListViewPath.self) { pathValue in
                switch pathValue {
                case .account:
                // case .account(profile: let profile):
                    Text("この画面が見えたらおかしいよ")
                    // AccountView(viewState: AccountViewState(profile: profile))
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
                case .report(review: let review):
                    ReportReviewView(viewState: ReportReviewViewState(review: review))
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
                Text("「\(review.comment)」を削除してもよろしいですか？")
            })
            .alert(
                "",
                isPresented: $viewState.showingErrorAlert,
                presenting: viewState.showingErrorAlertPresenting,
                actions: { _ in
                    Button("とじる", role: .none) {}
                }, message: { message in
                    Text(message)
                }
            )
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 16)
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
