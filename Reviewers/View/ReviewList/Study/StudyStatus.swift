import Foundation

enum StudyStatus: Equatable {
    // 問題解いてる中
    case toiteru

    // 結果表示中
    case kekka

    case answerCorrect
    case answerIncorrect

    // 解説表示中
    case kaisetu
}
