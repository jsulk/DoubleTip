//
//  TipData.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 9/25/24.
//

import CoreData
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


//class TipOfflineDataController: ObservableObject {
//    let container: NSPersistentContainer = NSPersistentContainer(name: "LifeTip")
//    
//    init() {
//        container.loadPersistentStores { description, error in
//            guard error == nil else {
//                // TODO: Handle error if load fails
//                print("Load of persistent storage failed")
//                return
//            }
//            
//        }
//    }
//}