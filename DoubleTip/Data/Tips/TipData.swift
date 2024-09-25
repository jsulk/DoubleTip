//
//  TipData.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 9/25/24.
//

import Foundation

struct TipDataResponse: Decodable {
    var data: TipDataObject
}

struct TipDataObject: Decodable {
    var children: [TipData]
}

struct TipData: Decodable {
    var data: Tip
}

struct Tip: Decodable {
    var title: String
    var author: String
}
