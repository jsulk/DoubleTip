//
//  DoubleTipApp.swift
//  DoubleTip
//
//  Created by Jake Sulkoske on 8/8/24.
//

import SwiftUI
import Foundation
import Combine

@main
struct DoubleTipApp: App {
    private var cancellables = Set<AnyCancellable>()
    
    var body: some Scene {
        WindowGroup {
            HomePage(viewModel: HomePage.ViewModel())
        }
    }
}
