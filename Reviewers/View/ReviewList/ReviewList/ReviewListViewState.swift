import Foundation

class ReviewListViewState: ObservableObject {
    @Published var favoriteColor = 0
    @Published var path: [ReviewListViewPath] = []
        
    @Published var showingPostCover = false
    
    
    @Published var showingSignInAlert = false
    @Published var showingSignUpFullScreen = false

    
    private let authRepository = AuthRepository()
    
    
    private let repository = Repository()
    
    func onAppear() { }
    
    
    func tapped() {
        path.append(.reviewDetail(title: "ssss"))
    }
    
    
    func postButtonTapped() {
        guard let user = authRepository.getUser() else {
            return
        }
        
        // 認証済みユーザーの場合、投稿画面を表示
        if user.isAnonymous == false {
            showingPostCover = true
            return
        }
        
        // メール認証が終わっていない場合
        guard user.isEmailVerified == false else {
            // 登録されたメールアドレスに送りました。届かない場合は
            return
        }
        
        print(user.uid)
        
  
        showingSignInAlert = true

        
        //showingPostCover = true
    }
    
    
    func signInTapped() {
        showingSignUpFullScreen = true
    }
    
    
    

    func matigaeta() {
        showingPostCover = true
    }

    func check() {
        showingPostCover = true

    }
}
