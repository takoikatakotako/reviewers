import Foundation

struct Repository {
    func fetchCategory() async throws -> PrimaryCategory {
        let url = URL(string: "https://rikako-question-sandbox.s3-ap-northeast-1.amazonaws.com/category/1.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PrimaryCategory.self, from: data)
    }
    
    func fetchQuestionList() async throws -> QuestionList {
        let url = URL(string: "https://rikako-question-sandbox.s3-ap-northeast-1.amazonaws.com/question/list.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(QuestionList.self, from: data)
    }

    func fetchQuestion(questionId: Int) async throws -> Question {
        let url = URL(string: "https://rikako-question-sandbox.s3-ap-northeast-1.amazonaws.com/question/\(questionId).json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let questionTypeCkeck = try JSONDecoder().decode(QuestionTypeChecker.self, from: data)
        switch questionTypeCkeck.type {
        case .simple:
            let question = try JSONDecoder().decode(QuestionSimple.self, from: data)
            return .questionSimple(question)
        case .simpleNoChoices:
            let question = try JSONDecoder().decode(QuestionSimpleNoChoices.self, from: data)
            return .questionSimpleNoChoices(question)
        }
    }

    func fetchQuestions(questionIds: [Int]) async throws -> [Question] {
        return try await withThrowingTaskGroup(of: Question.self) { group in
            for questionId in questionIds {
                group.addTask {
                   return try await fetchQuestion(questionId: questionId)
                }
            }

            return try await group.reduce(into: [Question]()) { result, question in
                result.append(question)
            }
        }
    }
}
