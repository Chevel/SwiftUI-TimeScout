//
//  ProTimeActivity+Relationship.swift
//  TimeScout
//
//  Created by Matej on 15/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import TimeScoutCore

public extension ProTimeActivity {
    
    var categories: [ProCategory] {
        self.relationship?
            .allObjects
            .compactMap({
                guard let type = ($0 as? ProTimeCategory)?.typeId else { return nil }
                return ProCategory(rawValue: Int(type))
            }) ?? []
    }
}
