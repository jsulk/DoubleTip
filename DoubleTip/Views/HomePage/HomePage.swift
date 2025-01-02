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
    
    private let homePageSubtitleKey = DTBunle.string("home_page_subtitle")
    private let calculateButtonTitle = DTBunle.string("calculate")
    private let fontMedium = DTBunle.string("font_page_futura_medium")
    private let billAmount = DTBunle.string("bill_amount")
    private let tipPercentage = DTBunle.string("tip_percentage")
    private let total = DTBunle.string("total")
    
    var body: some View {
        contentView
            .padding(16)
    }
    
    var contentView: some View {
        VStack(alignment: .center) {
            pageDescription
                .padding(.vertical, 16)
            
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
    
    private var pageDescription: some View {
        Text(homePageSubtitleKey)
            .multilineTextAlignment(.center)
            .font(.custom(fontMedium, size: 18))
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
                .font(.custom(fontMedium, size: 16))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var tipPercentageSection: some View {
        VStack {
            TextField("15%", value: $viewModel.tipPercentage, format: .percent)
            Text(tipPercentage)
                .font(.custom(fontMedium, size: 16))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var calculateButtonSection: some View {
        Button(action: self.viewModel.calculateTipPercentage, label: {
            Text(calculateButtonTitle)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
                .font(.custom(fontMedium, size: 18))
        })
        .padding()
        .background(Color.doubleTipGreen.gradient)
        .cornerRadius(15)
    }
    
    private var totalSection: some View {
        VStack {
            Text(total)
                .font(.custom(fontMedium, size: 16))
                .foregroundStyle(Color.gray)
            Text(viewModel.totalAmount)
        }
    }
}

#Preview {
    HomePage(viewModel: HomePage.ViewModel())
}
