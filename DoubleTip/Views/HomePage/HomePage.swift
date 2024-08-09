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
    
    var body: some View {
        contentView
    }
    
    var contentView: some View {
        VStack(alignment: .center) {
            pageTitle
                .padding(.vertical, 8)
            
            pageSubtitle
                .padding(.bottom, 16)
            
            Spacer()
            
        }
        .padding()
    }
    
    var pageTitle: some View {
        Text(homePageTitleKey)
            .font(.largeTitle)
    }
    
    var pageSubtitle: some View {
        Text(homePageSubtitleKey)
            .font(.subheadline)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    HomePage()
}
