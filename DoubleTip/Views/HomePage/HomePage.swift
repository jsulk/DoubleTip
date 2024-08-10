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
        }
        .padding()
    }
    
    var pageTitle: some View {
        Text(homePageTitleKey)
            .font(.custom(titleFont, size: 36))
            .foregroundStyle(Color.doubleTipGreen.gradient)
    }
    
    var pageSubtitle: some View {
        Text(homePageSubtitleKey)
            .multilineTextAlignment(.center)
            .font(.custom(subtitleFont, size: 18))
            .foregroundStyle(Color.doubleTipGreen.gradient)
    }
    
    var calculatorView: some View {
        VStack {
            Form {
                
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
                .isHidden($viewModel.tipPercentIsHidden.wrappedValue)
                
                Section {
                    VStack {
                        Text("TOTAL")
                            .font(.custom(subtitleFont, size: 16))
                            .foregroundStyle(Color.gray)
                        Text(viewModel.totalAmount)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .isHidden($viewModel.totalAmountIsHidden.wrappedValue)
                
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    HomePage(viewModel: HomePage.ViewModel())
}
