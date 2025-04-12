//
//  Image+SFSymbols.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

extension Image {
    
    enum SFSymbols {
        
        // MARK: - Share

        static let share = Image(systemName: "square.and.arrow.up").resizable()
        
        // MARK: - Search

        static let magnifyGlass = Image(systemName: "magnifyingglass").resizable()
        
        // MARK: - Swipe action
        
        static let trash = Image(systemName: "trash").resizable()

        // MARK: - Navigation

        static let backArrow = Image(systemName: "arrow.left").resizable()
        
        // MARK: - Generic

        static let plus = Image(systemName: "plus").resizable()
        static let close = Image(systemName: "xmark.circle").resizable()
        static let checkmark = Image(systemName: "checkmark").resizable()
        static let timeIcon = Image(systemName: "clock").resizable()
        static let hourglassIcon = Image(systemName: "hourglass").resizable()

        // MARK: - Tab

        static let home = Image(systemName: "house.fill").resizable()
        static let list = Image(systemName: "list.bullet").resizable()
    }
}

// MARK: - Button

extension Image.SFSymbols {
    
    enum Button {
        static let circle = Image(systemName: "circle.circle.fill").resizable()
        static let lock = Image(systemName: "lock.fill").resizable()
    }
}

// MARK: - Timer

extension Image.SFSymbols {
    
    enum Timer {
        static let stop = Image(systemName: "stop.circle").resizable()
    }
}

// MARK: - Category

extension Image.SFSymbols {
   
    enum Category {
        static let health = Image(systemName: "figure.walk").resizable()
        static let emotion = Image(systemName: "face.smiling.inverse").resizable()
        static let brainPower = Image(systemName: "brain.head.profile").resizable()
        
        static let friends = Image(systemName: "figure.2.arms.open").resizable()
        static let family = Image(systemName: "figure.2.and.child.holdinghands").resizable()
        static let spouse = Image(systemName: "heart.fill").resizable()
        
        static let money = Image(systemName: "building.columns.fill").resizable()
        static let fun = Image(systemName: "party.popper.fill").resizable()
        static let work = Image(systemName: "briefcase.fill").resizable()
    }
    
}
