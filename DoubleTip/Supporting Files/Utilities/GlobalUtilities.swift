//
//  GlobalUtilities.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 9/18/24.
//

import Foundation

class GlobalUtilities {
    static func totalAmountWiithTipAsDouble(totalExpense: Double?, tipPercentage: Int?) -> Double? {
        guard let tipPercentage,
              let totalExpense,
              tipPercentage != 0
        else { return nil }
        let percentageDecimal: Double = Double(tipPercentage) / 100.00
        let totalTipAmount: Double = totalExpense * percentageDecimal
        let totalAmountWithTip: Double = totalExpense + totalTipAmount
        return Double(totalAmountWithTip)
    }
}
