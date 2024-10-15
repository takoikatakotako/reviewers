// import SwiftUI
//
// struct SignUpView: View {
//    @StateObject var viewState: SignUpViewState
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                VStack(alignment: .leading, spacing: 0) {
//                    VStack(alignment: .leading, spacing: 12) {
//                        CommonText(text: "メールアドレス", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
//                            .foregroundStyle(Color(.appMainText))
//                            .disabled(viewState.inprogress)
//
//                        TextField("", text: $viewState.mail)
//                            .textFieldStyle(.roundedBorder)
//                            .font(.mPlus2Regular(size: 16))
//                    }
//
//                    VStack(alignment: .leading, spacing: 12) {
//                        CommonText(text: "パスワード", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
//                            .foregroundStyle(Color(.appMainText))
//                            .disabled(viewState.inprogress)
//
//                        SecureField("", text: $viewState.password)
//                            .textFieldStyle(.roundedBorder)
//                            .font(.mPlus2Regular(size: 16))
//                    }
//                    .padding(.top, 12)
//
//                    Button {
//                        viewState.signUp()
//                    } label: {
//                        HStack {
//                            Spacer()
//                            CommonText(text: "アカウント作成", font: .mPlus2Bold(size: 14), lineHeight: 20)
//                                .foregroundStyle(Color(.white))
//
//                            Spacer()
//                        }
//                        .frame(height: 48)
//                        .background(Color(.appGreenBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                    .disabled(viewState.inprogress)
//                    .padding(.top, 24)
//
//                    Text("[利用規約](https://apple.com) と [プライバシーポリシー](https://apple.com) に同意してアカウントを作成してみましょう。")
//                        .foregroundStyle(Color(.appMainText))
//                        .tint(Color(.appMain))
//                        .font(.mPlus2Regular(size: 16))
//                        .lineSpacing(4)
//                        .padding(.vertical, 4)
//                        .multilineTextAlignment(.leading)
//                        .padding(.top, 12)
//
//
//                    NavigationLink {
//                        SignInView(viewState: SignInViewState())
//                    } label: {
//                        HStack {
//                            Spacer()
//                            CommonText(text: "アカウントをお持ちの方", font: .mPlus2SemiBold(size: 16), lineHeight: 24)
//                                .foregroundStyle(Color(.appMain))
//
//                            Spacer()
//                        }
//                    }
//                    .disabled(viewState.inprogress)
//                    .padding(.top, 16)
//
//                    Spacer()
//                }
//                .padding(16)
//
//                if viewState.inprogress {
//                    ProgressView()
//                        .progressViewStyle(.circular)
//                        .padding()
//                        .tint(Color.white)
//                        .background(Color.gray)
//                        .cornerRadius(8)
//                        .scaleEffect(1.2)
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "multiply")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 20, height: 20)
//                            .foregroundStyle(Color.white)
//                            .padding(.top, 8)
//                            .padding(.leading, 4)
//                            .padding(.trailing, 8)
//                            .padding(.bottom, 8)
//                    }
//                }
//
//                ToolbarItem(placement: .principal) {
//                    CommonText(text: "アカウント作成", font: .mPlus2Bold(size: 14), lineHeight: 20)
//                        .foregroundStyle(Color(.white))
//                }
//            }
//            .toolbarBackground(Color(.appMain), for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//        }
//    }
// }
//
// #Preview {
//    SignUpView(viewState: SignUpViewState())
// }
