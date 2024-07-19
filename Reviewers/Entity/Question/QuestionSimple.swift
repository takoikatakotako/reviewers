import Foundation

struct QuestionSimple: Decodable, Hashable {
    let id: Int
    let type: String
    let text: String
    let image: String?
    let refer: String?
    let choices: [String]
    let answer: Int
    let explanation: String
    let explanationImage: String?
}
