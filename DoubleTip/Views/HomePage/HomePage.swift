//
//  HomePage.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 8/8/24.
//

import Foundation
import SwiftUI
import Combine

struct HomePage: View {
    @StateObject var viewModel: ViewModel
    
    private let homePageTitleKey = DTBunle.string("home_page_title")
    private let homePageSubtitleKey = DTBunle.string("home_page_subtitle")
    private let calculateButtonTitle = DTBunle.string("calculate")
    private let titleFont = DTBunle.string("font_large_page_title")
    private let subtitleFont = DTBunle.string("font_page_subtitle")
    private let billAmount = DTBunle.string("bill_amount")
    private let tipPercentage = DTBunle.string("tip_percentage")
    private let total = DTBunle.string("total")
    
    var body: some View {
        contentView
            .padding(16)
    }
    
    var contentView: some View {
        VStack(alignment: .center) {
            pageTitle
                .padding(.vertical, 8)
            
            pageSubtitle
                .padding(.bottom, 16)
            
            Spacer()
            
            calculatorView
            
            Spacer()
            
            bonusTipView
                .isHidden(viewModel.totalAmountIsHidden)
        }
        .padding()
    }
    
    private var bonusTipView: some View {
        VStack {
            Text(viewModel.lifeTipTitle)
                .padding(.bottom, 8)
                .font(.caption2)
                .italic()
            Text(viewModel.lifeTipAuthor)
                .font(.caption2)
                .italic()
        }
    }
    
    private var pageTitle: some View {
        Text(homePageTitleKey)
            .font(.custom(titleFont, size: 36))
            .foregroundStyle(Color.doubleTipGreen.gradient)
    }
    
    private var pageSubtitle: some View {
        Text(homePageSubtitleKey)
            .multilineTextAlignment(.center)
            .font(.custom(subtitleFont, size: 18))
            .foregroundStyle(Color.doubleTipGreen.gradient)
    }
    
    private var calculatorView: some View {
        VStack {
            Form {
                Section {
                    billAmountSection
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)

                Section {
                    tipPercentageSection
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                
                Section {
                    calculateButtonSection
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                
                Section {
                    totalSection
                }
                .isHidden(viewModel.totalAmountIsHidden)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    private var billAmountSection: some View {
        VStack {
            TextField("$0.00", value: $viewModel.expenseAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            Text(billAmount)
                .font(.custom(subtitleFont, size: 16))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var tipPercentageSection: some View {
        VStack {
            TextField("15%", value: $viewModel.tipPercentage, format: .percent)
            Text(tipPercentage)
                .font(.custom(subtitleFont, size: 16))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var calculateButtonSection: some View {
        Button(action: self.viewModel.calculateTipPercentage, label: {
            Text(calculateButtonTitle)
        })
    }
    
    private var totalSection: some View {
        VStack {
            Text(total)
                .font(.custom(subtitleFont, size: 16))
                .foregroundStyle(Color.gray)
            Text(viewModel.totalAmount)
        }
    }
}

#Preview {
    HomePage(viewModel: HomePage.ViewModel())
}
