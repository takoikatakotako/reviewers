import SwiftUI
import VisionKit

struct ReviewSearchDetailView: View {
    @StateObject var viewState: ReviewSearchDetailViewState
    @Environment(\.dismiss) var dismiss

    @State var isShowingScanner = true
    @State private var scannedText = ""

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 8) {
                            CommonText(text: "ポッキーチョコレート", font: .mPlus2SemiBold(size: 16), lineHeight: 24, alignment: .leading)
                                .foregroundStyle(.appMainText)

                            Spacer()

                            CommonText(text: "4.2", font: .mPlus2Regular(size: 14), lineHeight: 18)
                                .foregroundStyle(.appMainText)

                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.appMain)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.appMain)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.appMain)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.appMain)

                                Image(systemName: "star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.appMain)
                            }
                        }

                        CommonText(text: "ブランド: 江崎グリコ", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
                            .foregroundStyle(.appMainText)

                        ReviewListRowImage(url: URL(string: "https://images2.minutemediacdn.com/image/upload/c_fill,w_1440,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/mf-649509-pocky-hero-amazon-new-1ec72242df10b2fbc24617e702b8bd97.jpg"))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()

                        CommonText(text: "JANコード: 123445", font: .mPlus2Regular(size: 14), lineHeight: 24, alignment: .leading)
                            .foregroundStyle(.appMainText)

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

                    }
                    .listRowInsets(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))

                    ForEach(viewState.reviews) { review in
                        Button {
                            // viewState.reviewTapped(review: review)
                        } label: {
                            CommonReviewRow(review: review) { _ in
                                // viewState.accountTapped(profile: profile)
                            } imageTapAction: { _ in
                                // viewState.imageTapped(urlString: imageUrlString)
                            } menuTapAction: { _ in
                                // viewState.menuTapped(review: review)
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

                // バーコード
                if viewState.code == nil {
                    BarcodeScannerView { code in
                        viewState.codeSccaned(code: code)
                    }
                }

//
//                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
//                    BarcodeScannerView { code in
//                        // self.code = code
//                        // dismiss()
//                    }
//                } else if !DataScannerViewController.isSupported {
//                    Text("It looks like this device doesn't support the DataScannerViewController")
//                } else {
//                    Text("It appears your camera may not be available")
//                }

            }
            .tint(Color(.appMainText))
            .onAppear {
                viewState.xxxxx()
            }
//            .navigationDestination(item: $viewState.navigationDestination) { item in
//                switch item {
//                case .account(profile: let profile):
//                    AccountView(viewState: AccountViewState(profile: profile))
//                }
//            }
            .listStyle(.inset)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("商品検索")
                        .font(.system(size: 16).bold())
                        .foregroundStyle(Color.white)
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

        }
    }
}
