//
//  HomePage+ViewModel.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 8/9/24.
//

import Foundation
import Combine
import SwiftUI
import CoreData

extension HomePage {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var expenseAmount: Double? = nil
        @Published var tipPercentage: Int? = nil
        @Published var totalAmount: String = ""
        @Published var totalAmountIsHidden: Bool = true
        @Published var lifeTips: [LifeTip]?
        @Published var lifeTip: LifeTip?
        @Published var lifeTipTitle: String = ""
        @Published var lifeTipAuthor: String = ""
        
        let container: NSPersistentContainer
        private var currentCalculatedTip: Int? = nil
        private var currentCalculatedExpense: Double? = nil
        private var cancellables = Set<AnyCancellable>()
        
        init() {
            container = NSPersistentContainer(name: DTBunle.string("life_tip"))
            loadPersistentCache()
            
            $tipPercentage
                .combineLatest($expenseAmount)
                .map { [weak self] in
                    let expenseAndTipNil = $0 == nil || $1 == nil
                    let expenseAndTipDifferentValyesValues = $0 != self?.currentCalculatedTip || $1 != self?.currentCalculatedExpense
                    return (expenseAndTipNil || expenseAndTipDifferentValyesValues)
                }
                .assign(to: &$totalAmountIsHidden)
            
            $lifeTip
                .map {
                    guard let tipTitle = $0?.title else {
                        // TODO: manage Strings
                        return DTBunle.string("error_no_tips")
                    }
                    return DTBunle.string("tip_title", args: tipTitle)
                }
                .assign(to: &$lifeTipTitle)
            
            $lifeTip
                .map {
                    // TODO: manage Strings
                    guard let author = $0?.author, author != "[deleted]" else {
                        return DTBunle.string("author_unknown")
                    }
                    return DTBunle.string("author", args: author)
                }
                .assign(to: &$lifeTipAuthor)
        }
        
        func calculateTipPercentage() {
            
            guard let tipPercentage, let expenseAmount else { return }
            
            self.currentCalculatedTip = tipPercentage
            self.currentCalculatedExpense = expenseAmount
            
            totalAmount = GlobalUtilities.totalAmountWiithTipAsDouble(totalExpense: expenseAmount, tipPercentage: tipPercentage)?.formattedAsCurrency() ?? DTBunle.string("error_calculating")
            
            totalAmountIsHidden = false
            
            self.lifeTip = lifeTips?.randomElement()
        }
        
        private func loadPersistentCache() {
            container.loadPersistentStores { description, error in
                guard error == nil else {
                    // TODO: Handle error if load of core data object fails
                    print("Load of persistent storage failed")
                    return
                }
            }
            Task {
                await self.fetchPersistentLifeTips()
            }
        }
        
        private func fetchPersistentLifeTips() async {
            // TODO: manage Strings
            let lifeTipRequest: NSFetchRequest = NSFetchRequest<LifeTip>(entityName: DTBunle.string("life_tip"))
            do {
                let localStorageLifeTips = try container.viewContext.fetch(lifeTipRequest)
                if localStorageLifeTips.isEmpty {
                    let fetchedTipData = try await LifeTipDataManager().fetchTipData()
                    self.saveData(tipDataObject: fetchedTipData)
                } else {
                    lifeTips = localStorageLifeTips
                }
            } catch {
                // TODO: handle error
                print("Error fetching from storage: \(error.localizedDescription)")
            }
        }
        
        private func saveData(tipDataObject: TipDataResponse) {
            var lifeTips: [LifeTip] = []
            for tip in tipDataObject.data.children {
                let lifeTip = LifeTip(context: container.viewContext)
                lifeTip.id = UUID()
                lifeTip.title = tip.data.title
                lifeTip.author = tip.data.author
                lifeTips.append(lifeTip)
            }
            do {
                try container.viewContext.save()
                loadPersistentCache()
            } catch {
                // TODO: handle coredata save error
                print("HANDLE SAVE ERROR HERE")
            }
        }
    }
}
