import SwiftUI
import SDWebImageSwiftUI

struct AccountView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewState: AccountViewState
    
    var body: some View {
        List {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    WebImage(url: URL(string: viewState.profileImageUrlString)) { image in
                        image.resizable()
                    } placeholder: {
                        CommonAccountImageHolder()
                    }
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        CommonText(text: viewState.nickname, font: .mPlus2SemiBold(size: 20), lineHeight: 28, alignment: .leading)
                            .foregroundStyle(.appMainText)
                        CommonText(text: "ID: \(viewState.uid)", font: .mPlus2SemiBold(size: 14), lineHeight: 20, alignment: .leading)
                            .foregroundStyle(.appSubText)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Button {
                        print("ellipsis")
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color(.appSubText))
                    }
                }
                
                CommonText(text: "ポッカビゴンが大好きです！！！なんとかかんとかかんとかかんとか。ポッカビゴンが大好きです！！！なんとかかんとかかんとかかんとか。ポッカビゴンが大好きです!！小野", font: .mPlus2Regular(size: 14), lineHeight: 20, alignment: .leading)
                    .foregroundStyle(.appMainText)
            }
            .listRowInsets(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
            
            ForEach(viewState.reviews) { review in
                Button {
                    viewState.reviewTapped(review: review)
                } label: {
                    CommonReviewRow(review: review) { uid in
                        print(uid)
                    } imageTapAction: { imageUrlString in
                        print(imageUrlString)
                    } menuTapAction: { review in
                        print(review)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            
            if viewState.loading {
                HStack {
                    Spacer()
                    ProgressView()
                        .foregroundStyle(Color(.appMain))
                        .scaleEffect(1.2)
                    Spacer()
                }
            }
        }
        .onAppear {
            viewState.onAppear()
        }
        .refreshable {
            //await viewState.pullToRefresh()
        }
        .navigationDestination(item: $viewState.navigationDestination) { item in
            switch item {
            case .account(uid: let uid):
                AccountView(viewState: AccountViewState(uid: uid))
            case .reviewDetail(review: let review):
                ReviewDetailView(viewState: ReviewDetailViewState(review: review))
            }
        }
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
            //
            //            ToolbarItem(placement: .principal) {
            //                Text(viewState.title)
            //                    .font(.system(size: 16).bold())
            //                    .foregroundStyle(Color.white)
            //            }
            
        }
        .toolbarBackground(Color(.appMain), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    AccountView(viewState: AccountViewState(uid: ""))
}
