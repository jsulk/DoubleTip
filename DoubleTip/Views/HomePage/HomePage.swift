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
//    @EnvironmentObject var taskObject: TaskObservableObject
    
    private let homePageTitleKey = DTBunle.string("home_page_title")
    private let homePageSubtitleKey = DTBunle.string("home_page_subtitle")
    private let calculateButtonTitle = DTBunle.string("calculate")
    private let titleFont = DTBunle.string("font_large_page_title")
    private let subtitleFont = DTBunle.string("font_page_subtitle")
    
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
                // TODO: break out subviews
                Section {
                    VStack {
                        TextField("$0.00", value: $viewModel.expenseAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        Text("BILL AMOUNT")
                            .font(.custom(subtitleFont, size: 16))
                            .foregroundStyle(Color.gray)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)

                Section {
                    VStack {
                        TextField("15%", value: $viewModel.tipPercentage, format: .percent)
                        Text("TIP PERCENTAGE")
                            .font(.custom(subtitleFont, size: 16))
                            .foregroundStyle(Color.gray)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                
                Section {
                    Button(action: self.viewModel.calculateTipPercentage, label: {
                        Text(calculateButtonTitle)
                    })
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                
                Section {
                    VStack {
                        Text("TOTAL")
                            .font(.custom(subtitleFont, size: 16))
                            .foregroundStyle(Color.gray)
                        Text(viewModel.totalAmount)
                    }
                }
                .isHidden(viewModel.totalAmountIsHidden)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    HomePage(viewModel: HomePage.ViewModel())
}
