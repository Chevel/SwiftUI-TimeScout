//
//  Font+Pallete.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public extension Font {

    enum Pallete {
        public static let infoText = Font.system(size: 18, weight: .bold)
        public static let icon = Font.system(size: 18, weight: .bold)
        public static let snackbar = Font.system(size: 16, weight: .bold)
        
        public static let headerTitle = Font.system(size: 56, weight: .bold)
        public static let headerDetails = Font.system(size: 16, weight: .bold)
        
        public static let lettersPicker = Font.system(size: 14, weight: .semibold)
        
        public static let categoryCardName = Font.system(size: 16, weight: .semibold)
        public static let categoryCardSubtitle = Font.system(size: 21, weight: .semibold)
        
        // MARK: - Details

        public static let categoryDetailsHeaderTitle = Font.system(size: 56, weight: .bold)
        public static let categoryDetailsHeaderIcon = Font.system(size: 56, weight: .bold)

        public static let categoryDetailsFooterTitle = Font.system(size: 24, weight: .bold)
        public static let categoryDetailsFooterSubtitle = Font.system(size: 36, weight: .bold)
        
        // MARK: - Paywall

        public static let paywallText = Font.system(size: 20, weight: .bold)
    }
}

// MARK: - Chart

public extension Font.Pallete {
    
    enum Chart {
        public static let centerTextIpad = Font.custom("Cochin", size: 56)
        public static let centerText = Font.custom("Cochin", size: 24)
    }
}

// MARK: - Button

public extension Font.Pallete {
    
    enum Button {
        public static let medium = Font.system(size: 24, weight: .heavy)
        public static let big = Font.system(size: 52, weight: .heavy)
        public static let CTA = Font.system(size: 36, weight: .heavy)
    }
}

// MARK: - Onboarding

public extension Font.Pallete {
    
    enum Onboarding {
        public static let title = Font.system(size: 32, weight: .bold)
        public static let subtitle = Font.system(size: 18, weight: .regular)
    }
}
