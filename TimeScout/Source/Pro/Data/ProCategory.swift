//
//  ProCategory.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutUI

enum ProCategory: Int, CaseIterable {

    case health
    case emotion
    case brainPower
    case friends
    case family
    case spouse
    case money
    case fun
    case work

    var isLocked: Bool {
        switch self {
        case .family, .spouse, .money, .fun, .work: true
        default: false
        }
    }
}

// MARK: - Identifiable

extension ProCategory: Identifiable {
    
    var id: Self { self }
}

extension ProCategory {
    
    var icon: Image {
        switch self {
        case .health: return Image.SFSymbols.Category.health
        case .emotion: return Image.SFSymbols.Category.emotion
        case .brainPower: return Image.SFSymbols.Category.brainPower
        case .friends: return Image.SFSymbols.Category.friends
        case .family: return Image.SFSymbols.Category.family
        case .spouse: return Image.SFSymbols.Category.spouse
        case .money: return Image.SFSymbols.Category.money
        case .fun: return Image.SFSymbols.Category.fun
        case .work: return Image.SFSymbols.Category.work
        }
    }
    
    var color: Color {
        switch self {
        case .health: return Color(hex: "82D553")
        case .emotion: return Color(hex: "84BDF4")
        case .brainPower: return Color(hex: "E6BF58")
        case .friends: return Color(hex: "DB755E")
        case .family: return Color(hex: "B33E73")
        case .spouse: return Color(hex: "D95137")
        case .money: return Color(hex: "EDE568")
        case .fun: return Color(hex: "8CE0D0")
        case .work: return Color(hex: "000000")
        }
    }
    
    var name: String {
        switch self {
        case .health: return "category_health".translated()
        case .emotion: return "category_emotion".translated()
        case .brainPower: return "category_brain_power".translated()
        case .friends: return "category_friends".translated()
        case .family: return "category_family".translated()
        case .spouse: return "category_spouse".translated()
        case .money: return "category_money".translated()
        case .fun: return "category_fun".translated()
        case .work: return "category_work".translated()
        }
    }
    
}
