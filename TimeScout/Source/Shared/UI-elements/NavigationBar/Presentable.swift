//
//  Presentable.swift
//  TimeScout
//
//  Created by Matej on 16/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

protocol Presentable: View {
    var screenType: ProAppStateManager.MainScreenType { get }
    var appStateManager: ProAppStateManager { get }
}

extension Presentable {
    func notifyScreenChanged() {
        appStateManager.screen = screenType
    }
}

