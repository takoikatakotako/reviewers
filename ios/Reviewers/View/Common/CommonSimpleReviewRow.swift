import SwiftUI
import SDWebImageSwiftUI

struct CommonSimpleReviewRow: View {
    let uid: String
    let review: Review
    let imageTapAction: (_ url: URL?) -> Void
    let deleteReviewAction: (_ review: Review) -> Void
    let reportReviewAction: (_ review: Review) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.appMain)

                        Image(systemName: review.rate > 1 ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.appMain)

                        Image(systemName: review.rate > 2 ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.appMain)

                        Image(systemName: review.rate > 3 ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.appMain)

                        Image(systemName: review.rate > 4 ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.appMain)
                    }
                    CommonText(text: review.createdAtString, font: .mPlus2Regular(size: 14), lineHeight: 18)
                        .foregroundStyle(Color(.appMainText))
                }

                Spacer()

                HStack(spacing: 0) {
                    Spacer()

                    Menu {
                        if uid == review.uid {
                            Button(role: .destructive) {
                                deleteReviewAction(review)
                            } label: {
                                HStack {
                                    Text("投稿を削除")
                                    Spacer()
                                    Image(systemName: "trash")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                        Button(role: .none) {
                            reportReviewAction(review)
                        } label: {
                            HStack {
                                Text("投稿を報告")
                                    .foregroundStyle(Color(.appMainText))

                                Spacer()
                                Image(systemName: "flag")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color(.appSubText))

                    }

                }
            }

            if review.comment.isNotEmpty {
                CommonText(
                    text: review.comment,
                    font: .mPlus2Regular(size: 14),
                    lineHeight: 20,
                    alignment: .leading
                )
                .foregroundStyle(Color(.appMainText))
                .padding(.top, 12)
            }

            // 画像
            if review.imageUrls.count == 4 {
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        Button {
                            imageTapAction(review.imageUrls[0])
                        } label: {
                            ReviewListRowImage(url: review.imageUrls[0])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }

                        Button {
                            imageTapAction(review.imageUrls[1])
                        } label: {
                            ReviewListRowImage(url: review.imageUrls[1])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }
                    }

                    HStack(spacing: 4) {
                        Button {
                            imageTapAction(review.imageUrls[2])
                        } label: {
                            ReviewListRowImage(url: review.imageUrls[2])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }

                        Button {
                            imageTapAction(review.imageUrls[3])
                        } label: {
                            ReviewListRowImage(url: review.imageUrls[3])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }
                    }
                }
                .padding(.top, 12)
            } else if review.imageUrls.count == 3 {
                HStack(spacing: 4) {
                    Button {
                        imageTapAction(review.imageUrls[0])
                    } label: {
                        ReviewListRowImage(url: review.imageUrls[0])
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 204)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                    }

                    VStack(spacing: 4) {
                        Button {
                            imageTapAction(review.imageUrls[1])
                        } label: {
                            ReviewListRowImage(url: review.imageUrls[1])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }

                        Button {
                            imageTapAction(review.imageUrls[2])
                        } label: {
                            ReviewListRowImage(url: review.imageUrls[2])
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        }
                    }
                }
                .padding(.top, 12)
            } else if review.imageUrls.count == 2 {
                HStack(spacing: 4) {
                    Button {
                        imageTapAction(review.imageUrls[0])
                    } label: {
                        ReviewListRowImage(url: review.imageUrls[0])
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                    }

                    Button {
                        imageTapAction(review.imageUrls[1])
                    } label: {
                        ReviewListRowImage(url: review.imageUrls[1])
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                    }
                }
                .padding(.top, 12)
            } else if review.imageUrls.count == 1 {
                Button {
                    imageTapAction(review.imageUrls[0])
                } label: {
                    ReviewListRowImage(url: review.imageUrls[0])
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                }
                .padding(.top, 12)
            }

            //            if let merchandise = review.merchandise {
            //                CommonText(
            //                    text: "商品名: \(merchandise.name)",
            //                    font: .mPlus2Regular(size: 14),
            //                    lineHeight: 20,
            //                    alignment: .leading
            //                )
            //                .foregroundStyle(Color(.appMainText))
            //                .padding(.top, 12)
            //            } else {
            //                CommonText(
            //                    text: "JANコード: \(review.code)",
            //                    font: .mPlus2Regular(size: 14),
            //                    lineHeight: 20,
            //                    alignment: .leading
            //                )
            //                .foregroundStyle(Color(.appMainText))
            //                .padding(.top, 12)
            //            }
        }
        .padding(.top, 12)
        .padding(.leading, 12)
        .padding(.trailing, 12)
        .padding(.bottom, 12)
    }
}

// #Preview {
//    ReviewListViewRow(title: "基礎理論")
// }
