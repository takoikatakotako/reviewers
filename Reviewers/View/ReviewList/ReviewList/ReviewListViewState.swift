import Foundation

class ReviewListViewState: ObservableObject {
    @Published var favoriteColor = 0
    @Published var path: [ReviewListViewPath] = []
    
    @Published var primariCategory: PrimaryCategory?
    
    @Published var showingCover = false
    
    var title: String {
        if let primariCategory = primariCategory {
            return primariCategory.title
        } else {
            return ""
        }
    }
    
    private let repository = Repository()
    
    func onAppear() {
        Task { @MainActor in
            do {
                let primaryCategory = try await repository.fetchCategory()
                self.primariCategory = primaryCategory
            } catch {
                print(error)
            }
        }
    }
    
    
    func tapped() {
        path.append(.reviewDetail(title: "ssss"))
    }
    

    func matigaeta() {
        showingCover = true
    }

    func check() {
        showingCover = true

    }

    func random() {
        showingCover = true

        guard let primariCategory = primariCategory else {
            return
        }

        Task { @MainActor in
            // 問題を取得
            var questionIds: [Int] = []
            for secondaryCategory in primariCategory.secondaryCategories {
                for tertiaryCategory in secondaryCategory.tertiaryCategories {
                    questionIds += tertiaryCategory.questions.flatMap({ questionCategory in
                        return questionCategory.questionIds
                    })
                }
            }

            // 10件を決定
            let selectedQuestionIds = Array(Set(questionIds).shuffled().prefix(10))

            // 問題を取得
            do {
                let questions = try await repository.fetchQuestions(questionIds: selectedQuestionIds)
                path.append(ReviewListViewPath.study(title: primariCategory.title, questions: questions))
            } catch {
                print(error)
            }

            showingCover = false
        }
    }
}
