import SwiftUI

struct ReviewListRow: View {
//    let title: String
    var body: some View {
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
