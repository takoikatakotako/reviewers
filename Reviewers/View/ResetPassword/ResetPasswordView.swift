// import SwiftUI
//
// struct ResetPasswordView: View {
//    @StateObject var viewState: ResetPasswordViewState
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ZStack {
//            VStack {
//                VStack(alignment: .leading, spacing: 0) {
//                    VStack(alignment: .leading, spacing: 12) {
//                        CommonText(text: "メールアドレス", font: .mPlus2SemiBold(size: 14), lineHeight: 20)
//                            .foregroundStyle(Color(.appMainText))
//
//                        TextField("", text: $viewState.mail)
//                            .textFieldStyle(.roundedBorder)
//                            .font(.mPlus2Regular(size: 16))
//                    }
//
//                    
//                    
//                
//                    Button {
//                        viewState.resetPassowrd()
//                    } label: {
//                        HStack {
//                            Spacer()
//                            CommonText(text: "パスワードをリセット", font: .mPlus2Bold(size: 14), lineHeight: 20)
//                                .foregroundStyle(Color(.white))
//
//                            Spacer()
//                        }
//                        .frame(height: 48)
//                        .background(Color(.appGreenBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                    .padding(.top, 24)
//                }
//                .padding(16)
//
//                Spacer()
//            }
//
//            if viewState.inprogress {
//                ProgressView()
//                    .progressViewStyle(.circular)
//                    .padding()
//                    .tint(Color.white)
//                    .background(Color.gray)
//                    .cornerRadius(8)
//                    .scaleEffect(1.2)
//            }
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.backward")
//                        .foregroundStyle(Color.white)
//                        .padding(.vertical, 8)
//                        .padding(.trailing, 8)
//                }
//            }
//
//            ToolbarItem(placement: .principal) {
//                CommonText(text: "パスワードリセット", font: .mPlus2Bold(size: 14), lineHeight: 20)
//                    .foregroundStyle(Color(.white))
//            }
//        }
//        .toolbarBackground(Color(.appMain), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//    }
// }
//
//
// #Preview {
//    ResetPasswordView(viewState: ResetPasswordViewState())
// }
