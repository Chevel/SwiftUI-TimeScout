//
//  NoButtonStyle.swift
//  TimeScout
//
//  Created by Matej on 08/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

// Disables the highlight on NavigationLink when tapped.
public struct ClearNavigationLinkStyle: ButtonStyle {

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label.background(Color.clear)
    }
}
