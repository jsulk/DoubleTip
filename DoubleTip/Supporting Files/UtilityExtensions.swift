//
//  UtilityExtensions.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 8/9/24.
//

import SwiftUI

//MARK: Color Extensions
extension Color {
    public static var doubleTipGreen: Color {
        return Color(UIColor(red: 8/255, green: 79/255, blue: 9/255, alpha: 1.0))
    }
}

//MARK: View Extensions
extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

//MARK: Currency calculator
extension Double {
    public func formattedAsCurrency(maxDecimalPoint: Int = 2) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = maxDecimalPoint
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self))
        return formattedNumber
    }
}
