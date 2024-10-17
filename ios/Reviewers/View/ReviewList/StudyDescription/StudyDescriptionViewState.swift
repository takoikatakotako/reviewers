import SwiftUI

class StudyDescriptionViewState: ObservableObject {
    @Published var showingImageCover: Bool = false

    @Published var showingResult: Bool = false
    @Published var result = false

}
