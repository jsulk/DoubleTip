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
    
    public func getTips(accessToken: String) -> AnyPublisher<TipDataResponse, Error> {
        return URLSession.shared.dataTaskPublisher(for: getFormattedRequest(accessToken: accessToken))
            .map({ $0.data })
            .decode(type: TipDataResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func getFormattedRequest(accessToken: String) -> URLRequest {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [ "Authorization": "bearer \(accessToken)" ]
        return request
    }
}
