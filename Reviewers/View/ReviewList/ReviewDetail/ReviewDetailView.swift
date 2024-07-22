import SwiftUI

struct ReviewDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewState: ReviewDetailViewState

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        Image(.icon)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading, spacing: 4) {
                            CommonText(text: "かびごん小野", font: .mPlus2Medium(size: 14), lineHeight: 18)
                                .foregroundStyle(Color(.appMainText))
                            CommonText(text: "2024/12/23 23:12", font: .mPlus2Regular(size: 14), lineHeight: 18)
                                .foregroundStyle(Color(.appMainText))
                        }

                        Spacer()

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

                    CommonText(
                        text: "ポッキーは私のお気に入りのお菓子です！そのサクサクとした食感と、程よい甘さのチョコレートコーティングが絶妙です。パッケージも手軽で持ち運びやすく、友達とシェアするのにもぴったり。特にミルクチョコレート味が大好きで、食べ始めると止まらなくなります。いろんなフレーバーがあるので、気分によって選べるのも良いですね。ポッキーがあれば、どんな時でも幸せな気分になれます！",
                        font: .mPlus2Regular(size: 14),
                        lineHeight: 20,
                        alignment: .leading
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundStyle(Color(.appMainText))
                    .padding(.top, 12)

                    Image(.samplePockey)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                        .padding(.top, 12)

                    // XXX
                    HStack(spacing: 0) {
                        Spacer()

                        HStack(spacing: 8) {
                            Button {

                            } label: {
                                Image(systemName: "bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color(.appMainText))
                                    .padding(8)
                            }

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

                    Divider()
                        .padding(.top, 12)

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
                                CommonText(text: "2024/12/23 23:12", font: .mPlus2Regular(size: 14), lineHeight: 18)
                                    .foregroundStyle(Color(.appMainText))
                            }

                            Spacer()

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
                        .padding(.top, 12)

                        CommonText(
                            text: "抹茶味が好きですカビ！\nノーマルタイプも美味しいですカビ！！\nノーマルタイプも美味しいですカビ！！",
                            font: .mPlus2Regular(size: 14),
                            lineHeight: 20,
                            alignment: .leading
                        )
                        .foregroundStyle(Color(.appMainText))
                        .padding(.top, 12)

                        Divider()
                            .padding(.top, 12)
                    }

                }
                .padding(.top, 12)
                .padding(.leading, 12)
                .padding(.trailing, 12)
                .padding(.bottom, 12)
            }

            //            VStack(spacing: 8) {
            //                HStack(spacing: 8) {
            //                    Button {
            //
            //                    } label: {
            //                        Text("間違えた問題")
            //                            .font(.system(size: 18).bold())
            //                            .foregroundStyle(Color.white)
            //                            .frame(height: 48)
            //                            .frame(minWidth: 0, maxWidth: .infinity)
            //                            .background(Color(.appBlueBackground))
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                    }
            //
            //                    Button {
            //
            //                    } label: {
            //                        Text("チェックから出題")
            //                            .font(.system(size: 18).bold())
            //                            .foregroundStyle(Color.white)
            //                            .frame(height: 48)
            //                            .frame(minWidth: 0, maxWidth: .infinity)
            //                            .background(Color(.appRedBackground))
            //                            .clipShape(RoundedRectangle(cornerRadius: 8))
            //                    }
            //                }
            //                .padding(.horizontal, 16)
            //
            //                Button {
            //
            //                } label: {
            //                    Text("ランダムに出題")
            //                        .font(.system(size: 18).bold())
            //                        .foregroundStyle(Color.white)
            //                        .frame(height: 48)
            //                        .frame(minWidth: 0, maxWidth: .infinity)
            //                        .background(Color(.appGreenBackground))
            //                        .clipShape(RoundedRectangle(cornerRadius: 8))
            //                        .padding(.horizontal, 16)
            //                        .padding(.bottom, 8)
            //                }
            //            }
            //            .clipped()
        }
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

// #Preview {
//    StudyCategoryDetailView(viewState: StudyCategoryDetailViewState(category: TertiaryCategory(title: "Title", questions: [])))
// }
