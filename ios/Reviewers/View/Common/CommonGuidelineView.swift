import SwiftUI
import Markdown

struct CommonGuidelineView: View {
    @Environment(\.dismiss) var dismiss

    let markdown: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(LocalizedStringKey(markdown))
                    .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(.appMain), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                    }
                }
            }
        }
    }
    
    func getAttributedString(markdown: String) -> AttributedString {
        var attributedString = AttributedString()
        for block in Document(parsing: markdown).blockChildren {
            if let heading = block as? Heading {
                var headingAttributedString = AttributedString(heading.plainText + "\n\n")
                if heading.level == 1 {
                    headingAttributedString.font = .system(size: 24, weight: .bold)
                } else if heading.level == 2 {
                    headingAttributedString.font = .system(size: 18, weight: .bold)
                } else {
                    headingAttributedString.font = .system(size: 16, weight: .bold)
                }
                attributedString += headingAttributedString
            } else if let paragraph = block as? Paragraph {
                let paragraphAttributedString = AttributedString(paragraph.plainText + "\n\n")
                attributedString += paragraphAttributedString
            } else {
                print(type(of: block))
            }
        }
        return attributedString
    }
}
