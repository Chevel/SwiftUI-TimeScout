//
//  Data.swift
//  TimeScout
//
//  Created by Matej on 29. 11. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public extension Onboarding {
    
    enum Page {
        case info(Data)
        
        var data: Data {
            switch self {
            case .info(let data): return data
            }
        }
    }
}
