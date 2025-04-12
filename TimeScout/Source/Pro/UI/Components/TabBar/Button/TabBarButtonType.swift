//
//  TabBarButtonType.swift
//  TimeScout
//
//  Created by Matej on 02/08/2022.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

enum TabBarButtonType: String {
    case home
    case list

    var image: Image {
        switch self {
        case .home: return Image.SFSymbols.home
        case .list: return Image.SFSymbols.list
        }
    }
}
