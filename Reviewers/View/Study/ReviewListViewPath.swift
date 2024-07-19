import Foundation

enum ReviewListViewPath: Hashable {
    case study(title: String, questions: [Question])
    case reviewDetail(title: String)
}
