//
//  LifeTipDataManager.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 1/1/25.
//

import Foundation

public struct LifeTipDataManager {
    func fetchTipData() async throws -> TipDataResponse {
        guard let accessTokenData = try await RedditAccessTokenDataManager().getAccessToken() else {
            // TODO: update error thrown
            throw AppError.parsing
        }
        guard let lifeTips = try await SubredditDataManager().getTips(accessToken: accessTokenData.access_token) else {
            // TODO: update error thrown
            throw AppError.network
        }
        return lifeTips
    }
}
