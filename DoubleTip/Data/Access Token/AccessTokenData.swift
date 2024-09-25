//
//  AccessTokenData.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 9/25/24.
//

import Foundation

struct AccessTokenData: Decodable {
    var access_token: String
    var token_type: String
}
