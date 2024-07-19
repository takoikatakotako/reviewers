import Foundation

struct QuestionCategory: Decodable, Hashable {
    var title: String
    var questionIds: [Int]
}
