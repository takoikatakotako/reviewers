import SwiftUI

class StudyViewState: ObservableObject {
    @Published var status: StudyStatus = .toiteru
    @Published var showingImageCover: Bool = false
    @Published var showingResult: Bool = false
    @Published var finish = false
    @Published var choiceIndex: Int?
    @Published var cover: StudyViewCover?
    
    private let initialTitle: String
    private let questions: [Question]
    private var results: [QuestionResult]
    
    var title: String {
        return "\(initialTitle)(\(results.count+1)/\(questions.count))"
    }

    var question: Question {
        return questions[results.count]
    }

    var disabled: Bool {
        return [.answerCorrect, .answerIncorrect].contains(where: { $0 == self.status })
    }

    init(title: String, questions: [Question], results: [QuestionResult]) {
        self.initialTitle = title
        self.questions = questions
        self.results = results
    }

    func imageTapped(imageName: String) {
        cover = .image(imageName: imageName)
    }

    func choiceTapped(choiceIndex: Int) {
        self.choiceIndex = choiceIndex
        
        let answer: Int
        switch question {
        case .questionSimple(let questionSimple):
            answer = questionSimple.answer
        case .questionSimpleNoChoices(let questionSimpleNoChoices):
            answer = questionSimpleNoChoices.answer
        }
        
        if choiceIndex == answer {
            status = .answerCorrect
        } else {
            status = .answerIncorrect
        }
        
        Task { @MainActor in
            do {
                try await Task.sleep(nanoseconds: UInt64(0.7 * Double(NSEC_PER_SEC)))
                status = .kaisetu
            } catch {

            }
        }
    }
    
    func next() {
        
        // 結果を追加
        if let choiceIndex = self.choiceIndex {
            results.append(QuestionResult(question: question, answered: choiceIndex))
        }
        
        // 最後の問題
        if results.count == questions.count {
            finish = true
            return
        }
        
        status = .toiteru
    }
}
