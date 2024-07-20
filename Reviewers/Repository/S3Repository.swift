import Foundation

struct S3Repository {
    func fetchAppInfo() async throws -> AppInfo {
        let url = URL(string: "https://reviewers-app-sandbox.s3-ap-northeast-1.amazonaws.com/app-info.json")!
        
        // disable cache
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let (data, _) = try await URLSession(configuration: config).data(from: url)
        return try JSONDecoder().decode(AppInfo.self, from: data)
    }
}
