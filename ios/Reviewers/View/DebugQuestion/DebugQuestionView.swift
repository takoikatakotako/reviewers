// import SwiftUI
//
// struct DebugQuestionView: View {
//    @StateObject var viewState: DebugQuestionViewState
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                if let question = viewState.question {
//                    switch question {
//                    case .questionSimple(let questionSimple):
//                        QuestionSimpleView(question: questionSimple, disabled: false) { imageName in
//                            print(imageName)
//                        }
//
//                        // 正解
//                        DebugQuestionAnswerView(text: questionSimple.answer.katakana)
//                            .padding(.top, 16)
//
//                        // 解説
//                        DebugQuestionExplanationView(text: questionSimple.explanation)
//                            .padding(.top, 16)
//
//                    case .questionSimpleNoChoices(let questionSimpleNoChoices):
//                        QuestionSimpleNoChoicesView(question: questionSimpleNoChoices, disabled: false) { imageName in
//                            print(imageName)
//                        }
//
//                        // 正解
//                        DebugQuestionAnswerView(text: questionSimpleNoChoices.answer.katakana)
//                            .padding(.top, 16)
//
//                        // 解説
//                        DebugQuestionExplanationView(text: questionSimpleNoChoices.explanation)
//                            .padding(.top, 16)
//                    }
//                } else {
//                    Text("Loading")
//                }
//
//                Spacer()
//            }
//            .padding(.top, 16)
//            .padding(.horizontal, 16)
//            .onAppear {
//                viewState.onAppear()
//            }
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
//                CommonText(text: "No: \(viewState.questionId)", font: .mPlus2Bold(size: 16), lineHeight: 16)
//                    .font(.system(size: 16).bold())
//                    .foregroundStyle(Color.white)
//            }
//        }
//        .toolbarBackground(Color(.appMain), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//        .toolbar(.hidden, for: .tabBar)
//    }
// }
//
//// #Preview {
////    DebugQuestionView(viewState: DebugQuestionViewState(questionId: 1))
//// }
