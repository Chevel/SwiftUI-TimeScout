//
//  Image+SFSymbols.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public extension Image {
    
    enum SFSymbols {
        
        // MARK: - Share

        public static let share = Image(systemName: "square.and.arrow.up").resizable()
        
        // MARK: - Search

        public static let magnifyGlass = Image(systemName: "magnifyingglass").resizable()
        
        // MARK: - Swipe action
        
        public static let trash = Image(systemName: "trash").resizable()

        // MARK: - Navigation

        public static let backArrow = Image(systemName: "arrow.left").resizable()
        
        // MARK: - Generic

        public static let plus = Image(systemName: "plus").resizable()
        public static let close = Image(systemName: "xmark.circle").resizable()
        public static let checkmark = Image(systemName: "checkmark").resizable()
        public static let timeIcon = Image(systemName: "clock").resizable()
        public static let hourglassIcon = Image(systemName: "hourglass").resizable()

        // MARK: - Tab

        public static let home = Image(systemName: "house.fill").resizable()
        public static let list = Image(systemName: "list.bullet").resizable()
    }
}

// MARK: - Button

public extension Image.SFSymbols {
    
    enum Button {
        public static let circle = Image(systemName: "circle.circle.fill").resizable()
        public static let lock = Image(systemName: "lock.fill").resizable()
    }
}

// MARK: - Timer

public extension Image.SFSymbols {
    
    enum Timer {
        public static let stop = Image(systemName: "stop.circle").resizable()
    }
}

// MARK: - Category

public extension Image.SFSymbols {
   
    enum Category {
        public static let health = Image(systemName: "figure.walk").resizable()
        public static let emotion = Image(systemName: "face.smiling.inverse").resizable()
        public static let brainPower = Image(systemName: "brain.head.profile").resizable()
        
        public static let friends = Image(systemName: "figure.2.arms.open").resizable()
        public static let family = Image(systemName: "figure.2.and.child.holdinghands").resizable()
        public static let spouse = Image(systemName: "heart.fill").resizable()
        
        public static let money = Image(systemName: "building.columns.fill").resizable()
        public static let fun = Image(systemName: "party.popper.fill").resizable()
        public static let work = Image(systemName: "briefcase.fill").resizable()
    }
    
}
