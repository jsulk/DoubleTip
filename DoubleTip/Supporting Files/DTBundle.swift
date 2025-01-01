//
//  DTBundle.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 8/9/24.
//

import Foundation

public class DTBunle {
    public static let bundle = Bundle(for: DTBunle.self)
    
    public static func string(_ key: String) -> String {
        return DTBunle.bundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    public static func string(_ key: String, args: CVarArg...) -> String {
        let base = DTBunle.bundle.localizedString(forKey: key, value: nil, table: nil)
        return String.localizedStringWithFormat(base, args)
    }
}
