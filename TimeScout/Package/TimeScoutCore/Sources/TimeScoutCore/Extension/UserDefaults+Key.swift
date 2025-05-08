//
//  UserDefaults+Key.swift
//  TimeScout
//
//  Created by Matej on 30. 12. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    enum TimeScoutProKey: String {
        case workspace
        case wasOnboardingShown
    }

    enum TimeScoutKey: String {
        case selectedCategory
        case wasOnboardingShown
    }
}
