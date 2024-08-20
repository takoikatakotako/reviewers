import Foundation

enum ReviewersError: Error {
    case clientError
    case serverError
    case decode
    case encode
    case temp
    case temp2(xxx: String)
}

extension ReviewersError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .clientError:
            return "クライアントエラー。ネットワークを確認してください"
        case .serverError:
            return "サーバーエラー。サーバーからのデータ取得に失敗しました。"
        case .decode:
            return "クライアントエラー。データのデコードに失敗しました。"
        case .encode:
            return "クライアントエラー。データのエンコードに失敗しました。"
        case .temp:
            return "あああああああああああ"
            
        case .temp2(let xxx):
            return "\(xxx)"
        }
    }
}
