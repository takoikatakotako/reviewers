import Foundation

enum ReviewersError: Error {
    case clientError
    case serverError
    case decode
    case encode
    case temp
    case temp2(xxx: String)
    case failedToDecode(message: String)
}

extension ReviewersError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .clientError:
            return "クライアントエラー。ネットワークを確認してください"
        case .serverError:
            return "サーバーエラー。サーバーからのデータ取得に失敗しました。"
        case .decode:
            return "failed to decode"
        case .encode:
            return "クライアントエラー。データのエンコードに失敗しました。"
        case .temp:
            return "あああああああああああ"

        case .temp2(let xxx):
            return "\(xxx)"
        case .failedToDecode(message: let message):
            return "Failed to Decode: \(message)"
        }
    }
}
