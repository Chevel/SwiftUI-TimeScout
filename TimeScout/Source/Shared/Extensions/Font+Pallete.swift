//
//  Font+Pallete.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

extension Font {

    enum Pallete {
        static let infoText = Font.system(size: 18, weight: .bold)
        static let icon = Font.system(size: 18, weight: .bold)
        static let snackbar = Font.system(size: 16, weight: .bold)
        
        static let headerTitle = Font.system(size: 56, weight: .bold)
        static let headerDetails = Font.system(size: 16, weight: .bold)
        
        static let lettersPicker = Font.system(size: 14, weight: .semibold)
        
        static let categoryCardName = Font.system(size: 16, weight: .semibold)
        static let categoryCardSubtitle = Font.system(size: 21, weight: .semibold)
        
        // MARK: - Details

        static let categoryDetailsHeaderTitle = Font.system(size: 56, weight: .bold)
        static let categoryDetailsHeaderIcon = Font.system(size: 56, weight: .bold)

        static let categoryDetailsFooterTitle = Font.system(size: 24, weight: .bold)
        static let categoryDetailsFooterSubtitle = Font.system(size: 36, weight: .bold)
        
        // MARK: - Paywall

        static let paywallText = Font.system(size: 20, weight: .bold)
    }
}

// MARK: - Chart

extension Font.Pallete {
    
    enum Chart {
        static let centerTextIpad = Font.custom("Cochin", size: 56)
        static let centerText = Font.custom("Cochin", size: 24)
    }
}

// MARK: - Button

extension Font.Pallete {
    
    enum Button {
        static let medium = Font.system(size: 24, weight: .heavy)
        static let big = Font.system(size: 52, weight: .heavy)
        static let CTA = Font.system(size: 36, weight: .heavy)
    }
}

// MARK: -

extension Font.Pallete {
    
    enum Onboarding {
        static let title = Font.system(size: 32, weight: .bold)
        static let subtitle = Font.system(size: 18, weight: .regular)
    }
}
