//
//  AppStateManager.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import Foundation
import TimeScoutCore

class AppStateManager: NSObject, ObservableObject {
    
    // MARK: - Onboarding
    
    @Published var currentScreen: ProAppStateManager.ScreenType = {
        let wasOnboardingShown = switch AppSettings.target {
        case .basic: UserDefaults.standard.bool(forKey: UserDefaults.TimeScoutKey.wasOnboardingShown.rawValue)
        case .pro: UserDefaults.standard.bool(forKey: UserDefaults.TimeScoutProKey.wasOnboardingShown.rawValue)
        }
        return wasOnboardingShown ? .main : .onboarding
    }()

    // MARK: - Snackbar

    @Published var isSnackbarPresented = false
    {
        didSet {            
            guard isSnackbarPresented else { return }

            DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .seconds(2))) { [weak self] in
                guard self?.isSnackbarPresented == true else { return }
                self?.isSnackbarPresented = false
            }
        }
    }

    // MARK: - UI

    @Published var isListShown = false
    @Published var isItemSelectionShown = false

    func closeListView() {
        isListShown = false
        isItemSelectionShown = false
    }

    // MARK: - Add activity

    @Published var isAddActivityShownOnHome = false
    @Published var isAddActivityShownOnList = false

    func closeAddActivity() {
        isAddActivityShownOnHome = false
        isAddActivityShownOnList = false
    }

    // MARK: - Items
    
    @Published var searchQuery = ""
    
    // MARK: - Core Data

    @Published var selectedCategory: TimeCategory?
    {
        didSet {
            guard let selectedCategory else { return }
            UserDefaults.standard.set(selectedCategory.name, forKey: UserDefaults.TimeScoutKey.selectedCategory.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}
