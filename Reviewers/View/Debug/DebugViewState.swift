// import Foundation
//
// import SwiftUI
//
// class DebugViewState: ObservableObject {
//    @Published var questions: [Int] = []
//
//    func onAppear() {
//        Task { @MainActor in
//            do {
//                let questionList = try await repository.fetchQuestionList()
//                self.questions = questionList.questions
//            } catch {
//                print(error)
//            }
//        }
//    }
// }
