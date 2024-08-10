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
            
        }
    }
}
