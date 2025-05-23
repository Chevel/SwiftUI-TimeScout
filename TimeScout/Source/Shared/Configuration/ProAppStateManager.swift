//
//  ProAppStateManager.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import SwiftUI

class ProAppStateManager: NSObject, ObservableObject {
    
    // MARK: - Onboarding
    
    @Published var currentScreen: ProAppStateManager.ScreenType = {
        return if UserDefaults.standard.bool(forKey: UserDefaults.TimeScoutProKey.wasOnboardingShown.rawValue) {
            .main
        } else {
            .onboarding
        }
    }()

    // MARK: - Timer
    
    @Published var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    func startTimer() {
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }

    // MARK: - Navigation bar
    
    @Published var screen = MainScreenType.home
    var isDetailsPushed: Bool {
        switch screen {
        case .home, .timeline, .activityDetails: return false
        case .timelineDetails: return true
        }
    }
    // MARK: - UI
    
    @Published var isItemSelectionShown = false
    @Published var selectedTab: TabBarButtonType = .home
    @Published var isCategoryDetailsShown = false

    // MARK: - Add activity
    
    @Published var isAddActivityShown = false

    // MARK: - Core Data

    @Published var selectedCategory: ProCategory?
}

extension ProAppStateManager {
    
    enum MainScreenType {
        case home
        case timeline
        case timelineDetails
        case activityDetails
    }
}

extension ProAppStateManager {

    enum ScreenType: Identifiable, Hashable {
        case onboarding
        case main
    }
}

// MARK: - Identifiable

extension ProAppStateManager.ScreenType {

    var id: String {
        switch self {
        case .onboarding: return "onboarding"
        case .main: return "main"
        }
    }
}
