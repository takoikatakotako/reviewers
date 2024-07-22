import SwiftUI

class DebugQuestionViewState: ObservableObject {
    @Published var question: Question?

    let questionId: Int
    private let repository: Repository = Repository()

    init(questionId: Int) {
        self.questionId = questionId
    }

    func onAppear() {
        Task { @MainActor in

            do {
                let question = try await repository.fetchQuestion(questionId: questionId)
                self.question = question
            } catch {
                print(error)
            }
        }
    }
}
