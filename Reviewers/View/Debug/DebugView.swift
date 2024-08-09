// import SwiftUI
//
// struct DebugView: View {
//    @StateObject var viewState: DebugViewState
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        List(viewState.questions, id: \.self) { questionId in
//            NavigationLink {
//                DebugQuestionView(viewState: DebugQuestionViewState(questionId: questionId))
//            } label: {
//                Text("\(questionId)")
//            }
//        }
//        .onAppear {
//            viewState.onAppear()
//        }
//        .scrollIndicators(.hidden)
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
//                CommonText(text: "デバッグ", font: .mPlus2Bold(size: 16), lineHeight: 16)
//                    .font(.system(size: 16).bold())
//                    .foregroundStyle(Color.white)
//            }
//
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    URLCache.shared.removeAllCachedResponses()
//                } label: {
//                    CommonText(text: "リセット", font: .mPlus2Bold(size: 16), lineHeight: 16)
//                        .font(.system(size: 16).bold())
//                        .foregroundStyle(Color.white)
//                }
//            }
//        }
//        .toolbarBackground(Color(.appMain), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//        .toolbar(.hidden, for: .tabBar)
//    }
// }
//
// #Preview {
//    DebugView(viewState: DebugViewState())
// }
