import SwiftUI

struct CommonText: View {
    let text: String
    let font: Font
    let lineHeight: CGFloat
    let alignment: TextAlignment

    init(text: String, font: Font, lineHeight: CGFloat, alignment: TextAlignment = .center) {
        self.text = text
        self.font = font
        self.lineHeight = lineHeight
        self.alignment = alignment
    }

    var body: some View {
        Text(LocalizedStringKey(text))
            .multilineTextAlignment(alignment)
            .font(font)
            .lineSpacing(lineHeight - UIFont.preferredFont(from: font).lineHeight)
            .padding(.vertical, (lineHeight - UIFont.preferredFont(from: font).lineHeight) / 2)
    }
}

// #Preview {
//    CommonText()
// }
