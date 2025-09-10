//
//  Color+Pallete.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public extension Color {
    
    enum Pallete {
        public static let primary = Color(hex: "1E4C7C")
        public static let secondary = Color(hex: "479FF8")
        
        public static let alert = Color(hex: "DB3232").opacity(0.3)
    }
}

// MARK: - Text

public extension Color.Pallete {
    
    enum Foreground {

        public static let primary = Color(hex: "FFFFFF")
    }
}

// MARK: - Background

public extension Color.Pallete {
    
    enum Background {

        public static let primary = Color(hex: "1E4C7C")
        public static let secondary = Color(hex: "FFFFFF")
    }
}

// MARK: - Custom

public extension Color.Pallete {
    
    enum Onboarding {

        public static let title = Color.white
        public static let subtitle = Color.gray
    }
}
