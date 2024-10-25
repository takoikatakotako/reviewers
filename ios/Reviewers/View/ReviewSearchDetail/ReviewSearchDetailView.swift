import SwiftUI
import VisionKit

struct ReviewSearchDetailView: View {
    @StateObject var viewState: ReviewSearchDetailViewState
    @Environment(\.dismiss) var dismiss

    @State var isShowingScanner = true
    @State private var scannedText = ""

    var body: some View {
            ZStack {
                List {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            CommonText(text: viewState.merchandise.name, font: .mPlus2SemiBold(size: 16), lineHeight: 24, alignment: .leading)
                                .foregroundStyle(.appMainText)

                            Spacer()

//                            CommonText(text: "4.2", font: .mPlus2Regular(size: 14), lineHeight: 18)
//                                .foregroundStyle(.appMainText)
//
//                            HStack(spacing: 4) {
//                                Image(systemName: "star.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 18, height: 18)
//                                    .foregroundColor(.appMain)
//
//                                Image(systemName: "star.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 18, height: 18)
//                                    .foregroundColor(.appMain)
//
//                                Image(systemName: "star.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 18, height: 18)
//                                    .foregroundColor(.appMain)
//
//                                Image(systemName: "star.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 18, height: 18)
//                                    .foregroundColor(.appMain)
//
//                                Image(systemName: "star")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 18, height: 18)
//                                    .foregroundColor(.appMain)
//                            }
                        }

//                        CommonText(text: "ブランド: 江崎グリコ", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
//                            .foregroundStyle(.appMainText)

                        if let imageUrl = viewState.merchandise.imageURL {
                            ReviewListRowImage(url: imageUrl)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }

                        CommonText(text: "JANコード: \(viewState.merchandise.code)", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
                            .foregroundStyle(.appMainText)

//                        // アフリアエイト
//                        HStack(spacing: 8) {
//                            // Amazon
//                            Button {
//
//                            } label: {
//                                VStack(spacing: 0) {
//                                    CommonText(text: "Amazon", font: .mPlus2Medium(size: 18), lineHeight: 20)
//                                        .foregroundStyle(Color(.appMainText))
//                                    CommonText(text: "アフリエイト広告", font: .mPlus2Medium(size: 14), lineHeight: 20)
//                                        .foregroundStyle(Color(.appSubText))
//                                }
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .frame(height: 60)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(lineWidth: 1)
//                                        .fill(Color(.appBackground))
//                                }
//                                .mask {
//                                    RoundedRectangle(cornerRadius: 8)
//                                }
//                            }
//
//                            // 楽天市場
//                            Button {
//
//                            } label: {
//                                VStack(spacing: 0) {
//                                    CommonText(text: "楽天市場", font: .mPlus2Medium(size: 18), lineHeight: 20)
//                                        .foregroundStyle(Color(.appMainText))
//                                    CommonText(text: "アフリエイト広告", font: .mPlus2Medium(size: 14), lineHeight: 20)
//                                        .foregroundStyle(Color(.appSubText))
//                                }
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .frame(height: 60)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(lineWidth: 1)
//                                        .fill(Color(.appBackground))
//                                }
//                                .mask {
//                                    RoundedRectangle(cornerRadius: 8)
//                                }
//                            }
//                        }

                    }
                    .listRowInsets(EdgeInsets(top: 16, leading: 12, bottom: 12, trailing: 12))

                    ForEach(viewState.reviews) { review in
                        Button {
                            // viewState.reviewTapped(review: review)
                        } label: {
                            CommonSimpleReviewRow(
                                uid: "",
                                review: review) { url in
                                    print(url)
                                } deleteReviewAction: { review in
                                    print(review)
                                } reportReviewAction: { review in
                                    print(review)
                                }

                        }
                        .listRowInsets(EdgeInsets())
                    }
                }

                if viewState.loading {
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
//            .navigationDestination(item: $viewState.navigationDestination) { item in
//                switch item {
//                case .account(profile: let profile):
//                    AccountView(viewState: AccountViewState(profile: profile))
//                }
//            }
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
            .listStyle(.inset)
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

                ToolbarItem(placement: .principal) {
                    Text("商品詳細")
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

        }

}
