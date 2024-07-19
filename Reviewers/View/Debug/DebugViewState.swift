import Foundation

import SwiftUI

class DebugViewState: ObservableObject {
    @Published var questions: [Int] = []
    private let repository: Repository = Repository()
    
    func onAppear() {
        Task { @MainActor in
            do {
                let questionList = try await repository.fetchQuestionList()
                self.questions = questionList.questions
            } catch {
                print(error)
            }
        }
    }
}
