//
//  HomePage.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 8/8/24.
//

import SwiftUI

struct HomePage: View {
    
    private let homePageTitleKey = DTBunle.string("home_page_title")
    private let homePageSubtitleKey = DTBunle.string("home_page_subtitle")
    private let titleFont = DTBunle.string("font_large_page_title")
    private let subtitleFont = DTBunle.string("font_page_subtitle")
    
    var body: some View {
        contentView
    }
    
    var contentView: some View {
        VStack(alignment: .center) {
            pageTitle
                .padding(.vertical, 8)
            
            pageSubtitle
                .padding(.bottom, 16)
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
}

#Preview {
    HomePage()
}
