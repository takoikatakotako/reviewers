import Foundation

extension Int {
    var katakana: String {
        let array = ["ア", "イ", "ウ", "エ", "オ", "カ", "キ", "ク"]
        if 0 <= self && (self - 1) < array.count {
            return array[self]
        } else {
            return ""
        }
    }
}
