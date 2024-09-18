//
//  HomePage+ViewModel.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 8/9/24.
//

import Foundation
import Combine

extension HomePage {
    class ViewModel: ObservableObject {
        
        @Published var expenseAmount: Double? = nil
        @Published var tipPercentage: Int? = nil
        @Published var totalAmount: String = ""
        @Published var tipPercentIsHidden: Bool = true
        @Published var totalAmountIsHidden: Bool = true
        
        init() {
            $expenseAmount
                .map { return !($0 != nil) }
                .assign(to: &$tipPercentIsHidden)
            
            $tipPercentage
                .combineLatest($expenseAmount)
                .map {
                    return !($0 != nil && $1 != nil)
                }
                .assign(to: &$totalAmountIsHidden)
            
            $tipPercentage
                .combineLatest($expenseAmount)
                .filter { !($0 == nil) && !($1 == nil) }
                .map { tipPercent, expense in
                    return GlobalUtilities.totalAmountWiithTipAsDouble(totalExpense: expense, tipPercentage: tipPercent)?.formattedAsCurrency() ?? DTBunle.string("error_calculating")
                }
                .assign(to: &$totalAmount)
        }
    }
}
