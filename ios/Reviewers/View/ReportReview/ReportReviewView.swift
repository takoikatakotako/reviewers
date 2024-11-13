import SwiftUI

struct ReportReviewView: View {
    @StateObject var viewState: ReportReviewViewState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    CommonText(text: "報告する問題の種類を教えてください", font: .mPlus2Medium(size: 18), lineHeight: 20)

                    VStack(spacing: 12) {
                        // スパム
                        Button {
                            viewState.spamTapped()
                        } label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 8) {
                                    CommonText(text: "スパム", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                                        .foregroundStyle(Color(.appMainText))
                                    CommonText(text: "商品と関係ない投稿、詐欺、偽のアカウント、悪意のある投稿", font: .mPlus2Regular(size: 14), lineHeight: 20, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color(.appMainText))
                                }
                                Spacer()
                                Circle()
                                    .stroke(Color(.appBackground), lineWidth: 2)
                                    .fill(viewState.spamActive ? Color(.appGreenBackground) : Color.white)
                                    .frame(width: 20, height: 20)
                            }
                        }

                        // 攻撃的な行為や嫌がらせ
                        Button {
                            viewState.aggressiveTapped()
                        } label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 8) {
                                    CommonText(text: "攻撃的な行為や嫌がらせ", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                                        .foregroundStyle(Color(.appMainText))
                                    CommonText(text: "商品に対する侮辱的発言、望ましくない閲覧注意コンテンツや刺激の強いコンテンツ", font: .mPlus2Regular(size: 14), lineHeight: 20, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color(.appMainText))
                                }
                                Spacer()
                                Circle()
                                    .stroke(Color(.appBackground), lineWidth: 2)
                                    .fill(viewState.aggressiveActive ? Color(.appGreenBackground) : Color.white)
                                    .frame(width: 20, height: 20)
                            }
                        }

                        // プライバシー
                        Button {
                            viewState.privacyTapped()
                        } label: {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 8) {
                                    CommonText(text: "プライバシー", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                                        .foregroundStyle(Color(.appMainText))
                                    CommonText(text: "個人情報を共有している、個人を特定できる情報が投稿に含まれている", font: .mPlus2Regular(size: 14), lineHeight: 20, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color(.appMainText))
                                }
                                Spacer()
                                Circle()
                                    .stroke(Color(.appBackground), lineWidth: 2)
                                    .fill(viewState.privacyActive ? Color(.appGreenBackground) : Color.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.white)
                            }
                        }

                        // その他
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 8) {
                                CommonText(text: "その他", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
                                    .foregroundStyle(Color(.appMainText))

                                TextField("報告内容をご記載ください", text: $viewState.other)
                                    .simultaneousGesture(TapGesture().onEnded {
                                        viewState.otherTapped()
                                    })
                                    .textFieldStyle(.roundedBorder)
                                    .font(.mPlus2Regular(size: 14))
                                    .foregroundStyle(Color(.appMainText))
                            }
                            Spacer()

                            Button {
                                viewState.otherTapped()
                            } label: {
                                Circle()
                                    .stroke(Color(.appBackground), lineWidth: 2)
                                    .fill(viewState.otherActive ? Color(.appGreenBackground) : Color.white)
                                    .frame(width: 20, height: 20)
                            }
                        }

                        Spacer()

                        // 報告
                        Button {
                            viewState.reportButtonTapped()
                        } label: {
                            HStack {
                                Spacer()
                                CommonText(text: "報告", font: .mPlus2Bold(size: 14), lineHeight: 20)
                                    .foregroundStyle(Color(.white))

                                Spacer()
                            }
                            .frame(height: 48)
                            .background(viewState.reportButtonDisabled ? Color(.appBackground) : Color(.appGreenBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .disabled(viewState.reportButtonDisabled)
                    }
                    .padding(.top, 24)
                }
                .padding(.top, 24)
                .padding(.horizontal, 12)
            }
            .alert("", isPresented: $viewState.showingCompleteAlert, actions: {
                Button("とじる", role: .none) {
                    dismiss()
                }
            }, message: {
                Text("ご報告ありがとうございました。")
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                    }
                }

                ToolbarItem(placement: .principal) {
                    CommonText(text: "レビューを報告", font: .mPlus2Bold(size: 14), lineHeight: 20)
                        .foregroundStyle(Color(.white))
                }
            }
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
