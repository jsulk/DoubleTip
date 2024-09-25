//
//  RedditAccessTokenDataManager.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 9/25/24.
//

import Foundation

struct RedditAccessTokenDataManager {
    
    fileprivate let baseUrl: URL = URL(string: "https://www.reddit.com/api/v1/access_token")!
    
    public func getAccessToken(completion: @escaping (String?, LocalizedError?) -> Void) {
        let task = URLSession.shared.dataTask(with: getFormattedRequest()) { (data, response, error) in
            if error != nil {
                completion(nil, AppError.network)
            } else if let data = data {
                if let accessTokenData = try? JSONDecoder().decode(AccessTokenData.self, from: data) {
                    completion(accessTokenData.access_token, nil)
                }
            }
        }
        task.resume()
    }
    
    private func getFormattedRequest() -> URLRequest {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "*/*",
            "Accept-Encoding": "gzip, deflate, br",
            "Authorization": getFormatAuthorization()
        ]
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = getFormattedData()
        return request
    }
    
    private func getFormatAuthorization() -> String {
        let username = "cb3v0yrkWezmNTukc-cf9w"
        let password = "aV1GGCcMEN_pbbIaCLjurEe8d60MXA"
        let loginString = String(format: "\(username):\(password)", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        return "Basic \(base64LoginString)"
    }
    
    private func getFormattedData() -> Data {
        let data = NSMutableData(data: "grant_type=password".data(using: .utf8)!)
        data.append("&username=Sad-Obligation7836".data(using: .utf8)!)
        data.append("&password=123456789RedditPass".data(using: .utf8)!)
        return data as Data
    }
}
