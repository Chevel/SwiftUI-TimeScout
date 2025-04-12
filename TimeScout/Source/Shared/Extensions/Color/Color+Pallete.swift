//
//  Color+Pallete.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

extension Color {
    
    enum Pallete {
        static let primary = Color(hex: "1E4C7C")
        static let secondary = Color(hex: "479FF8")
        
        static let alert = Color(hex: "DB3232").opacity(0.3)
    }
}

// MARK: - Text

extension Color.Pallete {
    
    enum Foreground {

        static let primary = Color(hex: "FFFFFF")
    }
}

// MARK: - Background

extension Color.Pallete {
    
    enum Background {

        static let primary = Color(hex: "1E4C7C")
        static let secondary = Color(hex: "FFFFFF")
    }
}

// MARK: - Custom

extension Color.Pallete {
    
    enum Onboarding {

        static let title = Color.white
        static let subtitle = Color.gray
    }
}
