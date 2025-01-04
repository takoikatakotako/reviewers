import SwiftUI
import SDWebImageSwiftUI
import LicenseList

struct MyReviewListView: View {
    @StateObject var viewState: MyReviewListViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            List(viewState.reviews) {review in
                Button {
                    viewState.reviewTapped(review: review)
                } label: {
                    CommonSimpleReviewRow(
                        uid: viewState.uid,
                        review: review,
                        enableReportReview: false,
                        imageTapAction: { imageUrl in
                            viewState.imageTapped(imageURL: imageUrl)
                        },
                        deleteReviewAction: { review in
                            viewState.deleteReviewTapped(review: review)
                        },
                        reportReviewAction: { _ in }
                    )
                }
                .listRowInsets(EdgeInsets())
                .listStyle(.grouped)
                .scrollIndicators(.hidden)
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
        .tint(Color(.appMainText))
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.reviewDeleted)) { output in
            guard let reviewId = output.userInfo?["reviewId"] as? String else {
                return
            }
            viewState.recieveDeleteReview(reviewId: reviewId)
        }
        .alert(
            "",
               isPresented: $viewState.showingReviewDeleteConfirmAlert,
            presenting: viewState.showingReviewDeleteConfirmAlertPresenting,
            actions: { review in
            Button("投稿を削除", role: .destructive) {
                viewState.deleteReview(review: review)
            }
            Button("キャンセル", role: .cancel) {}
        }, message: { review in
            Text("「\(review.comment)」を削除してもよろしいですか？")
        })
        .alert("", isPresented: $viewState.showingReviewDeleteCompleteAlert, actions: {
            Button("とじる") {}
        }, message: {
            Text("レビューの削除が完了しました。")
        })
        .onAppear {
            viewState.onAppear()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .fullScreenCover(item: $viewState.fullScreenCover, content: { item in
            switch item {
            case .image(imageURL: let imageURL):
                CommonImageViewer(url: imageURL)
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
                Text("マイレビュー")
                    .font(.system(size: 16).bold())
                    .foregroundStyle(Color.white)
            }
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}
