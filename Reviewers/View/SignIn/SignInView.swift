// import SwiftUI
//
// struct SignInView: View {
//    @StateObject var viewState: SignInViewState
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ZStack {
//  
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
//                CommonText(text: "ログイン", font: .mPlus2Bold(size: 14), lineHeight: 20)
//                    .foregroundStyle(Color(.white))
//            }
//        }
//        .toolbarBackground(Color(.appMain), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//    }
// }
//
// #Preview {
//    SignInView(viewState: SignInViewState())
// }
