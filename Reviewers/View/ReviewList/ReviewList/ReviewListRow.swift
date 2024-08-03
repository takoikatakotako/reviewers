import SwiftUI
import SDWebImageSwiftUI

struct ReviewListRow: View {
    //    let title: String
    
    let review: Review
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                Image(.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    CommonText(text: "かびごん小野", font: .mPlus2Medium(size: 14), lineHeight: 18)
                        .foregroundStyle(Color(.appMainText))
                    CommonText(text: review.createdAtString, font: .mPlus2Regular(size: 14), lineHeight: 18)
                        .foregroundStyle(Color(.appMainText))
                }
                
                Spacer()
                
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
            
            
            if review.images.count == 4 {
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[0])")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                        
                        ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[1])")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                    }
                    
                    HStack(spacing: 4) {
                        ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[2])")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                        
                        ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[3])")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                    }
                }
                .padding(.top, 12)
            } else if review.images.count == 3 {
                HStack(spacing: 4) {
                    ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[0])")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 204)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                    
                    VStack(spacing: 4) {
                        ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[1])")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                        
                        ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[2])")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                    }
                }
                .padding(.top, 12)
            } else if review.images.count == 2 {
                HStack(spacing: 4) {
                    ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[0])")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                    
                    ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[1])")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                }
                .padding(.top, 12)
            } else if review.images.count == 1 {
                ReviewListRowImage(urlString: "https://storage.googleapis.com/reviewers-develop.appspot.com/image/user/\(review.uid)/\(review.images[0])")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()
                .padding(.top, 12)
            }
            
            
            
            
            
            //                VStack(spacing: 8) {
            //                    HStack(spacing: 8) {
            //                        FirestorageImage(uid: review.uid, fileName: review.images[0])
            //                            .frame(height: 100)
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                            .clipped()
            //
            //                        FirestorageImage(uid: review.uid, fileName: review.images[1])
            //                            .frame(height: 100)
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                            .clipped()
            //                    }
            //
            //                    HStack(spacing: 8) {
            //                        FirestorageImage(uid: review.uid, fileName: review.images[2])
            //                            .frame(height: 100)
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                            .clipped()
            //
            //                        FirestorageImage(uid: review.uid, fileName: review.images[3])
            //                            .frame(height: 100)
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                            .clipped()
            //                    }
            //                }
            //                .padding(.top, 12)
            
            
            //            ForEach(review.images, id: \.self) { image in
            //
            //            }
            
            CommonText(
                text: "JANコード: \(review.code)",
                font: .mPlus2Regular(size: 14),
                lineHeight: 20,
                alignment: .leading
            )
            .foregroundStyle(Color(.appMainText))
            .padding(.top, 12)
        }
        .padding(.top, 12)
        .padding(.leading, 12)
        .padding(.trailing, 12)
        .padding(.bottom, 12)
        //        VStack(spacing: 0) {
        //            HStack(spacing: 16) {
        //                VStack(spacing: 8) {
        //                    HStack(spacing: 0) {
        //                        Text(title)
        //                            .font(.system(size: 14))
        //                            .foregroundStyle(Color(.appMainText))
        //                        Spacer()
        //                        Text("23 / 76")
        //                            .font(.system(size: 14))
        //                            .foregroundStyle(Color(.appMainText))
        //                    }
        //
        //                    GeometryReader { geometry in
        //                        ZStack(alignment: .leading) {
        //                            RoundedRectangle(cornerRadius: 4.0)
        //                                .foregroundStyle(Color(.appBackground))
        //                                .frame(height: 8)
        //                                .frame(width: geometry.size.width)
        //
        //                            RoundedRectangle(cornerRadius: 4.0)
        //                                .foregroundStyle(Color(.appRedBackground))
        //                                .frame(height: 8)
        //                                .frame(width: geometry.size.width * 0.8)
        //
        //                            RoundedRectangle(cornerRadius: 4.0)
        //                                .foregroundStyle(Color(.appBlueBackground))
        //                                .frame(height: 8)
        //                                .frame(width: geometry.size.width * 0.7)
        //
        //                            RoundedRectangle(cornerRadius: 4.0)
        //                                .foregroundStyle(Color(.appGreenBackground))
        //                                .frame(height: 8)
        //                                .frame(width: geometry.size.width * 0.2)
        //                        }
        //                        .frame(minWidth: 0, maxWidth: .infinity)
        //                    }
        //                }
        //
        //                Image(systemName: "chevron.forward")
        //                    .resizable()
        //                    .scaledToFit()
        //                    .frame(width: 9)
        //            }
        //            .padding(.top, 16)
        //            .padding(.horizontal, 16)
        //            .padding(.bottom, 16)
        //
        //            Divider()
        //        }
    }
}

// #Preview {
//    ReviewListViewRow(title: "基礎理論")
// }
