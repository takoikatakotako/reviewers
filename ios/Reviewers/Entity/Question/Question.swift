import Foundation

enum Question: Hashable {
    case questionSimple(QuestionSimple)
    case questionSimpleNoChoices(QuestionSimpleNoChoices)

}
