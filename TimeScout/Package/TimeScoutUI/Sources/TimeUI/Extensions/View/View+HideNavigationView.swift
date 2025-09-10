//
//  View+HideNavigationView.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import SwiftUI

public extension View {

    func hideNavigationView() -> some View {
        self.navigationTitle("").navigationBarHidden(true)
    }
}
