import Foundation

struct QuestionSimpleNoChoices: Decodable, Hashable {
    let id: Int
    let type: String
    let text: String
    let image: String?
    let refer: String?
    let answer: Int
    let explanation: String
    let explanationImage: String?
}
