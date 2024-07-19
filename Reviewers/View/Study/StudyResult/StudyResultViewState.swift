import Foundation

import SwiftUI

class StudyResultViewState: ObservableObject {
    @Published var showingImageCover: Bool = false

    @Published var showingResult: Bool = false
    @Published var result = false

}
