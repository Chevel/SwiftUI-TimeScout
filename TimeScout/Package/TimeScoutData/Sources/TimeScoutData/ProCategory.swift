//
//  ProCategory.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public enum ProCategory: Int, CaseIterable {

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
    
    public var id: Self { self }
}
