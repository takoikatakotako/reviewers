import Foundation

struct TertiaryCategory: Decodable, Hashable {
    let title: String
    let questions: [QuestionCategory]
}
