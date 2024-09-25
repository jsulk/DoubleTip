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
        @Published var totalAmountIsHidden: Bool = true
        
        private var currentCalculatedTip: Int? = nil
        private var currentCalculatedExpense: Double? = nil
        private var cancellables = Set<AnyCancellable>()
        
        init() {
            fetchTipDataAsync()
            
            $tipPercentage
                .combineLatest($expenseAmount)
                .map { [weak self] in
                    let expenseAndTipNil = $0 == nil || $1 == nil
                    let expenseAndTipDifferentValyesValues = $0 != self?.currentCalculatedTip || $1 != self?.currentCalculatedExpense
                    return (expenseAndTipNil || expenseAndTipDifferentValyesValues)
                }
                .assign(to: &$totalAmountIsHidden)
        }
        
        func fetchTipDataAsync() {
            RedditAccessTokenDataManager().getAccessToken().flatMap { accessTokenData -> AnyPublisher<TipDataResponse, Error> in
                SubredditDataManager().getTips(accessToken: accessTokenData.access_token)
            }.sink { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { tipDataObject in
                DispatchQueue.main.async {
                    print("Tip array: \(tipDataObject.data.children)")
                }
            }
            .store(in: &cancellables)
        }
        
        func calculateTipPercentage() {
            
            guard let tipPercentage, let expenseAmount else { return }
            
            self.currentCalculatedTip = tipPercentage
            self.currentCalculatedExpense = expenseAmount
            
            totalAmount = GlobalUtilities.totalAmountWiithTipAsDouble(totalExpense: expenseAmount, tipPercentage: tipPercentage)?.formattedAsCurrency() ?? DTBunle.string("error_calculating")
            
            totalAmountIsHidden = false
        }
    }
}
