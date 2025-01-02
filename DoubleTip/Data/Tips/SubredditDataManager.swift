//
//  SubredditDataManager.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 9/25/24.
//

import Foundation
import Combine

struct SubredditDataManager {
    
    fileprivate let baseUrl: URL = URL(string: "https://oauth.reddit.com/r/lifeprotips/top?t=all&limit=100")!
    
    public func getTips(accessToken: String) async throws -> TipDataResponse? {
        let (data, response) = try await URLSession.shared.data(for: getFormattedRequest(accessToken: accessToken))
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw AppError.network
        }
        let tipData = try? JSONDecoder().decode(TipDataResponse.self, from: data)
        return tipData
    }
    
    private func getFormattedRequest(accessToken: String) -> URLRequest {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [ "Authorization": "bearer \(accessToken)" ]
        return request
    }
}
