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
                        imageTapAction: { imageUrl in
                            viewState.imageTapped(imageURL: imageUrl)
                        },
                        deleteReviewAction: { _ in

                        },
                        reportReviewAction: { _ in

                        }
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
